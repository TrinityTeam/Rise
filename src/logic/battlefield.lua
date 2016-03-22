local BattleField = {}
local Class = require("class")


function BattleField.new(size)
    assert(size and size.w and size.h, "You must specify size(table {w = Width, h = Height}")
    local self = {}

    self.size = {w = size.w, h = size.h}
    self.unitsByPos = {}
    for c = 0, size.h do
        self.unitsByPos[c] = {}
    end
    self.unitsByName = {}

    return self
end



local function isPosInBounds(pos, size)
    if pos.x > 0 and pos.y > 0 and pos.x <= size.w and pos.y <= size.h then
        return true
    else
        return false
    end
end



function BattleField:addUnit(unit)
    local pos = unit:getPosition()
    assert(isPosInBounds(pos, self.size), "Position "..pos.x..":"..pos.y.." are out of field bounds")
    assert(self.unitsByPos[pos.x][pos.y] == nil, "Position "..pos.x..":"..pos.y.." are occupied")
    assert(self.unitsByName[unit:getId()] == nil, "Unit "..unit:getId().." already exist")
    self.unitsByPos[pos.x][pos.y] = unit
    self.unitsByName[unit:getId()] = unit
end



function BattleField:getUnit(pos)
    assert(isPosInBounds(pos, self.size))
    return self.unitsByPos[pos.x][pos.y]
end



function BattleField:moveUnit(id, destination)
    assert(isPosInBounds(destination, self.size))
    assert(self.unitsByPos[destination.x][destination.y] == nil, 
           "Position "..destination.x..":"..destination.y.." are occupied")
    local unit = self.unitsByName[id]
    self.unitsByPos[destination.x][destination.y] = id
    self.unitsByPos[unit:getPosition().x][unit:getPosition().y] = nil
    unit:setPosition(destination)
end



function BattleField:getSize()
    return self.size
end



function BattleField:getHeight()
    return self.size.h
end



function BattleField:getWidth()
    return self.size.w
end



Class.register(BattleField)

return BattleField