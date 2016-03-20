setmetatable(_G, {__newindex = function(t, k) error("Undeclared variable "..k) end})
setmetatable(_G, {__index = function(t, k) error("Undeclared variable "..k) end})

MOAISim.setStep(0.03)
local GUI = require("gui.gui")

GUI.openWindow("Rise", 800, 600)

local Game = require("game")

local gameThread = MOAICoroutine.new()
gameThread:run(Game.run)
