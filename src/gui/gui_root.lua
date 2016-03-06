local GUI_Root = {}
local GUI = require("gui.gui")



function GUI_Root.new()
    local self = {}

    self.widgets = {}

    setmetatable(self, {__index = GUI_Root})
    return self
end



function GUI_Root:update(deltaTime)
    for k, v in pairs(self.widgets) do
        if self.widgets[k].update then
            self.widgets[k]:update(deltaTime)
        end
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



setmetatable(GUI_Root, {__call = function (self, ...)
                                     return GUI_Root.new(...)
                                 end})


return GUI_Root