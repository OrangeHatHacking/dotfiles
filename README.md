# Dotfiles 

These are the dotfiles for my Hyprland setup on Arch, btw with dynamic wallpaper-based theming using `pywal16`. 
It tries to integrate colors across Qt, and Wayland applications for a semi consistent theme based on the current wallpaper (selected via a custom rofi menu using `MOD+SHIFT` `T`.

Gave up on gtk theming honestly, swapped my apps to qt versions and everything looks decent.


### Essential-ish Packages
Some are needed for the dots, others are preference (librewolf to hide from the technocratic overlords, etc. <img src="https://i.imgflip.com/1pzanj.jpg" width="50" style="vertical-align:middle;" />)

They're what **_I_** want on **_my_** system.

Install with `yay` or `paru`:
```bash
yay -S \
  swww \
  neovim \
  playerctl \
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
  zscroll-git \
  keepassxc \
  bluez \
  bluetui
```

<br>

### Keybinds

Super key refers to your $mainMod (the Windows key).
Vim motions can replace arrow keys for window movements (H, J, K, L)

| Key Combo                    | Action                               |
| ---------------------------- | ------------------------------------ |
| `Super + Return`             | Launch terminal                      |
| `Super + C`                  | Kill active window                   |
| `Super + B`                  | Launch browser                       |
| `Super + F4`                 | Exit Hyprland                        |
| `Super + M`                  | Lock screen                          |
| `Super + E`                  | Open file manager                    |
| `Super + V`                  | Toggle floating layout               |
| `Super + Space`              | Open launcher/menu (rofi)            |
| `Super + P`                  | Enter pseudo mode (Whatever that is) |
| `Super + S`                  | Toggle split direction (dwindle)     |
| `Super + R`                  | Hyrpctl reload                       |
| `Super + F`                  | Activate fullscreen for current window|
| `Super + Shift + T`          | Open wallpaper/theme selector        |
| `Super + Arrow Keys`         | Move focus between windows           |
| `Super + Shift + Arrow Keys` | Swap windows in given direction      |
| `Super + [0–9/0]`            | Switch to workspace 1–10             |
| `Super + Shift + [0–9/0]`    | Move active window to workspace 1–10 |

<br>

## To-Do
- [ ] Write an install script to automate package installation via `yay` and symlinking dotfiles with `stow`
 
- [ ] Set up sway-nc properly
    
- [x] Map out keybinds in the readme
   
- [ ] Add some more bits like spicetify and vencord
    
- [x] Get Hyprlock to activate on laptop lid close

- [ ] Break hyprland config into modular files

- [ ] Switch to USWM for hyprland and subsequent app launching

- [ ] Touch grass

<br>

#### For my own future reference:
- Use ly as the display/login manager
- librewolf extensions
    - Pywalfox
    - Firefox Multi-Account Containers
    - Canvas Blocker

<br>

---

© 2025 OrangeHatHacking. No rights, lefts, or uppercuts reserved. 

<img src="https://media1.tenor.com/m/bNzZ1qOeBG0AAAAC/gun-tears.gif)" width="250"/>

AI could never
