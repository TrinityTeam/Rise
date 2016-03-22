local GameState = {}
local GuiParser = require("resource_control.data_parsers.gui_parser")
local StateManager = require("states.state_manager")
local Class = require("class")


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



function GameState:mousePressEvent() end

Class.registerSingleton(GameState)

return GameState
