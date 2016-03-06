local GameState = {}
local GuiParser = require("resource_control.gui_parser")
local StateManager = require("states.state_manager")


function GameState:init()
    self.guiRoot = GuiParser.readFrom("game_ui.json")

    self.guiRoot:getWidget("next_state"):setCallback(function() 
                                StateManager:requestPop() 
                                StateManager:requestPush("Menu") 
                            end)
end



function GameState:show()
    self.guiRoot:show()
    
end



function GameState:hide()
    self.guiRoot:hide()
    
end



function GameState:update(deltaTime)
    self.guiRoot:update(deltaTime)
end



return GameState
