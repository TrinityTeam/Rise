-- This file is for testing new abilities

local Battlefield = require('logic.battlefield')
local Unit = require('logic.unit')

local Game = {}

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

function Game.init(players)
    Game.field = Battlefield({w = 3, h = 3})

    Game.units = {}

    local pos = 0 --! @todo: units arrangement
    for name, data in pairs(players) do
        for id, unit in pairs(players[name].units) do
            pos = pos + 1
            unit.owner = name
            Game.units[id] = unit
            Game.field:addUnit(id, {x = pos % Game.field:getSize().w, 
                                    y = math.ceil(pos / Game.field:getSize().w)})
        end
    end

    for id, unit in pairs(Game.units) do
        print(id, Game.field:getUnitPos(id).x, Game.field:getUnitPos(id).y)
    end
end



function parseCommand(s)
    local args = {} 

    for arg in string.gmatch(s, "%g+") do 
         table.insert(args, arg)
         print (arg)
    end

    if #args == 0 then return end 

    if args[1] == "help" then
        print("Are you think that you in fairy tail?")

    elseif args[1] == "info" then
        if #args < 2 then 
            print("You must specify the unit, which data interests you")
            return
        end
        for k, v in pairs(Game.units[args[2]]) do
            print(k, v)
        end
        print("pos: ", Game.field:getUnitPos(args[2]).x, 
                       Game.field:getUnitPos(args[2]).y)

    elseif args[1] == "exit" then
        os.exit()

    else
        print("Invalid command "..args[1])
        return
    end
end



function proccessTurn(turn)
    command = io.read()
    parseCommand(command)
end



function Game.run()
    while true do
        proccessTurn()
    end
end



Game.init(players)
Game.run()