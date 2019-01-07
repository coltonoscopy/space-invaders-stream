--[[
    Dependencies
]]

Class = require 'lib/class'
push = require 'lib/push'

require 'src/Entity'

require 'src/Alien'
require 'src/constants'
require 'src/Projectile'
require 'src/Ship'
require 'src/StateMachine'
require 'src/Util'

require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/TitleState'
require 'src/states/GameOverState'

love.graphics.setDefaultFilter('nearest', 'nearest')

gTextures = {
    ['aliens'] = love.graphics.newImage('graphics/aliens12.png')
}

gFrames = {
    ['aliens'] = GenerateQuads(gTextures['aliens'], ALIEN_SIZE, ALIEN_SIZE)
}

gSounds = {
    ['laser'] = love.audio.newSource('sounds/laser.wav', 'static'),
    ['alien-laser'] = love.audio.newSource('sounds/alien_laser.wav', 'static'),
    ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
    ['death'] = love.audio.newSource('sounds/death.wav', 'static')
}