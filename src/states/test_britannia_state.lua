local BritanniaState = {}
local Button = require("gui.button")
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")



function BritanniaState:init()
    local style = MOAITextStyle.new()
    style:setColor(1, 1, 1)
    style:setFont(ResourceManager:get("main font"))
    style:setSize(24)

    self.sign = Button(style)
    self.sign:setTexture(Button.State.Normal, ResourceManager:get("britannia"))
    self.sign:setTexture(Button.State.Hovered, ResourceManager:get("britannia"))
    self.sign:setTexture(Button.State.Pressed, ResourceManager:get("britannia"))
    self.sign:setSize(400, 300)
    self.sign:setCallback(function ()
                              StateManager:requestPop()
                              StateManager:requestPush("Game")
                          end)
end




function BritanniaState:show()
    self.sign:show()
    
end



function BritanniaState:hide()
    self.sign:hide()
end



function BritanniaState:update(deltaTime)
    self.sign:update(deltaTime)
end



return BritanniaState