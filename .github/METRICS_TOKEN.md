# Fixing `METRICS_TOKEN` (Lowlighter Metrics)

The metrics workflow fails with **`Bad credentials`** when this secret is expired or revoked.

## 1. Create a Personal Access Token

### Classic PAT (simplest)

1. GitHub → **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. **Generate new token (classic)**
3. Scopes:
   - **`public_repo`** (required for committing SVGs to this public profile repo)
   - Optional: **`read:user`** if you want richer profile plugins
4. Generate and **copy the token once**

### Fine-grained PAT (alternative)

1. **Fine-grained tokens** → Generate
2. Resource owner: your user
3. Repository access: **Only select repositories** → `humank/humank`
4. Permissions:
   - **Contents**: Read and write
   - **Metadata**: Read-only
5. Generate and copy

## 2. Store it as a repo secret

1. Open https://github.com/humank/humank/settings/secrets/actions
2. Edit **`METRICS_TOKEN`** (or create it)
3. Paste the new token → Save

## 3. Re-run the workflow

1. https://github.com/humank/humank/actions/workflows/metrics.yml
2. **Run workflow** → branch `master`
3. Confirm a commit like `chore: update metrics [skip ci]` lands and SVGs under `metrics/` refresh

## Notes

- Workflow runs **daily** and on **manual dispatch** only (not on every push).
- Commit messages include **`[skip ci]`** so metrics pushes do not re-trigger Actions.
- Action is pinned to **`lowlighter/metrics@v3.34`**.
