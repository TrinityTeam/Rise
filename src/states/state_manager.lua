local StateManager = {}
local Class = require("class")

local states = {}
local requests = {}
local REQUEST = {PUSH = 1, POP = 2, CLEAR = 3}
local registered_states = {}



function StateManager:registerState(id, state)
	registered_states[id] = state
end



function StateManager:haveStates()
	return #states > 0
end



function StateManager:requestPush(new_state_id, ...)
	assert(registered_states[new_state_id], new_state_id.." state unregistered!")
	table.insert(requests, {action = REQUEST.PUSH, state = registered_states[new_state_id], args = ...})
end



function StateManager:requestPop()
	table.insert(requests, {action = REQUEST.POP})
end



function StateManager:requestClear()
	table.insert(requests {action = REQUEST.CLEAR})
end



function StateManager:update(deltaTime)
	self:processRequests()
	for k, v in pairs(states) do
		v:update(deltaTime)
	end
end



function StateManager:mouseClickEvent(pressed)
	for k, v in pairs(states) do
		if v.mouseClickEvent ~= nil then
			v:mouseClickEvent(pressed)
		end
	end
end



function StateManager:processRequests()
	for k, v in pairs(requests) do
		if v.action == REQUEST.PUSH then
			v.state:init(v.args)
			v.state:show()
			table.insert(states, v.state)

		elseif v.action == REQUEST.POP then
			states[#states]:hide()
			table.remove(states)

		elseif v.action == REQUEST.CLEAR then
			states = {}
		end
		table.remove(requests, k)
	end
end


Class.registerSingleton(StateManager)

return StateManager
