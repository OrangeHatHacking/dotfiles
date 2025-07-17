# Dotfiles for Hyprland with Dynamic Theming

These are the dotfiles for my Hyprland setup on Arch, btw with dynamic wallpaper-based theming using `pywal16`. 
It tries to integrate colors across Qt, and Wayland applications for a semi consistent theme based on the current wallpaper (selected via a custom rofi menu using `MOD+SHIFT` `T`.
Gave up on gtk themeing honestly, swapped my apps to qt versions and everything looks decent.
---

## Essential-ish Packages

They're what I want on my system. Some are needed for the dots, others are preference (librewolf to hide form the technocratic overlords, etc.)

Install with `yay` or `paru`:
```bash
yay -S \
  swww \
  waybar \
  rofi \
  kitty \
  qt6ct \
  kvantum \
  swaync \
  python-pywal16 \
  python-pywalfox-librewolf \
  hyprlock \
  librewolf-bin \
  ttf-jetbrains-mono-nerd \
  git \
  pavucontrol-qt \
  colorz \
  stow \
  pcmanfm-qt \
  qt5-wayland \
  qt6-wayland
```

## To-Do

- [ ] Write an install script to automate:
  - Package installation via `yay`
  - Symlinking dotfiles with `stow`
  - Initial wallpaper selection and theme generation
    
- [ ] Add some more bits like spicetify and vencord, maybe a password manager? (probably beyond the scope of some dotfiles)

For my own future reference, use ly as the login manager.
