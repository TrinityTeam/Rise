local GUI = {}

local viewport
local layer

local ResourceManager = require("resource_control.resource_manager")

function GUI.openWindow(title, width, height)
	MOAISim.openWindow(title, width, height)
	viewport = MOAIViewport.new()
	viewport:setSize(width, height)
	viewport:setScale(width, height)
	layer = MOAILayer2D.new()
	layer:setViewport(viewport)

	renderTable = { GUI.getLayer() }
	MOAIRenderMgr.setRenderTable(renderTable)
end



function GUI.getLayer()
	return layer
end



return GUI