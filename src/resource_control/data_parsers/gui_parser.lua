local GUI_Parser = {}
local GUI_Root = require("gui.gui_root")
local ButtonParser = require("resource_control.data_parsers.button_parser")
local LabelParser = require("resource_control.data_parsers.label_parser")



function GUI_Parser.readFrom(filename)
    print("READ "..filename)
    local fullpath = "../data/gui/"..filename

    local f = io.open(fullpath)
    local text = f:read("*a")
    local file = MOAIJsonParser.decode(text)
    
    local gui_root = GUI_Root()
    for k, v in pairs(file.buttons or {}) do
        gui_root:addWidget(ButtonParser.createButton(v))
    end

    for k, v in pairs(file.labels or {}) do
        gui_root:addWidget(LabelParser.createLabel(v))
    end
    return gui_root
end



return GUI_Parser
