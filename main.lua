--[[
    Space Invaders

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

require 'src/Dependencies'

local projectiles = {}
local aliens = {}
local ship

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Space Invaders')

    gFont = love.graphics.newFont('fonts/pressstart.ttf', 8)
    love.graphics.setFont(gFont)

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    local shipIndexAsli = 16 * 3 + 6
    local shipIndexBhavik = 16 * 12 + 9

    local shipIndex = math.random(2) == 1 and shipIndexAsli or shipIndexBhavik

    ship = Ship(VIRTUAL_WIDTH / 2 - ALIEN_SIZE / 2,
        VIRTUAL_HEIGHT - 64, shipIndex)

    -- generate rows and columns of aliens
    for y = 1, ALIENS_TALL do
        for x = 1, ALIENS_WIDE do
            table.insert(aliens, Alien(x * ALIEN_SIZE, y * ALIEN_SIZE,
                math.random(256)))
        end
    end

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    ship:update(dt, projectiles)

    for _, projectile in pairs(projectiles) do
        projectile:update(dt)
    end

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

    love.graphics.clear((20 / 255), (10 / 255), (30 / 255), 1)

    for _, projectile in pairs(projectiles) do
        projectile:render()
    end

    -- draw all aliens
    for _, alien in pairs(aliens) do
        alien:render()
    end

    ship:render()
    push:finish()
end