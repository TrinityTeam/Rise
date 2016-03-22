local Button = {}
local Class = require("class")
local GUI = require("gui.gui")
local Label = require("gui.label")
Button.State = {Normal = 1, Pressed = 2, Hovered = 3}



function Button.new(text_style)
	local self = {}

	self.text = Label(text_style)
	self.textures = {}
	self.currentTexture = MOAIProp2D.new()
	self.state = Button.State.Normal
	self.isShown = false

    -- Backup: MOAIInputMgr.device.mouseLeft:setCallback(function(isPressed) self:mousePressEvent(isPressed) end)
    MOAIInputMgr.device.mouseLeft:setCallback(self:mousePressEvent)

	setmetatable(self, {__index = Button})

	MOAIInputMgr.device.mouseLeft:setCallback(function(isPressed) 
											  	  self:mousePressEvent(isPressed) 
											  end)
	return self
end



function Button:setCallback(callback)
	self.callback = callback
end



function Button:update(deltaTime)
	local x, y = GUI:getLayer():wndToWorld(MOAIInputMgr.device.pointer:getLoc())
	if self.currentTexture:inside(x, y) then
		if self.state == Button.State.Normal then
			self:_setState(Button.State.Hovered)
		end
	else
		self:_setState(Button.State.Normal)
	end
end



function Button:mousePressEvent(isPressed) 
	assert(self.currentTexture, "You must specify button textures")
	if isPressed then
		if self.state == Button.State.Hovered then
			self:_setState(Button.State.Pressed)
		end
	else
		if self.state == Button.State.Pressed then
			self.callback()
			self:_setState(Button.State.Hovered)
		end
	end
end



function Button:setSize(width, height)
	self.text:setSize(width, height)
	local x, y = self.currentTexture:getDims()
	self.currentTexture:setScl(width / x, height / y, 1)
end



function Button:setTexture(state, texture)
	self.textures[state] = texture
	if state == self.state then
		self.currentTexture:setDeck(texture)
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
	self.currentTexture:setLoc(x, y)
end



function Button:setText(text)
	self.text:setText(text)
end



function Button:_setState(state)
	self.state = state
	self.currentTexture:setDeck(self.textures[state])
end

Class.register(Button)

return Button
