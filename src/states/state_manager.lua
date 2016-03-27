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



function StateManager:update(deltaTime)
	self:processRequests()
	for k, _ in pairs(states) do
		states[k]:update(deltaTime)
	end
end



function StateManager:processRequests()
	for k, request in pairs(requests) do
		if request.action == REQUEST.PUSH then
			request.state:init(request.args)
			request.state:show()
			table.insert(states, request.state)

		elseif request.action == REQUEST.POP then
			states[#states]:hide()
			table.remove(states)

		elseif request.action == REQUEST.CLEAR then
			for k, _ in pairs(states) do
				states[k]:hide()
			end
			states = {}
		end
		table.remove(requests, k)
	end
end



function StateManager:requestPush(new_state_id, args)
	assert(registered_states[new_state_id], new_state_id.." state unregistered!")
	table.insert(requests, {action = REQUEST.PUSH, 
							state = registered_states[new_state_id], 
							args = args})
end



function StateManager:requestPop()
	table.insert(requests, {action = REQUEST.POP})
end



function StateManager:requestClear()
	table.insert(requests {action = REQUEST.CLEAR})
end



Class.registerSingleton(StateManager)

return StateManager
