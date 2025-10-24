#!/bin/bash

set -ouex pipefail

# COPRs, DMS
dnf5 -y copr enable yalter/niri
dnf5 -y copr disable yalter/niri
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:yalter:niri install niri
rm -rf /usr/share/doc/niri

dnf5 -y copr enable errornointernet/quickshell
dnf5 -y copr disable errornointernet/quickshell
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:errornointernet:quickshell install quickshell

dnf5 -y copr enable purian23/material-symbols-fonts
dnf5 -y copr disable purian23/material-symbols-fonts
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:purian23:material-symbols-fonts install material-symbols-fonts

dnf5 -y copr enable avengemedia/dms
dnf5 -y copr disable avengemedia/dms
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:avengemedia:dms install \
    dms \
    dms-greeter

dnf5 -y copr enable scottames/ghostty
dnf5 -y copr disable scottames/ghostty
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:scottames:ghostty install ghostty

dnf5 -y copr enable zirconium/packages
dnf5 -y copr disable zirconium/packages
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:zirconium:packages install \
    matugen \
    cliphist

mkdir ~/.config/quickshell && git clone https://github.com/AvengeMedia/DankMaterialShell.git ~/.config/quickshell/dms
sh -c "curl -L https://github.com/AvengeMedia/danklinux/releases/latest/download/dms-$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/').gz | gunzip | tee /usr/local/bin/dms > /dev/null && chmod +x /usr/local/bin/dms"

dnf5 -y copr enable avengemedia/danklinux
dnf5 -y copr disable avengemedia/danklinux
dnf5 -y --enablerepo copr:copr.fedorainfracloud.org:avengemedia:danklinux install \
     hyprpicker \
     dgop \
     brightnessctl \
     cava \
     qt6-multimedia \
     accountsservice

# dms-greeter
groupadd -r greeter
useradd -r -g greeter -d /var/lib/greeter -s /bin/bash -c "System Greeter" greeter
mkdir -p /var/lib/greeter
chown greeter:greeter /var/lib/greeter

## Cache directory for DMS-Greeter
mkdir -p /var/cache/dms-greeter
chown greeter:greeter /var/cache/dms-greeter
chmod 750 /var/cache/dms-greeter

usermod -aG greeter $USER
setfacl -m u:greeter:x ~ ~/.config ~/.local ~/.cache ~/.local/state
chgrp -R greeter ~/.config/DankMaterialShell ~/.local/state/DankMaterialShell ~/.cache/quickshell
chmod -R g+rX ~/.config/DankMaterialShell ~/.local/state/DankMaterialShell ~/.cache/quickshell
ln -sf ~/.config/DankMaterialShell/settings.json /var/cache/dms-greeter/settings.json
ln -sf ~/.local/state/DankMaterialShell/session.json /var/cache/dms-greeter/session.json
ln -sf ~/.cache/DankMaterialShell/dms-colors.json /var/cache/dms-greeter/colors.json


# gaming stuff
dnf5 -y install \
     steam \
     gamemode \
     mangohud \
     gamescope \
     lutris

systemctl enable --now gamemoded.service


# main packages ig lol
dnf5 -y install \
     hyfetch \
     greetd \
     greetd-selinux \
     steam-devices \
     udiskie \
     wlsunset \
     xdg-desktop-portal-wlr \
     wl-clipboard


# qt stuff
dnf5 -y install --setopt=install_weak_deps=False \
    kf6-kirigami \
    qt6ct \
    polkit-kde \
    plasma-breeze \
    kf6-qqc2-desktop-style


# zirconium stuff i yanked
sed -i '/gnome_keyring.so/ s/-auth/auth/ ; /gnome_keyring.so/ s/-session/session/' /etc/pam.d/greetd
cat /etc/pam.d/greetd


sed -i "s/After=.*/After=graphical-session.target/" /usr/lib/systemd/user/plasma-polkit-agent.service

add_wants_niri() {
    sed -i "s/\[Unit\]/\[Unit\]\nWants=$1/" "/usr/lib/systemd/user/niri.service"
}
add_wants_niri noctalia.service
add_wants_niri plasma-polkit-agent.service
add_wants_niri swayidle.service
add_wants_niri udiskie.service
add_wants_niri xwayland-satellite.service
cat /usr/lib/systemd/user/niri.service


# services
systemctl disable gdm
systemctl enable greetd

systemctl enable --global plasma-polkit-agent.service
systemctl enable --global swayidle.service
systemctl enable --global udiskie.service
systemctl enable --global xwayland-satellite.service


# fonts
dnf5 -y install \
    default-fonts-core-emoji \
    google-noto-color-emoji-fonts \
    google-noto-emoji-fonts \
    glibc-all-langpacks \
    default-fonts

## DMS
curl -L "https://github.com/google/material-design-icons/raw/master/variablefont/MaterialSymbolsRounded%5BFILL%2CGRAD%2Copsz%2Cwght%5D.ttf" -o /usr/share/fonts/MaterialSymbolsRounded.ttf
curl -L "https://github.com/rsms/inter/raw/refs/tags/v4.1/docs/font-files/InterVariable.ttf" -o /usr/share/fonts/InterVariable.ttf
curl -L "https://github.com/tonsky/FiraCode/releases/latest/download/FiraCode-Regular.ttf" -o /usr/share/fonts/FiraCode-Regular.ttf

## Maple Mono
mkdir -p "/usr/share/fonts/Maple_Mono"

MAPLE_TMPDIR="$(mktemp -d)"
trap 'rm -rf "${MAPLE_TMPDIR}"' EXIT

LATEST_RELEASE_FONT="$(curl "https://api.github.com/repos/subframe7536/maple-font/releases/latest" | jq '.assets[] | select(.name == "MapleMono-Variable.zip") | .browser_download_url' -rc)"
curl -fSsLo "${MAPLE_TMPDIR}/maple.zip" "${LATEST_RELEASE_FONT}"
unzip "${MAPLE_TMPDIR}/maple.zip" -d "/usr/share/fonts/Maple Mono"

echo 'source /usr/share/zirconium/shell/pure.bash' | tee -a "/etc/bashrc"