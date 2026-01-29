#!/usr/bin/env nix-shell
(*
#!nix-shell --pure -i utop -p ocaml ocamlPackages.findlib ocamlPackages.utop
*)
(* #use "topfind";; *)


let (let*) x f = f x

let _ = 
  let* x = "Stuff" in
  print_endline x


let _ =
  (fun x-> print_endline x) "Stuff"



let a = 
  let* () = () in
  print_endline "Stuff"



let (let*) (x : unit -> unit) (f : unit -> 'a) = 
  Fun.protect ~finally:x f



let b = 
  let* () = fun () -> print_endline "Defered" in
  print_endline "Stuff";
  print_endline "More Stuff";
  let* () = fun () -> print_endline "Defered again" in
  print_endline "Even More Stuff";

