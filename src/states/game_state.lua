local GameState = {}
local Button = require("gui.button")
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")


function GameState:init()
    local style = MOAITextStyle.new()
    style:setColor(1, 1, 1)
    style:setFont(ResourceManager:get("main font"))
    style:setSize(24)

    self.button = Button(style)
    self.button:setTexture(Button.State.Normal, ResourceManager:get("geass"))
    self.button:setTexture(Button.State.Hovered, ResourceManager:get("antigeass"))
    self.button:setTexture(Button.State.Pressed, ResourceManager:get("kurono_kishidan"))
    self.button:setCallback(function() 
                                StateManager:requestPop() 
                                StateManager:requestPush("Menu") 
                            end)
    self.button:setText("Game")
    self.button:setLoc(0, 0)
end



function GameState:show()
    self.button:show()
    
end



function GameState:hide()
    self.button:hide()
    
end



function GameState:update(deltaTime)
    self.button:update(deltaTime)
end



return GameState
