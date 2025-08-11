# Command implementations for mu

(import ./utils :as u)

(defn run-command [cmd &opt dry-run]
  "Execute a shell command, or show what would be run if dry-run is true"
  (if dry-run
    (do
      (u/log :info (string "Would run: " cmd))
      0)
    (do
      (u/log :info (string "Running: " cmd))
      (os/shell cmd))))

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
    (u/log :success (string "Switched to NixOS " profile " profile"))
    (u/log :error "NixOS switch failed"))
  result)

(defn switch-home-only [profile dry-run]
  "Switch home-manager configuration only"
  (def cmd (string "home-manager switch --flake .#" profile))
  (def result (run-command cmd dry-run))
  (if (= result 0)
    (u/log :success (string "Switched to home-manager " profile " profile"))
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