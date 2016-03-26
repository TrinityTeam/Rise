local Unit = {}
local Class = require("class")


function Unit.new(hp, speed, attack)
    local self = {}

    self.hp = hp or error("You must specify hp")
    self.speed = speed or error("You must specify speed")
    self.attack = attack or error("You must specify attack")

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



function Unit:getId()
    return self.id or error("ID unspecified")
end



function Unit:setPosition(pos)
    self.pos = {x = pos.x or error("X is nil"), 
                y = pos.y or error("Y is nil")}
end



function Unit:getPosition()
    return self.pos
end



Class.register(Unit)

return Unit
