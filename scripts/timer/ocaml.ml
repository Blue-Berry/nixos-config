#!/usr/bin/env nix-shell
(*
#!nix-shell --pure -i utop -p ocaml ocamlPackages.findlib ocamlPackages.core ocamlPackages.utop
*)
(* #use "topfind";; *)
#require "unix";;



let run cmd =
  let inp = Unix.open_process_in cmd in
  let r = In_channel.input_all inp in
  In_channel.close inp; r

let notify () =
  let _ = run "/nix/store/ay25i5r4q4jkss036y68j1r6ywz0cdhv-profile/bin/notify-send -t 5000 \"ED\" \"10 minuites\"" in
  ()

let play_tone () =
  let _ = run "/nix/store/msfiwiiq3ks17qvzs68r4c1x6cg00c48-system-path/bin/pw-play notify.wav --volume 10.0" in
  ()


(*
let () =
  while true do
    notify ();
    play_tone ();
    Unix.sleep (60 * 10);
  done
*)

(* chech if the time is a multiple of 10 minutes. ie 0:00, 10:00, 20:00 *)
let is_ten_min_mark () =
  let time = Unix.time () |> int_of_float in
  if (time mod (60 * 10)) < 5 then
    true
  else false

let debounce = ref false

let () =
  while true do
    Unix.sleep 1;
    match !debounce, is_ten_min_mark () with
    | false, true ->
      debounce := true;
      notify ();
      play_tone ();
    | _, false ->
      debounce := false;
    | _ -> ()
  done
