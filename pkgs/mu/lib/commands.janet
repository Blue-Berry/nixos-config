# Command implementations for mu

(import ./utils :as u)

(defn diff-nvd [cmd dry-run]
  "Run nvd command with output always visible"
  (if dry-run
    (do
      (u/log :info (string "Would run: " cmd))
      0)
    # Always show nvd output regardless of verbosity
    (os/shell cmd)))

(defn should-use-nom [cmd verbosity]
  "Check if command should use nix-output-monitor for prettier output"
  (and (= verbosity 0)
       (not (os/getenv "MU_NO_NOM"))
       (or (and (string/has-prefix? "sudo nixos-rebuild" cmd)
                (string/find "build" cmd)
                (not (string/find "switch" cmd)))
           (and (string/has-prefix? "home-manager" cmd)
                (string/find "build" cmd)
                (not (string/find "switch" cmd))))))

(defn wrap-with-nom [cmd]
  "Wrap command with nom if it's a nix command"
  (cond
    (string/has-prefix? "sudo nixos-rebuild" cmd)
    (string "unbuffer " cmd " |& nom")
    
    (string/has-prefix? "home-manager" cmd)
    (string "unbuffer " cmd " |& nom")
    
    cmd))

(defn run-command [cmd &opt dry-run]
  "Execute a shell command with verbosity control"
  (def verbosity (or (dyn :mu-verbosity) 0))
  
  (if dry-run
    (do
      (def use-nom (and (= verbosity 0) (should-use-nom cmd 0)))
      (def actual-cmd (if use-nom
                        (wrap-with-nom cmd)
                        cmd))
      (u/log :info (string "Would run: " actual-cmd))
      0)
    (do
      (when (>= verbosity 1)
        (u/log :info (string "Running: " cmd)))
      
      (if (= verbosity 0)
        # Default mode - use nom for nix commands, otherwise capture output
        (if (should-use-nom cmd verbosity)
          # Use nom with proper JSON format
          (do
            (def nom-cmd (wrap-with-nom cmd))
            (os/shell nom-cmd))
          # Capture output for non-nix commands
          (do
            (def silent-cmd (string cmd " 2>&1"))
            (def proc (os/spawn ["/bin/sh" "-c" silent-cmd] :p {:out :pipe :err :pipe}))
            (def result (os/proc-wait proc))
            (def output (string/trim (ev/read (proc :out) :all)))
            (ev/close (proc :out))
            (when (and (not= result 0) (not (empty? output)))
              (u/log :error (string "Command failed:\n" output)))
            result))
        # Verbose mode - show all output without nom
        (os/shell cmd)))))

(defn build-nixos [profile dry-run]
  "Build NixOS configuration for the given profile"
  (u/log :info (string "Building NixOS configuration for " profile))
  (def cmd (string "sudo nixos-rebuild build --flake .#" profile))
  (def result (run-command cmd dry-run))
  (if (not= result 0)
    (do
      (u/log :error "NixOS build failed")
      (os/exit 1)))
  result)

(defn build-home-manager [profile dry-run]
  "Build home-manager configuration for the given profile"
  (u/log :info (string "Building home-manager configuration for " profile))
  (def cmd (string "home-manager build --flake .#" profile))
  (def result (run-command cmd dry-run))
  (if (not= result 0)
    (do
      (u/log :error "Home-manager build failed")
      (os/exit 1)))
  result)

(defn switch-nixos-only [profile dry-run]
  "Switch NixOS configuration only"
  (def cmd (string "sudo nixos-rebuild switch --flake .#" profile))
  (def result (run-command cmd dry-run))
  (if (= result 0)
    (do
      (u/log :success (string "Switched to NixOS " profile " profile"))
      # Show what changed unless dry run
      (unless dry-run
        (u/log :info "What changed:")
        (diff-nvd "nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link | tail -2)" false)))
    (u/log :error "NixOS switch failed"))
  result)

