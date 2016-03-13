local BattleData = {}



function BattleData.new(battlefield, units)
    local self = {}

    self.battlefield = battlefield or error("You must specify battlefield")
    self.units = units or error("You must specify units")

    for id, unit in pairs(units) do
        battlefield:addUnit(unit)
    end

    setmetatable(self, {__index = BattleData})
    return self
end



setmetatable(BattleData, {__call = function(self, ...) return self.new(...) end})

return BattleData