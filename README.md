# <img width="182" height="84" alt="cooltext495840264446333" src="https://github.com/user-attachments/assets/8d17a9e6-79a9-47b7-bf60-a5103cbb870d" />
**This is now mostly unmaintained. Check out [Bizzite](https://github.com/Matthias-adR/bizzite) or [Zirconium](https://github.com/zirconium-dev/zirconium) instead. Bifin will still continue to work but see no additions.**

[![Build container image](https://github.com/Matthias-adR/bifin/actions/workflows/build.yml/badge.svg)](https://github.com/Matthias-adR/bifin/actions/workflows/build.yml) [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/matthias-adr/bifin)

### Opinionated Bluefin image with Niri and DankMaterialShell

This image is built on top of [Bluefin](https://projectbluefin.io) and aims to provide [Niri](https://github.com/YaLTeR/niri) and [DMS](https://github.com/AvengeMedia/DankMaterialShell), while using Bluefin-DX-NVIDIA.

## Purpose

The Containerfile is built directly off of [`bluefin-dx-nvidia-open:beta`](https://github.com/ublue-os/bluefin/pkgs/container/bluefin-dx-nvidia-open)

If you want something designed for general consumption, I suggest using [Zirconium](https://github.com/zirconium-dev/zirconium) or Bluefin from [Project Bluefin](https://projectbluefin.io).

## Usage

Oh well. On Bluefin or Bazzite with GNOME, type `sudo bootc switch ghcr.io/matthias-adr/bifin`.
This is not intended for general use and may break any time though, be warned.

*Notes:* 
- *On first time setup, please press Ctrl + Alt + F3, login in the TTY and then type `sudo dms-greeter --command niri`. After that, type reboot, and you should be good to go.*
- You must navigate to `/etc/niri/config.kdl` and copy its contents, and then paste it into `~/.config/niri/config.kdl` (create one if missing)
- I heavily recommend adding `QT_QPA_PLATFORMTHEME=qt6ct` to /etc/environment

## Credits

The folks over at Fedora and Project Bluefin are wonderful people. :D

Many parts of Bifin use parts of Zirconium made by [Tulip](https://github.com/tulilirockz) and [Valerie](https://github.com/valerie-tar-gz).

#### _In development. No warranty._

Also, pibble! 🩷💜💙
