Province = {}

function Province:new(name, pop, fractions, unrest, force, infrastructure)
    local obj= {}
    obj.name = name
    obj.pop = pop
    obj.fractions = fractions
    obj.unrest = unrest
    obj.force = force
    obj.infrastructure = infrastructure

    --чистая магия!
    setmetatable(obj, self)
    self.__index = self;
    return obj
end