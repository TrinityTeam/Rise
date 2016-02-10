GUI = require("gui.gui")

GUI.openWindow("Rise", 800, 600)

GUI.createSprite('../data/geass.jpg', {width=240, height=240}, {x=0, y=0})

headerFont = MOAIFont.new()
headerFont:loadFromTTF('../data/supernatural_knight.ttf')

headerStyle = MOAITextStyle.new()
headerStyle:setColor(1, 0, 0)
headerStyle:setFont(headerFont)
headerStyle:setSize(52)

header = GUI.createTextbox("RISE", {x=0, y=150}, headerFont, headerStyle)

font = MOAIFont.new()
font:loadFromTTF('../data/allods_west.ttf')

style = MOAITextStyle.new()
style:setColor(0.4, 0, 0.9)
style:setFont(font)
style:setSize(24)

text = GUI.createTextbox("Coming soon...", {x=0, y=-280}, font, style)

MOAIUntzSystem.initialize()

sound = MOAIUntzSound.new()
sound:load('../data/Rise.wav')
sound:setVolume(1)
sound:setLooping(true)
sound:play()
