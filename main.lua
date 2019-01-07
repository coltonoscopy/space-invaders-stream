--[[
    Space Invaders

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Space Invaders')

    gFont = love.graphics.newFont('fonts/pressstart.ttf', 8)
    love.graphics.setFont(gFont)

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:start()

    gStateMachine:render()
    
    push:finish()
end