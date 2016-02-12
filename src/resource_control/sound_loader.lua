local SoundLoader = {}

local SOUNDS_PATH = "../data/sounds/"



function SoundLoader.load(definition)
	local sound = MOAIUntzSound.new()
	local filePath = SOUNDS_PATH..definition.fileName
	sound:load(filePath)
	sound:setVolume(definition.volume)
	sound:setLooping(definition.isLooping)
	return sound
end



return SoundLoader