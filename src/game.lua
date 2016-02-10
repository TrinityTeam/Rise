Game = {}



function Game.run()
	Game.init()

	while not Game.isOver do
		coroutine.yield()
	end

	os.exit()
end



function Game.init()
	local GUI = require("gui.gui")
	
	GUI.createSprite('../data/geass.jpg', {width=240, height=240}, {x=0, y=0})

	local headerFont = MOAIFont.new()
	headerFont:loadFromTTF('../data/supernatural_knight.ttf')
	
	local headerStyle = MOAITextStyle.new()
	headerStyle:setColor(1, 0, 0)
	headerStyle:setFont(headerFont)
	headerStyle:setSize(52)
	
	local header = GUI.createTextbox("RISE", {x=0, y=150}, headerFont, headerStyle)
	
	local font = MOAIFont.new()
	font:loadFromTTF('../data/allods_west.ttf')
	
	local style = MOAITextStyle.new()
	style:setColor(0.4, 0, 0.9)
	style:setFont(font)
	style:setSize(24)
	
	local text = GUI.createTextbox("Coming soon...", {x=0, y=-280}, font, style)
	
	MOAIUntzSystem.initialize()
	
	local sound = MOAIUntzSound.new()
	sound:load('../data/Rise.wav')
	sound:setVolume(1)
	sound:setLooping(true)
	sound:play()

	Game.isOver = false

	MOAIInputMgr.device.keyboard:setCallback(Game.processKeyboard)
end



function Game.processKeyboard(key, down)
	if down then
		Game.isOver = true
	end
end


return Game