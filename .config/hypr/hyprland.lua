-- Hyprland Lua config
-- Converted from hyprland.conf
-- See https://wiki.hypr.land/Configuring/Start/

--------------------
---- LOAD COLORS ---
--------------------

-- Parse the pywal colors-hyprland.conf (HyprLang $var = rgba(...) format)
-- into a Lua table so we can use them throughout the config.
local colors = {}
local colors_file = os.getenv("HOME") .. "/.cache/wal/colors-hyprland.conf"
local f = io.open(colors_file, "r")
if f then
    for line in f:lines() do
        local name, value = line:match("^%$(%S+)%s*=%s*(.+)$")
        if name and value then
            colors[name] = value
        end
    end
    f:close()
end

-- Fallback colors in case pywal hasn't run yet
local color2      = colors["color2"]      or "rgba(172,79,35,1.0)"
local color4      = colors["color4"]      or "rgba(197,154,45,1.0)"
local color8      = colors["color8"]      or "rgba(112,95,92,1.0)"
local background  = colors["background"]  or "rgba(30,16,12,1.0)"


------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "0x0",
    scale    = "auto",
})

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "pcmanfm-qt"
local menu        = os.getenv("HOME") .. "/.config/scripts/rofi-launcher.sh"
local browser     = "librewolf"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("waybar")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/scripts/startup-theme.sh")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("NO_AT_BRIDGE", "1")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = { top = 5, right = 10, bottom = 10, left = 10 },

        border_size = 2,

        col = {
            active_border   = { colors = { color2, color4 }, angle = 45 },
            inactive_border = color8,
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 0.9,
        inactive_opacity = 0.7,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = background,
        },

        blur = {
            enabled   = true,
            size      = 2,
            passes    = 3,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Animations
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })


-----------------
---- LAYOUTS ----
-----------------

hl.config({
    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "ie",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 0,

        sensitivity = 0.3,

        touchpad = {
            natural_scroll = true,
        },
    },

    ecosystem = {
        no_update_news  = true,
        no_donation_nag = true,
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

local scripts = os.getenv("HOME") .. "/.config/swaync/scripts"
local mainMod = "SUPER"

-- Core binds
hl.bind(mainMod .. " + Return",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",            hl.dsp.window.close())
hl.bind(mainMod .. " + B",            hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F4",           hl.dsp.exit())
hl.bind(mainMod .. " + M",            hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D",            hl.dsp.exec_cmd("pidof Discord && killall -9 Discord || discord"))

hl.bind(mainMod .. " + space",        hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + S",            hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + R",            hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + F",            hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + W",            hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/waybar/scripts/launch.sh"))
hl.bind(mainMod .. " + N",            hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + P",            hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/scripts/project-session-selector.sh"))
hl.bind(mainMod .. " + SHIFT + T",    hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/scripts/theme-selector.sh"))
hl.bind(mainMod .. " + SHIFT + F",    hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/scripts/concentration.sh"))
hl.bind("PRINT",                       hl.dsp.exec_cmd("hyprshot -zm region"))

-- Move focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Swap windows with arrow keys
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Vim keybinds for focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Vim keybinds for swap
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

-- Cycle workspaces with Tab
hl.bind(mainMod .. " + Tab",          hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + Tab",  hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(scripts .. "/volume-control.sh --inc"),        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(scripts .. "/volume-control.sh --dec"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(scripts .. "/volume-control.sh --toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd(scripts .. "/volume-control.sh --toggle-mic"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(scripts .. "/brightness.sh --inc"),            { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(scripts .. "/brightness.sh --dec"),            { locked = true, repeating = true })

-- Playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "float-pavucontrol",
    match = { class = "^(pavucontrol%-qt)" },
    float = true,
})

hl.window_rule({
    name  = "float-nmtui",
    match = { title = "^(nmtui)" },
    float = true,
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Layer rules
hl.layer_rule({
    name  = "blur-swaync-control",
    match = { namespace = "swaync-control-center" },
    blur  = true,
})

hl.layer_rule({
    name  = "blur-swaync-notification",
    match = { namespace = "swaync-notification-window" },
    blur  = true,
})

hl.layer_rule({
    name  = "alpha-swaync-control",
    match = { namespace = "swaync-control-center" },
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name  = "alpha-swaync-notification",
    match = { namespace = "swaync-notification-window" },
    ignore_alpha = 0.5,
})
