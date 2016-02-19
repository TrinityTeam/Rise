local StateManager = {}

local states = {}
local requests = {}
local REQUEST = {PUSH, POP, CLEAR}



function StateManager:haveStates()
	return #states > 0
end



function StateManager:requestPush(new_state)
	table.insert(requests, {action = REQUEST.PUSH, state = new_state})
end



function StateManager:requestPop()
	table.insert(requests, {action = REQUEST.POP})
end



function StateManager:requestClear()
	table.insert(requests {action = REQUEST.CLEAR})
end



function StateManager:update(deltaTime)
	self:processRequests()
	--[[for k, v in ipairs(states) do
		v:update(deltaTime)
	end
	--]]
end



function StateManager:processRequests()
	for k, v in pairs(requests) do
		if v.action == REQUEST.PUSH then
			v.state:init()
			v.state:show()
			table.insert(states, v.state)
		elseif v.action == REQUEST.POP then
			v.state:hide()
			table.remove(states)
		elseif v.action == REQUEST.CLEAR then
			states = {}
		end
		table.remove(requests, k)
	end
end


return StateManager