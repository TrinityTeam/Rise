MOAISim.openWindow('Test', 480, 320)

viewport = MOAIViewport.new()
viewport:setSize(480, 320)
viewport:setScale(480, 320)

layer = MOAILayer2D.new()
layer:setViewport(viewport)

image = MOAIGfxQuad2D.new()
image:setTexture('../data/geass.jpg')
image:setRect(-100, -50, 100, 50)

prop = MOAIProp2D.new()
prop:setDeck(image)
prop:setLoc(0, 0)

layer:insertProp(prop)

font = MOAIFont.new()
font:loadFromTTF('../data/allods_west.ttf')

text = MOAITextLabel.new()
text:setLoc(0, -50)
text:setString("Coming soon...")
text:setFont(font)
text:setTextSize(32)
text:setYFlip(true)
text:setAlignment(MOAITextBox.CENTER_JUSTIFY, MOAITextBox.BASELINE_JUSTIFY)
layer:insertProp(text)

renderTable = { layer }
MOAIRenderMgr.setRenderTable(renderTable)

