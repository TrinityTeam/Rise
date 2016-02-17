local Image = {}
local GUI = require("gui.gui")
local ResourceManager = require("resource_control.resource_manager")


function Image.new(image_id)
	self = {}

	self.prop = MOAIProp2D.new()
	self.prop:setDeck(ResourceManager:get(image_id))
	self.prop:setLoc(0, 0)

	setmetatable(self, {__index = Image})
	return self
end



function Image:show()
	GUI.getLayer():insertProp(self.prop)
end



function Image:hide()
	GUI.getLayer():removeProp(self.prop)
end



function Image:setLoc(x, y)
	self.prop:setLoc(x, y)
end



function Image:isInside(x, y)
	return self.prop:inside(x, y)
end



setmetatable(Image, {__call = function (self, ...)
							      return Image.new(...)
 							  end})

return Image