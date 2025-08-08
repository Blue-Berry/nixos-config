#!/usr/bin/env janet

# Main entry point for mu
(import ./lib/core :as core)

# Direct execution
(core/run-mu (dyn :args))