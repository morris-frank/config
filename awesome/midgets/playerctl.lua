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
    local cmd  = string.format("playerctl metadata --format '{{ artist }} - {{ title }}'")

    helpers.set_map("current spotify track", nil)

    function playerctl.update()
        helpers.async({ shell, "-c", cmd }, function(f)
            widget = playerctl.widget
            playerctl_now = string.match(f , "(.*)\n")
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
