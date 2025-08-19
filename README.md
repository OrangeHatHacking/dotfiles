# Dotfiles 

These are the dotfiles for my Hyprland setup on Arch, btw with dynamic wallpaper-based theming using `pywal16`. 
It tries to integrate colors across Qt, and Wayland applications for a semi consistent theme based on the current wallpaper (selected via a custom rofi menu using `MOD+SHIFT` `T`.

Gave up on gtk theming honestly, swapped my apps to qt versions and everything looks decent.

---
### One Line Installation

This can be installed on a (minimal) fresh arch install with the following command
Hyprland, ly, graphics drivers, etc. will be automagically installed and setup

`curl -fsSL https://raw.githubusercontent.com/OrangeHatHacking/dotfiles/main/install.sh | bash -s --`


### Essential-ish Packages
Some are needed for the dots, others are preference (librewolf to hide from the technocratic overlords, etc. <img src="https://i.imgflip.com/1pzanj.jpg" width="50" style="vertical-align:middle;" />)

They're what **_I_** want on **_my_** system.

```
This list has gotten too big to maintain here since install.sh has been changed to work from a
minimal arch install.
Check the install.sh script 
(You should be doing that anyways, 
what are you thinking trusting some stranger's code on the internet?)
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
| `Super + P`                  | Open keepassxc                       |
| `Super + S`                  | Toggle split direction               |
| `Super + R`                  | Hyrpctl reload                       |
| `Super + F`                  | Fullscreen current window            |
| `Super + D`                  | Launch/kill Discord                  |
| `Super + W`                  | Toggle waybar                        |
| `Super + Shift + T`          | Open wallpaper/theme selector        |
| `Super + Arrow/Vim Keys`     | Move focus between windows           |
| `Super + Shift + Arrow/Vim Keys` | Swap windows in given direction  |
| `Super + [0–9/0]`            | Switch to workspace 1–10             |
| `Super + Shift + [0–9/0]`    | Move active window to workspace 1–10 |

<br>

## To-Do
- [x] Write an install script to automate package installation via `yay` and symlinking dotfiles with `stow` (I ended uup doing much more than just that)
 
- [x] Set up sway-nc properly
    
- [x] Map out keybinds in the readme
   
- [x] Add some more bits like spicetify and vencord
    
- [x] Get Hyprlock to activate on laptop lid close

- [ ] Break hyprland config into modular files

- [ ] Switch to USWM for hyprland and subsequent app launching? Maybe???

- [ ] Touch grass

<br>

#### For my own future reference:
- librewolf extensions
    - Pywalfox
    - Firefox Multi-Account Containers
    - Canvas Blocker
    - Dark Reader

<br>

---

© 2025 OrangeHatHacking. No rights, lefts, or uppercuts reserved. 

<img src="https://media1.tenor.com/m/bNzZ1qOeBG0AAAAC/gun-tears.gif)" width="250"/>

AI could never
