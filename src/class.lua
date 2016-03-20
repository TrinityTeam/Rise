local Class = {}



function Class.register(prototype)
    if prototype == nil then
        error("Prototype can't be nil")
    end
    if prototype.new == nil then
        error("You must specify class constructor(member function 'new(...)'")
    end
    
    local metatable = {}
    metatable.__metatable = "Private metatable"
    metatable.__call = function(self, ...) 
                            local instance = self.new(...)
                            setmetatable(instance, {__index = prototype, 
                                                    __metatable = "Private metatable"})
                            return instance
                        end
    metatable.__index = function(t, k) error("Nil field "..k.." requested") end
    metatable.__newindex = function() error("Nil field requested") end
    setmetatable(prototype, metatable)

    return prototype
end



return Class