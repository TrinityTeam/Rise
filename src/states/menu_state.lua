local MenuState = {}
local GUI = require("gui.gui")
local Label = require("gui.label")
local Button = require("gui.button")
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")



function MenuState:init()
	self.soundtrack = ResourceManager:get("soundtrack")

	local headerStyle = MOAITextStyle.new()
	headerStyle:setColor(1, 0, 0)
	headerStyle:setFont(ResourceManager:get("header font"))
	headerStyle:setSize(52)

	self.header = Label(headerStyle)
	self.header:setText("RISE")
	self.header:setLoc(0, 150)

	local geass = MOAIProp2D.new()
	geass:setDeck(ResourceManager:get("geass"))
	local antigeass = MOAIProp2D.new()
	antigeass:setDeck(ResourceManager:get("antigeass"))
	local kurono_kishidan = MOAIProp2D.new()
	kurono_kishidan:setDeck(ResourceManager:get("kurono_kishidan"))

	self.button = Button(headerStyle)
	self.button:setTexture(Button.State.Normal, geass)
	self.button:setTexture(Button.State.Hovered, antigeass)
	self.button:setTexture(Button.State.Pressed, kurono_kishidan)
	self.button:setCallback(function()
                                StateManager:requestPop()
                                StateManager:requestPush("Game") 
                            end)
	self.button:setLoc(0, 0)

	local style = MOAITextStyle.new()
	style:setColor(0.4, 0, 0.9)
	style:setFont(ResourceManager:get("main font"))
	style:setSize(24)
	
    self.text = Label(style)
    self.text:setText("Coming soon...")
    self.text:setLoc(0, -280)
end




function MenuState:show()
    self.header:show()
    self.button:show()
    self.text:show()
end



function MenuState:hide()
    self.header:hide()
    self.button:hide()
    self.text:hide()
end



function MenuState:update(deltaTime)
    self.button:update()
end



function MenuState:playOrStopMusic()
    if self.soundtrack:isPlaying() then
        self.soundtrack:pause()
    else
        self.soundtrack:play()
    end
end



return MenuState