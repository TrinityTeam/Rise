local GUI = {}

local viewport
local layer

local ResourceManager = require("resource_control.resource_manager")



function GUI.openWindow(title, width, height)
	MOAISim.openWindow(title, width, height)
	local viewport = MOAIViewport.new()
	viewport:setSize(width, height)
	viewport:setScale(width, height)
	GUI.layer = MOAILayer2D.new()
	GUI.layer:setViewport(viewport)

	local renderTable = { GUI.getLayer() }
	MOAIRenderMgr.setRenderTable(renderTable)
end



function GUI.getLayer()
	return GUI.layer
end

return GUI