#!/bin/bash

######## VARIÁVEIS GERAIS ########

INITIAL_DIRECTORY=$(pwd)
UBUNTU_CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d '=' -f2)

# CORES
RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'


######## FUNÇÕES ########

function prog_installer() {
    package_manager=$1
    programs=$2
    if [ $package_manager == 'apt' ]; then
        for program in ${programs[@]}; do
            if ! dpkg -l | grep -q $program; then
                sudo apt install -y $program;
            else
                echo -e "${GREEN}[JÁ INSTALADO] $program${NO_COLOR}"
            fi
        done
    elif [ $package_manager == 'flatpak' ]; then
        for program in ${programs[@]}; do
            if ! flatpak list | grep -q $program; then
                flatpak install -y $program;
            else
                echo -e "${GREEN}[JÁ INSTALADO] $program${NO_COLOR}"
            fi
        done
    else
        echo -e "${RED}[ERROR] Gerenciaor de pacotes inválido.${NO_COLOR}"
        echo 'Gerenciadores de pacotes válidos: apt e flatpak.'
        echo 'Por favor, tente novamente.'
        exit 2
    fi
}


# UPDATE
sudo apt update && sudo apt upgrade -y


######## FERRAMENTAS DE SISTEMA ########
SYSTEM_TOOLS=(
    vim         # Editor vi melhorado
    unzip       # Desarquivador para arquivos .zip
    bashtop     # Monitor de recursos em linha de comando
    btop        # Monitor de recursos em linha de comando
    ncdu        # Visualizador de uso de disco em ncurses
    duf         # Disk Usage/Free Utility
    bat         # Cat(1) clone with syntax highlighting and git integration
    tilix       # Tiling terminal emulator - data files
    nemo        # Gerenciador de arquivos e shell gráfico para Cinnamon
    postfix     # agente de transporte de e-mail ("mail transport agent") de alta performance - (Relatórios rsync)
    hplip       # Sistema de Imagem e Impressão HP Linux (HPLIP) - Driver do Scanner
)
system_tools="${SYSTEM_TOOLS[@]}"

prog_installer apt "$system_tools"

unset SYSTEM_TOOLS system_tools


######## MONTAGEM DOS HDs ########
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
APT_PROGRAMS=(
    gparted             # editor de partições GNOME
    keepassxc           # gerenciador de senhas interplataforma
    alacarte            # ferramenta de fácil edição do menu GNOME
    gsmartcontrol       # graphical user interface for smartctl
    calibre             # gerenciador de e-books poderoso e fácil de usar
    conky-all           # highly configurable system monitor (all features enabled)
    snapd               # daemon e ferramentas para habilitar pacotes snap
    code                # VS Code
    stacer              # Linux system optimizer and monitoring
    virtualbox          # solução de virtualização x86 - binários base
    github-desktop      # Simple collaboration from your desktop
    gnome-tweaks        # ferramenta para ajustar as configurações avançadas do GNOME
    flameshot           # software poderoso, ainda que simples de usar, de captura de tela
    youtubedl-gui       # GUI on youtube-dl to download videos from a variety of sites
    vlc                 # reprodutor e gerador de fluxo multimídia
    steam               # Valve's Steam digital software delivery system
    lutris              # video game preservation platform
    audacity            # editor de áudio multiplataforma rápido
    kdenlive            # editor de vídeo não-linear
    telegram-desktop    # aplicativo de mensagens rápido e seguro
    folder-color        # folder color for nautilus
    gnome-sushi         # sushi é um pré-visualizador rápido para o nautilus
)
apt_programs="${APT_PROGRAMS[@]}"

prog_installer apt "$apt_programs"

unset APT_PROGRAMS apt_programs


######## BRAVE BROWSER ########
sudo apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser
cp /home/fernando/documentos/escritorio/Bookmarks/Bookmarks.json /home/fernando/.config/BraveSoftware/Brave-Browser/Default/Bookmarks


######## STRAWBERY ########
STRAWBERY_URL='https://files.strawberrymusicplayer.org/'
LATEST_STRAWBERY=$(curl $STRAWBERY_URL | grep $UBUNTU_CODENAME | grep -v sha256sum | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2  | tail -1)
wget $STRAWBERY_URL$LATEST_STRAWBERY
sudo apt install -y ./$LATEST_STRAWBERY
sudo apt --fix-broken install -y

unset STRAWBERY_URL LATEST_STRAWBERY


