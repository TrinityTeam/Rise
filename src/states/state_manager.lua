local StateManager = {}

local states = {}
local requests = {}
local REQUEST = {PUSH, POP, CLEAR}



function StateManager:requestPush(state)
	table.insert(self.requests, {action = REQUEST.PUSH, state = state})
end



function StateManager:requestPop()
	table.insert(self.requests, {action = REQUEST.POP})
end



function StateManager:requestClear()
	table.insert(self.requests {action = REQUEST.CLEAR})
end



function StateManager:update(deltaTime)
	self:processRequests()
	for k, v in ipairs(self.states) do
		v:update(deltaTime)
	end
end



function StateManager:processRequests()
	for k, v in pairs(self.requests) do
		if v.action == REQUEST.PUSH then
			table.insert(self.states, v.state)
		elseif v.action == REQUEST.POP then
			table.remove(self.states)
		elseif v.action == REQUEST.CLEAR then
			self.states = {}
		end
	end
end


return StateManager