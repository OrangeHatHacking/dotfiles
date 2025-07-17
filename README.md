# Dotfiles 

These are the dotfiles for my Hyprland setup on Arch, btw with dynamic wallpaper-based theming using `pywal16`. 
It tries to integrate colors across Qt, and Wayland applications for a semi consistent theme based on the current wallpaper (selected via a custom rofi menu using `MOD+SHIFT` `T`.

Gave up on gtk theming honestly, swapped my apps to qt versions and everything looks decent.


### Essential-ish Packages
They're what I want on my system.

Some are needed for the dots, others are preference (librewolf to hide form the technocratic overlords, etc. <img src="https://i.imgflip.com/1pzanj.jpg" width="50" style="vertical-align:middle;" />)

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

<br>

## To-Do
- [ ] Write an install script to automate package installation via `yay` and symlinking dotfiles with `stow`
    
- [ ] Add some more bits like spicetify and vencord, maybe a password manager? (probably beyond the scope of some dotfiles)

<br>

For my own future reference, use ly as the login manager.

<br>

---

© 2025 OrangeHatHacking. No rights, lefts, or uppercuts reserved. 

<img src="https://media1.tenor.com/m/bNzZ1qOeBG0AAAAC/gun-tears.gif)" width="250"/>

AI could never
