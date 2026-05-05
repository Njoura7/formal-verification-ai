import Mathlib.Algebra.BigOperators.Basic
import Mathlib.Algebra.Order.Sum

/-!
# Example 3 — MSE Loss is Non-Negative

MSE (Mean Squared Error) is the most common regression loss:
  MSE(ys, ŷs) = Σᵢ (ysᵢ - ŷsᵢ)²

We prove it is non-negative for any pair of prediction vectors.

The proof is *compositional*:
  sq_nonneg   — every squared term ≥ 0         (leaf lemma)
  sum_nonneg  — sum of non-negative terms ≥ 0  (combinator)
  ─────────────────────────────────────────────────────────
  mse_nonneg  — the full MSE ≥ 0               (composed result)

Course connection (Lec. 3):
  Mirrors how denotational semantics builds meaning compositionally:
  ⟦e1 + e2⟧s = ⟦e1⟧s + ⟦e2⟧s
-/

theorem mse_nonneg (ys ŷs : Fin n → ℝ) :
    0 ≤ ∑ i : Fin n, (ys i - ŷs i) ^ 2 := by
  apply Finset.sum_nonneg   -- each summand ≥ 0  ⟹  sum ≥ 0
  intro i _
  exact sq_nonneg _         -- (ys i - ŷs i)² ≥ 0  ∎
