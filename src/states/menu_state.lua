local MenuState = {}
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")
local GuiParser = require("resource_control.data_parsers.gui_parser")
local Class = require("class")
local Battlefield = require("logic.battlefield")
local BattleData = require("logic.battle_data")
local Unit = require("logic.unit")

local alreadyInit = false

function MenuState:init()
	if not alreadyInit then
        --self.soundtrack = ResourceManager:get("soundtrack")
    end
    --self:playOrStopMusic()

    self.guiRoot = GuiParser.readFrom("main_menu_ui.json")

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
    self.data = BattleData(field, units)

    self.guiRoot:getWidget("next_state"):setCallback(function()
                            StateManager:requestPop()
                            StateManager:requestPush("Assault", {battleData = self.data})
                            --self:playOrStopMusic()
                            end)
    alreadyInit = true
end



function MenuState:show()
    self.guiRoot:show()
end



function MenuState:hide()
    self.guiRoot:hide()
end



function MenuState:update(deltaTime)
    self.guiRoot:update(deltaTime)
end



function MenuState:playOrStopMusic()
    if self.soundtrack:isPlaying() then
        self.soundtrack:stop()
    else
        self.soundtrack:play()
    end
end



Class.registerSingleton(MenuState)

return MenuState
