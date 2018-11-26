--[[
    Utility functions
]]

function GenerateQuads(texture, width, height)
    local quads = {}
    local textureWidth, textureHeight = texture:getWidth(), texture:getHeight()
    local spritesWide, spritesTall = textureWidth / width, textureHeight / height

    for y = 0, spritesTall - 1 do
        for x = 0, spritesWide - 1 do
            table.insert(quads, love.graphics.newQuad(x * width, y * height, width, height, 
                texture:getDimensions()))
        end
    end

    return quads
end