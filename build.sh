#!/bin/bash
# BoomerBox OS - live-build configuration script
# Run: sudo ./build.sh
set -e

VERSION="0.0.0-dev"
if [ -f "$(dirname "$0")/VERSION" ]; then
  VERSION="$(tr -d '[:space:]' < "$(dirname "$0")/VERSION")"
fi

# ISO volume labels are uppercase ASCII; replace dots/dashes with underscores.
VOLUME_LABEL="BOOMERBOX_$(echo "$VERSION" | tr '.-' '__' | tr '[:lower:]' '[:upper:]')"

lb config noauto \
  --mode debian \
  --distribution bookworm \
  --architectures amd64 \
  --linux-flavours amd64 \
  --archive-areas "main contrib non-free non-free-firmware" \
  --iso-application "BoomerBox OS" \
  --iso-publisher "BoomerBox Project; https://github.com/Vet-TV/boomerbox-os" \
  --iso-volume "$VOLUME_LABEL" \
  --image-name "boomerbox-${VERSION}" \
  --bootappend-live "boot=live components quiet splash username=boomer hostname=boomerbox" \
  --memtest memtest86+ \
  --apt-recommends true \
  "${@}"
