function titlebar(c)
	-- buttons for the titlebar
	local buttons = awful.util.table.join(
		awful.button({ }, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
	)

	-- Widgets that are aligned to the left
	local left_layout = wibox.layout.fixed.horizontal()
	left_layout:add(awful.titlebar.widget.iconwidget(c))
	left_layout:buttons(buttons)

	-- Widgets that are aligned to the right
	local right_layout = wibox.layout.fixed.horizontal()
	right_layout:add(awful.titlebar.widget.floatingbutton(c))
	right_layout:add(awful.titlebar.widget.maximizedbutton(c))
	right_layout:add(awful.titlebar.widget.stickybutton(c))
	right_layout:add(awful.titlebar.widget.ontopbutton(c))
	right_layout:add(awful.titlebar.widget.closebutton(c))

	-- The title goes in the middle
	local middle_layout = wibox.layout.flex.horizontal()
	local title = awful.titlebar.widget.titlewidget(c)
	title:set_align("center")
	middle_layout:add(title)
	middle_layout:buttons(buttons)

	-- Now bring it all together
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
	layout:set_right(right_layout)
	layout:set_middle(middle_layout)

	awful.titlebar(c):set_widget(layout)
end

-- {{{ Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
		properties = { border_width = beautiful.border_width,
		               border_color = beautiful.border_normal,
		               focus = awful.client.focus.filter,
		               keys = clientkeys,
		               buttons = clientbuttons } },

	{ rule = { class = "MPlayer" },
		callback = awful.placement.centered,
		properties = { floating = true } },
	{ rule = { class = "Vlc" },
		callback = awful.placement.centered,
		properties = { floating = true } },
	{ rule = { class = "pinentry" },
		callback = awful.placement.centered,
		properties = { floating = true } },
	{ rule = { class = "Gimp" },
		properties = { floating = true } },

	-- Rules for firefox
	{
		rule = { class = "Firefox" }, except = { instance = "Navigator" },
		callback = titlebar,
		properties = { floating = true }
	},

	-- Rules for Thunderbird
	{
		rule = { class = "Thunderbird" }, except = { instance = "Mail" },
		callback = titlebar,
		properties = { floating = true }
	},

	-- Rules for floating windows
	{ rule = { class = "Steam" }, properties = { floating = true } },
	{ rule = { class = "bitcoin-qt" }, properties = { floating = true } },
	{ rule = { class = "dogecoin-qt" }, properties = { floating = true } },
	{ rule = { class = "VirtualBox" }, properties = { floating = true } },

	-- Misc
	{
		rule = { class = "Isaac" },
		callback = function(c)
			awful.titlebar.add(c, {modkey=modkey})
		end,
		properties = { floating = true }
	},

	-- Set Firefox to always map on tags number 2 of screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { tag = tags[1][2] } },
}
-- }}}
