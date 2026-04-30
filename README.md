# BoomerBox OS

A retro-styled, modern Linux distribution for gaming. Looks like Windows 98. Runs on modern hardware. Plays everything from DOS to Steam.

Built on **Debian Bookworm + XFCE + Chicago95 theme**. Ships Steam (installed on first boot), Wine, RetroArch, DOSBox, ScummVM, and cloud gaming shortcuts (GeForce NOW, Xbox Cloud, Amazon Luna) out of the box.

## Status
**Current release:** `0.2.0-alpha`. Alpha quality — not ready for daily driving. Test in a VM first.

See [CHANGELOG.md](./CHANGELOG.md) for what's new.

## Building Locally (Docker — any host OS)

From inside this folder:

```bash
docker run --rm --privileged -v "${PWD}:/build" -w /build debian:bookworm bash -c '
  apt-get update && \
  apt-get install -y --no-install-recommends \
    live-build debootstrap squashfs-tools xorriso \
    isolinux syslinux-common grub-pc-bin grub-efi-amd64-bin \
    mtools dosfstools ca-certificates git sudo && \
  chmod +x build.sh && ./build.sh && lb build && \
  mkdir -p out && mv boomerbox-*.iso out/
'
```

The ISO lands in `./out/`. Flash with [Ventoy](https://www.ventoy.net) or `dd`.

**Build time:** 30–60 minutes on first run (downloads ~3 GB of Debian packages and the Chicago95 theme). Subsequent builds reuse the apt cache.

## Automated Builds
Every push to `main` triggers a GitHub Actions build that uploads the ISO as a workflow artifact. Tagging a commit `vX.Y.Z[-suffix]` (e.g. `v0.2.0-alpha`) publishes the ISO to the [Releases page](https://github.com/Vet-TV/boomerbox-os/releases) automatically.

To cut a release:

```bash
git tag v0.2.0-alpha
git push origin v0.2.0-alpha
```

## What's on the ISO

- **Desktop:** XFCE 4 with the [Chicago95](https://github.com/grassmunk/Chicago95) theme pre-applied (icons, cursors, Whisker Start menu, fonts).
- **Modern gaming:** Steam (deferred install on first boot), Wine + winetricks, GameMode, full gamepad/joystick stack.
- **Retro gaming:** RetroArch with SNES, NES, Genesis, and GBA cores; ScummVM; DOSBox.
- **Cloud gaming:** One-click launchers for GeForce NOW, Xbox Cloud, and Amazon Luna (via Chromium app mode).
- **Drivers/firmware:** Mesa, AMD/Intel/Nouveau X drivers, full non-free firmware, Intel + AMD microcode.
- **Audio:** PipeWire + WirePlumber.
- **Networking:** NetworkManager + GUI applet.

## Why Debian instead of Arch?
- The `gtk2-engines-murrine` package required by Chicago95 was dropped from Arch's official repos in late 2025 (GTK2 EOL). Debian still ships it as a first-class package.
- More stable base — gaming distros need predictability.
- `live-build` is mature, well-documented, and battle-tested by Tails, Kali, and dozens of other live distros.

## Default Live User
- **Username:** `boomer`
- **Password:** *(none — passwordless login on the live ISO; passwordless `sudo` is enabled for convenience)*

## License
GPLv3. Third-party components retain their original licenses — see [THIRD_PARTY_LICENSES.md](./THIRD_PARTY_LICENSES.md).

## Credits
- [Chicago95](https://github.com/grassmunk/Chicago95) — the Win95 theme that makes this whole thing work.
- Debian, XFCE, Steam, Valve's Proton, RetroArch, and the entire Linux gaming community.

## NOT Affiliated With
Microsoft. We do not ship any Microsoft assets, fonts, sounds, or trademarks.
