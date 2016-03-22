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
            unit.id = id
            Game.units[id] = unit
            Game.field:addUnit(unit, {x = pos % Game.field:getSize().w, 
                                      y = math.ceil(pos / Game.field:getSize().w)})
        end
    end

    for id, unit in pairs(Game.units) do
        io.write(id, unit:getPosition().x, unit:getPosition().y)
    end
end



local function io.writeRecursive(...)
    for k, v in pairs(...) do
        io.write(k, v)
        if type(v) == "table" then
            io.writeRecursive(v)
        end
    end
end



function parseCommand(s)
    local args = {} 

    for arg in string.gmatch(s, "%g+") do 
         table.insert(args, arg)
         io.write (arg)
    end

    if #args == 0 then return end 

    if args[1] == "help" then
        io.write("Do you think you're in fairy tail?")

    elseif args[1] == "info" then
        if #args < 2 then 
            io.write("You must specify the unit, which data interests you")
            return
        end
        io.writeRecursive(Game.units[args[2]])

    elseif args[1] == "attack" then
        if #args < 2 then 
            error("You must specify the attacking unit")
        end

    elseif args[1] == "exit" then
        os.exit()

    else
        io.write("Invalid command "..args[1])
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
