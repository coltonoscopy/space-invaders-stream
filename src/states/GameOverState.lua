--[[
    GameOverState Class
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('title')
    end
end

function GameOverState:enter(params)
    self.score = params.score
end

function GameOverState:render()
    love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 8, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Your Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2 + 8, VIRTUAL_WIDTH, 'center')
end