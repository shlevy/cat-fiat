Require Import Fiat.Computation.
Require Import Cat.PTStream.
Require Import Coq.Lists.List.

(** * Denotational semantics for the unix cat program

    cat turns a sequence of streams into one with them concatenated
    together. *)

Definition cat_spec (A : Type) (streams : list (pt_stream A)) : Comp (pt_stream A) :=
  { s | pt_stream_eq s (fold_right PTStream.app (PTStream.nil _) streams) }.