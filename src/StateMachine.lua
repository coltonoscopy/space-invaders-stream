--[[
    StateMachine Class
]]

StateMachine = Class{}

function StateMachine:init(states)
    self.states = states
end

function StateMachine:change(state, params)
    if self.currentState then self.currentState:exit() end
    self.currentState = self.states[state]()
    self.currentState:enter(params)
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end