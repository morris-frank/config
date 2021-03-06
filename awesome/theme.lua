local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local midgets = require("midgets")

local os = { getenv = os.getenv, setlocale = os.setlocale }
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.confdir                                   = os.getenv("CONFIG_DIR") .. "/awesome/"
theme.wallpaper                                 = theme.confdir .. "/wall_2.jpg"
theme.font                                      = "Fira Sans Book 8"
theme.bg_normal                                 = "#282828"
theme.bg_focus                                  = "#689D6A"
theme.bg_urgent                                 = "#cc241d"
theme.fg_normal                                 = "#ebdbb2"
theme.fg_focus                                  = "#282828"
theme.fg_urgent                                 = "#282828"
theme.fg_minimize                               = "#ebdbb2"
theme.border_width                              = 0
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#606060"
theme.border_marked                             = "#3ca4d8"
theme.useless_gap                               = 0

local markup = lain.util.markup

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock(markup(theme.fg_normal, "%H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.calendar({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Fira Code 7",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Music player
local playerctl = midgets.playerctl({
    settings = function()
        local musc = ""
        local fcol = theme.bg_focus
        if playerctl_now.status ~= 'N/A' then
            musc = '<i>' .. playerctl_now.artist .. ' - ' .. playerctl_now.title .. '</i>'
        end
        if playerctl_now.status == 'Playing' then
            fcol = "#689D6A"
            musc = "⚞ " .. musc .. " ⚟"
        end
        widget:set_markup(markup.fontfg(theme.font, fcol, musc))
    end
})

-- Battery
local bat = lain.widget.bat({
    batteries = {"BAT0", "BAT1"},
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.time or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc))
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, volume_now.level .. "%"))
    end
})

local rspace = wibox.widget.textbox()
rspace.forced_width = 10

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, false)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, { bg_focus = barcolor })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 19, bg = theme.bg_normal, fg = theme.fg_normal })

    local wiboxlayout = wibox.layout.align.horizontal()
    wiboxlayout.expand = "none"
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wiboxlayout,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            playerctl.widget,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            rspace,
            bat.widget,
            rspace,
            theme.volume.widget,
            rspace,
            mytextclock,
        },
    }
end

return theme
