local BattleField = {}



function BattleField.new(size)
    assert(size and size.w and size.h, "You must specify size(table {w = Width, h = Height}")
    local self = {}

    self.size = {w = size.w, h = size.h}
    self.unitsByPos = {}
    for c = 0, size.h do
        self.unitsByPos[c] = {}
    end
    self.unitsByName = {}

    setmetatable(self, {__index = BattleField})
    return self
end



local function isPosInBounds(pos, size)
    if pos.x >= 0 and pos.y >= 0 and pos.x < size.w and pos.y < size.h then
        return true
    else
        return false
    end
end



function BattleField:addUnit(id, pos)
    assert(isPosInBounds(pos, self.size), "Position "..pos.x..":"..pos.y.." are out of field bounds")
    assert(self.unitsByPos[pos.x][pos.y] == nil, "Position "..pos.x..":"..pos.y.." are occupied")
    assert(self.unitsByName[id] == nil, "Unit "..id.." already exist")
    self.unitsByPos[pos.x][pos.y] = id
    self.unitsByName[id] = { x = pos.x, y = pos.y}
end



function BattleField:getUnitId(pos)
    assert(isPosInBounds(pos, self.size))
    return self.unitsByPos[pos.x][pos.y]
end



function BattleField:getUnitPos(id)
    return self.unitsByName[id]
end



function BattleField:moveUnit(id, destination)
    assert(isPosInBounds(destination, self.size))
    assert(self.unitsByPos[destination.x][destination.y] == nil, 
           "Position "..destination.x..":"..destination.y.." are occupied")
    local unitPos = self.unitsByName[id]
    self.unitsByPos[destination.x][destination.y] = id
    self.unitsByPos[unitPos.x][unitPos.y] = nil
    unitPos = {x = destination.x, y = destination.y}
end



function BattleField:getSize()
    return self.size
end



setmetatable(BattleField, {__call = function (self, ...)
                                        return BattleField.new(...)
                                    end})
return BattleField