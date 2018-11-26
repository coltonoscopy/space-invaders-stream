--[[
    Entity Base Class

    Anything that moves and has a sprite.
]]

Entity = Class{}

function Entity:init(x, y, sprite)
    self.x = x
    self.y = y
    self.sprite = sprite
end

function Entity:render()
    love.graphics.draw(gTextures['aliens'], gFrames['aliens'][self.sprite],
        self.x, self.y)
end