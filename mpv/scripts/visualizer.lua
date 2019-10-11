local mode = "novideo"
    -- off              disable visualization
    -- noalbumart       enable visualization when no albumart and no video
    -- novideo          enable visualization when no video
    -- force            always enable visualization

if not (mp.get_property("options/lavfi-complex", "") == "") then
    return
end

local msg     = require 'mp.msg'

local function get_visualizer()
    local fps = 50
    local w = 700
    local h = w

    return "[aid1] asplit [ao]," ..
        "afifo," ..
        "aformat            =" ..
            "sample_rates   = 192000," ..
        "avectorscope       =" ..
            "scale          = lin:" ..
            "draw           = line:" ..
            "size           =" .. w .. "x" .. h .. ":" ..
            "m              = lissajous:" ..
            "rc             = 200:" ..
            "gc             = 72:" ..
            "bc             = 96:" ..
            "rf             = 35:" ..
            "gf             = 100:" ..
            "bf             = 80:" ..
            "r              =" .. fps .. "," ..
        "format             = rgb0 [vo]"
end

local function select_visualizer(atrack, vtrack, albumart)
    if mode == "off" then
        return ""
    elseif mode == "force" then
        return get_visualizer()
    elseif mode == "noalbumart" then
        if albumart == 0 and vtrack == 0 then
            return get_visualizer()
        end
        return ""
    elseif mode == "novideo" then
        if vtrack == 0 then
            return get_visualizer()
        end
        return ""
    end

    msg.log("error", "invalid mode")
    return ""
end

local function visualizer_hook()
    local count = mp.get_property_number("track-list/count", -1)
    local atrack = 0
    local vtrack = 0
    local albumart = 0
    if count <= 0 then
        return
    end
    for tr = 0,count-1 do
        if mp.get_property("track-list/" .. tr .. "/type") == "audio" then
            atrack = atrack + 1
        else
            if mp.get_property("track-list/" .. tr .. "/type") == "video" then
                if mp.get_property("track-list/" .. tr .. "/albumart") == "yes" then
                    albumart = albumart + 1
                else
                    vtrack = vtrack + 1
                end
            end
        end
    end

    mp.set_property("options/lavfi-complex", select_visualizer(atrack, vtrack, albumart))
end

mp.add_hook("on_preloaded", 50, visualizer_hook)
