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
			 callback = function(c)
										 awful.titlebar.add(c, {modkey=modkey})
									end,
			 properties = { floating = true }
		},

		-- Rules for Thunderbird
		{
			 rule = { class = "Thunderbird" }, except = { instance = "Mail" },
			 callback = function(c)
										 awful.titlebar.add(c, {modkey=modkey})
									end,
			 properties = { floating = true }
		},

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
