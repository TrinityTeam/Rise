GUI = {}


local viewport
local layer



function GUI.openWindow(title, width, height)
	MOAISim.openWindow(title, width, height)
	viewport = MOAIViewport.new()
	viewport:setSize(width, height)
	viewport:setScale(width, height)
	layer = MOAILayer2D.new()
	layer:setViewport(viewport)

	renderTable = { GUI.getLayer() }
	MOAIRenderMgr.setRenderTable(renderTable)
end



local function checkWindowOpened()
	if layer == nil then 
		print "Error: You should open window before accessing layer"
		return false
	end
	return true
end



function GUI.getLayer()
	if checkWindowOpened() then
		return layer
	end
end



function GUI.createTextbox(text, loc, font, style)
	local textbox = MOAITextLabel.new()
	textbox:setStyle(style)
	textbox:setLoc(loc.x, loc.y)
	textbox:setString(text)
	textbox:setYFlip(true)
	textbox:setAlignment(MOAITextBox.CENTER_JUSTIFY, MOAITextBox.BASELINE_JUSTIFY)
	GUI.getLayer():insertProp(textbox)
	return textbox
end



function GUI.createSprite(filepath, size, loc)
	local texture = MOAITexture.new()
	texture:load(filepath)
	local w, h = texture:getSize()
	local k = w / h
	
	local image = MOAIGfxQuad2D.new()
	image:setTexture(texture)
	image:setRect(-size.width/2*k, -size.height/2, size.width/2*k, size.height/2)
	
	local prop = MOAIProp2D.new()
	prop:setDeck(image)
	prop:setLoc(loc.x, loc.y)
	
	GUI.getLayer():insertProp(prop)
end



return GUI