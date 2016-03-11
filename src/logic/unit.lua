local Unit = {}



function Unit.new(hp, speed, attack)
    local self = {}

    self.hp = hp or error("You must specify hp")
    self.speed = speed or error("You must specify speed")
    self.attack = attack or error("You must specify attack")

    setmetatable(self, {__index = Unit})
    return self    
end



function Unit:attackedBy(attacker)
    self.hp = self.hp - attacker:getAttack()
end



function Unit:isDestroyed()
    return self.hp > 0
end



function Unit:getAttack()
    return self.attack
end



function Unit:getSpeed()
    return self.speed
end



setmetatable(Unit, {__call = function (self, ...)
                                 return Unit.new(...)
                             end})

return Unit
