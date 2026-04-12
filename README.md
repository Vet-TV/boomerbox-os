# BoomerBox OS

A retro-styled, modern Linux distribution for gaming. Looks like Windows 98. Runs on modern hardware. Plays everything from DOS to Steam.

Built on **Debian Bookworm + XFCE + Chicago95 theme**. Ships Steam, Wine, RetroArch, DOSBox-Staging, ScummVM, and cloud gaming shortcuts (GeForce NOW, Xbox Cloud, Amazon Luna) out of the box.

## Status
Alpha. Not ready for daily driving. Test in a VM first.

## Building Locally (Docker - any OS)

From inside this folder:

```bash
docker run --rm --privileged -v "${PWD}:/build" -w /build debian:bookworm bash -c "apt-get update && apt-get install -y --no-install-recommends live-build debootstrap squashfs-tools xorriso isolinux syslinux-common grub-pc-bin grub-efi-amd64-bin mtools dosfstools ca-certificates git sudo && chmod +x build.sh && ./build.sh && lb build && mkdir -p out && mv *.iso out/"
```

The ISO lands in `./out/`. Flash with [Ventoy](https://www.ventoy.net) or `dd`.

**Build time:** 30-60 minutes on first run (downloads ~3 GB of Debian packages). Subsequent builds are faster thanks to apt cache.

## Automated Builds
Every push to `main` triggers a GitHub Actions build. Tagged releases (`v*`) publish the ISO to the Releases page.

## Why Debian instead of Arch?
- The `gtk2-engines-murrine` package required by Chicago95 was dropped from Arch's official repos in late 2025 (GTK2 EOL). Debian still ships it as a first-class package.
- More stable base — gaming distros need predictability.
- `live-build` is mature, well-documented, and battle-tested by Tails, Kali, and dozens of other live distros.

## License
GPLv3. Third-party components retain their original licenses — see `THIRD_PARTY_LICENSES.md`.

## Credits
- [Chicago95](https://github.com/grassmunk/Chicago95) — the Win95 theme that makes this whole thing work
- Debian, XFCE, Steam, Valve's Proton, RetroArch, and the entire Linux gaming community

## NOT Affiliated With
Microsoft. We do not ship any Microsoft assets, fonts, sounds, or trademarks.
