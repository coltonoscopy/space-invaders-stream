--[[
    Projectile Class
]]

Projectile = Class{}

function Projectile:init(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
end

function Projectile:update(dt)
    if self.direction == 'up' then
        self.y = self.y - PROJECTILE_SPEED * dt
    else
        self.y = self.y + PROJECTILE_SPEED * dt
    end
end

function Projectile:render()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', self.x, self.y, 1, PROJECTILE_LENGTH)
    love.graphics.setColor(1, 1, 1, 1)
end