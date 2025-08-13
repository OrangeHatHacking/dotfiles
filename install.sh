#!/usr/bin/env bash
set -euo pipefail

# Basic dependencies
printf "\n\n###############################################\n#Installing Hyprland and essential packages...#\n##############################################\n\n"
sleep 3
sudo pacman -Sy --needed --noconfirm hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland polkit-kde-agent xdg-utils vim openssh git base-devel

# Install yay (if not already present)
if ! command -v yay &>/dev/null; then
  printf "\n\n##############################\n#Installing yay AUR helper...#\n##############################\n\n"
  git clone https://aur.archlinux.org/yay.git ~/yay-temp
  sleep 3
  cd ~/yay-temp
  makepkg -si --noconfirm
  cd ..
  rm -rf ~/yay-temp
fi

# Detect graphics card
printf "\n\n####################################\n#Attempting to detect Graphics Card#\n####################################\n\n"
sleep 3
if lspci | grep -qi nvidia; then
    printf "\n\nNvidia Graphics Card detected!!!\nAttempting to install drivers\n\n"
    sleep 3
    yay -Sy --needed --noconfirm dkms libva-nvidia-driver nvidia-open-dkms xorg-server xorg-xinit \
	libva-mesa-driver mesa vulkan-nouveau xf86-video-nouveau nvidia-dkms
elif lspci | grep -Ei 'intel.*vga'; then
    printf "\n\nIntel Graphics Card detected!!!\nAttempting to install drivers\n\n"
    sleep 3
    yay -Sy --needed --noconfirm intel-media-driver libva-intel-driver mesa vulkan-intel xorg-server xorg-xinit
elif lspci | grep -E 'AMD|ATI'; then
    printf "\n\nAMD Graphics Card detected!!!\nAttempting to install drivers\n\n"
    sleep 3
    yay -Sy --needed --noconfirm libva-mesa-driver mesa vulkan-radeon xf86-video-amdgpu xf86-video-ati xorg-server xorg-xinit
else
    printf "\n\nNo Graphics Card detected!!!\nAttempting to install all open source drivers\n\n"
    sleep 3
    yay -Sy --needed --noconfirm intel-media-driver libva-intel-driver libva-mesa-driver mesa vulkan-intel vulkan-nouveau vulkan-radeon \
	xf86-video-amdgpu xf86-video-ati xf86-video-nouveau xorg-server xorg-xinit
fi

printf "\n\n################################################\ninstalling and enabling ly as login manager...#\n################################################\n\n"
sleep 3
yay -Sy --noconfirm ly
sudo systemctl enable ly.service

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
yay -Sy --needed --noconfirm \
  swww neovim nmtui playerctl waybar rofi-wayland kitty qt6ct kvantum swaync python-pywal16 \
  python-pywalfox-librewolf hyprlock librewolf-bin ttf-jetbrains-mono-nerd \
  git pavucontrol-qt colorz stow pcmanfm-qt zscroll-git npm \
  keepassxc bluez bluetui discord

printf "\n\nInstalling and setting up Vencord...\n\n"
sleep 1
mkdir -p "$HOME/dotfiles/.config/Vencord/themes"
tmp_vencord_file="temp_vencord_installation_file"

curl -sS https://github.com/Vencord/Installer/releases/download/v1.4.0/VencordInstallerCli-linux --output "$tmp_vencord_file" --location --fail

chmod +x "$tmp_vencord_file"
sudo ./"$tmp_vencord_file" -install -branch stable
rm "$tmp_vencord_file"

printf "\n\n###################################################\n#Cleaning conflicting files/directories in home...#\n###################################################\n\n"
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
sleep 1
stow .

cd "$HOME"

while true; do
    read -r -p "Installation complete!Would you like to reboot now? (No may cause buggy behaviour)[Y/n]: " response

    case "${response,,}" in
	y|yes|'')
	    reboot
	    ;;
	n|no)
	    if [[ $- == *i* ]]; then
		source "$HOME/.bashrc"
	    fi
	    pidof swww-daemon || swww-daemon &
	    bash .config/scripts/startup-theme.sh &
	    hyprctl reload
	    return 0
	    ;;
    esac
done

