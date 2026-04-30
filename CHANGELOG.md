# Changelog

All notable changes to BoomerBox OS are recorded in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0-alpha] - 2026-04-30

### Added
- Chicago95 theme, icons, cursors, and bundled GPL fonts are now pre-installed
  system-wide during ISO build (no internet required at first boot). The fetch
  runs on the build host via `build.sh`, so the chroot doesn't need network
  for it.
- XFCE xfconf defaults baked into `/etc/skel` so the Win95 look is applied on
  first session start without any user intervention.
- Cloud-gaming launchers (GeForce NOW, Xbox Cloud, Amazon Luna) ship as proper
  system-wide `.desktop` entries — they appear in the Start menu *and* on every
  new user's Desktop.
- ISO and image filenames are now version-stamped (e.g. `boomerbox-0.2.0-alpha-amd64.hybrid.iso`).
- `VERSION` file as the single source of truth for the release version.
- `CHANGELOG.md`.

### Changed
- `boomerbox-firstboot` is now idempotent and far smaller. It no longer clones
  Chicago95 over the network; it only does a defensive theme reapply, marks
  desktop launchers as trusted, and kicks off the deferred Steam install.
- First-boot logs are now written to the user's home directory
  (`~/.boomerbox-firstboot.log`) instead of `/tmp`, so they survive reboots.
- `build.sh` now passes `--debian-installer false` explicitly and sets sane
  default locale/keyboard via `bootappend-live`.
- Third-party license table updated to reflect actual installed packages
  (DOSBox vs DOSBox-Staging) and to include MangoHud and GameMode.

### Fixed
- README claimed "DOSBox-Staging" but the package list installed plain `dosbox`.
  Naming reconciled.
- Race-prone "untrusted launcher" prompts on the cloud gaming desktop shortcuts
  (now baked in with executable bit and trust metadata).

## [0.1.0-alpha] - 2026-04-30

Initial pivot to Debian Bookworm + live-build. Live-only ISO, deferred Steam
install on first boot due to i386 multiarch timing inside live-build.

[0.2.0-alpha]: https://github.com/Vet-TV/boomerbox-os/releases/tag/v0.2.0-alpha
[0.1.0-alpha]: https://github.com/Vet-TV/boomerbox-os/releases/tag/v0.1.0-alpha
