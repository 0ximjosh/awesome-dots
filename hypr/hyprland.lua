local terminal = "ghostty"
local mainMod = "SUPER"
local home = os.getenv("HOME")

----------------
---- MONITORS ----
----------------

hl.monitor({
    output   = "DP-4",
    mode     = "2560x1440@120",
    position = "2560x0",
    scale    = 1,
})
hl.monitor({
    output   = "DP-5",
    mode     = "2560x1440@164.55",
    position = "0x0",
    scale    = 1,
})
hl.monitor({
    output   = "DP-6",
    mode     = "2560x1440@164.55",
    position = "5120x0",
    scale    = 1,
})

local workspaces = {
    { monitor = "DP-4", from = 1,  to = 5  },
    { monitor = "DP-5", from = 6,  to = 10 },
    { monitor = "DP-6", from = 11, to = 15 },
}

for _, group in ipairs(workspaces) do
    for id = group.from, group.to do
        hl.workspace_rule({
            workspace  = tostring(id),
            monitor    = group.monitor,
            persistent = true,
        })
    end
end

-----------------
---- AUTOSTART ----
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprctl setcursor Adwaita 24")
    hl.exec_cmd("wpaperd -d")
    hl.exec_cmd("nikon-drain")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 20,
        border_size      = 2,
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            enabled  = true,
            size     = 8,
            passes   = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled              = true,
        workspace_wraparound = true,
    },

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

    input = {
        kb_layout          = "us",
        follow_mouse       = 1,
        sensitivity        = 0,
        repeat_delay       = 200,
        repeat_rate        = 35,
        numlock_by_default = true,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + C",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SPACE",  hl.dsp.exec_cmd("wofi --show drun --style " .. home .. "/.config/wofi/styles.css"))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd("firefox"))

hl.bind("ALT + SHIFT + H", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + SHIFT + L", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + SHIFT + K", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + SHIFT + J", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("ALT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("ALT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("ALT + J", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + J",         hl.dsp.window.move({ workspace = "r-1", follow = true }))
hl.bind(mainMod .. " + K",         hl.dsp.window.move({ workspace = "r+1", follow = true }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ workspace = "r+1" }))

hl.bind("CONTROL + ALT + W",   hl.dsp.exec_cmd("wpaperctl next"))
hl.bind("CONTROL + ALT + D",   hl.dsp.exec_cmd("nikon-drain"))
hl.bind("CONTROL + SHIFT + P", hl.dsp.exec_cmd(home .. "/.config/waybar/scripts/audio_changer.py"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 2%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 2%-"),                  { locked = true, repeating = true })

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

hl.layer_rule({
    match        = { namespace = "waybar" },
    blur         = true,
    ignore_alpha = 0.5,
})
