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
DOTFILES=~/.dotfiles
if [ -d "$DOTFILES/.git" ]; then
  echo "Updating existing dotfiles repo..."
  (cd "$DOTFILES" && git pull)
else
  echo "Cloning dotfiles repository..."
  git clone https://github.com/OrangeHatHacking/dotfiles "$DOTFILES"
fi
cd "$DOTFILES"

# Install packages via yay
echo "Installing essential-ish packages from README..."
yay -Sy --needed --noconfirm \
  swww playerctl waybar rofi kitty qt6ct kvantum swaync python-pywal16 \
  python-pywalfox-librewolf hyprlock librewolf-bin ttf-jetbrains-mono-nerd \
  git pavucontrol-qt colorz stow pcmanfm-qt zscroll-git \
  keepassxc bluez bluetui

# Stow dotfiles
echo "Symlinking dotfiles using stow..."
for pkg in */; do
  pkg=${pkg%/}
  echo "Stowing $pkg..."
  if ! stow --dir="$DOTFILES" --target="$HOME" --no-folding "$pkg"; then
    echo "Conflict detected for $pkg—removing old links and retrying..."
    stow --dir="$DOTFILES" --target="$HOME" -DR "$pkg"
    stow --dir="$DOTFILES" --target="$HOME" "$pkg"
  fi
done

echo "Installation complete! Please restart your terminal/session."
