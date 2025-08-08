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

(defn prompt-choice [question choices default]
  "Prompt user for a choice from given options"
  (print question)
  (each choice choices
    (def is-default (= choice default))
    (def first-char (string/ascii-upper (string/slice choice 0 1)))
    (printf "  [%s] %s%s" 
            first-char
            choice
            (if is-default " (default)" "")))
  (printf "> ")
  (flush)
  (def input (string/trim (getline)))
  (if (empty? input)
    default
    (do
      (def input-lower (string/ascii-lower input))
      (def input-first (string/ascii-lower (string/slice input 0 1)))
      # Find matching choice by full name or first letter
      (var matched-choice nil)
      (each choice choices
        (def choice-first (string/ascii-lower (string/slice choice 0 1)))
        (when (or (= input-lower (string/ascii-lower choice))
                  (= input-first choice-first))
          (set matched-choice choice)))
      (or matched-choice default))))

(defn prompt-confirm [question default]
  "Prompt user for yes/no confirmation"
  (def default-text (if default "Y/n" "y/N"))
  (printf "%s [%s]: " question default-text)
  (flush)
  (def input (string/trim (getline)))
  (if (empty? input)
    default
    (do
      (def input-lower (string/ascii-lower input))
      (or (= input-lower "y") (= input-lower "yes")))))

(defn show-help []
  "Display help information"
  (print (colored :cyan "mu") " - NixOS Configuration Manager\n")
  (print "Usage: mu <command> [profile] [options]\n")
  (print "Commands:")
  (print "  build [profile]     Build NixOS/home-manager configurations (interactive)")
  (print "  switch [profile]    Switch to NixOS/home-manager configurations (interactive)")  
  (print "  home [profile]      Build/switch home-manager for profile")
  (print "  status              Show current system status")
  (print "  help                Show this help message")
  (print "\nProfiles: personal, work")
  (print "Default profile: Uses MU_PROFILE environment variable if set")
  (print "\nOptions:")
  (print "  --dry-run           Show what would be done without executing"))