local ResourceManager = {}

local ResourceDefinitions = require("resource_control.resource_definitions")
local cache = {}



function ResourceManager:get(name)
	if not self:isLoaded(name) then
		self:load(name)
	end

	return cache[name]
end




function ResourceManager:load(name)
	local definition = ResourceDefinitions.get(name)
	if definition == nil then
		error("Resource definition for "..name.." not found")
		return
	end

	print("Load "..name.." from "..definition.fileName.." resource type "..definition.type)

	local resource
	if definition.type == ResourceDefinitions.Type.Image then
		local ImageLoader = require("resource_control.image_loader")
		resource = ImageLoader.load(definition)

	elseif definition.type == RESOURCE_TYPE_TILED_IMAGE then
		resource = self:loadTiledImage(definition)
	
	elseif definition.type == ResourceDefinitions.Type.Font then
		local FontLoader = require("resource_control.font_loader")
		resource = FontLoader.load(definition)

	elseif definition.type == ResourceDefinitions.Type.Sound then
		local SoundLoader = require("resource_control.sound_loader")
		resource = SoundLoader.load(definition)
	end
	cache[name] = resource
end



function ResourceManager:isLoaded(name)
	return cache[name] ~= nil
end



return ResourceManager