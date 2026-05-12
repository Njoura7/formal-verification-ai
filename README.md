# formal-verification-ai — Lean 4 Code

Lean 4 snippets from the presentation  
**"Formal Verification meets AI: Using Lean as a Practical Bridge"**  
Aziz Najjar · Formal Semantics, Spring 2026, ELTE

---

## Files

| File               | What it proves                                                        |
| ------------------ | --------------------------------------------------------------------- |
| `lean/relu.lean`   | `relu x ≥ 0` for all `x : ℝ`                                          |
| `lean/vecadd.lean` | Vector addition is type-safe: `Fin 3 ≠ Fin 2` is a compile-time error |
| `lean/mse.lean`    | MSE loss `≥ 0` via a compositional proof                              |

---

## Prerequisites

### Option A — Native install (Linux / macOS)

1. **Install `elan`** (Lean version manager)

   ```bash
   curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
   source ~/.profile   # or restart your shell
   ```

2. **Install the Lean 4 extension for VS Code**  
   Extensions panel → search `lean4` → install `leanprover.lean4`

### Option B — Docker (recommended if you have SSL/proxy issues)

Only **Docker** is required — no local Lean, elan, or extensions needed.

```bash
docker compose build          # first build ≈ 30-60 min (downloads toolchain + mathlib)
docker compose run lean       # builds the project & verifies all proofs
```

To open an interactive Lean REPL inside the container:

```bash
docker compose run lean lake env lean
```

**Tip — making the VS Code extension work locally (Windows):**  
If the Lean 4 extension fails due to SSL errors, copy the toolchain from Docker:

```powershell
docker compose run lean tar cf - -C /root/.elan/toolchains . | tar xf - -C "$env:USERPROFILE\.elan\toolchains"
elan default leanprover--lean4---v4.30.0-rc2
```

---

## Reproducing the proofs

### With Docker

```bash
docker compose build
docker compose run lean
```

A successful build with **no errors** means every theorem is verified.  
Lean's type checker is the proof — if `lake build` exits 0, all proofs are accepted.

### Without Docker

```bash
# Clone
git clone https://github.com/Njoura7/formal-verification-ai
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

This builds the `FormalVerificationAI` library, which includes all files under `lean/`.

---

## Lean version

```
leanprover/lean4 : v4.30.0-rc2
mathlib4          : latest compatible release (resolved by lake)
```

The `lakefile.lean` at the root pins these via `require mathlib`.

---

## References

| Paper                                                 | Link                                                                                                   |
| ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| Yang et al. — _LeanDojo_ (NeurIPS 2023)               | [arXiv:2306.15626](https://arxiv.org/abs/2306.15626)                                                   |
| DeepMind — _AlphaProof_ (2024)                        | [deepmind.google](https://deepmind.google/discover/blog/ai-solves-imo-problems-at-silver-medal-level/) |
| Ying et al. — _DeepSeek-Prover-V2_ (2025)             | [arXiv:2504.21801](https://arxiv.org/abs/2504.21801)                                                   |
| Edwards et al. — _TorchLean_ (2026)                   | [arXiv:2602.22631](https://arxiv.org/abs/2602.22631)                                                   |
| Horpácsi, D. — _Formal Semantics_ lecture notes, ELTE | Course material                                                                                        |

---

_AI tools used in preparation: ChatGPT (outline), Claude (wording review)._
