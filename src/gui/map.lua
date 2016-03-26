local Map = {}
Map.Provinces = {}  -- dictionary with all provinces of map. Key type - MOAIColor, value type - logic.province.Province

local GUI = require("gui.gui")
local Label = require("gui.label")

function Province:new()
    MOAIInputMgr.device.mouseLeft:setCallback(function(isPressed)
        pickList = {
            globals.partition:propListForRay(originX, originY, 0, directionX, directionY, 0)
        }
    end)
end
