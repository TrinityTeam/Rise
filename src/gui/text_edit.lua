local TextEdit = {}
local Class = require("class")
local Label = require("gui.label")



function TextEdit.new()
    local self = {}

    self.label = Label()

    return self
end



Class.register(TextEdit)

return TextEdit