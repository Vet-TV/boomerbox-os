#!/bin/bash
# BoomerBox OS - live-build configuration script
# Run: sudo ./build.sh
set -e

HERE="$(cd "$(dirname "$0")" && pwd)"
VERSION="$(tr -d '[:space:]' < "$HERE/VERSION" 2>/dev/null || echo)"
VERSION="${VERSION:-0.0.0-dev}"

# ISO volume labels are limited to 32 chars and uppercase ASCII; keep terse.
VOLUME_LABEL="BOOMERBOX_$(echo "$VERSION" | tr '.-' '__' | tr '[:lower:]' '[:upper:]')"

# Fetch Chicago95 once on the build host and stage it into includes.chroot,
# so live-build's chroot doesn't need network access for it. Skipped if the
# theme is already staged (e.g. on a re-run).
CHICAGO95_REF="${CHICAGO95_REF:-master}"
THEME_DEST="$HERE/config/includes.chroot/usr/share/themes/Chicago95"
if [ ! -d "$THEME_DEST" ]; then
  echo "==> Staging Chicago95 from upstream (ref=$CHICAGO95_REF)"
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  git clone --depth=1 --branch "$CHICAGO95_REF" \
    https://github.com/grassmunk/Chicago95.git "$TMP/Chicago95"

  install -d "$HERE/config/includes.chroot/usr/share/themes" \
             "$HERE/config/includes.chroot/usr/share/icons" \
             "$HERE/config/includes.chroot/usr/share/fonts/truetype/chicago95" \
             "$HERE/config/includes.chroot/etc/skel/.config/xfce4/panel"

  cp -r "$TMP/Chicago95/Theme/Chicago95"   "$THEME_DEST"
  cp -r "$TMP/Chicago95/Icons/Chicago95"   "$HERE/config/includes.chroot/usr/share/icons/Chicago95"
  cp -r "$TMP/Chicago95/Cursors/Chicago95" "$HERE/config/includes.chroot/usr/share/icons/Chicago95-cursor"

  find "$TMP/Chicago95/Fonts" -type f \( -iname '*.ttf' -o -iname '*.otf' \) \
    -exec cp {} "$HERE/config/includes.chroot/usr/share/fonts/truetype/chicago95/" \; || true

  if [ -f "$TMP/Chicago95/Extras/Whisker-Menu/whiskermenu-1.rc" ]; then
    cp "$TMP/Chicago95/Extras/Whisker-Menu/whiskermenu-1.rc" \
       "$HERE/config/includes.chroot/etc/skel/.config/xfce4/panel/whiskermenu-1.rc"
  fi
fi

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
