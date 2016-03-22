local Label = {}
local Class = require("class")
local GUI = require("gui.gui")



function Label.new(style)
	local self = {}

	self.textbox = MOAITextLabel.new()
	self.textbox:setStyle(style)
	self.textbox:setLoc(0, 0)
	self.textbox:setYFlip(true)
	self.textbox:setAlignment(MOAITextBox.CENTER_JUSTIFY, 
							  MOAITextBox.BASELINE_JUSTIFY)


	return self
end



function Label:show()
	GUI.getLayer():insertProp(self.textbox)
end



function Label:hide()
	GUI.getLayer():removeProp(self.textbox)
end



function Label:setText(text)
	self.textbox:setString(text)
end



function Label:setLoc(x, y)
	self.textbox:setLoc(x, y)
end



function Label:setSize(width, height)
	local xmin, ymin, xmax, ymax = self.textbox:getRect()
	local origin = {x = xmin+(xmax-xmin)/2, 
					y = ymin+(ymax-ymin)/2}
	self.textbox:setRect(origin.x - width/2, origin.y - height/2,
						 origin.x + width/2, origin.y + height /2)
end



function Label:getBounds()
	local xmin, ymin, xmax, ymax = self.textbox:getRect()
	return {x=xmin, y=ymin, w=xmax-xmin, h=ymax-ymin}
end



function Label:update()

end


Class.register(Label)

return Label