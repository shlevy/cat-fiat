Set Implicit Arguments.
(** * Possibly terminating streams

    We conceptualize the traditional unix pipeline programs as
    transformations on streams. These streams are neither traditional
    lists, which must terminate, nor traditional coinductive streams,
    which must not, so we use a hybrid of the two. *)

CoInductive pt_stream (A : Type) : Type :=
| nil : pt_stream A
| cons : A -> pt_stream A -> pt_stream A.

(** pt_streams are equal when they're bisimulationally-equivalent
    infinite streams or the same finite stream. *)
CoInductive pt_stream_eq (A : Type) : pt_stream A -> pt_stream A -> Prop :=
| pt_stream_eq_nil : pt_stream_eq (nil A) (nil A)
| pt_stream_eq_cons : forall {a} {tl1} {tl2}, pt_stream_eq tl1 tl2 -> pt_stream_eq (cons a tl1) (cons a tl2).

(** Concatenate two streams *)
CoFixpoint app {A : Type} (fst : pt_stream A) (snd : pt_stream A) : pt_stream A :=
  match fst with
  | nil _ => snd
  | cons a tl => cons a (app tl snd)
  end.
