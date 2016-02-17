local Label = {}
local GUI = require("gui.gui")



function Label.new(style)
	local self = {}

	self.textbox = MOAITextLabel.new()
	self.textbox:setStyle(style)
	self.textbox:setLoc(0, 0)
	self.textbox:setYFlip(true)
	self.textbox:setAlignment(MOAITextBox.CENTER_JUSTIFY, 
							  MOAITextBox.BASELINE_JUSTIFY)


	setmetatable(self, {__index = Label})
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



setmetatable(Label, {__call = function (self, ...)
							      return Label.new(...)
 							  end})

return Label