local Game = {}

local ResourceManager = require("resource_control.resource_manager")
local ResourceDefinitions = require("resource_control.resource_definitions")
local StateManager = require("states.state_manager")



function Game.run()
	Game.init()
	while not Game.isOver do
		coroutine.yield()
	end
	os.exit()
end



function Game.init()
	local GUI = require("gui.gui")
	local Label = require("gui.label")
	local Button = require("gui.button")
	---[[
	MOAIDebugLines.setStyle ( MOAIDebugLines.PARTITION_CELLS, 2, 1, 1, 1 )
	MOAIDebugLines.setStyle ( MOAIDebugLines.PARTITION_PADDED_CELLS, 1, 0.5, 0.5, 0.5 )
	MOAIDebugLines.setStyle ( MOAIDebugLines.PROP_WORLD_BOUNDS, 2, 0.75, 0.75, 0.75 )
	MOAIDebugLines.setStyle ( MOAIDebugLines.PROP_MODEL_BOUNDS, 2, 1, 1, 1 )
	GUI.getLayer():showDebugLines(true)
	--]]
	ResourceDefinitions.set("geass", {	type = ResourceDefinitions.Type.Image,
										fileName = "geass.png",
										width = 1540/4,
										height = 830/4
								 	 })
	ResourceDefinitions.set("antigeass", {	
									type = ResourceDefinitions.Type.Image,
									fileName = "antigeass.png",
									width = 1566/4,
									height = 844/4
							 	 })
	ResourceDefinitions.set("kurono_kishidan", {	
									type = ResourceDefinitions.Type.Image,
									fileName = "kurono_kishidan.png",
									width = 922/3,
									height = 768/3
							 	 })
	ResourceDefinitions.set("soundtrack", {	type = ResourceDefinitions.Type.Sound,
											fileName = "Rise.wav",
											isLooping = true,
											volume = 1
								 	      })
	ResourceDefinitions.set("header font", {type = ResourceDefinitions.Type.Font,
											fileName = "supernatural_knight.ttf",
											glyphs = "qwertyuiopasdfghjklzxcvbnm!@#$%^&*()_+:\"{}<>?,./';[]0123456789",
											fontSize = 26,
											dpi = 160
								 	       })
	ResourceDefinitions.set("main font", {type = ResourceDefinitions.Type.Font,
										  fileName = "allods_west.ttf",
										  glyphs = "qwertyuiopasdfghjklzxcvbnm!@#$%^&*()_+:\"{}<>?,./';[]0123456789",
										  fontSize = 26,
										  dpi = 160
								 	     })
	MOAIUntzSystem.initialize()
	Game.soundtrack = ResourceManager:get("soundtrack")

	local headerStyle = MOAITextStyle.new()
	headerStyle:setColor(1, 0, 0)
	headerStyle:setFont(ResourceManager:get("header font"))
	headerStyle:setSize(52)

	Game.header = Label(headerStyle)
	Game.header:setText("RISE")
	Game.header:setLoc(0, 150)
	Game.header:show()

	local geass = MOAIProp2D.new()
	geass:setDeck(ResourceManager:get("geass"))
	local antigeass = MOAIProp2D.new()
	antigeass:setDeck(ResourceManager:get("antigeass"))
	local kurono_kishidan = MOAIProp2D.new()
	kurono_kishidan:setDeck(ResourceManager:get("kurono_kishidan"))

	Game.button = Button(headerStyle)
	Game.button:setTexture(Button.State.Normal, geass)
	Game.button:setTexture(Button.State.Hovered, antigeass)
	Game.button:setTexture(Button.State.Pressed, kurono_kishidan)
	Game.button:setCallback(function() Game.playOrStopMusic() end)
	Game.button:setLoc(0, 0)
	Game.button:show()

	local style = MOAITextStyle.new()
	style:setColor(0.4, 0, 0.9)
	style:setFont(ResourceManager:get("main font"))
	style:setSize(24)
	
	Game.text = Label(style)
	Game.text:setText("Coming soon...")
	Game.text:setLoc(0, -280)
	Game.text:show()
	
	Game.isOver = false

	MOAIInputMgr.device.keyboard:setCallback(Game.processKeyboard)
	io.flush()
end



function Game.playOrStopMusic()
	if Game.soundtrack:isPlaying() then
		Game.soundtrack:pause()
	else
		Game.soundtrack:play()
	end
end



function Game.processKeyboard(key, down)
	if down then
		if key == 283 then
			Game.isOver = true
		end
	end
end


return Game