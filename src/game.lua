local Game = {}

local StateManager = require("states.state_manager")
local DefinitionsList = require("resource_control.definitions_list")
local MenuState = require("states.menu_state")
local GameState = require("states.game_state")



function Game.run()
	Game.init()
	while not Game.isOver do
		StateManager:update()
		coroutine.yield()
	end
	os.exit()
end



function Game.init()
	
	MOAIDebugLines.setStyle ( MOAIDebugLines.PARTITION_CELLS, 2, 1, 1, 1 )
	MOAIDebugLines.setStyle ( MOAIDebugLines.PARTITION_PADDED_CELLS, 1, 0.5, 0.5, 0.5 )
	MOAIDebugLines.setStyle ( MOAIDebugLines.PROP_WORLD_BOUNDS, 2, 0.75, 0.75, 0.75 )
	MOAIDebugLines.setStyle ( MOAIDebugLines.PROP_MODEL_BOUNDS, 2, 1, 1, 1 )
	GUI.getLayer():showDebugLines(true)
	
	MOAIUntzSystem.initialize()
	
	DefinitionsList.init()

	StateManager:registerState("Game", GameState)
	StateManager:registerState("Menu", MenuState)
	StateManager:requestPush("Menu")

	Game.isOver = false

	MOAIInputMgr.device.keyboard:setCallback(Game.processKeyboard)
end



function Game.processKeyboard(key, down)
	if down then
		if key == 283 then
			Game.isOver = true
		end
	end
end


return Game