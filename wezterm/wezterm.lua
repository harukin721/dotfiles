local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
	}),
	font_size = 14.0,
	color_scheme = "Tokyo Night Storm",
	default_prog = { "/bin/zsh", "-l" },
	window_decorations = "RESIZE",
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
}

-- tmuxライクなプレフィックスキー設定
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- ペイン分割
	{ key = "%", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- ペイン移動
	{ key = "o", mods = "LEADER", action = act.ActivatePaneDirection("Next") },
	{ key = ";", mods = "LEADER", action = act.ActivatePaneDirection("Prev") },

	-- ペイン閉じる
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

	-- ペインをフルスクリーン化（トグル）
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	-- ウィンドウ（タブ）操作
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "&", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
}

return config