####### PYENV DEPENDENCES ########
PYENV_DEPENDENCES=(
    libedit-dev         # Bibliotecas editline e history do BSD (desenvolvimento).
    libncurses5-dev     # transitional package for libncurses-dev
    zlib1g              # biblioteca de compressão - runtime (tempo de execução)
    zlib1g-dev          # biblioteca de compressão - desenvolvimento
    libssl-dev          # conjunto de ferramentas do Secure Sockets Layer - arquivos de desenvolvimento
    libbz2-dev          # high-quality block-sorting file compressor library - development
    libsqlite3-dev      # SQLite 3 development files
    liblzma-dev         # XZ-format compression library - development files
    libreadline-dev     # GNU readline and history libraries, development files
    g++                 # Compilador GCC
    make                # tool which controls the generation of executables and other non-source files of a program from the program's source files.
    python-tk           # Tkinter - Writing Tk applications with Python2
    python3-tk          # Tkinter - Writing Tk applications with Python 3.x
    tk-dev              # Toolkit for Tcl and X11 (default version) - development files
)
pyenv_dependences="${PYENV_DEPENDENCES[@]}"

prog_installer apt "$pyenv_dependences"

unset PYENV_DEPENDENCES pyenv_dependences


####### FLATPAKS #########
FLATPAK_PROGRAMS=(
    com.anydesk.Anydesk                     # Conectar com um computador remotamente
    com.discordapp.Discord                  # Messaging, Voice, and Video Client
    com.getpostman.Postman                  # Postman is a complete API development environment.
    rest.insomnia.Insomnia                  # Open Source API Client and Design Platform for GraphQL, REST and gRPC.
    org.avidemux.Avidemux                   # Multi-purpose video editing and processing software
    com.google.Chrome                       # The web browser from Google
    org.chromium.Chromium                   # The web browser from Chromium project
    org.gimp.GIMP                           # Programa de manipulação de imagens
    org.inkscape.Inkscape                   # Editor de Imagens Vetoriais
    com.snes9x.Snes9x                       # A Super Nintendo emulator
    io.github.Foldex.AdwSteamGt             # Adwaita for Steam Skin Installer
    org.duckstation.DuckStation             # PlayStation 1/PSX emulator.
    org.libretro.RetroArch                  # Frontend for emulators, game engines and media players
    com.bitwarden.desktop                   # A secure and free password manager for all of your devices
    com.authy.Authy                         # Twilio Authy two factor authentication desktop application
    org.onlyoffice.desktopeditors           # Office productivity suite
    org.qbittorrent.qBittorrent             # An open-source Bittorrent client
    Dorg.signal.Signal                      # Programa de mensagens instantâneas
    in.srev.guiscrcpy                       # Android Screen Mirroring Software
    com.spotify.Client                      # Online music streaming service
    net.ankiweb.Anki                        # Powerful, intelligent flash cards
    com.github.hluk.copyq                   # Advanced clipboard manager
    org.kde.kolourpaint                     # Programa de Pintura
    com.github.ADBeveridge.Raider           # Apague seus arquivos de forma segura
    com.github.bcedu.valasimplehttpserver   # Access your files from any device on the same network
    io.github.cboxdoerfer.FSearch           # Software de busca de arquivos com interface gráfica
    com.neatdecisions.Detwinner             # Find and remove duplicate files and similar images
    me.kozec.syncthingtk                    # Sincronização de arquivos descentralizada
)

flatpak_programs="${FLATPAK_PROGRAMS[@]}"

prog_installer flatpak "$flatpak_programs"

unset FLATPAK_PROGRAMS flatpak_programs


######## SNAPS ########
PYCHARM_RELEASE='pycharm-professional'
sudo snap install $PYCHARM_RELEASE --classic

unset PYCHARM_RELEASE


######## SGBDs ########
SGBDS=(
    postgresql              # banco de dados SQL objeto-relacional (versão com suporte)
    postgresql-contrib      # additional facilities for PostgreSQL (supported version)
    libpq-dev               # arquivos de cabeçalho parao libpq5 (biblioteca PostgreSQL)
    mysql-server            # MySQL database server (metapackage depending on the latest version)
    mysql-client            # MySQL database client binaries
    libmysqlclient-dev      # arquivos de desenvolvimento do banco de dados MySQL
)

sgbds="${SGBDS[@]}"

prog_installer flatpak "$sgbds"

unset SGBDS sgbds


######## UNIFIED REMOTE ########
cd /tmp
REDIRECT_LINK=$(curl https://www.unifiedremote.com/download/linux-x64-deb | cut -d' ' -f4)
UNIFIED_REMOTE_URL="https://www.unifiedremote.com$REDIRECT_LINK"
wget $UNIFIED_REMOTE_URL
UNIFIED_REMOTE_VERSION=$(echo $REDIRECT_LINK | rev | cut -d'/' -f1 | rev)
sudo apt install -y ./$UNIFIED_REMOTE_VERSION

unset REDIRECT_LINK UNIFIED_REMOTE_URL UNIFIED_REMOTE_VERSION

######## SCANNER HP PSC 1500 ########
sudo hp-setup


######## LIMPEZA ########
sudo apt autoclean -y
sudo apt autoremove -y


######## Criação do alias git hist para formatação do git log ########
git config --global alias.hist "log --pretty=format:'%C(green)[%ad]%C(reset) %C(bold red)[%h]%C(reset) | %C(white bold)%s %C(bold yellow)%an%C(reset) %C(blue)%d%C(reset)' --graph --date=short"
