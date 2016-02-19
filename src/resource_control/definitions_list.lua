local DefinitionList = {}
local ResourceDefinitions = require("resource_control.resource_definitions")



function DefinitionList.init()
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
end



return DefinitionList