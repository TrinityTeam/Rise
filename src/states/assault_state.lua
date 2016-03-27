local AssaultState = {}
local Class = require("class")
local GuiParser = require("resource_control.data_parsers.gui_parser")
local StateManager = require("states.state_manager")
local GUI = require("gui.gui")
local ResourceManager = require("resource_control.resource_manager")



function AssaultState:init(args)
    local battleData = args.battleData
    if false then
        self.guiRoot = GuiParser.readFrom("assault_ui.json")
    
        self.guiRoot:getWidget("next_state"):setCallback(function() 
                                    StateManager:requestPop() 
                                    StateManager:requestPush("Menu") 
                                end)
    end

    self.grid = MOAIGrid.new()
    self.grid:initHexGrid(math.ceil(battleData.battlefield:getWidth()/2), battleData.battlefield:getHeight()*2, 32)
    self.grid:fill(1)

    self.tileDeck = MOAITileDeck2D.new()
    self.tileDeck:setTexture("../data/textures/hex-tiles.png")
    self.tileDeck:setSize(1, 1, 0.25, 0.216796875)

    self.gridProp = MOAIProp2D.new()
    self.gridProp:setDeck(self.tileDeck)
    self.gridProp:setGrid(self.grid)
    self.gridProp:setLoc(-256, -256)
    self.gridProp:forceUpdate()
    GUI:getLayer():insertProp(self.gridProp)

    for c = 1, math.ceil(battleData.battlefield:getWidth()/2) do
        for r = 1, battleData.battlefield:getHeight()*2 do
            local x, y = self.grid:getTileLoc(c, r)
            x, y = self.gridProp:modelToWorld(x, y)
            local textbox = MOAITextBox.new ()
            textbox:setFont ( ResourceManager:get("default_font") )
            textbox:setTextSize ( 20 )
            textbox:setRect ( -20, -20, 20, 20 )
            textbox:setLoc ( x, y )
            textbox:setYFlip ( true )
            textbox:setAlignment ( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
            GUI:getLayer():insertProp ( textbox )
        
            textbox:setString ( string.format("%d,%d", c, r) )
        end
    end

    self.units = {}
    for id, unit in pairs(battleData.units) do 
        local gfxQuad = MOAIGfxQuad2D.new()
        gfxQuad:setTexture("../data/textures/sutherland.png")
        gfxQuad:setRect(-24, -24, 24, 24)
         
        self.units[id] = MOAIProp2D.new()
        self.units[id]:setDeck(gfxQuad)
        self.units[id]:setLoc(self.gridProp:modelToWorld(self.grid:getTileLoc(unit:getPosition().x, unit:getPosition().y)))
        GUI.getLayer():insertProp(self.units[id])
    end
end



function AssaultState:show()
    --self.guiRoot:show()
end



function AssaultState:hide()
    --self.guiRoot:hide()
end



function AssaultState:update(deltaTime)
    
    --self.guiRoot:update(deltaTime)
end



Class.registerSingleton(AssaultState)

return AssaultState
