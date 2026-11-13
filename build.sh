#!/usr/bin/env bash
set -Eeuo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
source /etc/os-release
[[ $ID == debian && ${VERSION_CODENAME:-} == trixie && $(uname -m) == x86_64 ]] || {
    echo "Debian 13 amd64 derleme ortamı gerekiyor." >&2; exit 1;
}
[[ $EUID == 0 ]] || { echo "sudo bash build.sh kullanın." >&2; exit 1; }
profile=${1:-desktop}
case "$profile" in base|desktop) ;; *) echo "Kullanım: build.sh [base|desktop]" >&2; exit 2;; esac
command -v lb >/dev/null
root=$PWD
mkdir -p "build/$profile" dist
cd "build/$profile"
exec 9>.build.lock
flock -n 9
if [[ -d config ]]; then lb clean --purge; fi
lb config --mode debian --distribution trixie --architectures amd64 \
    --archive-areas "main contrib non-free-firmware" --binary-images iso-hybrid \
    --debian-installer live --debian-installer-gui true --debian-installer-distribution trixie \
    --iso-application "ElmaOS 1.0" --iso-volume "ElmaOS 1.0 amd64" \
    --bootappend-live "boot=live components locales=tr_TR.UTF-8 keyboard-layouts=tr timezone=Europe/Istanbul username=elma hostname=elmaos" \
    --bootappend-install "locale=tr_TR.UTF-8 keymap=tr hostname=elmaos"
mkdir -p config/package-lists config/includes.chroot config/hooks/live
cp "$root/base/packages.list.chroot" config/package-lists/
install -m 0755 "$root/base/010-brand.hook.chroot" config/hooks/live/
if [[ $profile == desktop ]]; then
    cp "$root/desktop/packages.list.chroot" config/package-lists/elma.list.chroot
    cp -a "$root/desktop/rootfs/." config/includes.chroot/
    chmod 0755 config/includes.chroot/usr/local/bin/elma-*
fi
lb build 2>&1 | tee "$root/build/$profile.log"
test -s live-image-amd64.hybrid.iso
name=ElmaOS-1.0-amd64.iso
[[ $profile != base ]] || name=ElmaOS-base-amd64.iso
install -m 0644 live-image-amd64.hybrid.iso "$root/dist/.$name.tmp"
mv -f "$root/dist/.$name.tmp" "$root/dist/$name"
cd "$root/dist"
sha256sum "$name" > "$name.sha256"
