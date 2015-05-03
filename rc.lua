awful = require("awful")
awful.autofocus = require("awful.autofocus")
awful.rules = require("awful.rules")
awful.widget = require("awful.widget")
beautiful = require("beautiful")
naughty = require("naughty")
wibox = require("wibox")
menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
									 title = "Oops, there were errors during startup!",
									 text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
											 -- Make sure we don't go into an endless error loop
											 if in_error then return end
											 in_error = true

											 naughty.notify({ preset = naughty.config.presets.critical,
																				title = "Oops, an error happened!",
																				text = err })
											 in_error = false
																		 end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
-- beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")
-- beautiful.init(awful.util.getdir("config") .. "/themes/ext2/theme.lua")
beautiful.init(awful.util.getdir("config") .. "/themes/ext2/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "/home/ext/bin/local/term"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = editor

-- Default modkey.
modkey = "Mod4"

require("layout")
require("menu")

-- {{{ Wibox
-- Create a textclock widget
--mytextclock = awful.widget.textclock({ align = "left" }, "%A %Y-%m-%d %k:%M:%S v.%U", 1)
mytextclock = awful.widget.textclock("%A %Y-%m-%d %k:%M:%S v.%U", 1)

def_buttons = awful.util.table.join(
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}

mytaglist = {}
mytaglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
	awful.button({ }, 1, function (c)
								 if c == client.focus then
									 c.minimized = true
								 else
									 if not c:isvisible() then
										 awful.tag.viewonly(c:tags()[1])
									 end
									 -- This will also un-minimize
									 -- the client, if needed
									 client.focus = c
									 c:raise()
								 end
											 end),
	awful.button({ }, 3, function ()
								 if instance then
									 instance:hide()
									 instance = nil
								 else
									 instance = awful.menu.clients({ width=250 })
								 end
											 end)
)

for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
													 awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
													 awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
													 awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
													 awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)


	-- Create the wibox
	mywibox[s] = awful.wibox({ position = "top", screen = s })
	mywibox[s]:buttons(awful.util.table.join(
	                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
	                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)))

	-- Widgets that are aligned to the left
	local left_layout = wibox.layout.fixed.horizontal()
	left_layout:add(mylauncher)
	left_layout:add(mytaglist[s])
	left_layout:add(mypromptbox[s])

	-- Widgets that are aligned to the right
	local right_layout = wibox.layout.fixed.horizontal()
	if s == 1 then right_layout:add(wibox.widget.systray()) end
	right_layout:add(wibox.widget.systray())
	right_layout:add(mytextclock)
	right_layout:add(mylayoutbox[s])

	-- Now bring it all together (with the tasklist in the middle)
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
	layout:set_middle(mytasklist[s])
	layout:set_right(right_layout)

	mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
							 awful.button({ }, 3, function () mymainmenu:toggle() end),
							 awful.button({ }, 4, awful.tag.viewnext),
							 awful.button({ }, 5, awful.tag.viewprev)
																	))
-- }}}

require("keys")
require("rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
										-- Add a titlebar
										-- awful.titlebar.add(c, { modkey = modkey })

										-- Enable sloppy focus
										c:connect_signal("mouse::enter", function(c)
																	 if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
																	 and awful.client.focus.filter(c) then
																		 client.focus = c
																	 end
																								 end)

										if not startup then
											-- Set the windows at the slave,
											-- i.e. put it at the end of others instead of setting it master.
											-- awful.client.setslave(c)

											-- Put windows in a smart way, only if they does not set an initial position.
											if not c.size_hints.user_position and not c.size_hints.program_position then
												awful.placement.no_overlap(c)
												awful.placement.no_offscreen(c)
											end
										end
														end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
