# Utility functions for mu - colors, logging, validation

# Color constants
(def colors {:red "\e[31m" :green "\e[32m" :yellow "\e[33m" :blue "\e[34m" :magenta "\e[35m" :cyan "\e[36m" :white "\e[37m" :reset "\e[0m"})

(defn colored [color text]
  "Apply color formatting to text"
  (string (get colors color "") text (get colors :reset "")))

(defn log [level message]
  "Log a message with color-coded level"
  (case level
    :info (print (colored :blue "[INFO]") " " message)
    :warn (print (colored :yellow "[WARN]") " " message)
    :error (print (colored :red "[ERROR]") " " message)
    :success (print (colored :green "[SUCCESS]") " " message)
    (print message)))

(defn validate-profile [profile]
  "Validate that profile is either 'personal' or 'work'"
  (if (or (= profile "personal") (= profile "work"))
    true
    (do
      (log :error (string "Invalid profile: " profile ". Must be 'personal' or 'work'"))
      false)))

(defn show-help []
  "Display help information"
  (print (colored :cyan "mu") " - NixOS Configuration Manager\n")
  (print "Usage: mu <command> [profile] [options]\n")
  (print "Commands:")
  (print "  build <profile>     Build NixOS configuration for profile")
  (print "  switch <profile>    Switch to NixOS configuration for profile")
  (print "  home <profile>      Build/switch home-manager for profile")
  (print "  status              Show current system status")
  (print "  help                Show this help message")
  (print "\nProfiles: personal, work")
  (print "\nOptions:")
  (print "  --dry-run           Show what would be done without executing"))