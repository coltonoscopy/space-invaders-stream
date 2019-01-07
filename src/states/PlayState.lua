--[[
    PlayState Class
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.projectiles = {}
    self.aliens = {}
    self.alienDirection = 'right'
    self.alienMovementTimer = 0

    self.score = 0
    
    local shipIndexAsli = 16 * 3 + 6
    local shipIndexBhavik = 16 * 12 + 9

    local shipIndex = math.random(2) == 1 and shipIndexAsli or shipIndexBhavik

    self.ship = Ship(VIRTUAL_WIDTH / 2 - ALIEN_SIZE / 2,
        VIRTUAL_HEIGHT - 64, shipIndex)
    self.ship.canFire = true

    -- generate rows and columns of aliens
    for y = 1, ALIENS_TALL do
        for x = 1, ALIENS_WIDE do
            local alien = Alien(x * ALIEN_SIZE, y * ALIEN_SIZE, math.random(256))
            
            if y == ALIENS_TALL then
                alien.canFire = true
                alien.fireTimer = 0
                alien.fireInterval = math.random(10)
            end

            table.insert(self.aliens, alien)
        end
    end
end

function PlayState:update(dt)
    self.ship:update(dt, self.projectiles)

    for p_key, projectile in pairs(self.projectiles) do
        projectile:update(dt)

        if projectile.y <= -PROJECTILE_LENGTH or projectile.y > VIRTUAL_HEIGHT then
            self.projectiles[p_key] = nil
        else
            for a_key, alien in pairs(self.aliens) do
                if projectile:collides(alien) and not alien.invisible then
                    self.projectiles[p_key] = nil
                    alien.invisible = true
                    gSounds['explosion']:stop()
                    gSounds['explosion']:play()
                    self.score = self.score + 100

                    if a_key > ALIENS_WIDE then
                        self.aliens[a_key - ALIENS_WIDE].canFire = true
                        self.aliens[a_key - ALIENS_WIDE].fireTimer = 0
                        self.aliens[a_key - ALIENS_WIDE].fireInterval = math.random(10)
                    end
                end
            end

            if projectile:collides(self.ship) and not self.ship.invisible then
                self.ship.invisible = true
                gSounds['death']:stop()
                gSounds['death']:play()
                gStateMachine:change('game-over', {
                    score = self.score
                })
            end
        end
    end

    self:tickAliens(dt)

    for _, alien in pairs(self.aliens) do
        if not alien.invisible then
            if alien.canFire then
                alien.fireTimer = alien.fireTimer + dt

                if alien.fireTimer >= alien.fireInterval then
                    alien.fireTimer = alien.fireTimer - alien.fireInterval
                    alien.fireInterval = math.random(10)

                    gSounds['alien-laser']:stop()
                    gSounds['alien-laser']:play()

                    table.insert(self.projectiles, Projectile(alien.x + ALIEN_SIZE / 2, alien.y + alien.height, 'down'))
                end
            end
        end
    end
end

function PlayState:render()
    love.graphics.clear((20 / 255), (10 / 255), (30 / 255), 1)

    for _, projectile in pairs(self.projectiles) do
        projectile:render()
    end

    -- draw all aliens
    for _, alien in pairs(self.aliens) do
        alien:render()
    end

    self.ship:render()

    love.graphics.print('Score: ' .. tostring(self.score))
end

function PlayState:tickAliens(dt)
    self.alienMovementTimer = self.alienMovementTimer + dt

    if self.alienMovementTimer >= ALIEN_MOVEMENT_INTERVAL then
        if self.alienDirection == 'right' then
            if self.aliens[FAR_RIGHT_ALIEN].x >= VIRTUAL_WIDTH - ALIEN_SIZE then
                self.alienDirection = 'left'

                for _, alien in pairs(self.aliens) do
                    alien.y = alien.y + ALIEN_STEP_HEIGHT
                end
            else
                for _, alien in pairs(self.aliens) do
                    alien.x = alien.x + ALIEN_STEP_LENGTH
                end
            end
        else
            if self.aliens[FAR_LEFT_ALIEN].x <= 4 then
                self.alienDirection = 'right'

                for _, alien in pairs(self.aliens) do
                    alien.y = alien.y + ALIEN_STEP_HEIGHT
                end
            else
                for _, alien in pairs(self.aliens) do
                    alien.x = alien.x - ALIEN_STEP_LENGTH
                end
            end
        end

        self.alienMovementTimer = self.alienMovementTimer - ALIEN_MOVEMENT_INTERVAL
    end
end