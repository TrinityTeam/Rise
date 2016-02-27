local BritanniaState = {}
local Button = require("gui.button")
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")



function BritanniaState:init()

end




function BritanniaState:show()
    self.button:show()
    
end



function BritanniaState:hide()
    self.button:hide()
    
end



function BritanniaState:update(deltaTime)
    self.button:update(deltaTime)
end



return BritanniaState