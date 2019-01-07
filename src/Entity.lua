--[[
    Entity Base Class

    Anything that moves and has a sprite.
]]

Entity = Class{}

function Entity:init(x, y, sprite)
    self.x = x
    self.y = y
    self.width = ALIEN_SIZE
    self.height = ALIEN_SIZE
    self.sprite = sprite
    self.invisible = false
    self.canFire = false
end

function Entity:render()
    if not self.invisible then
        love.graphics.draw(gTextures['aliens'], gFrames['aliens'][self.sprite],
            self.x, self.y)
    end
end