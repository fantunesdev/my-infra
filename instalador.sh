#!/bin/bash

INITIAL_DIRECTORY=$(pwd)
UBUNTU_CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d '=' -f2)

sudo apt update && sudo apt upgrade -y
sudo apt install -y vim bashtop btop ncdu duf bat tilix nemo

sudo mount -t ntfs /dev/sdb1 /home/fernando/Downloads/
mv /home/fernando/Documentos/ /home/fernando/documentos/
sudo mount -t ntfs /dev/sdc1 /home/fernando/documentos/

# Instalação do dracula no Grub
cd /tmp
git clone https://github.com/dracula/grub.git
sudo mkdir /boot/grub/themes
sudo mv grub/dracula/ /boot/grub/themes/
sudo echo 'GRUB_THEME="/boot/grub/themes/dracula/theme.txt"' >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg


######## SETAR PROGRAMAS PADRÃO ########
sudo update-alternatives --config x-terminal-emulator
xdg-mime default nemo.desktop inode/directory application/xgnome-saved-search


######## APT ########

sudo apt install -y gparted keepassxc alacarte gsmartcontrol calibre conky-all unzip snapd code stacer \
virtualbox github-desktop gnome-tweaks flameshot youtube-dl youtubedl-gui vlc steam lutris audacity \
telegram-desktop


######## BRAVE BROWSER ########
sudo apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser
cp /home/fernando/documentos/escritorio/Bookmarks/Bookmarks.json /home/fernando/.config/BraveSoftware/Brave-Browser/Default/Bookmarks


######## STRAWBERY 
STRAWBERY_URL='https://files.strawberrymusicplayer.org/'
LATEST_STRAWBERY=$(curl $STRAWBERY_URL | grep $UBUNTU_CODENAME | grep -v sha256sum | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2  | tail -1)
wget $STRAWBERY_URL$LATEST_STRAWBERY
sudo apt install -y ./$LATEST_STRAWBERY
sudo apt --fix-broken install -y


####### PYENV DEPENDENCES ##########
sudo apt install -y libedit-dev libncurses5-dev zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev \
liblzma-dev libreadline-dev g++ make python-tk python3-tk tk-dev


####### FLATPAKS #########
flatpak install -y com.anydesk.Anydesk com.discordapp.Discord com.getpostman.Postman com.snes9x.Snes9x \
org.avidemux.Avidemux org.chromium.Chromium org.chromium.Chromium.Codecs org.duckstation.DuckStation \
org.gimp.GIMP org.inkscape.Inkscape org.libretro.RetroArch org.onlyoffice.desktopeditors \
org.qbittorrent.qBittorrent Dorg.signal.Signal rest.insomnia.Insomnia in.srev.guiscrcpy \
com.spotify.Client io.github.Foldex.AdwSteamGt com.authy.Authy net.ankiweb.Anki com.bitwarden.desktop


######## SNAPS ########

PYCHARM_RELEASE='pycharm-professional'
sudo snap install $PYCHARM_RELEASE --classic


######## SGBDs ########
sudo apt install -y postgresql postgresql-contrib libpq-dev
sudo apt install -y mysql-server mysql-client libmysqlclient-dev


######## UNIFIED REMOTE ########
cd /tmp
REDIRECT_LINK=$(curl https://www.unifiedremote.com/download/linux-x64-deb | cut -d' ' -f4)
UNIFIED_REMOTE_URL="https://www.unifiedremote.com$REDIRECT_LINK"
wget $UNIFIED_REMOTE_URL
UNIFIED_REMOTE_VERSION=$(echo $REDIRECT_LINK | rev | cut -d'/' -f1 | rev)
sudo apt install -y ./$UNIFIED_REMOTE_VERSION
