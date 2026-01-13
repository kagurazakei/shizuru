local wezterm = require("wezterm") ---@type Wezterm
local config = wezterm.config_builder() ---@type Config
--- ---------------------------------------------------------------------------
--- Variables
--- ---------------------------------------------------------------------------
local WALLPAPER_DIR = "/home/antonio/.config/wezterm/wallpaper"
local DEFAULT_TRANSPARENCY_STEP = 0.05
local DEFAULT_BACKGROUND_OPACITY = 0.95
local DEFAULT_OVERLAY_OPACITY = 0.95
local STATUS_STYLE = "active" -- minimal, active
local STATUS_COMPONENTS = {
	vpn = false,
	ssh = false,
	mode = false,
	leader = true,
}
--- ---------------------------------------------------------------------------
--- Global State
--- ---------------------------------------------------------------------------
---@class GlobalState
---@field wallpapers string[]
---@field current_wallpaper_type string?
---@field selected_wallpaper integer
---@field pre_toggle_opacity number
---@field light_mode boolean

local global = wezterm.GLOBAL --[[@as GlobalState]]
global.wallpapers = global.wallpapers or {}
global.current_wallpaper_type = global.current_wallpaper_type or nil
global.selected_wallpaper = global.selected_wallpaper or 1
global.pre_toggle_opacity = global.pre_toggle_opacity or DEFAULT_BACKGROUND_OPACITY
global.light_mode = global.light_mode or false

--- ---------------------------------------------------------------------------
--- Theme
--- ---------------------------------------------------------------------------
-- theme: 'Ayu Mirage' 'Tokyo Night Day'
--         'Catppuccin Mocha' Catppuccin Macchiato' 'Catppuccin Frappe' 'Catppuccin Latte'
-- highlight: orange:#ffcc66 blue:#0284c7 salmon:#df5b61
-- overlay: "#1f2430" "#0a0e13"
local CUSTOM_COLOURS = {
	dark = {
		theme = "Catppuccin Mocha",
		highlight = "#df5b61",
		dim = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]["selection_bg"],
		overlay = "#11121d",
	},
	light = {
		theme = "Catppuccin Latte",
		highlight = "#0284c7",
		dim = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]["selection_bg"],
		overlay = "#cbd5e1",
	},
}
--- ---------------------------------------------------------------------------
--- Functions
--- ---------------------------------------------------------------------------
local function get_current_theme()
	return global.light_mode and CUSTOM_COLOURS.light or CUSTOM_COLOURS.dark
end

---@return Color
local function set_alpha(c, a)
	local fh, fs, fl, _ = wezterm.color.parse(c):hsla()
	return wezterm.color.from_hsla(fh, fs, fl, a)
end

local function prompt_line()
	return wezterm.action.PromptInputLine({
		description = "Enter new name for tab",
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				window:active_tab():set_title(line)
			end
		end),
	})
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function get_wallpapers()
	local wallpaper_types = {}
	for _, path in ipairs(wezterm.read_dir(WALLPAPER_DIR)) do
		local name = basename(path)
		if not name:match("^%.") then
			table.insert(wallpaper_types, name)
		end
	end

	local wallpapers = {}
	for _, wallpaper_type in ipairs(wallpaper_types) do
		wallpapers[wallpaper_type] = {}
		local type_dir = WALLPAPER_DIR .. "/" .. wallpaper_type
		for _, path in ipairs(wezterm.read_dir(type_dir)) do
			local filename = basename(path)
			if not filename:match("^%.") then
				table.insert(wallpapers[wallpaper_type], filename)
			end
		end
	end

	return wallpapers
end

local function ensure_wallpapers_loaded()
	local has_wallpapers = false
	for _ in pairs(global.wallpapers) do
		has_wallpapers = true
		break
	end

	if not has_wallpapers then
		global.wallpapers = get_wallpapers()
		local wallpaper_types = {}
		for type_name, _ in pairs(global.wallpapers) do
			table.insert(wallpaper_types, type_name)
		end
		table.sort(wallpaper_types)
		if #wallpaper_types > 0 then
			global.current_wallpaper_type = wallpaper_types[1]
		end
	end
