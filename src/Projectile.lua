--[[
    Projectile Class
]]

Projectile = Class{}

function Projectile:init(x, y, direction)
    self.x = x
    self.y = y
    self.width = PROJECTILE_WIDTH
    self.height = PROJECTILE_LENGTH
    self.direction = direction
end

function Projectile:collides(entity)
    if self.x > entity.x + entity.width or self.x + self.width < entity.x or
        self.y > entity.y + entity.height or self.y + self.height < entity.y then
            return false
    else
        return true
    end
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