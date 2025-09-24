#!/usr/bin/bash

set -Eeuo pipefail

SOURCE_DIR="/etc"  #backing up /etc
BACKUP_DIR="/home/anya/backups" #where to store archives
RETAIN_COUNT=5 #Keep backup for 5 days


mkdir -p "$BACKUP_DIR"

HOST="$(hostname -s)"
WHEN="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
ARCHIVE="${BACKUP_DIR}/${HOST}-backup-${WHEN}.tar.gz"

echo "[*] Creating: $ARCHIVE"
tar -czf "$ARCHIVE" \
  --warning=no-file-changed \
  --ignore-failed-read \
  --exclude=/proc \
  --exclude=/sys \
  --exclude=/run \
  --exclude=/dev \
  --exclude=/tmp \
  --exclude=/var/tmp \
  --exclude=/var/run \
  -C / "$SOURCE_DIR"

sha256sum "$ARCHIVE" > "${ARCHIVE}.sha256"

echo "[*] Applying retention --> Keep last ${RETAIN_COUNT}"
ls -lt "${BACKUP_DIR}"/"${HOST}-backup-"*.tar.gz 2>/dev/null | tail -n +$((RETAIN_COUNT+1)) | xargs -r rm -f

SIZE=$(du -h "$ARCHIVE" | awk '{print $1')
echo "Done --> The file is: $ARCHIVE & the size is: $SIZE"
