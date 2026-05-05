import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-!
# Example 1 — ReLU is Non-Negative

ReLU (Rectified Linear Unit) is the standard activation function
in neural networks: relu(x) = max(0, x).

We prove that relu is non-negative for every real input.
This is a universal statement — it holds for *all* x : ℝ,
not just the finite set of inputs a test suite would cover.

Course connection (Lec. 3):
  Analogous to ⟦a⟧s being defined (and well-behaved) for *all* states s.
-/

noncomputable def relu (x : ℝ) : ℝ := max 0 x

theorem relu_nonneg (x : ℝ) : relu x ≥ 0 := by
  unfold relu           -- expand the definition of relu
  exact le_max_left 0 x -- apply the Mathlib lemma: 0 ≤ max 0 x
