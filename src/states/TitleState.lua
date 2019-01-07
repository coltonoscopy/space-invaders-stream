--[[
    TitleState Class
]]

TitleState = Class{__includes = BaseState}

function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleState:render()
    love.graphics.printf('Space Invaders', 0, VIRTUAL_HEIGHT / 2 - 8, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to Play', 0, VIRTUAL_HEIGHT / 2 + 8, VIRTUAL_WIDTH, 'center')
end