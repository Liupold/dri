command -v yay >/dev/null  || ./aur-installer.sh
yay --noconfirm --needed -Syu $@
