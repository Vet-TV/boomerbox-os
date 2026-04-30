# Changelog

All notable changes to BoomerBox OS are recorded in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0-alpha] - 2026-04-30

### Added
- `VERSION` file as the single source of truth for the release version.
- ISO and image filenames are now version-stamped
  (e.g. `boomerbox-0.2.0-alpha-amd64.hybrid.iso`).
- XFCE xfconf defaults baked into `/etc/skel`
  (`xsettings.xml`, `xfwm4.xml`) so the Chicago95 look is selected on first
  session start without any user intervention.
- Cloud-gaming launchers (GeForce NOW, Xbox Cloud, Amazon Luna) now ship as
  proper system-wide `.desktop` entries — they appear in the Start menu, and
  a chroot hook mirrors them onto every new user's Desktop.
- `CHANGELOG.md`.

### Changed
- `boomerbox-firstboot` is now idempotent (`~/.boomerbox-firstboot-done`
  marker), logs to `~/.boomerbox-firstboot.log` (survives reboots, unlike
  `/tmp`), notifies on Steam-install success/failure, and marks the
  pre-baked Desktop launchers executable so the "Untrusted launcher" prompt
  doesn't fire.
- Third-party license table updated to reflect actual installed packages
  (DOSBox vs the previously claimed DOSBox-Staging) and to document
  GameMode.
- README rewritten for 0.2.0-alpha — release-cut instructions, default
  user/password, what's on the ISO, fixed the DOSBox naming.

### Fixed
- README claimed "DOSBox-Staging" but the package list installed plain
  `dosbox`. Naming reconciled.

## [0.1.0-alpha] - 2026-04-30

Initial pivot to Debian Bookworm + live-build. Live-only ISO, deferred Steam
install on first boot due to i386 multiarch timing inside live-build.

[0.2.0-alpha]: https://github.com/Vet-TV/boomerbox-os/releases/tag/v0.2.0-alpha
[0.1.0-alpha]: https://github.com/Vet-TV/boomerbox-os/releases/tag/v0.1.0-alpha
