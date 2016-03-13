local MenuState = {}
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")
local GuiParser = require("resource_control.gui_parser")



function MenuState:init()
	if self.soundtrack == nil then
    --self.soundtrack = ResourceManager:get("soundtrack")
    end
    --self:playOrStopMusic()

    if self.guiRoot == nil then
        self.guiRoot = GuiParser.readFrom("main_menu.json")
    
        self.guiRoot:getWidget("next_state"):setCallback(function()
                                    StateManager:requestPop()
                                    StateManager:requestPush("Assault")
          --                        self:playOrStopMusic()
                                end)
    end
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



return MenuState
