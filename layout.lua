-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
--	awful.layout.suit.spiral,
--	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.max,
--	awful.layout.suit.magnifier
}

-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	-- Order of layouts.
	local order = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }

	-- Different defaults on screens.
	local default = awful.layout.suit.tile;
	if s == 2 then
		default = awful.layout.suit.tile.bottom;
	end

	tags[s] = awful.tag(order, s, default)
end

-- Use maximized layout as default on first screen, first tag.
awful.layout.set(awful.layout.suit.max, tags[1][1])
