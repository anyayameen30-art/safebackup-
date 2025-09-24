#!/usr/bin/env bash
# --- Simple Restore Script ---
set -Eeuo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <archive.tar.gz|tar.zst> <restore_dir>"
  exit 1
fi

ARCHIVE="$1"
RESTORE_DIR="$2"

# sanity checks
[[ -r "$ARCHIVE" ]] || { echo "Archive not readable: $ARCHIVE"; exit 1; }

mkdir -p "$RESTORE_DIR"
echo "Restoring $ARCHIVE --> $RESTORE_DIR"

# verify checksum if available
if [[ -f "${ARCHIVE}.sha256" ]]; then
  echo "Verifying checksum..."
  if ! sha256sum -c "${ARCHIVE}.sha256"; then
    echo "Checksum FAILED — aborting restore."
    exit 1
  fi
fi

# extract based on type
case "$ARCHIVE" in
  *.tar.gz)  tar -xzf "$ARCHIVE" -C "$RESTORE_DIR" ;;
  *.tar.zst) tar --zstd -xf "$ARCHIVE" -C "$RESTORE_DIR" ;;
  *) echo "Unsupported archive type: $ARCHIVE"; exit 1 ;;
esac

echo "Restore complete!"

# show a quick view of what was restored
if command -v tree >/dev/null 2>&1; then
  tree -L 2 "$RESTORE_DIR"
else
  ls -R "$RESTORE_DIR" | head -n 50
fi

