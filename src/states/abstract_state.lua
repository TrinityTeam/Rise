local Class = require("class")
local State = {}

function State.new(init, show, hide, update, mousePressEvent)
    local self = {}

    self.init = init or error("You must specify init() method")
    self.show = show or error("You must specify show() method")
    self.hide = hide or error("You must specify hide() method")
    self.update = update or error("You must specify update() method")
    self.mousePressEvent = mousePressEvent or error("You must specify mousePressEvent() method")

    return self
end

Class.register(State)

return State