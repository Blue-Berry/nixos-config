# Core logic for mu - argument parsing and command dispatching

(import ./utils :as u)
(import ./commands :as c)

(defn has-flag? [args flag]
  "Check if a flag exists in the argument list"
  (some |(= $ flag) args))

(defn parse-args [args]
  "Parse command line arguments into structured data"
  # Skip the first argument (script name)
  (def real-args (drop 1 args))
  (def dry-run (has-flag? real-args "--dry-run"))
  (def filtered-args (filter |(not= $ "--dry-run") real-args))
  
  (def command (get filtered-args 0))
  (def explicit-profile (get filtered-args 1))
  
  # Use explicit profile if provided and valid, otherwise fall back to MU_PROFILE env var
  (def env-profile (os/getenv "MU_PROFILE"))
  (def profile (if (and explicit-profile (not (string/has-prefix? "--" explicit-profile)))
                 explicit-profile
                 env-profile))
  
  {:command command :profile profile :dry-run dry-run})

(defn run-mu [args]
  "Main entry point for mu - parse args and dispatch to commands"
  (def parsed (parse-args args))
  (def command (get parsed :command))
  (def profile (get parsed :profile))
  (def dry-run (get parsed :dry-run))
  
  
  # Handle help and no-command cases
  (when (or (not command) (= command "help"))
    (u/show-help)
    (if (not command) (os/exit 1))
    (os/exit 0))
  
  # Dispatch to appropriate command
  (case command
    "build" (c/build-command profile dry-run)
    "switch" (c/switch-command profile dry-run)
    "home" (c/home-command profile dry-run)
    "status" (c/status-command dry-run)
    # default
    (do
      (u/log :error (string "Unknown command: " command))
      (u/show-help)
      (os/exit 1))))