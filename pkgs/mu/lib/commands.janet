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

(defn build-command [profile dry-run]
  "Build NixOS and home-manager configurations for the given profile"
  (unless (u/validate-profile profile) (os/exit 1))
  
  # Build NixOS configuration
  (u/log :info (string "Building NixOS configuration for " profile))
  (def nixos-cmd (string "sudo nixos-rebuild build --flake .#" profile))
  (def nixos-result (run-command nixos-cmd dry-run))
  
  (if (not= nixos-result 0)
    (do
      (u/log :error "NixOS build failed")
      (os/exit 1)))
  
  # Build home-manager configuration
  (u/log :info (string "Building home-manager configuration for " profile))
  (def home-cmd (string "home-manager build --flake .#" profile))
  (def home-result (run-command home-cmd dry-run))
  
  (if (= home-result 0)
    (u/log :success (string "Build completed for " profile " profile (NixOS + home-manager)"))
    (do
      (u/log :error "Home-manager build failed")
      (os/exit 1))))

(defn switch-command [profile dry-run]
  "Switch to NixOS configuration for the given profile"
  (unless (u/validate-profile profile) (os/exit 1))
  (def cmd (string "sudo nixos-rebuild switch --flake .#" profile))
  (def result (run-command cmd dry-run))
  (if (= result 0)
    (u/log :success (string "Switched to " profile " profile"))
    (u/log :error "Switch failed")))

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