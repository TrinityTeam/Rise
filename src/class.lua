local Class = {}



function Class.register(prototype)
    if prototype == nil then
        error("Prototype can't be nil")
    end
    if prototype.new == nil then
        prototype.new = function() local self = {}; return self; end
    end
    
    local metatable = {}
    metatable.__metatable = "Private metatable"
    metatable.__call = function(self, ...) 
                            local instance = self.new(...)
                            setmetatable(instance, {__index = prototype, 
                                                    __metatable = "Private metatable"})
                            return instance
                        end
    metatable.__index = function(t, k) error("Nil field "..k.." in table requested") end
    metatable.__newindex = function(t, k) error("Nil field "..k.." in table requested") end
    setmetatable(prototype, metatable)

    return prototype
end


function Class.registerSingleton(class)
    if class == nil then
        error("Prototype can't be nil")
    end

    local metatable = {}
    metatable.__metatable = "Private metatable"
    metatable.__index = function(t, k) error("Nil field "..k.." in singletone requested") end
    setmetatable(class, metatable)

    return class
end



return Class