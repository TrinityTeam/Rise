local ButtonParser = {}
local ResourceManager = require("resource_control.resource_manager")
local Button = require("gui.button")
local defaults = nil


local function readDefaults(filename)
    print("READ "..filename)
    local fullpath = "../data/gui/defaults/"..filename

    local f = io.open(fullpath)
    local text = f:read("*a")
    defaults = MOAIJsonParser.decode(text)
end



function ButtonParser.createButton(data)
    if defaults == nil then
        readDefaults("default_button.json")
    end

    local style = MOAITextStyle.new()
    local text_color = data.text_color or defaults.text_color
    style:setColor(text_color.r, text_color.g, text_color.b)
    style:setFont(ResourceManager:get(data.font or defaults.font))
    style:setSize(data.text_size or defaults.text_size)

    local button = Button(style)
    local textures = data.textures or defaults.textures
    button:setTexture(Button.State.Normal, ResourceManager:get(textures.normal))
    button:setTexture(Button.State.Hovered, ResourceManager:get(textures.hovered))
    button:setTexture(Button.State.Pressed, ResourceManager:get(textures.pressed))
    local loc = data.loc or defaults.loc
    button:setLoc(loc.x, loc.y)
    button:setText(data.text or defaults.text)

    return data.id, button
end



return ButtonParser