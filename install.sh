#!/usr/bin/env bash
set -euo pipefail

# Basic dependencies
echo "Installing Hyprland and essential packages..."
sudo pacman -Sy --needed --noconfirm hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland polkit-kde-agent xdg-utils vim openssh git base-devel

# Install yay (if not already present)
if ! command -v yay &>/dev/null; then
  echo "Installing yay AUR helper..."
  git clone https://aur.archlinux.org/yay.git ~/yay-temp
  cd ~/yay-temp
  makepkg -si --noconfirm
  cd ..
  rm -rf ~/yay-temp
fi

# Detect graphics card
echo "Attempting to detect Graphics Card"
if lspci | grep -qi nvidia; then
    printf "Nvidia Graphics Card detected!!!\nAttempting to install drivers"
    yay -Sy --needed --noconfirm dkms libva-nvidia-driver nvidia-open-dkms xorg-server xorg-xinit \
	libva-mesa-driver mesa vulkan-nouveau xf86-video-nouveau nvidia-dkms
elif lspci | grep -Ei 'intel.*vga'; then
    printf "Intel Graphics Card detected!!!\nAttempting to install drivers"
    yay -Sy --needed --noconfirm intel-media-driver libva-intel-driver mesa vulkan-intel xorg-server xorg-xinit
elif lspci | grep -E 'AMD|ATI'; then
    printf "AMD Graphics Card detected!!!\nAttempting to install drivers"
    yay -Sy --needed --noconfirm libva-mesa-driver mesa vulkan-radeon xf86-video-amdgpu xf86-video-ati xorg-server xorg-xinit
else
    printf "No Graphics Card detected!!!\nAttempting to install all open source drivers"
    yay -Sy --needed --noconfirm intel-media-driver libva-intel-driver libva-mesa-driver mesa vulkan-intel vulkan-nouveau vulkan-radeon \
	xf86-video-amdgpu xf86-video-ati xf86-video-nouveau xorg-server xorg-xinit
fi

echo "installing and enabling ly as login manager..."
yay -Sy --noconfirm ly
sudo systemctl enable ly.service

# Clone dotfiles repo (or update if exists)
DOTFILES=~/dotfiles
if [ -d "$DOTFILES/.git" ]; then
  echo "Updating existing dotfiles repo..."
  (cd "$DOTFILES" && git pull)
else
  echo "Cloning dotfiles repository..."
  git clone https://github.com/OrangeHatHacking/dotfiles "$DOTFILES"
fi
cd "$DOTFILES"

# Install packages via yay
echo "Installing packages..."
yay -Sy --needed --noconfirm \
  swww neovim nmtui playerctl waybar rofi-wayland kitty qt6ct kvantum swaync python-pywal16 \
  python-pywalfox-librewolf hyprlock librewolf-bin ttf-jetbrains-mono-nerd \
  git pavucontrol-qt colorz stow pcmanfm-qt zscroll-git npm \
  keepassxc bluez bluetui discord

echo "Installing vencord"
tmp_vencord_file="temp_vencord_installation_file"

curl -sS https://github.com/Vencord/Installer/releases/download/v1.4.0/VencordInstallerCli-linux --output "$tmp_vencord_file" --location --fail

chmod +x "$tmp_vencord_file"
sudo ./"$tmp_vencord_file" -install -branch stable
rm "$tmp_vencord_file"

echo "Cleaning conflicting files/directories in home..."

for item in * .*; do
  # Skip '.' and '..'
  [[ "$item" == "." || "$item" == ".." ]] && continue

  target="$HOME/$item"

  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "Backing up existing $target"
    mv "$target" "$target.bkp"
  fi
done

echo "All conflicting files removed."

stow .

echo "Installation complete! Attempting automatic restart of programs"

cd "$HOME"

if [[ $- == *i* ]]; then
  source "$HOME/.bashrc"
fi
pidof swww-daemon || swww-daemon &
bash .config/scripts/startup-theme.sh &
hyprctl reload
