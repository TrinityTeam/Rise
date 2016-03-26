local TextEditParser = {}
local TextEdit = require("gui.text_edit")
local ResourceManager = require("resource_control.resource_manager")

local defaults = nil

local function readDefaults(filename)
    io.write("READ ", filename, "\n")
    local fullpath = "../data/gui/defaults/"..filename

    local f = io.open(fullpath)
    local text = f:read("*a")
    defaults = MOAIJsonParser.decode(text)
end



function TextEditParser.createTextEdit(data)
    if defaults == nil then
        readDefaults("default_label.json")
    end

    local style = MOAITextStyle.new()
    local text_color = data.text_color or defaults.text_color
    style:setColor(text_color.r, text_color.g, text_color.b)
    style:setFont(ResourceManager:get(data.font or defaults.font))
    style:setSize(data.text_size or defaults.text_size)

    local textEdit = TextEdit(style)
    local loc = data.loc or defaults.loc
    textEdit:setLoc(loc.x, loc.y)
    textEdit:setText(data.text or defaults.text)

    return data.id, textEdit
end



return TextEditParser