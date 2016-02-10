Province = {}

function Province:new(name, pop, fractions, unrest, force, infrastructure, controller)
    local obj= {}
    obj.name = name
    obj.pop = pop
    obj.fractions = fractions
    obj.unrest = unrest
    obj.force = force
    obj.infrastructure = infrastructure
    obj.controller = controller

    setmetatable(obj, self)
    self.__index = self;
    return obj
end