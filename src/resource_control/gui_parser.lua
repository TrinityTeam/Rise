local GUI_Parser = {}
local GUI_Root = require("gui.gui_root")
local ResourceManager = require("resource_control.resource_manager")
local Button = require("gui.button")
local Label = require("gui.label")


local function readButton(button_data)
    local style = MOAITextStyle.new()
    style:setColor(button_data.text_color.r, button_data.text_color.g, button_data.text_color.b)
    style:setFont(ResourceManager:get(button_data.font))
    style:setSize(button_data.text_size)

    local button = Button(style)
    button:setTexture(Button.State.Normal, ResourceManager:get(button_data.textures.normal))
    button:setTexture(Button.State.Hovered, ResourceManager:get(button_data.textures.hovered))
    button:setTexture(Button.State.Pressed, ResourceManager:get(button_data.textures.pressed))
    button:setLoc(button_data.loc.x, button_data.loc.y)
    button:setText(button_data.text)

    return button_data.id, button
end



local function readLabel(label_data)
    local style = MOAITextStyle.new()
    style:setColor(label_data.text_color.r, label_data.text_color.g, label_data.text_color.b)
    style:setFont(ResourceManager:get(label_data.font))
    style:setSize(label_data.text_size)

    label = Label(style)
    label:setText(label_data.text)
    label:setLoc(label_data.loc.x, label_data.loc.y)

    return label_data.id, label
end



function GUI_Parser.readFrom(filename)
    print("READ "..filename)
    local fullpath = "../data/gui/"..filename

    f = io.open(fullpath)
    local text = f:read("*a")
    local file = MOAIJsonParser.decode(text)
    
    local gui_root = GUI_Root.new()
    for k, v in pairs(file.buttons) do
        gui_root:addWidget(readButton(v))
    end

    for k, v in pairs(file.labels) do
        gui_root:addWidget(readLabel(v))
    end
    return gui_root
end



return GUI_Parser
