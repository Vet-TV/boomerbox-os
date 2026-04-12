#!/bin/bash
# BoomerBox OS - live-build configuration script
# Run: sudo ./build.sh
set -e

lb config noauto \
  --mode debian \
  --distribution bookworm \
  --architectures amd64 \
  --linux-flavours amd64 \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer live \
  --iso-application "BoomerBox OS" \
  --iso-publisher "BoomerBox Project; https://github.com/Vet-TV/boomerbox-os" \
  --iso-volume "BOOMERBOX" \
  --image-name "boomerbox" \
  --bootappend-live "boot=live components quiet splash username=boomer hostname=boomerbox" \
  --memtest memtest86+ \
  --apt-recommends true \
  "${@}"
