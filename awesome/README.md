# The `Awesome` Dotfiles.

A very minimal set of dotfiles for awesome.
Enough to get the job done without sacrificing speed.

## Features

* Lightweight volume popup that I spent far too much time on
* Toggles for `stay ontop` and converting tiled clients to floating
* Random wallpapers from nordic github repo
* Rofi menu's for starting applications & power menu
* Screenshotter that copies to clipboard
* Blur effects (thanks picom)
* Made with multihead setupts as a focus
* Blazingly Fast

## Dependencies

* awesome-git
    * Is not compatable with `awesome`, need the git version
* Picom
    * Picom adds blur effect to most windows.
* maim
    * Screenshotter
* xclip
    * Copy screenshots
* wallpaper directory
    * Wallpapers
    * Can be any directory containing only images
    * https://github.com/0ximjosh/nordic-wallpapers
    * Change dir in `awesome/scripts/set_wallpapers`
* amixer
    * Used for audio management
* Rofi
    * Various menus

Make sure to check `rc.lua` for `terminal`, `editor`, and `editor_cmd` and set them as such.

# Key binds

### Tag Control

| Keybind | Action |
|---------|--------|
|`modkey` + `0` | Toggle all tags visible |
|`modkey` + `k` | Move client to next tag |
|`modkey` + `j` | Move client to previous tag |
|`modkey` + `l` | Move client to next screen |
|`modkey` + `h` | Move client to previous screen |
|`Scrollwheel+` | View next tag |
|`Scrollwheel-` | View previous tag |
|`modkey` + `Escape` | Back to last seen tag |
|`modkey` + `Shift` + `k`| View next Tag |
|`modkey` + `Shift` + `j` | View previous tag |
|`modkey` + `Shift` + `l` | Focus next screen |
|`modkey` + `Shift` + `h` | Focus previous screen |
|`altkey` + `Shift` + `tab` | Show list of clients on tag |

For issues with fullscreen clients dissapearing when focusing other screen,
use the last keybind on the above list to bring it back


### Applications
| Keybind | Action |
|---------|--------|
|`modkey` + `s` | Open Spotify |
|`modkey` + `t` | Open Telegram |
|`modkey` + `d` | Open Discord |
|`modkey` + `b` | Open Firefox |
|`modkey` + `Return` | Open terminal |

### Screenshots
| Keybind | Action |
|---------|--------|
|`Print` | Screenshot all monitors and copy to clipboard|
|`modkey` + `Shift` + `s` | Screenshot area and copy to clipboard |

### Media

* `XF86Audio[Raise|Lower]Volume` mapped to amixer
* `XF86AudioMute` mapped to amixer
* `XF86Audio[Play|Next|Prev]` mapped to dbus-send `>` Spotify
* `modkey` + `XF86AudioNext` mapped to next sink (switch output device, and move all sink-inputs)

### Client Management
| Keybind | Action |
|---------|--------|
|`altkey` + `f` | Force client as raised |
|`altkey` + `c` | Toggle floating |
|`altkey` + `u` | Jump to urgent client |
|`altkey` + `m` | Fullscreen client |
|`altkey` + `Tab` | Focus last focused client |
|`altkey` + `Shift`+ `k` | Focus next client in tag |
|`altkey` + `Shift`+ `j` | Focus previous client in tag |
|`modkey` + `m` | Fullscreen client|
|`modkey` + `Shift` + `m` | Maximize client horizontally|
|`modkey` + `Control` + `m` | Maximize client vertically|
|`modkey` + `altkey` + `k` | Swap with next client in tag |
|`modkey` + `altkey` + `j` | Swap with previous client in tag |

### AwesomeWM
| Keybind | Action |
|---------|--------|
|`modkey` + `w` | Show main menu |
|`modkey` + `Shift` + `r` | Restart awesome |
|`modkey` + `Shift` + `e` | Quit awesome |

### Prompt and Top Bar
| Keybind | Action |
|---------|--------|
|`modkey` + `r` | Run Prompt |
|`modkey` + `x` | Run lua code |
|`modkey` + `p` | Show menu bar |
|`modkey` + `Shift` + `t` | Toggle system tray |

### Rofi Menus
| Keybind | Action |
|---------|--------|
|`modkey` + `Space` | Rofi Menu |
|`modkey` + `Shift` + `p` | Power Menu |

### Wallpaper
| Keybind | Action |
|---------|--------|
|`altkey` + `Control` + `w` | Refresh wallpapers|

## Structure

All key binds are in `keys.lua`  
Helper functions are in `helpers.lua`  
Shell scripts are in `scripts`  
Volume Slider is, well I think you can find it.  

These will be most likely be further broken out as I work on the files  
The goal is for these to be extremely portable, and stay as fast as possible.

# To-dos

- [X] Move all key files to keys folder
- [X] Possibly add more Keybinds
- [ ] Create init script
- [ ] Move startup programs to separate file
- [X] Make wallpaper script more configurable
- [ ] Make central location for variables

