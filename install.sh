#!/usr/bin/env bash
set -euo pipefail

# keep sudo permissions refreshed to avoid multiple prompts and possible script timeout
sudo -v

while true; do
    sleep 180
    sudo -n true
    kill -0 "$$" 2>/dev/null || exit
done &

GREEN=$(tput setaf 2) #'\033[0;31m'
NC=$(tput sgr0) #'\033[0m'

# Basic dependencies
printf "\n\n###############################################\n#${GREEN}Installing Hyprland and essential packages...${NC}#\n###############################################\n\n"
sleep 3

# python-gobject is a dependency of power-profiles-daemon that does not install automatically
sudo pacman -Sy --needed --noconfirm hyprland xdg-desktop-portal xdg-desktop-portal-hyprland \
    qt5-wayland qt6-wayland polkit-kde-agent xdg-utils neovim openssh git base-devel pipewire \
    pipewire-pulse pipewire-alsa pipewire-jack pipewire-libcamera wireplumber networkmanager \
    upower udisks2 usbutils pciutils util-linux inetutils iproute2 net-tools wireless_tools \
    wpa_supplicant bluez bluez-utils alsa-utils polkit gvfs gvfs-mtp gvfs-gphoto2 xdg-user-dirs \
    xdg-utils power-profiles-daemon bash-completion man-db man-pages which htop \
    power-profiles-daemon python-gobject

# Install yay (if not already present)
if ! command -v yay &>/dev/null; then
  printf "\n\n##############################\n#${GREEN}Installing yay AUR helper...${NC}#\n##############################\n\n"
  git clone https://aur.archlinux.org/yay.git ~/yay-temp
  sleep 3
  cd ~/yay-temp
  makepkg -si --noconfirm
  cd ..
  rm -rf ~/yay-temp
fi

# Detect graphics card
printf "\n\n####################################\n#${GREEN}Attempting to detect Graphics Card${NC}#\n####################################\n\n"
sleep 3
if lspci | grep -qi nvidia; then
    printf "\n\nNvidia Graphics Card detected!!!\nAttempting to install drivers\n\n"
    sleep 3
    yay -Sy --needed --noconfirm dkms libva-nvidia-driver nvidia-open-dkms xorg-server xorg-xinit \
	libva-mesa-driver mesa vulkan-nouveau xf86-video-nouveau nvidia-dkms
elif lspci | grep -Ei 'intel'; then
    printf "\n\nIntel Graphics Card detected!!!\nAttempting to install drivers\n\n"
    sleep 3
    yay -Sy --needed --noconfirm intel-media-driver libva-intel-driver mesa vulkan-intel \
	xorg-server xorg-xinit
elif lspci | grep -E 'AMD|ATI'; then
    printf "\n\nAMD Graphics Card detected!!!\nAttempting to install drivers\n\n"
    sleep 3
    yay -Sy --needed --noconfirm libva-mesa-driver mesa vulkan-radeon xf86-video-amdgpu \
	xf86-video-ati xorg-server xorg-xinit
else
    printf "\n\nNo Graphics Card detected!!!\nAttempting to install all open source drivers\n\n"
    sleep 3
    yay -Sy --needed --noconfirm intel-media-driver libva-intel-driver libva-mesa-driver mesa \
	vulkan-intel vulkan-nouveau vulkan-radeon xf86-video-amdgpu xf86-video-ati \
	xf86-video-nouveau xorg-server xorg-xinit
fi

printf "\n\n################################################\n#${GREEN}Installing and enabling ly as login manager...${NC}#\n################################################\n\n"
sleep 3
yay -Sy --noconfirm ly
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service

# Clone dotfiles repo (or update if exists)
DOTFILES=~/dotfiles
if [ -d "$DOTFILES/.git" ]; then
  printf "\n\nUpdating existing dotfiles repo...\n\n"
  sleep 2
  (cd "$DOTFILES" && git pull)
else
  printf "\n\nCloning dotfiles repository...\n\n"
  sleep 2
  git clone https://github.com/OrangeHatHacking/dotfiles "$DOTFILES"
fi
cd "$DOTFILES"

# Install packages via yay
printf "\n\nInstalling packages...\n\n"
sleep 2
yay -Sy --needed --noconfirm swww neovim playerctl waybar hypridle \
    rofi-wayland kitty qt6ct kvantum swaync python-pywal16 \
  python-pywalfox-librewolf hyprlock librewolf-bin ttf-jetbrains-mono-nerd \
  pavucontrol-qt colorz stow pcmanfm-qt zscroll-git npm noto-fonts noto-fonts-cjk \
  noto-fonts-emoji noto-fonts-extra keepassxc bluez bluetui discord papirus-icon-theme qt5ct qt6ct 

printf "\n\nInstalling and setting up Vencord...\n\n"
sleep 1
mkdir -p "$HOME/dotfiles/.config/Vencord/themes"
tmp_vencord_file="temp_vencord_installation_file"

curl -sS https://github.com/Vencord/Installer/releases/download/v1.4.0/VencordInstallerCli-linux --output "$tmp_vencord_file" --location --fail

chmod +x "$tmp_vencord_file"
sudo ./"$tmp_vencord_file" -install -branch stable
rm "$tmp_vencord_file"

printf "\n\n###################################################\n#${GREEN}Cleaning conflicting files/directories in home...${NC}#\n###################################################\n\n"
sleep 3

for item in * .*; do
  # Skip '.' and '..'
  [[ "$item" == "." || "$item" == ".." ]] && continue

  target="$HOME/$item"

  if [ -e "$target" ] || [ -L "$target" ]; then
    printf "\n\nBacking up existing $target...\n\n"
    mv "$target" "$target.bkp"
  fi
done

printf "\n\nAll conflicting files removed.\n\n"
stow .

cd "$HOME"

# Enable services
systemctl --user enable --now xdg-desktop-portal-hyprland pipewire pipewire-pulse wireplumber

printf "\n\n###################################################\n#${GREEN}Disabling iwd and enabling NetworkManager service${NC}#\n###################################################\n\n"
sleep 3
sudo systemctl enable --now NetworkManager power-profiles-daemon upower
sudo systemctl disable iwd

while true; do
    printf "\n\n\t${GREEN}Installation complete!!!${NC}\n\tWould you like to reboot now? (No may cause buggy behaviour)[Y/n]: "
    read -r response
    case "${response,,}" in
	y|yes|'')
	    printf "\nrebooting...\n"
	    sleep 2
	    reboot
	    ;;
	n|no)
	    printf "\nAttempting to set up and start hyprland...\n"
	    sleep 2
	    if [[ $- == *i* ]]; then
		source "$HOME/.bashrc"
	    fi
	    pidof Hyprland && hyprctl reload || hyprland
	    return 0
	    ;;
	*)
	    printf "INVALID INPUT AUTOREBOOTING"
	    sleep 3
	    reboot
    esac
    exit
done

