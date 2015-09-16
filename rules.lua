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

	-- Floating window
	{
		rule_any = { class = {"Steam", "bitcoin-qt", "dogecoin-qt", "VirtualBox", "Gimp"} },
		properties = {
			floating = true
		}
	},

	-- Floating window, centered on launch
	{
		rule_any = { class = {"MPlayer", "Animate", "Vlc", "pinentry", "Xdialog"} },
		callback = awful.placement.centered,
		properties = {
			floating = true
		}
	},

	-- Games: floating, titlebar (some games doesn't have any other way to exit)
	{
		rule_any = { name = {"HuniePop", "Isaac"} },
		callback = titlebar,
		properties = {
			floating = true
		}
	}
}
-- }}}
