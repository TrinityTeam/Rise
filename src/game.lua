Game = {}

local ResourceManager = require("resource_control.resource_manager")
local ResourceDefinitions = require("resource_control.resource_definitions")



function Game.run()
	Game.init()

	while not Game.isOver do
		coroutine.yield()
	end

	os.exit()
end



function Game.init()
	local GUI = require("gui.gui")
	
	ResourceDefinitions.set("geass", {	type = ResourceDefinitions.Type.Image,
										fileName = "geass.jpg",
										width = 1000/2,
										height = 625/2
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
	GUI.createSprite('geass', {width=240, height=240}, {x=0, y=0})

	local headerStyle = MOAITextStyle.new()
	headerStyle:setColor(1, 0, 0)
	headerStyle:setFont(ResourceManager:get("header font"))
	headerStyle:setSize(52)
	
	GUI.createTextbox("RISE", {x=0, y=150}, headerStyle)
	
	local style = MOAITextStyle.new()
	style:setColor(0.4, 0, 0.9)
	style:setFont(ResourceManager:get("main font"))
	style:setSize(24)
	
	GUI.createTextbox("Coming soon...", {x=0, y=-280}, style)
	
	MOAIUntzSystem.initialize()
	
	Game.soundtrack = ResourceManager:get("soundtrack")
	Game.soundtrack:play()

	Game.isOver = false

	MOAIInputMgr.device.keyboard:setCallback(Game.processKeyboard)
end



function Game.processKeyboard(key, down)
	if down then
		if key == 283 then
			Game.isOver = true
		end
	end
end


return Game