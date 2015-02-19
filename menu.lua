-- {{{ Menu
-- Create a laucher widget and a main menu

separator = { "———————" }

myawesomemenu = {
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
	{ "restart", awesome.restart },
}

sysmenu = {
	{ "shut down", "sudo -n /sbin/halt" },
	{ "suspend to ram", "sudo -n /usr/sbin/pm-suspend" },
	{ "suspend to disk", "sudo -n /usr/sbin/pm-hibernate" },
	{ "reboot", "sudo -n /sbin/reboot" },
	{ "log out", awesome.quit }
}

mymainmenu = awful.menu({
	items = {
			{ "terminal", terminal, ".config/awesome/icons/term.png" },
			{ "IRC", "/home/ext/bin/user/irc" },
			separator,
			{ "&Firefox", "firefox", ".config/awesome/icons/firefox.png" },
			{ "Firefox (Tor)", "firefox -P tor", ".config/awesome/icons/firefox.png" },
			{ "&Chromium", "chromium", ".config/awesome/icons/chromium.png" },
			{ "&Thunderbird", "thunderbird", ".config/awesome/icons/thunderbird.xpm"},
			{ "&Amarok", "amarok", ".config/awesome/icons/amarok.png" },
			{ "&Gimp", "gimp", ".config/awesome/icons/gimp.png" },
			{ "&LibreOffice", "libreoffice", ".config/awesome/icons/office.xpm" },
			{ "&VirtualBox", "VirtualBox", ".config/awesome/icons/virtualbox.png" },
			{ "&Steam", "steam", ".config/awesome/icons/steam.png" },
			{ "&Wireshark", "wireshark", ".config/awesome/icons/wireshark.png" },
			{ "&Skype", "skype"},
			separator,
			{ "awesome", myawesomemenu, beautiful.awesome_icon },
			{ "system", sysmenu }
	}
})

mylauncher = awful.widget.launcher(
	{image = beautiful.awesome_icon, menu = mymainmenu }
)

-- }}}

-- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
