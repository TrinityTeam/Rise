local Button = {}
local GUI = require("gui.gui")
local Label = require("gui.label")
Button.State = {Normal = 1, Pressed = 2, Hovered = 3}



function Button.new(text_style)
	local self = {}

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
	if self.currentTexture:inside(GUI.getLayer():wndToWorld(x, y)) then
		self:_setCurrentTexture(self.textures[Button.State.Hovered])

	else
		self:_setCurrentTexture(self.textures[Button.State.Normal])
	end
end



function Button:mousePressEvent(isPressed) 
	if isPressed then
		if self.currentTexture == self.textures[Button.State.Hovered] then
			self:_setCurrentTexture(self.textures[Button.State.Pressed])
		end
	else
		if self.currentTexture == self.textures[Button.State.Pressed] then
			self.callback()
			self:_setCurrentTexture(self.textures[Button.State.Hovered])
		end
	end
end



function Button:setTexture(state, image)
	self.textures[state] = image
	print(state, self.textures[state])
	if self.currentTexture == nil then
		self.currentTexture = image
	end
end



function Button:show()
	self.isShown = true
	GUI.getLayer():insertProp(self.currentTexture)
	self.text:show()
end



function Button:hide()
	self.isShown = true
	GUI.getLayer():removeProp(self.currentTexture)
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
	if self.currentTexture ~= image then
		GUI.getLayer():removeProp(self.currentTexture)
		self.currentTexture = image
		if self.isShown then
			GUI.getLayer():insertProp(self.currentTexture)
		end
	end
end



setmetatable(Button, {__call = function (self, ...)
							      return Button.new(...)
 							   end})

return Button