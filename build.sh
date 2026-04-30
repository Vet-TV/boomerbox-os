#!/bin/bash
# BoomerBox OS - live-build configuration script
# Run: sudo ./build.sh
set -e

VERSION="$(cat "$(dirname "$0")/VERSION" 2>/dev/null | tr -d '[:space:]')"
VERSION="${VERSION:-0.0.0-dev}"

# ISO volume labels are limited to 32 chars and uppercase ASCII; keep terse.
VOLUME_LABEL="BOOMERBOX_$(echo "$VERSION" | tr '.-' '__' | tr '[:lower:]' '[:upper:]')"

lb config noauto \
  --mode debian \
  --distribution bookworm \
  --architectures amd64 \
  --linux-flavours amd64 \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer false \
  --iso-application "BoomerBox OS" \
  --iso-publisher "BoomerBox Project; https://github.com/Vet-TV/boomerbox-os" \
  --iso-volume "$VOLUME_LABEL" \
  --image-name "boomerbox-${VERSION}" \
  --bootappend-live "boot=live components quiet splash username=boomer hostname=boomerbox locales=en_US.UTF-8 keyboard-layouts=us" \
  --memtest memtest86+ \
  --apt-recommends true \
  "${@}"
