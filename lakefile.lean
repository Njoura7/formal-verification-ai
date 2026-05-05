import Lake
open Lake DSL

package «formal-verification-ai» where
  name := "formal-verification-ai"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "stable"

lean_lib «FormalVerificationAI» where
  globs := #[.submodules `lean]
