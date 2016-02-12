local ResourceDefinitions = {}

local definitions = {}

ResourceDefinitions.Type = {
	Image = 0, Sound = 1, Font = 2
}


function ResourceDefinitions.set(name, definition)
	definitions[name] = definition
end




function ResourceDefinitions.get(name)
	return definitions[name]
end



function ResourceDefinitions.remove(name)
	definitions[name] = nil
end



return ResourceDefinitions