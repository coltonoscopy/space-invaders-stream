--[[
    Ship Player Class
]]

Ship = Class{__includes = Entity}

function Ship:update(dt, projectiles)
    if love.keyboard.isDown('left') then
        self.x = math.max(0, self.x - SHIP_SPEED * dt)
    elseif love.keyboard.isDown('right') then
        self.x = math.min(VIRTUAL_WIDTH - ALIEN_SIZE, self.x + SHIP_SPEED * dt)
    end

    if love.keyboard.wasPressed('space') then
        table.insert(projectiles, Projectile(self.x, self.y - PROJECTILE_LENGTH, 'up'))
        gSounds['laser']:stop()
        gSounds['laser']:play()
    end
end