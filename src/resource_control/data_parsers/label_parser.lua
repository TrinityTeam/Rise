local LabelParser = {}
local Label = require("gui.label")
local ResourceManager = require("resource_control.resource_manager")

local defaults = nil

local function readDefaults(filename)
    print("READ "..filename)
    local fullpath = "../data/gui/defaults/"..filename

    local f = io.open(fullpath)
    local text = f:read("*a")
    defaults = MOAIJsonParser.decode(text)
end



function LabelParser.createLabel(data)
    if defaults == nil then
        readDefaults("default_label.json")
    end

    local style = MOAITextStyle.new()
    local text_color = data.text_color or defaults.text_color
    style:setColor(text_color.r, text_color.g, text_color.b)
    style:setFont(ResourceManager:get(data.font or defaults.font))
    style:setSize(data.text_size or defaults.text_size)

    local label = Label(style)
    label:setText(data.text or defaults.text_size)
    local loc = data.loc or defaults.loc
    label:setLoc(loc.x, loc.y)

    return data.id, label
end



return LabelParser