import Mathlib.Data.Fin.Basic
import Mathlib.Data.Fin.Tuple.Basic

/-!
# Example 2 — Vector Dimension Safety

Shape mismatch is the most common runtime crash in deep learning
frameworks (PyTorch, JAX, TensorFlow).

Here we define vector addition where the size `n` is a
*type-level* parameter. Lean's type checker enforces that both
arguments have the same length — at compile time, with no
runtime overhead.

Course connection (Lec. 1):
  Dependent types implement a form of static semantics that goes
  beyond what context-free grammars can express.
-/

-- `Fin n → ℝ` is a vector of exactly n real numbers.
-- The type itself carries the length constraint.
def vecAdd (a b : Fin n → ℝ) : Fin n → ℝ :=
  fun i => a i + b i

-- Sample vectors
def v3 : Fin 3 → ℝ := ![1, 2, 3]
def v2 : Fin 2 → ℝ := ![4, 5]

-- This type-checks: both have length 3
#check vecAdd v3 v3   -- Fin 3 → ℝ

-- This is a TYPE ERROR — caught before any code runs:
-- #check vecAdd v3 v2
-- ^ application type mismatch: expected Fin 3 → ℝ, got Fin 2 → ℝ
