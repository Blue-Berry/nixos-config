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
  "Build NixOS configuration for the given profile"
  (unless (u/validate-profile profile) (os/exit 1))
  (def cmd (string "sudo nixos-rebuild build --flake .#" profile))
  (def result (run-command cmd dry-run))
  (if (= result 0)
    (u/log :success (string "Build completed for " profile " profile"))
    (u/log :error "Build failed")))

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