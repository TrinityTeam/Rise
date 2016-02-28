MOAISim.setStep(0.03)
GUI = require("gui.gui")

GUI.openWindow("Rise", 800, 600)

Game = require("game")

gameThread = MOAICoroutine.new()
gameThread:run(Game.run)
