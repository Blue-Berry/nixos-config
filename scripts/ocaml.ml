#!/usr/bin/env nix-shell
(*
#!nix-shell --pure -i utop -p ocaml ocamlPackages.findlib ocamlPackages.core ocamlPackages.utop
*)
(* #use "topfind";; *)
#require "core";;

Core.print_string "Hello world! 🚀 \n";;
