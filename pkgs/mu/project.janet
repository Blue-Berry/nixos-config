(declare-project
  :name "mu"
  :description "NixOS Configuration Manager"
  :version "0.1.0"
  :dependencies [])

(declare-executable
  :name "mu"
  :entry "mu.janet")

(declare-binpath "/bin")

# Build rules
(rule "build" []
  (shell "janet -c lib/utils.janet")
  (shell "janet -c lib/commands.janet")  
  (shell "janet -c lib/core.janet"))