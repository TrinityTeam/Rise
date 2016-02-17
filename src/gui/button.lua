local Button = {}
local GUI = require("gui.gui")
local Label = require("gui.label")
local Image = require("gui.image")
Button.State = {Normal = 1, Pressed = 2, Hovered = 3}



function Button.new(text_style)
	local self = {}
	self.state = Button.State.Normal

	self.text = Label(text_style)
	self.textures = {}
	self.isShown = false

	MOAIInputMgr.device.pointer:setCallback(function(x, y) self:mouseMoveEvent(x, y) end)
	MOAIInputMgr.device.mouseLeft:setCallback(function(isPressed) self:mousePressEvent(isPressed) end)

	setmetatable(self, {__index = Button})
	return self
end



function Button:setCallback(callback)
	self.callback = callback
end



function Button:mouseMoveEvent(x, y) 
	if self.currentTexture:isInside(GUI.getLayer():wndToWorld(x, y)) then
		self._setCurrentTexture(self.textures[Button.State.Hovered])
	else
		self._setCurrentTexture(self.textures[Button.State.Normal])
	end
end



function Button:mousePressEvent(isPressed) 
	if isPressed then
		if self.currentTexture == self.textures[Button.State.Hovered] then
			self._setCurrentTexture(self.textures[Button.State.Pressed])
		end
	else
		if self.currentTexture == self.textures[Button.State.Pressed] then
			self.callback()
			self._setCurrentTexture(self.textures[Button.State.Hovered])
		end
	end
end



function Button:setTexture(state, image)
	self.textures[state] = image
	if self.currentTexture == nil then
		self.currentTexture = image
	end
end



function Button:show()
	self.isShown = true
	self.currentTexture:show()
	self.text:show()
end



function Button:hide()
	self.isShown = true
	self.currentTexture:hide()
	self.text:hide()
end



function Button:setLoc(x, y)
	self.text:setLoc(x, y)
	for k, v in pairs(self.textures) do
		self.textures[k]:setLoc(x, y)
	end
end



function Button:setText(text)
	self.text:setText(text)
end



function Button:_setCurrentTexture(image)
	if self.currentTexture then
		self.currentTexture:hide()
	end
	self.currentTexture = image
	if self.isShown then
		self.currentTexture:show()
	end
end



setmetatable(Button, {__call = function (self, ...)
							      return Button.new(...)
 							   end})

return Button