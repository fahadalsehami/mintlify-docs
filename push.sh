#!/usr/bin/env bash
# Push the Medera docs to GitHub.
#
# The repo is already initialized, committed, and has `origin` set to
# https://github.com/fahadalsehami/mintlify-docs.git on the `main` branch.
# This script just runs the push from your machine, where your GitHub
# credentials live.
#
# Authentication options:
#   1. HTTPS + GitHub CLI (recommended):  brew install gh && gh auth login
#   2. HTTPS + Personal Access Token:     create a PAT with `repo` scope at
#                                         https://github.com/settings/tokens
#                                         and use it as the password when prompted
#   3. SSH:                                run `bash push.sh ssh` to switch the
#                                         remote to git@github.com:... before pushing

set -euo pipefail

cd "$(dirname "$0")"

if [[ "${1:-}" == "ssh" ]]; then
  git remote set-url origin git@github.com:fahadalsehami/mintlify-docs.git
fi

echo "Pushing to: $(git remote get-url origin)"
git push -u origin main
echo
echo "✅ Pushed. Connect the repo in the Mintlify dashboard: https://dashboard.mintlify.com"