(defn switch-home-only [profile dry-run]
  "Switch home-manager configuration only"
  (def cmd (string "home-manager switch --flake .#" profile))
  (def result (run-command cmd dry-run))
  (if (= result 0)
    (do
      (u/log :success (string "Switched to home-manager " profile " profile"))
      # Show what changed unless dry run
      (unless dry-run
        (u/log :info "What changed:")
        (diff-nvd "nvd diff $(ls -d1v ~/.local/state/nix/profiles/home-manager-*-link | tail -2)" false)))
    (u/log :error "Home-manager switch failed"))
  result)

(defn switch-both [profile dry-run]
  "Switch both NixOS and home-manager configurations"
  (def nixos-result (switch-nixos-only profile dry-run))
  (def home-result (switch-home-only profile dry-run))
  (if (and (= nixos-result 0) (= home-result 0))
    (u/log :success (string "Switched to " profile " profile (NixOS + home-manager)"))))

(defn build-command [profile dry-run]
  "Interactive build command - prompts for what to build"
  (unless (u/validate-profile profile) (os/exit 1))
  
  (printf "Profile: %s\n" (u/colored profile :cyan))
  (def choice (u/prompt-choice 
               "What would you like to build?"
               ["nixos" "home-manager" "both"]
               "both"))
  
  (def start-time (os/time))
  (var nixos-success false)
  (var home-success false)
  
  (case choice
    "nixos" 
    (do
      (set nixos-success (= (build-nixos profile dry-run) 0))
      (if nixos-success
        (u/log :success (string "NixOS build completed for " profile " profile"))))
    
    "home-manager"
    (do
      (set home-success (= (build-home-manager profile dry-run) 0))
      (if home-success
        (u/log :success (string "Home-manager build completed for " profile " profile"))))
    
    "both"
    (do
      (set nixos-success (= (build-nixos profile dry-run) 0))
      (set home-success (= (build-home-manager profile dry-run) 0))
      (if (and nixos-success home-success)
        (u/log :success (string "Build completed for " profile " profile (NixOS + home-manager)")))))
  
  (def duration (- (os/time) start-time))
  (u/log :info (string/format "Build took %.2f seconds" duration))
  
  # Prompt to switch if build was successful
  (def any-success (or nixos-success home-success))
  (when (and any-success (not dry-run))
    (def should-switch (u/prompt-confirm "Switch to new configuration?" false))
    (when should-switch
      (case choice
        "nixos" (switch-nixos-only profile dry-run)
        "home-manager" (switch-home-only profile dry-run)  
        "both" (switch-both profile dry-run)))))

(defn switch-command [profile dry-run]
  "Interactive switch command - prompts for what to switch"
  (unless (u/validate-profile profile) (os/exit 1))
  
  (printf "Profile: %s\n" (u/colored profile :cyan))
  (def choice (u/prompt-choice 
               "What would you like to switch?"
               ["nixos" "home-manager" "both"]
               "both"))
  
  (def start-time (os/time))
  
  (case choice
    "nixos" (switch-nixos-only profile dry-run)
    "home-manager" (switch-home-only profile dry-run)
    "both" (switch-both profile dry-run))
  
  (def duration (- (os/time) start-time))
  (u/log :info (string/format "Switch took %.2f seconds" duration)))

(defn home-command [profile dry-run]
  "Switch home-manager configuration for the given profile"
  (unless (u/validate-profile profile) (os/exit 1))
  (def cmd (string "home-manager switch --flake .#" profile))
  (def result (run-command cmd dry-run))
  (if (= result 0)
    (u/log :success (string "Home-manager updated for " profile " profile"))
    (u/log :error "Home-manager update failed")))

(defn status-command [dry-run]
  "Show current system status"
  (u/log :info "Current system status:")
  (run-command "nixos-version" dry-run)
  (run-command "home-manager generations | head -5" dry-run))

(defn diff-command [profile dry-run]
  "Show differences between system generations using nvd"
  (unless (u/validate-profile profile) (os/exit 1))
  
  (u/log :info "System differences:")
  (u/log :info "Comparing last two NixOS generations...")
  (diff-nvd "nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link | tail -2)" dry-run)
  
  (u/log :info "Comparing last two home-manager generations...")
  (diff-nvd "nvd diff $(ls -d1v ~/.local/state/nix/profiles/home-manager-*-link | tail -2)" dry-run))