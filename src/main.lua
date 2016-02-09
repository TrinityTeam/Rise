MOAISim.openWindow('Test', 800, 600)

viewport = MOAIViewport.new()
viewport:setSize(800, 600)
viewport:setScale(800, 600)

layer = MOAILayer2D.new()
layer:setViewport(viewport)

texture = MOAITexture.new()
texture:load('../data/geass.jpg')
w, h = texture:getSize()
k = w / h
image = MOAIGfxQuad2D.new()
image:setTexture(texture)
image:setRect(-120*k, -120, 120*k, 120)

prop = MOAIProp2D.new()
prop:setDeck(image)
prop:setLoc(0, 0)

layer:insertProp(prop)

headerFont = MOAIFont.new()
headerFont:loadFromTTF('../data/supernatural_knight.ttf')

headerStyle = MOAITextStyle.new()
headerStyle:setColor(1, 0, 0)
headerStyle:setFont(headerFont)

header = MOAITextLabel.new()
header:setStyle(headerStyle)
header:setTextSize(64)
header:setLoc(0, 150)
header:setString("RISE")
header:setYFlip(true)
header:setAlignment(MOAITextBox.CENTER_JUSTIFY, MOAITextBox.BASELINE_JUSTIFY)
layer:insertProp(header)

font = MOAIFont.new()
font:loadFromTTF('../data/allods_west.ttf')

style = MOAITextStyle.new()
style:setColor(0.4, 0, 0.9)
style:setFont(font)

text = MOAITextLabel.new()
text:setLoc(0, -280)
text:setString("Coming soon...")
text:setStyle(style)
text:setTextSize(24)
text:setYFlip(true)
text:setAlignment(MOAITextBox.CENTER_JUSTIFY, MOAITextBox.BASELINE_JUSTIFY)
layer:insertProp(text)

renderTable = { layer }
MOAIRenderMgr.setRenderTable(renderTable)

MOAIUntzSystem.initialize()

sound = MOAIUntzSound.new()
sound:load('../data/Rise.wav')
sound:setVolume(1)
sound:setLooping(true)
sound:play()
