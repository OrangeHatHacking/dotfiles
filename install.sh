#!/usr/bin/env bash
set -euo pipefail

# Basic dependencies
echo "Installing git and base-devel..."
sudo pacman -Sy --needed --noconfirm git base-devel

# Install yay (if not already present)
if ! command -v yay &>/dev/null; then
  echo "Installing yay AUR helper..."
  git clone https://aur.archlinux.org/yay.git ~/yay-temp
  cd ~/yay-temp
  makepkg -si --noconfirm
  cd ..
  rm -rf ~/yay-temp
fi

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
  git pavucontrol-qt colorz stow pcmanfm-qt zscroll-git \
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
