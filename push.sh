#!/usr/bin/env bash
# Push Medera docs to GitHub (fahadalsehami/mintlify-docs:main).
#
# Handles:
#   - stuck .git/index.lock left by sandbox sessions
#   - any pending unstaged changes (stages them + commits)
#   - HTTPS or SSH auth (pass `ssh` as first arg to switch remote)
#
# Auth options (HTTPS, default):
#   - `gh auth login`  (brew install gh)
#   - Personal Access Token with `repo` scope, used as the password when prompted
#
# Auth options (SSH):
#   `bash push.sh ssh`  switches remote to git@github.com:fahadalsehami/mintlify-docs.git

set -euo pipefail
cd "$(dirname "$0")"

echo "→ Working dir: $(pwd)"

# 1) Release any stuck lock
if [[ -f .git/index.lock ]]; then
  echo "→ Releasing stuck .git/index.lock"
  rm -f .git/index.lock
fi

# 2) Make sure we're on main
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$CURRENT_BRANCH" != "main" ]]; then
  echo "→ Switching from '$CURRENT_BRANCH' to main"
  git checkout main
fi

# 3) Stage and commit pending changes
git add -A
if ! git diff --cached --quiet; then
  echo "→ Committing pending changes"
  COMMIT_MSG="${COMMIT_MSG:-docs: production-ready release}"
  git -c user.email="famstanford@gmail.com" -c user.name="Fahad Alsehami" \
    commit -m "$COMMIT_MSG"
else
  echo "→ No pending changes to commit"
fi

# 4) Optionally switch to SSH
if [[ "${1:-}" == "ssh" ]]; then
  echo "→ Switching remote to SSH"
  git remote set-url origin git@github.com:fahadalsehami/mintlify-docs.git
fi

REMOTE_URL=$(git remote get-url origin)
echo "→ Remote: $REMOTE_URL"
echo "→ Pushing to origin/main"

# 5) Push (force on first push if remote is empty)
if ! git push -u origin main 2>/dev/null; then
  echo "→ Standard push failed — trying with --force-with-lease (safe force)"
  git push -u origin main --force-with-lease
fi

echo
echo "✅ Pushed to https://github.com/fahadalsehami/mintlify-docs"
echo
echo "Next: connect the repo in the Mintlify dashboard"
echo "   https://dashboard.mintlify.com"
echo "Mintlify auto-deploys on every push to main."
