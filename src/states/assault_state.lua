local AssaultState = {}
local Class = require("class")
local GuiParser = require("resource_control.data_parsers.gui_parser")
local StateManager = require("states.state_manager")
local GUI = require("gui.gui")
local ResourceManager = require("resource_control.resource_manager")

local grid
local gridProp
local guiRoot
local units


function AssaultState:init(args)
    local battleData = args.battleData
    if false then
        guiRoot = GuiParser.readFrom("assault_ui.json")
    
        guiRoot:getWidget("next_state"):setCallback(
                function() 
                    StateManager:requestPop() 
                    StateManager:requestPush("Menu") 
                end)
    end

    grid = MOAIGrid.new()
    grid:initHexGrid(math.ceil(battleData.battlefield:getWidth()/2), battleData.battlefield:getHeight()*2, 32)
    grid:fill(1)

    local tileDeck = MOAITileDeck2D.new()
    tileDeck:setTexture("../data/textures/hex-tiles.png")
    tileDeck:setSize(1, 1, 0.25, 0.216796875)

    gridProp = MOAIProp2D.new()
    gridProp:setDeck(tileDeck)
    gridProp:setGrid(grid)
    gridProp:setLoc(-256, -256)
    gridProp:forceUpdate()
    GUI:getLayer():insertProp(gridProp)

    for c = 1, math.ceil(battleData.battlefield:getWidth()/2) do
        for r = 1, battleData.battlefield:getHeight()*2 do
            local x, y = grid:getTileLoc(c, r)
            x, y = gridProp:modelToWorld(x, y)
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

    units = {}
    for id, unit in pairs(battleData.units) do 
        local gfxQuad = MOAIGfxQuad2D.new()
        gfxQuad:setTexture("../data/textures/sutherland.png")
        gfxQuad:setRect(-24, -24, 24, 24)
         
        units[id] = MOAIProp2D.new()
        units[id]:setDeck(gfxQuad)
        units[id]:setLoc(gridProp:modelToWorld(grid:getTileLoc(unit:getPosition().x, unit:getPosition().y)))
        GUI.getLayer():insertProp(units[id])
    end
end



function AssaultState.show()
    --guiRoot:show()
end



function AssaultState.hide()
    --guiRoot:hide()
end



function AssaultState.update(deltaTime)
    
    --guiRoot:update(deltaTime)
end



Class.registerSingleton(AssaultState)

return AssaultState
