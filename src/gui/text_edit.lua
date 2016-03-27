local TextEdit = {}
local Class = require("class")
local Label = require("gui.label")
local Rect = require("util.rect")
local GUI = require("gui.gui")



function TextEdit.new(style)
    local self = {}

    self.label = Label(style)
    self.isCursorShowed = false
    self.lastBlinkTime = 0
    self.isActive = false
    self.cursorPos = 1

    GUI.addMouseClickCallback(function(isPressed) self:mouseClickEvent(isPressed) end)
    GUI.addKeyboardCallback(function(key, isPressed) self:keyboardEvent(key, isPressed) end)

    return self
end



function TextEdit:show()
    self.label:show()
end



function TextEdit:hide()
    self.label:hide()
end



function TextEdit:setText(text)
    self.label:setText(text)
end



function TextEdit:setLoc(x, y)
    self.label:setLoc(x, y)
end



function TextEdit:setSize(width, height)
    self.label:setSize(width, height)
end



function TextEdit:blinkCursor()
    if self.isCursorShowed then
        self:hideCursor()
    else
        self:showCursor()
    end
end



function TextEdit:hideCursor()
    if self.isCursorShowed then
        self.isCursorShowed = false
        local text = self.label:getText()
        self.label:setText(text:sub(0, self.cursorPos)..text:sub(self.cursorPos+2))
    end
end



function TextEdit:showCursor()
    if not self.isCursorShowed then
        self.isCursorShowed = true
        local text = self.label:getText()
        self.label:setText(text:sub(1, self.cursorPos).."|"..
                           text:sub(self.cursorPos+1))
    end
end



function TextEdit:update()
    if self.isActive and os.time() - self.lastBlinkTime > 0.9 then
        self:blinkCursor()
        self.lastBlinkTime = os.time()
    end
end



function TextEdit:mouseClickEvent(isPressed) 
    if isPressed then
        local x, y = GUI:getLayer():wndToWorld(MOAIInputMgr.device.pointer:getLoc())
        if self.label:inside(x, y) then
            self.isActive = true
        else
            self.isActive = false
            self:hideCursor()
        end
    end
end



function TextEdit:moveCursor(offset)
    self.cursorPos = self.cursorPos+offset
    if self.cursorPos > self.label:getText():len() then
        self.cursorPos = self.cursorPos - self.label:getText():len() - 1 

    elseif self.cursorPos < 0 then
        self.cursorPos = self.label:getText():len() + self.cursorPos + 1
    end
end



function TextEdit:keyboardEvent(key, isPressed) 
    if isPressed then
        if self.isActive then
            self:hideCursor()

            if key == MOAIKeyCode.RIGHT then
                self:moveCursor(1)
            
            elseif key == MOAIKeyCode.LEFT then
                self:moveCursor(-1)

            elseif key == MOAIKeyCode.HOME then
                self.cursorPos = 0

            elseif key == MOAIKeyCode.END then
                self.cursorPos = self.label:getText():len()

            elseif key == MOAIKeyCode.BACKSPACE then
                if self.cursorPos ~= 0 then
                    local text = self.label:getText()
                    self.label:setText(text:sub(0, self.cursorPos-1)..text:sub(self.cursorPos+1))
                    self:moveCursor(-1)
                end
            else
                local text = self.label:getText()
                self.label:setText(text:sub(0, self.cursorPos)..
                                   string.char(key)..text:sub(self.cursorPos+1))
                self:moveCursor(1)
            end
            self:showCursor()
        end
    end
end



Class.register(TextEdit)

return TextEdit