local Class = require("class")
local Widget = {}

function Widget.new(show, hide, update, setLoc)
    local self = {}
    
    self.show = show or error("You must specify show() method")
    self.hide = hide or error("You must specify hide() method")
    self.update = update or error("You must specify update() method")
    self.setLoc = setLoc or error("You must specify setLoc() method")
    
    return self
end

Class.register(Widget)

return Widget