# formal-verification-ai — Lean 4 Code

Lean 4 snippets from the presentation  
**"Formal Verification meets AI: Using Lean as a Practical Bridge"**  
Aziz Najjar · Formal Semantics, Spring 2026, ELTE

---

## Files

| File | What it proves |
|------|----------------|
| `lean/relu.lean` | `relu x ≥ 0` for all `x : ℝ` |
| `lean/vecadd.lean` | Vector addition is type-safe: `Fin 3 ≠ Fin 2` is a compile-time error |
| `lean/mse.lean` | MSE loss `≥ 0` via a compositional proof |

---

## Prerequisites

1. **Install `elan`** (Lean version manager)

   ```bash
   curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
   source ~/.profile   # or restart your shell
   ```

2. **Install the Lean 4 extension for VS Code**  
   Extensions panel → search `lean4` → install `leanprover.lean4`

---

## Reproducing the proofs

```bash
# Clone
git clone https://github.com/<your-username>/formal-verification-ai
cd formal-verification-ai

# Download the pre-built Mathlib cache (≈ 1 GB, one-time)
lake exe cache get

# Open in VS Code — the extension handles the rest
code .
```

Open any file in `lean/`. The Lean 4 extension shows:

- **Spinning orange indicator** — elaborating
- **Blue checkmark** in the Infoview — proof accepted
- **Red/orange squiggles** — type error (try uncommenting the last line of `vecadd.lean`)

---

## Building from the command line

```bash
lake build
```

Each file compiles independently. To check a single file:

```bash
lake build lean/relu
lake build lean/vecadd
lake build lean/mse
```

---

## Lean version

```
leanprover/lean4 : stable
mathlib4          : latest compatible release (resolved by lake)
```

The `lakefile.lean` at the root pins these via `require mathlib`.

---

## References

| Paper | Link |
|-------|------|
| Yang et al. — *LeanDojo* (NeurIPS 2023) | [arXiv:2306.15626](https://arxiv.org/abs/2306.15626) |
| DeepMind — *AlphaProof* (2024) | [deepmind.google](https://deepmind.google/discover/blog/ai-solves-imo-problems-at-silver-medal-level/) |
| Ying et al. — *DeepSeek-Prover-V2* (2025) | [arXiv:2504.21801](https://arxiv.org/abs/2504.21801) |
| Edwards et al. — *TorchLean* (2026) | [arXiv:2602.22631](https://arxiv.org/abs/2602.22631) |
| Horpácsi, D. — *Formal Semantics* lecture notes, ELTE | Course material |

---

*AI tools used in preparation: ChatGPT (outline), Claude (wording review).*