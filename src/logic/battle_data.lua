local BattleData = {}
local Class = require("class")


function BattleData.new(battlefield, units)
    local self = {}

    self.battlefield = battlefield or error("You must specify battlefield")
    self.units = units or error("You must specify units")

    for id, unit in pairs(units) do
        battlefield:addUnit(unit)
    end

    return self
end



Class.register(BattleData)

return BattleData