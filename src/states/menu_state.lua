local MenuState = {}
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")
local GuiParser = require("resource_control.data_parsers.gui_parser")
local Class = require("class")

local alreadyInit = false

function MenuState:init()
	if not alreadyInit then
        --self.soundtrack = ResourceManager:get("soundtrack")
    end
    --self:playOrStopMusic()

    self.guiRoot = GuiParser.readFrom("main_menu_ui.json")

    self.guiRoot:getWidget("next_state"):setCallback(function()
                            StateManager:requestPop()
                            StateManager:requestPush("Assault")
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



function MenuState:mousePressEvent() end

Class.registerSingleton(MenuState)

return MenuState
