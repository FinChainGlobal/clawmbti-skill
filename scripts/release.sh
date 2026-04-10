#!/usr/bin/env bash
# Promote dev → main with prod URL substitution, then push.
# Usage: bash scripts/release.sh

set -euo pipefail

DEV_URL="https://clawmbti-dev.myfinchain.com"
PROD_URL="https://clawmbti.finchain.global"
DEV_KEY="sk-clawmbti"
PROD_KEY="mbti-main"

if [ "$(git branch --show-current)" != "dev" ]; then
  echo "Error: must be on dev branch" && exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Error: uncommitted changes. Please commit or stash first." && exit 1
fi

echo "Exporting dev → prod..."

TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Export current dev state (no .git, no untracked files)
git archive HEAD | tar -x -C "$TEMP_DIR"

# Substitute dev → prod URLs in temp copy
find "$TEMP_DIR" -type f \( -name "*.py" -o -name "*.md" \) \
  -exec sed -i '' "s|$DEV_URL|$PROD_URL|g" {} \; \
  -exec sed -i '' "s|$DEV_KEY|$PROD_KEY|g" {} \;

# Switch to main, overwrite with prod version, commit, push
git checkout main
rsync -a --delete --exclude='.git' "$TEMP_DIR/" .
git add -A
git diff --cached --quiet || git commit -m "release: $(date +%Y-%m-%d)"
git push origin main

git checkout dev
echo "✓ Released to main and pushed to origin"
