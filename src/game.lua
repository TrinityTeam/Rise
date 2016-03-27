local Game = {}

local StateManager = require("states.state_manager")
local DefinitionsList = require("resource_control.definitions_list")
local MenuState = require("states.menu_state")
local GameState = require("states.game_state")
local AssaultState = require("states.assault_state")
local Battlefield = require("logic.battlefield")
local Unit = require("logic.unit")
local BattleData = require("logic.battle_data")
local GUI = require("gui.gui")
local Class = require("class")



function Game.run()
	Game.init()
	while not Game.isOver do
		StateManager:update()
		coroutine.yield()
		io.flush()
	end
	os.exit()
end



function Game.init()
	MOAIDebugLines.setStyle(MOAIDebugLines.PARTITION_CELLS, 2, 1, 1, 1)
	MOAIDebugLines.setStyle(MOAIDebugLines.PARTITION_PADDED_CELLS, 1, 0.5, 0.5, 0.5)
	MOAIDebugLines.setStyle(MOAIDebugLines.PROP_WORLD_BOUNDS, 2, 0.75, 0.75, 0.75)
	MOAIDebugLines.setStyle(MOAIDebugLines.PROP_MODEL_BOUNDS, 2, 1, 1, 1)
	GUI.getLayer():showDebugLines(false)
	
	MOAIUntzSystem.initialize()
	
	DefinitionsList.init()

	StateManager:registerState("Game", GameState)
	StateManager:registerState("Menu", MenuState)
	StateManager:registerState("Assault", AssaultState)
	StateManager:requestPush("Game")

	Game.isOver = false

	GUI.addKeyboardCallback(Game.processKeyboard)
end



function Game.processKeyboard(key, down)
	if down then
		if key == 283 then
			Game.isOver = true
		end
	end
end


Class.registerSingleton(Game)

return Game
