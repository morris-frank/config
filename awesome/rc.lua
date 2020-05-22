--[[
     Based on github.com/lcpz
--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

--- AUTOSTART
run_once({"nm-applet", "unclutter", "pcloud", "blueman-tray"})
---

-- {{{ Variable definitions

local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "konsole"
local editor       = os.getenv("EDITOR") or "joe"

awful.util.terminal = terminal
awful.util.tagnames = { "www", "code", "3", "4", "5", "6", "7", "8", "pass", "music" }
awful.layout.layouts = {
    awful.layout.suit.tile.right,
    awful.layout.suit.tile.bottom
}

local theme_path = string.format("%s/awesome/theme.lua", os.getenv("CONFIG_DIR"))
beautiful.init(theme_path)
-- }}}

--{{{ Notifications
naughty.config.defaults['icon_size'] = 100
--- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}}

-- {{{ Key bindings
awful.util.taglist_buttons = my_table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

globalkeys = my_table.join(
    -- Hotkeys
    awful.key({ modkey,           }, "#67",      hotkeys_popup.show_help,
              {description = "show help", group="awesome"}),
    -- Tag browsing
    awful.key({ modkey,           }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "a", awful.tag.history.restore,
              {description = "toggle between the current and the last tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "h",
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[client.focus.first_tag.index - 1]
                if tag then
                    client.focus:move_to_tag(tag)
                    awful.tag.viewprev()
                end
            end
        end,
        {description = "move client to the prev tag", group = "client"}),
    awful.key({ modkey, "Shift" }, "l",
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[client.focus.first_tag.index + 1]
                if tag then
                    client.focus:move_to_tag(tag)
                    awful.tag.viewnext()
                end
            end
        end,
        {description = "move client to the next tag", group = "client"}),

    -- By direction client focus
    awful.key({ modkey }, "Down",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "Up",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "Left",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "Right",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx(  1)    end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx( -1)    end,
        {description = "swap with previous client by index", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "layout"}),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "layout"}),

    -- Standard program
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ "Control", altkey   }, "#115", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, "Alt"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Alt"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),

    awful.key({ modkey, "Control"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey, "Control" }, "j",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "k",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn("xsel | xsel -i -b") end,
              {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn("xsel -b | xsel") end,
              {description = "copy gtk to terminal", group = "hotkeys"})
)

clientkeys = my_table.join(
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "f",
              function (c)
                  c.ontop = not c.ontop
                  awful.client.floating.toggle()
              end,
              {description = "toggle floating (and keeping it on top)", group = "client"}),
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "m", function (c) c.fullscreen = not c.fullscreen     end,
              {description = "toggle fullscreen", group = "client"})
)

-- Bind all key numbers to tags.
for i = 1, 10 do
    -- Hack to only show tags 1,10,F1 and F10 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 10 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
    end
    if i <= 10 then offset = 9 else offset = 56 end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + offset,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + offset,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + offset,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move)
    )
end

clientbuttons = my_table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     },
    },


    -- Start windows as slave
    { rule = { }, properties = { }, callback = awful.client.setslave },


    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
        properties = { titlebars_enabled = false } },


    -- Set default tags for my standard programs.
    { rule = { class = "keepassxc" },
        properties = { tag = awful.util.tagnames[9] } },

    { rule = { class = "Spotify" },
        properties = { tag = awful.util.tagnames[10] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
        properties = { maximized = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- No border for maximized clients
function border_adjust(c)
    if c.maximized then -- no borders if only 1 client visible
        c.border_width = 0
    elseif #awful.screen.focused().clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
