# Utility functions for mu - colors, logging, validation

# Check if terminal supports colors by checking TERM environment variable
(defn has-color []
  "Check if terminal supports colors"
  (def term (os/getenv "TERM"))
  (and term 
       (not (string/has-suffix? term "mono"))
       (not (= term "dumb"))))

(defn colored [text color]
  "Return text with ANSI color codes if terminal supports colors"
  (if (has-color)
    (case color
      :red (string "\e[31m" text "\e[0m")
      :green (string "\e[32m" text "\e[0m")
      :yellow (string "\e[33m" text "\e[0m")
      :blue (string "\e[34m" text "\e[0m")
      :magenta (string "\e[35m" text "\e[0m")
      :cyan (string "\e[36m" text "\e[0m")
      :white (string "\e[37m" text "\e[0m")
      text)
    text))

(defn log [level message]
  "Log a message with color-coded level"
  (case level
    :info (printf "%s %s\n" (colored "[INFO]" :blue) message)
    :warn (printf "%s %s\n" (colored "[WARN]" :yellow) message)
    :error (printf "%s %s\n" (colored "[ERROR]" :red) message)
    :success (printf "%s %s\n" (colored "[SUCCESS]" :green) message)
    (printf "%s\n" message)))

(defn validate-profile [profile]
  "Validate that profile is either 'personal' or 'work'"
  (if (and profile (or (= profile "personal") (= profile "work")))
    true
    (do
      (if profile
        (log :error (string "Invalid profile: " profile ". Must be 'personal' or 'work'"))
        (log :error "No profile specified. Set MU_PROFILE environment variable or provide profile argument."))
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
  (print "mu - NixOS Configuration Manager\n")
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