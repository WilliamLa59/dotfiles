#!/usr/bin/env bash
set -euo pipefail
rsync -av --delete \
  --exclude='**/cache*/' --exclude='**/Cache*/' \
  --exclude='**/logs*/'  --exclude='**/*.log' \
  --exclude='**/*.sqlite*' --exclude='**/*.lock' \
  --exclude='**/.git' --exclude='**/.env*' \
  --exclude='**/*credentials*' --exclude='**/*secret*' \
  --exclude='**/*token*' --exclude='**/gh/hosts.yml' \
  --exclude='**/rclone/rclone.conf' --exclude='**/aws/credentials' \
  --exclude='**/docker/config.json' \
  ~/.config/ "$(dirname "$0")/.config/"
cd "$(dirname "$0")"
git add -A
git commit -m "update: $(date -Iseconds)" || true
git push
