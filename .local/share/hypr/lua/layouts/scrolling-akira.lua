local layout = {
	name = "Scrolling",
	icon = "",
	description = "Scrolling layout // Best for maximizing space"
}
if not hl then
	return layout
end

hl.config(
	{
		general = {
			layout = "scrolling"
		},
		scrolling = {
			fullscreen_on_one_column = true,
			column_width = 0.95,
			follow_min_visible = 0.10,
			-- direction = "down",
			explicit_column_widths = "0.1, 0.333, 0.5, 0.667, 0.9"
		}
	}
)

-- Just Utilizing the default keybinds for Scrolling Layout

_F = {description = "[Scrolling Resize Active Window] resize window right", repeating = true}
hl.bind("ALT + EQUAL", hl.dsp.layout("colresize +conf"), _F)
hl.bind("ALT + L", hl.dsp.layout("colresize +conf"), _F)
_F = {description = "[Scrolling Resize Active Window] resize window left", repeating = true}
hl.bind("ALT + MINUS", hl.dsp.layout("colresize -conf"), _F)
hl.bind("ALT + H", hl.dsp.layout("colresize -conf"), _F)

_F = {description = "[Scrolling] move window right"}
hl.bind("ALT + period", hl.dsp.layout("move +col"), _F)
_F = {description = "[Scrolling] move window left"}
hl.bind("ALT + comma", hl.dsp.layout("move -col"), _F)
--
-- _F = {description = "[Scrolling] swap current column up"}
-- hl.bind("ALT + K", hl.dsp.layout("swapcol u"), _F)
-- _F = {description = "[Scrolling] swap current column down"}
-- hl.bind("ALT + J", hl.dsp.layout("swapcol d"), _F)
_F = {description = "[Scrolling] swap current column left"}
hl.bind("ALT + Y", hl.dsp.layout("swapcol l"), _F)
_F = {description = "[Scrolling] swap current column right"}
hl.bind("ALT + I", hl.dsp.layout("swapcol r"), _F)
_F = {description = "[Scrolling] promote focused window to its own column"}
hl.bind("ALT + U", hl.dsp.layout("promote"), _F)

_F = {description = "[Scrolling] fit active window"}
hl.bind("ALT + F", hl.dsp.layout("fit active"), _F)
_F = {description = "[Scrolling] fit visible windows"}
hl.bind("ALT + SHIFT + F", hl.dsp.layout("fit visible"), _F)
_F = {description = "[Scrolling] toggle scroll inhibition"}
hl.bind("ALT + Z", hl.dsp.layout("inhibit_scroll"), _F)
_F = {description = "[Scrolling] expel window to dedicated column"}
hl.bind("ALT + O", hl.dsp.layout("expel"), _F)
_F = {description = "[Scrolling] consume window into previous column"}
hl.bind("ALT + SLASH", hl.dsp.layout("consume"), _F)
_F = {description = "[Scrolling] consume or expel window"}
hl.bind("ALT + M", hl.dsp.layout("consume_or_expel prev"), _F)

local MOD = hyde.config.modifiers.main
_F = {description = "[Scrolling] focus next workspace"}
hl.bind(MOD .. " + SHIFT + mouse_down", hl.dsp.focus({workspace = "r+1"}), _F)
_F = {description = "[Scrolling] focus previous workspace"}
hl.bind(MOD .. " + SHIFT + mouse_up", hl.dsp.focus({workspace = "r-1"}), _F)

_F = {description = "[Scrolling] scroll focus left"}
hl.bind(MOD .. "+ mouse_up", hl.dsp.focus({direction = "left"}), _F)
_F = {description = "[Scrolling] scroll focus right"}
hl.bind(MOD .. "+ mouse_down", hl.dsp.focus({direction = "right"}), _F)

_F = {description = "[Scrolling] scroll focus up"}
hl.bind(MOD .. "+CTRL + mouse_up", hl.dsp.focus({direction = "up"}), _F)
_F = {description = "[Scrolling] scroll focus down"}
hl.bind(MOD .. "+CTRL + mouse_down", hl.dsp.focus({direction = "down"}), _F)

-- 3-finger swipes switch workspaces, matching the monocle layout and the
-- near-universal desktop convention; 4-finger swipes move focus instead.


hl.gesture(
	{
		fingers = 3,
		direction = "vertical",
		action = "workspace"
	}
)

hl.gesture({
    fingers = 3,
    direction = "left",
    action = function()
        hl.dispatch(hl.dsp.focus({ direction = "right" }))
    end
})

hl.gesture({
    fingers = 3,
    direction = "right",
    action = function()
        hl.dispatch(hl.dsp.focus({ direction = "left" }))
    end
})


hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload")
end)

hl.config({
    plugin = {
        scrolloverview = {
            gesture_distance = 300, -- how far is the "max" for the gesture
            scale = 0.5, -- preferred overview scale
            workspace_gap = 60,
            layout = "vertical", -- vertical, horizontal, or auto (per-monitor orientation)
            wallpaper = 2, -- 0: global only, 1: per-workspace only, 2: both
            blur = true, -- blur only the main overview wallpaper

            shadow = {
                enabled = true,
                range = 50,
            },
        },
    },
})

hl.gesture({
    fingers = 4,
    direction = "vertical",
    action = hl.plugin.scrolloverview.overview("toggle all")
})


hl.bind(MOD .. " + TAB", hl.plugin.scrolloverview.overview("toggle all"), _F)

hl.bind(MOD .. " + bracketleft", hl.dsp.layout("swapcol l"))
hl.bind(MOD .. " + bracketright", hl.dsp.layout("swapcol r"))

hl.bind(MOD .. " + period", hl.dsp.layout("move +col"))
hl.bind(MOD .. " + comma", hl.dsp.layout("move -col"))




_F = {description = "[Window Management|alt-tab window switcher] cycle next", transparent = true}
hl.bind("ALT+TAB", hl.dsp.layout("scroller:movefocus, f"), _F)

_F = {description = "[Window Management|alt-tab window switcher] cycle previous", transparent = true}
hl.bind("ALT+SHIFT+TAB",hl.dsp.exec_cmd("command hyprctl dispatch cyclenext prev"), _F)

_F = {description = "[Window Management|alt-tab window switcher] switch", release = true, transparent = true}
hl.bind("ALT + ALT_R", function() end, _F)
hl.bind("ALT + ALT_L", function() end, _F)