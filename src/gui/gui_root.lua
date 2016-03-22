local GUI_Root = {}
local Class = require("class")
local GUI = require("gui.gui")



function GUI_Root.new()
    local self = {}

    self.widgets = {}

    return self
end



function GUI_Root:update(deltaTime)
    for k, v in pairs(self.widgets) do
        self.widgets[k]:update(deltaTime)
    end
end



function GUI_Root:addWidget(id, widget)
    if self.widgets[id] == nil then
        self.widgets[id] = widget
    else
        error("Widget with "..id.." id already exist")
    end
end



function GUI_Root:getWidget(id)
    return self.widgets[id]
end



function GUI_Root:show()
    for k, v in pairs(self.widgets) do
        self.widgets[k]:show()
    end
end



function GUI_Root:hide()
    for k, v in pairs(self.widgets) do
        self.widgets[k]:hide()
    end
end

Class.register(GUI_Root)

return GUI_Root