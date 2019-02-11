local helpers      = require("lain.helpers")
local shell        = require("awful.util").shell
local naughty      = require("naughty")
local wibox        = require("wibox")
local os           = { getenv = os.getenv }
local string       = { format = string.format,
                       gmatch = string.gmatch,
                       match  = string.match }

-- Playerctl infos
-- lain.widget.playerctl

local function factory(args)
    local playerctl           = { widget = wibox.widget.textbox() }
    local args          = args or {}
    local settings      = args.settings or function() end
    local cmd  = string.format("playerctl metadata --format '{{ status }}|{{ artist }}|{{ title }}'")

    helpers.set_map("current spotify track", nil)

    function playerctl.update()
        helpers.async({ shell, "-c", cmd }, function(f)
            widget = playerctl.widget
            playerctl_now = {
                title  = "N/A",
                artist = "N/A",
                status = "N/A"
            }
            string.gmatch(f, "")
            for status,artist,title in string.gmatch(f, "(.*)|(.*)|(.*)\n") do
                playerctl_now.title  = title
                playerctl_now.artist = artist
                playerctl_now.status = status
            end
            settings()
            if f ~= helpers.get_map("current spotify track") then
                helpers.set_map("current spotify track", "test")
                -- playerctl.id = naughty.notify(common).id
            end
        end)
    end

    playerctl.timer = helpers.newtimer("playerctl", 2, playerctl.update, true, true)

    return playerctl
end

return factory
