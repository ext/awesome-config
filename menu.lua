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

mymainmenu = awful.menu(
   { items = {
	{ "terminal", terminal, ".icons/term.png" },
	{ "IRC", "/home/ext/bin/user/irc" },
	separator,
	{ "&Firefox", "firefox", ".icons/firefox.png" },
	{ "&Chromium", "chromium", ".icons/chromium.png" },
	{ "&Thunderbird", "thunderbird", ".icons/thunderbird.xpm"},
	{ "&Amarok", "amarok", ".icons/amarok.png" },
	{ "&Gimp", "gimp" },
	{ "&LibreOffice", "libreoffice", ".icons/office.xpm" },
	{ "&Eclipse", "eclipse-3.5" },
	{ "&VirtualBox", "VirtualBox" },
	separator,
	{ "awesome", myawesomemenu, beautiful.awesome_icon },
	{ "system", sysmenu }
     }
  })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
-- }}}

-- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
