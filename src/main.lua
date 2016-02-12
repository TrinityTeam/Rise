GUI = require("gui.gui")

GUI.openWindow("Rise", 800, 600)

Game = require("game")

function mainLoop()
	Game.run()
end

gameThread = MOAICoroutine.new()
gameThread:run(mainLoop)
