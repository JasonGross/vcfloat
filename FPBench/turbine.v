Require Import vcfloat.VCFloat.
Require Import Interval.Tactic.
Import Binary List ListNotations.
Set Bullet Behavior "Strict Subproofs".
Section WITHNANS.
Context {NANS:Nans}.
Open Scope R_scope.


Definition turbine1_bmap_list := [Build_varinfo Tdouble 1%positive (-45e-1) (-3e-1);Build_varinfo Tdouble 2%positive (4e-1) (9e-1);Build_varinfo Tdouble 3%positive (38e-1) (78e-1)].

Definition turbine1_bmap :=
 ltac:(let z := compute_PTree (boundsmap_of_list turbine1_bmap_list) in exact z).

Definition turbine1 (v : ftype Tdouble) (w : ftype Tdouble) (r : ftype Tdouble) := 
  cast Tdouble (((((3)%F64 + ((2)%F64 / (r * r)%F64)%F64)%F64 - ((((125e-3)%F64 * ((3)%F64 - ((2)%F64 * v)%F64)%F64)%F64 * (((w * w)%F64 * r)%F64 * r)%F64)%F64 / ((1)%F64 - v)%F64)%F64)%F64 - (45e-1)%F64)%F64).

Definition turbine1_expr := 
 ltac:(let e' :=  HO_reify_float_expr constr:([1%positive;2%positive;3%positive]) turbine1 in exact e').


Lemma turbine1_bound:
	find_and_prove_roundoff_bound turbine1_bmap turbine1_expr.
Proof.
idtac "Starting turbine1".
time "turbine1" (
try (eexists; intro; prove_roundoff_bound);
try (prove_rndval; interval);
try (prove_roundoff_bound2; error_rewrites);
try (prune_terms (cutoff 70);
try match goal with |- (Rabs ?e <= ?a - 0)%R =>
  rewrite Rminus_0_r (* case prune terms will fail to produce reasonable bound on goal*)
end;
try match goal with |- (Rabs ?e <= ?a - ?b)%R =>
                      let G := fresh "G" in
                      interval_intro (Rabs e) as G ;
                      eapply Rle_trans;
                      [apply G | apply Rminus_plus_le_minus; apply Rle_refl] end);
try rewrite Rsqr_pow2;
try field_simplify_Rabs;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( i_bisect vxH,
i_bisect v, 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with (
i_bisect v, 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect v, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect vxH, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) as H'; apply H'; apply Rle_refl
end).
Defined.

Check ltac:(ShowBound (proj1_sig turbine1_bound)).

Goal proj1_sig turbine1_bound <= 7.9e-14.
simpl.
interval.
Qed.


Definition turbine2_bmap_list := [Build_varinfo Tdouble 1%positive (-45e-1) (-3e-1);Build_varinfo Tdouble 2%positive (4e-1) (9e-1);Build_varinfo Tdouble 3%positive (38e-1) (78e-1)].

Definition turbine2_bmap :=
 ltac:(let z := compute_PTree (boundsmap_of_list turbine2_bmap_list) in exact z).

Definition turbine2 (v : ftype Tdouble) (w : ftype Tdouble) (r : ftype Tdouble) := 
  cast Tdouble (((((6)%F64 * v)%F64 - ((((5e-1)%F64 * v)%F64 * (((w * w)%F64 * r)%F64 * r)%F64)%F64 / ((1)%F64 - v)%F64)%F64)%F64 - (25e-1)%F64)%F64).

Definition turbine2_expr := 
 ltac:(let e' :=  HO_reify_float_expr constr:([1%positive;2%positive;3%positive]) turbine2 in exact e').

Lemma turbine2_bound:
	find_and_prove_roundoff_bound turbine2_bmap turbine2_expr.
Proof.
idtac "Starting turbine2".
time "turbine2" (
try (eexists; intro; prove_roundoff_bound);
try (prove_rndval; interval);
try prove_roundoff_bound2;
try error_rewrites;
try ((prune_terms (cutoff 70);
try match goal with |- (Rabs ?e <= ?a - 0)%R =>
  rewrite Rminus_0_r (* case prune terms will fail to produce reasonable bound on goal*)
end;
try match goal with |- (Rabs ?e <= ?a - ?b)%R =>
                      let G := fresh "G" in
                      interval_intro (Rabs e) as G ;
                      eapply Rle_trans;
                      [apply G | apply Rminus_plus_le_minus; apply Rle_refl] end));
try rewrite Rsqr_pow2;
try field_simplify_Rabs;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( i_bisect vxH,
i_bisect v, 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with (
i_bisect v, 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect v, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect vxH, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) as H'; apply H'; apply Rle_refl
end).
Defined.

Check ltac:(ShowBound (proj1_sig turbine2_bound)).

Goal proj1_sig turbine2_bound <= 1.2e-13.
simpl; interval.
Qed.

Definition turbine3_bmap_list := [Build_varinfo Tdouble 1%positive (-45e-1) (-3e-1);Build_varinfo Tdouble 2%positive (4e-1) (9e-1);Build_varinfo Tdouble 3%positive (38e-1) (78e-1)].

Definition turbine3_bmap :=
 ltac:(let z := compute_PTree (boundsmap_of_list turbine3_bmap_list) in exact z).

Definition turbine3 (v : ftype Tdouble) (w : ftype Tdouble) (r : ftype Tdouble) : ftype Tdouble := 
  ((( (3 -  (2 / (r * r))) - (( (125e-3 * (1 + (2 * v))) *  (((w * w) * r) * r)) / (1 - v))) - (5e-1))%F64).

Definition turbine3_expr := 
 ltac:(let e' :=  HO_reify_float_expr constr:([1%positive;2%positive;3%positive]) turbine3 in exact e').


Lemma turbine3_bound:
	find_and_prove_roundoff_bound turbine3_bmap turbine3_expr.
Proof.
idtac "Starting turbine3".
time "turbine2" (
try (eexists; intro; prove_roundoff_bound);
try (prove_rndval; interval);
try prove_roundoff_bound2;
try error_rewrites;
try ((prune_terms (cutoff 70);
try match goal with |- (Rabs ?e <= ?a - 0)%R =>
  rewrite Rminus_0_r (* case prune terms will fail to produce reasonable bound on goal*)
end;
try match goal with |- (Rabs ?e <= ?a - ?b)%R =>
                      let G := fresh "G" in
                      interval_intro (Rabs e) as G ;
                      eapply Rle_trans;
                      [apply G | apply Rminus_plus_le_minus; apply Rle_refl] end));
(try rewrite Rsqr_pow2;
try field_simplify_Rabs;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( i_bisect vxH,
i_bisect v, 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with (
i_bisect v, 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect v0, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect v, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) with ( 
i_bisect vxH, i_depth 20) as H'; apply H'; apply Rle_refl
end;
try match goal with |- Rabs ?a <= _ =>
interval_intro (Rabs a) as H'; apply H'; apply Rle_refl
end)).
Defined.

Check ltac:(ShowBound (proj1_sig turbine3_bound)).

Goal proj1_sig turbine3_bound <= 6.1e-14.
simpl.
interval.
Qed.


End WITHNANS.
Close Scope R_scope.