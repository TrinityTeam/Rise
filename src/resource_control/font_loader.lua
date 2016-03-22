local FontLoader = {}

local FONTS_PATH = "../data/fonts/"



function FontLoader.load(definition)
	io.write("Load ", FONTS_PATH, " ", definition.fileName, "\n")
	local font = MOAIFont.new()
	local filePath = FONTS_PATH..definition.fileName
	font:loadFromTTF(filePath--[[, definition.glyphs, 
					 definition.fontSize, definition.dpi--]])
	return font
end



return FontLoader