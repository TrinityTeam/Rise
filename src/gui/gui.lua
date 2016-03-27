local GUI = {}

local viewport
local layer

local ResourceManager = require("resource_control.resource_manager")
local callbacks = {mouse_click = {}, keyboard = {}}


function GUI.openWindow(title, width, height)
	MOAISim.openWindow(title, width, height)
	local viewport = MOAIViewport.new()
	viewport:setSize(width, height)
	viewport:setScale(width, height)
	GUI.layer = MOAILayer2D.new()
	GUI.layer:setViewport(viewport)

    MOAIInputMgr.device.mouseLeft:setCallback(function(isPressed) 
                                                  for _, callback in pairs(callbacks.mouse_click) do
                                                      callback(isPressed)
                                                  end
                                              end)
    MOAIInputMgr.device.keyboard:setCallback(function(key, isPressed) 
                                                 print(key)
                                                 for _, callback in pairs(callbacks.keyboard) do
                                                     callback(key, isPressed)
                                                 end 
                                             end)
	local renderTable = { GUI.getLayer() }
	MOAIRenderMgr.setRenderTable(renderTable)
end



function GUI.addKeyboardCallback(callback)
    table.insert(callbacks.keyboard, callback)
end



function GUI.addMouseClickCallback(callback)
    table.insert(callbacks.mouse_click, callback)
end



function GUI.getLayer()
	return GUI.layer
end

return GUI
