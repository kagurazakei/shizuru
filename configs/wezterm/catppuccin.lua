local wezterm = require("wezterm")
local M = {}

local config = {
    position = "top",
    max_width = 32,
    dividers = "slant_right",
    indicator = {
        leader = {
            enabled = true,
            off = " ",
            on = " ",
        },
        mode = {
            enabled = true,
            names = {
                resize_mode = "RESIZE",
                copy_mode = "VISUAL",
                search_mode = "SEARCH",
            },
        },
    },
    tabs = {
        numerals = "arabic",
        pane_count = "superscript",
        brackets = {
            active = { "", ":" },
            inactive = { "", ":" },
        },
    },
    clock = {
        enabled = false,
        format = "%I:%M %P",
    },
}

local C = {}

local function tableMerge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

local dividers = {
    slant_right = { left = utf8.char(0xe0be), right = utf8.char(0xe0bc) },
    slant_left = { left = utf8.char(0xe0bb), right = utf8.char(0xe0b8) },
    arrows = { left = utf8.char(0xe0b2), right = utf8.char(0xe0b0) },
    rounded = { left = utf8.char(0xe0b6), right = utf8.char(0xe0b4) },
}

M.apply_to_config = function(c, opts)
    opts = opts or {}
    config = tableMerge(config, opts)
    C.div = { l = "", r = "" }

    if config.dividers then
        C.div.l = dividers[config.dividers].left
        C.div.r = dividers[config.dividers].right
    end

    C.leader = {
        enabled = config.indicator.leader.enabled,
        off = config.indicator.leader.off,
        on = config.indicator.leader.on,
    }

    C.mode = {
        enabled = config.indicator.mode.enabled,
        names = config.indicator.mode.names,
    }

    C.tabs = {
        numerals = config.tabs.numerals,
        pane_count_style = config.tabs.pane_count,
        brackets = {
            active = config.tabs.brackets.active,
            inactive = config.tabs.brackets.inactive,
        },
    }

    C.clock = {
        enabled = config.clock.enabled,
        format = config.clock.format,
    }

    C.p = (config.dividers == "rounded") and "" or " "

    c.hide_tab_bar_if_only_one_tab = true
    c.use_fancy_tab_bar = false
    c.tab_bar_at_bottom = config.position == "bottom"
    c.tab_max_width = config.max_width
end

local function numberStyle(number, script)
    local scripts = {
        superscript = { "⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹" },
        subscript = { "₀", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉" },
    }
    local result = ""
    for char in tostring(number):gmatch(".") do
        local num = tonumber(char)
        result = result .. (num and scripts[script][num + 1] or char)
    end
    return result
end

local roman_numerals = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ", "Ⅺ", "Ⅻ" }

wezterm.on("format-tab-title", function(tab, tabs, _, conf)
    local colours = conf.resolved_palette.tab_bar
    local active_tab_index = 0
    for _, t in ipairs(tabs) do
        if t.is_active then
            active_tab_index = t.tab_index
        end
    end

    local rainbow = {
        conf.resolved_palette.ansi[2],
        conf.resolved_palette.indexed[16],
        conf.resolved_palette.ansi[4],
        conf.resolved_palette.ansi[3],
        conf.resolved_palette.ansi[5],
        conf.resolved_palette.ansi[6],
    }

    local i = tab.tab_index % 6
    local active_bg = rainbow[i + 1]
    local active_fg = colours.background
    local inactive_bg = colours.inactive_tab.bg_color
    local inactive_fg = colours.inactive_tab.fg_color
    local new_tab_bg = colours.new_tab.bg_color

    local s_bg, s_fg, e_bg, e_fg

    if tab.tab_index == #tabs - 1 then
        s_bg = tab.is_active and active_bg or inactive_bg
        s_fg = tab.is_active and active_fg or inactive_fg
        e_bg = new_tab_bg
        e_fg = tab.is_active and active_bg or inactive_bg
    elseif tab.tab_index == active_tab_index - 1 then
        s_bg, s_fg = inactive_bg, inactive_fg
        e_bg = rainbow[(i + 1) % 6 + 1]
        e_fg = inactive_bg
    elseif tab.is_active then
        s_bg, s_fg = active_bg, active_fg
        e_bg, e_fg = inactive_bg, active_bg
    else
        s_bg, s_fg, e_bg, e_fg = inactive_bg, inactive_fg, inactive_bg, inactive_bg
    end

    local pane_count = ""
    if C.tabs.pane_count_style then
        local tabi = wezterm.mux.get_tab(tab.tab_id)
        local count = #tabi:panes() == 1 and "" or tostring(#tabi:panes())
        pane_count = numberStyle(count, C.tabs.pane_count_style)
    end

    local index_i = C.tabs.numerals == "roman" and roman_numerals[tab.tab_index + 1] or tab.tab_index + 1

    local index = string.format(
        "%s%s%s ",
        tab.is_active and C.tabs.brackets.active[1] or C.tabs.brackets.inactive[1],
        index_i,
        tab.is_active and C.tabs.brackets.active[2] or C.tabs.brackets.inactive[2]
    )

    local tabtitle = #tab.tab_title > 0 and tab.tab_title or tab.active_pane.title
    local width = conf.tab_max_width - (2 + #index + #pane_count + 2) - 1
    if #tabtitle > width then
        tabtitle = wezterm.truncate_right(tabtitle, width) .. "…"
    end

    return {
        { Background = { Color = s_bg } },
        { Foreground = { Color = s_fg } },
        { Text = " " .. index .. tabtitle .. pane_count .. C.p },
        { Background = { Color = e_bg } },
        { Foreground = { Color = e_fg } },
        { Text = C.div.r },
    }
end)

wezterm.on("update-status", function(window)
    local active_kt = window:active_key_table() ~= nil
    if not (C.leader.enabled or (active_kt and C.mode.enabled)) then
        window:set_left_status("")
        return
    end

    local _, conf = pcall(window.effective_config, window)
    local palette = conf.resolved_palette

    local leader = ""
    if C.leader.enabled then
        local leader_text = window:leader_is_active() and C.leader.on or C.leader.off
        leader = wezterm.format({
            { Foreground = { Color = palette.background } },
            { Background = { Color = palette.ansi[5] } },
            { Text = " " .. leader_text .. C.p },
        })
    end

    local mode = ""
    if C.mode.enabled then
        local active = window:active_key_table()
        local mode_text = C.mode.names[active] or ""
        mode = wezterm.format({
            { Foreground = { Color = palette.background } },
            { Background = { Color = palette.ansi[5] } },
            { Attribute = { Intensity = "Bold" } },
            { Text = mode_text },
            "ResetAttributes",
        })
    end

    local first_tab_active = window:mux_window():tabs_with_info()[1].is_active
    local divider = wezterm.format({
        { Background = { Color = first_tab_active and palette.ansi[2] or palette.tab_bar.inactive_tab.bg_color } },
        { Foreground = { Color = palette.ansi[5] } },
        { Text = C.div.r },
    })

    window:set_left_status(leader .. mode .. divider)

    if C.clock.enabled then
        window:set_right_status(wezterm.format({
            { Background = { Color = palette.tab_bar.background } },
            { Foreground = { Color = palette.ansi[6] } },
            { Text = wezterm.time.now():format(C.clock.format) },
        }))
    end
end)

return M
