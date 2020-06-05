command -v yay >/dev/null  || ./yay-installer.sh
yay --noconfirm --needed -Syu $@
