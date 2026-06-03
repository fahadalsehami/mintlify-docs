#!/usr/bin/env bash
# Push the Medera docs to GitHub.
#
# The repo lives at https://github.com/fahadalsehami/mintlify-docs.git on main.
# This script handles three things:
#   1. Cleans up any stuck .git/index.lock left over from sandbox sessions
#   2. Stages and commits any pending changes (with a sensible message)
#   3. Pushes to origin/main
#
# Auth options:
#   - HTTPS + GitHub CLI:   brew install gh && gh auth login
#   - HTTPS + Personal Access Token: with `repo` scope, used as the password
#   - SSH:                   bash push.sh ssh   (switches the remote to git@github.com)

set -euo pipefail
cd "$(dirname "$0")"

# 1. Release stuck lock (sandbox sessions sometimes leave one behind)
if [[ -f .git/index.lock ]]; then
  echo "→ Releasing stuck .git/index.lock"
  rm -f .git/index.lock
fi

# 2. Stage and commit any pending changes
if [[ -n "$(git status --porcelain)" ]]; then
  echo "→ Staging pending changes"
  git add -A
  COMMIT_MSG="${COMMIT_MSG:-docs: sync pending changes}"
  git commit -m "$COMMIT_MSG"
fi

# 3. Optionally switch to SSH
if [[ "${1:-}" == "ssh" ]]; then
  git remote set-url origin git@github.com:fahadalsehami/mintlify-docs.git
fi

echo "→ Pushing to: $(git remote get-url origin)"
git push -u origin main

echo
echo "✅ Pushed. Connect the repo in the Mintlify dashboard:"
echo "   https://dashboard.mintlify.com"