end

local function background_with_overlay(image_path, background_image_opacity)
	return {
		{
			source = { File = image_path },
			opacity = background_image_opacity,
		},
		{
			source = { Color = get_current_theme().overlay },
			width = "100%",
			height = "100%",
			opacity = DEFAULT_OVERLAY_OPACITY,
		},
	}
end

local function check_vpn_status(interface)
	local handle = assert(io.popen(string.format("ifconfig | grep -c %s", interface)))
	local result = handle:read("*a")
	handle:close()
	return tonumber(result) > 0
end

local function add_status_element(cells, text, is_active)
	-- there are two styles: "active" and "minimal"
	-- in the active state we show an active and inactive icon
	-- in the minimal state we show an active icon only
	local theme = get_current_theme()
	local icon_color = is_active and theme.highlight or theme.dim

	if STATUS_STYLE == "active" or (STATUS_STYLE == "minimal" and is_active) then
		table.insert(cells, { Foreground = { Color = icon_color } })
		table.insert(cells, { Background = { Color = "none" } })
		table.insert(cells, { Text = " " .. text .. " " })
	end
end

local function padded_launch_menu(entries, total, default)
	for _ = #entries + 1, total do
		table.insert(entries, default)
	end
	return entries
end

local function is_ssh_active(pane)
	local process_name = pane:get_foreground_process_name()
	if process_name and process_name:lower():find("ssh") then
		return true
	end

	-- mock ssh status for testing
	-- printf "\033]1337;SetUserVar=SSH_MOCK=MQ==\007"  fish - on
	-- printf "\033]1337;SetUserVar=SSH_MOCK=MA==\007"  fish - off
	-- printf "\033]1337;SetUserVar=SSH_MOCK=1\007"     bash - on
	-- printf "\033]1337;SetUserVar=SSH_MOCK=0\007"     bash - off
	local user_vars = pane:get_user_vars()
	return user_vars.SSH_MOCK == "1"
end

