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



local function checkWindowOpened()
	if layer == nil then 
		print "Error: You should open window before accessing layer"
		return false
	end
	return true
end



function GUI.getLayer()
	if checkWindowOpened() then
		return layer
	end
end



function GUI.createSprite(name, size, loc)
	local image = ResourceManager:get(name)
	
	local prop = MOAIProp2D.new()
	prop:setDeck(image)
	prop:setLoc(loc.x, loc.y)
	
	GUI.getLayer():insertProp(prop)
end



return GUI