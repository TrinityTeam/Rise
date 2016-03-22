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
	GUI.getLayer():showDebugLines(true)
	
	MOAIUntzSystem.initialize()
	
	DefinitionsList.init()

    local field = Battlefield({w = 10, h = 10})

    local players = {
    	["Kurono Kishidan"] = {
    	    units = {
    	        u1 = Unit(13, 3, 7),
    	        u2 = Unit(7, 3, 3)
    	    }
    	},
    	["Britannia Empire"] = {
    	    units = {
    	        wk = Unit(33, 3, 12),
    	        u3 = Unit(7, 3, 3)
    	    }
    	}
	}

    local units = {}

    local pos = 0 --! @todo: units arrangement
    for name, data in pairs(players) do
        for id, unit in pairs(players[name].units) do
            pos = pos + 1
            unit.owner = name
            unit.id = id
            unit.pos = {x = pos % field:getSize().w + 1, 
                        y = math.ceil(pos / field:getSize().w)}
            io.write(id, " ", unit.pos.x, " ", unit.pos.y, "\n")
            units[id] = unit
        end
    end
    local data = BattleData.new(field, units)

	StateManager:registerState("Game", GameState)
	StateManager:registerState("Menu", MenuState)
	StateManager:registerState("Assault", AssaultState)
	StateManager:requestPush("Game", data)

	Game.isOver = false

	MOAIInputMgr.device.keyboard:setCallback(Game.processKeyboard)
	MOAIInputMgr.device.pointer:setCallback(StateManager.mousePressEvent)
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
