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

font = MOAIFont.new()
font:loadFromTTF('../data/allods_west.ttf')

text = MOAITextLabel.new()
text:setLoc(0, -100)
text:setString("Coming soon...")
text:setFont(font)
text:setTextSize(32)
text:setYFlip(true)
text:setAlignment(MOAITextBox.CENTER_JUSTIFY, MOAITextBox.BASELINE_JUSTIFY)
layer:insertProp(text)

renderTable = { layer }
MOAIRenderMgr.setRenderTable(renderTable)