local function cycle_wallpaper_type()
	local types = {}
	for name in pairs(global.wallpapers) do
		table.insert(types, name)
	end
	table.sort(types)

	if #types == 0 then
		return false
	end

	local current_idx = 1
	for i, name in ipairs(types) do
		if name == global.current_wallpaper_type then
			current_idx = i
			break
		end
	end

	global.current_wallpaper_type = types[(current_idx % #types) + 1]
	global.selected_wallpaper = 1
	return true
end

local function cycle_wallpaper(window)
	if not global.current_wallpaper_type then
		return false
	end

	local images = global.wallpapers[global.current_wallpaper_type]
	if not images or #images == 0 then
		return false
	end

	local overrides = window:get_config_overrides() or {}
	local current_opacity = overrides.background and overrides.background[1] and overrides.background[1].opacity
		or DEFAULT_BACKGROUND_OPACITY
	local image_path = WALLPAPER_DIR .. "/" .. global.current_wallpaper_type .. "/" .. images[global.selected_wallpaper]

	overrides.background = background_with_overlay(image_path, current_opacity)
	window:set_config_overrides(overrides)

	global.selected_wallpaper = (global.selected_wallpaper % #images) + 1
	return true
end

local function create_tab_bar_colors(theme)
	return {
		background = "none",
		new_tab = { bg_color = "none", fg_color = theme.dim },
		new_tab_hover = { bg_color = "none", fg_color = theme.highlight },
		inactive_tab = { bg_color = "none", fg_color = theme.dim },
		inactive_tab_hover = {
			bg_color = "none",
			fg_color = wezterm.color
				.parse(wezterm.color.get_builtin_schemes()[theme.theme]["selection_bg"])
				:lighten(0.3),
		},
		active_tab = { bg_color = "none", fg_color = theme.highlight, intensity = "Bold" },
		inactive_tab_edge = "none",
	}
end

--- ---------------------------------------------------------------------------
--- Configuration
--- ---------------------------------------------------------------------------
-- general
config.default_cwd = wezterm.home_dir .. "/Code"
config.status_update_interval = 5000

-- leader
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 15.5
config.cell_width = 0.9
config.command_palette_font_size = 15.5

--- rendering
config.webgpu_power_preference = "HighPerformance"
config.front_end = "WebGpu"
config.max_fps = 120

-- launch manu
config.launch_menu = padded_launch_menu({
	{ label = " nu", args = { "/run/current-system/sw/bin/nu" } },
	{ label = " fish", args = { "/run/current-system/sw/bin/fish" } },
	{ label = " k9s", args = { "/run/current-system/sw/bin/fish", "-c", "k9s" } },
}, 9, { label = "-", args = { "/run/currruncurrent-systemsw/bin/nu" } })

-- window and tab bar
config.show_close_tab_button_in_tabs = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_out = "Linear"
config.cursor_blink_rate = 1000
config.enable_wayland = true
config.window_frame = {
	font = wezterm.font({ family = "Inter" }), -- fancy bar only
	active_titlebar_bg = "none", -- fancy bar only
	inactive_titlebar_bg = "none", -- fancy bar only
	font_size = 18, -- fancy bar only
}

local initial_theme = CUSTOM_COLOURS.dark
config.inactive_pane_hsb = { saturation = 1, brightness = 1 }
config.color_scheme = "Oxocarbon Dark"
config.colors = {
	cursor_bg = initial_theme.highlight,
	cursor_border = initial_theme.highlight,
	split = tostring(set_alpha(wezterm.color.get_builtin_schemes()[initial_theme.theme]["selection_bg"], 0.9)),
	tab_bar = create_tab_bar_colors(initial_theme),
}

-- background
-- Independent of whether I use fancy bar, light/dark mode works until
-- I split a pane in the light theme. When splitting, the tab is
-- rendered with the opposite color. Mitigated by applying background
-- layer.
local custom_bg =
	wezterm.color.parse(wezterm.color.get_builtin_schemes()[get_current_theme().theme]["background"]):lighten(0.1)

config.background = {
	{
		source = { Color = "11121D" },
		width = "100%",
		height = "100%",
		opacity = DEFAULT_BACKGROUND_OPACITY,
	},
}
--- ---------------------------------------------------------------------------
--- Keys
--- ---------------------------------------------------------------------------
config.keys = {
	-- LEADER
	{ key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- NAVIGATION
	{ key = "d", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "D", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "p", mods = "SUPER", action = wezterm.action.ActivateCommandPalette },
	-- EVENTS
	{ key = "s", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("new-ssh-tab") },
	{ key = "u", mods = "SUPER", action = wezterm.action.EmitEvent("new-nu-tab") },
	{ key = "n", mods = "CTRL", action = wezterm.action.EmitEvent("cycle-wallpaper-folder") },
	{ key = "b", mods = "CTRL", action = wezterm.action.EmitEvent("cycle-wallpaper") },
	{ key = "B", mods = "SHIFT", action = wezterm.action.EmitEvent("clear-background") },
	{ key = "[", mods = "CTRL", action = wezterm.action.EmitEvent("opacity-dec") },
	{ key = "]", mods = "CTRL", action = wezterm.action.EmitEvent("opacity-inc") },
	{ key = "t", mods = "CTRL", action = wezterm.action.EmitEvent("toggle-light-mode") },
	{ key = "o", mods = "CTRL", action = wezterm.action.EmitEvent("toggle-transparency") },
	{ key = "e", mods = "SUPER|SHIFT", action = prompt_line() },
}

--- ---------------------------------------------------------------------------
--- Events
--- ---------------------------------------------------------------------------
wezterm.on("new-ssh-tab", function(_, pane)
	local tab = pane:window():spawn_tab({})
	tab:set_title("ssh")
end)

wezterm.on("new-nu-tab", function(window, pane)
	local tab = pane:window():spawn_tab({ args = { "/run/current-system/sw/bin/nu" } })
	tab:set_title("nu")
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, _, hover, max_width)
	--- alternate icons: '󰋝'
	local title = tab.tab_title
	local main_title = "󰴻"
	if title and #title > 0 then
		title = tab.tab_title
	elseif tab.tab_index == 0 then
		title = main_title
	else
		title = ""
	end
	return { { Text = " " .. title .. " " } }
end)

wezterm.on("cycle-wallpaper", function(window, pane)
	cycle_wallpaper(window)
end)

wezterm.on("cycle-wallpaper-folder", function(window, pane)
	if cycle_wallpaper_type() then
		cycle_wallpaper(window)
	end
end)

wezterm.on("clear-background", function(window, _)
	local overrides = window:get_config_overrides() or {}
	overrides.background = nil

	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-transparency", function(window, _)
	local overrides = window:get_config_overrides() or {}
	overrides.background = overrides.background or config.background

	local current = overrides.background[1].opacity or 1.0
	local is_transparent = current < 1.0

	if is_transparent then
		global.pre_toggle_opacity = current
	end
	overrides.background[1].opacity = is_transparent and 1.0 or global.pre_toggle_opacity
	window:set_config_overrides(overrides)
end)

wezterm.on("opacity-inc", function(window, _)
	local overrides = window:get_config_overrides() or {}
	overrides.background = overrides.background or config.background

	local current = overrides.background[1].opacity or 1.0
	overrides.background[1].opacity = math.min(current + DEFAULT_TRANSPARENCY_STEP, 1.0)

	window:set_config_overrides(overrides)
end)

wezterm.on("opacity-dec", function(window, _)
	local overrides = window:get_config_overrides() or {}
	overrides.background = overrides.background or config.background

	local current = overrides.background[1].opacity or 1.0
	overrides.background[1].opacity = math.max(current - DEFAULT_TRANSPARENCY_STEP, 0.2)

	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-light-mode", function(window, _)
	local overrides = window:get_config_overrides() or {}

	global.light_mode = not global.light_mode
	local theme = get_current_theme()

	overrides.color_scheme = theme.theme
	overrides.colors = {
		cursor_bg = theme.highlight,
		cursor_border = theme.highlight,
		split = tostring(set_alpha(wezterm.color.get_builtin_schemes()[theme.theme]["selection_bg"], 0.9)),
		tab_bar = create_tab_bar_colors(theme),
	}

	if overrides.background then
		overrides.background = {
			{
				source = { Color = wezterm.color.get_builtin_schemes()[theme.theme]["background"] },
				width = "100%",
				height = "100%",
				opacity = overrides.background[1].opacity,
			},
		}
	end

	window:set_config_overrides(overrides)

	local _, _, _ = wezterm.run_child_process({
		"/run/current-system/sw/bin/fish",
		"-c",
		string.format("set -U WEZTERM_LIGHT_MODE %s", tostring(global.light_mode)),
	})
end)

wezterm.on("update-status", function(window, pane)
	local cells = {}

	if STATUS_COMPONENTS.leader then
		add_status_element(cells, "󰬓", window:leader_is_active())
	end
	if STATUS_COMPONENTS.mode then
		add_status_element(cells, "󰔎", not global.light_mode)
	end
	if STATUS_COMPONENTS.ssh then
		add_status_element(cells, "󰲝󰣀", is_ssh_active(pane))
	end
	if STATUS_COMPONENTS.vpn then
		add_status_element(cells, "󱘖", check_vpn_status("utun8"))
	end

	-- add some padding after status icons to match LHS
	table.insert(cells, { Text = "   " })
	window:set_right_status(wezterm.format(cells))
end)

wezterm.on("gui-startup", function() end)

return config
