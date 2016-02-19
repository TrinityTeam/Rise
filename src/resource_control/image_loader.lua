local ImageLoader = {}

ImageLoader.TEXTURES_PATH = "../data/textures/"



function ImageLoader.load(definition)
	local image
	local filePath = ImageLoader.TEXTURES_PATH..definition.fileName
	
	if definition.coords ~= nil then
		image = self:loadGfxQuad2D(filePath, definition.coords)

	else
		local halfWidth = definition.width / 2
		local halfHeight = definition.height / 2
		image = ImageLoader.loadGfxQuad2D(filePath, {-halfWidth, -halfHeight, 
													  halfWidth,  halfHeight})
	end
	return image	
end



function  ImageLoader.loadGfxQuad2D(filePath, rect)
	local image = MOAIGfxQuad2D.new()
	image:setTexture(filePath)
	image:setRect(unpack(rect))
	return image
end



return ImageLoader
