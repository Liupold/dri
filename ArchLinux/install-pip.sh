command -v pip >/dev/nul || ./pip-installer.sh
sudo -H python -m pip install $@
