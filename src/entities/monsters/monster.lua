-- Monster Entity
-- Shane Krolikowski
--

local Entity  = require 'src.entities.entity'
local Monster = Entity:extend()

function Monster:new(x, y)
    self.category = 'monster'
    self.pos      = Vec2(x, y)
    self.color    = Config.color.white
    self.oy       = 5
    self.vel      = Vec2()
    self.acc      = Vec2()

    -- flags
    self.highlight = false
    self.mirrored  = false

    -- behavior
    self.leaping = false
    self.steer   = Steer(self)
    self.fsm     = FSM(self, 'follow')
    self:maproute()
end

-- FSM: follow path
--
function Monster:follow()
    self.steer:follow()
end

-- FSM: knockback
--
function Monster:knockback()
    local angle   = self.attacker.pos:headingTo(self.pos)
    local impulse = Vec2:polar(angle, self.maxSpeed / 2)
    
    self:applyImpulse(impulse)
end

-- Apply impulse
--
function Monster:applyImpulse(impulse)
    self.vel = self.vel + impulse:scale(1 / self.mass)
end

-- Apply force
--
function Monster:applyForce(force)
    self.acc = self.acc + force:scale(1 / self.mass)
end

function Monster:nextPosition(dt)
    self.fsm:update()

    -- update velocity
    self.vel = self.vel + self.acc
    self.acc:scale(0)

    -- limit velocity
    self.vel:limit(self.maxSpeed)

    -- set heading
    local heading = self.vel:heading()
    self.mirrored = not (heading >= -_.__pi / 2 and heading <= _.__pi / 2)

    return self.pos + self.vel * dt
end

-- Collision resolution
--
function Monster:collidedWith(other, collision)
    if not self.stunned and other.name == 'goal' then
    	self:destroy(other)
    	other:takeDamage(self, self.atkStr)
    elseif other.name == 'bound' then
        self:destroy(other)
    elseif other.name == 'leap' then
        self.leaping = true
    end
end

-- Take knockback + damage
--
function Monster:takeKnockback(other, damage, time)
    self:takeDamage(other, damage)
    self.fsm:pushState('knockback')
    self.stunned  = true
    self.attacker = other

    -- stun cooldown
    Timer.after(time,
        function()
            self.stunned = false
            self.fsm:popState()
            self:maproute()
        end)
end

-- Destroy monster entity
--
function Monster:destroy(other)
    Entity.destroy(self, other)

    -- award player reward
    Game:awardMagic(self.value)

    if other and other.name == 'bound' then
        Config.audio.fall:play()
    end
end

-- Update entity
--
function Monster:update(dt)
    Entity.update(self, dt)

    -- reset
    self.leaping = false

    _World:moveEntity(self, self:nextPosition(dt))

    -- face image based on direction
    --


    -- goofy leap animation
    --
    if self.leaping and self.sx < self.scale.max then
        self.sx = self.sx + dt
        self.sy = self.sy + dt
    else
        if self.sx > self.scale.min then
            self.sx = self.sx - dt
            self.sy = self.sy - dt
        end
    end

    -- remove if out of bounds
    if not self:inBounds() then
        self:destroy(nil)
    end
end

-- Draw entity
--
function Monster:draw()
    Entity.draw(self)

    local x, y, w, h = self:container()

    -- health bar
    love.graphics.setColor(Config.color.health)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle('fill', x, y - 16, (self.health.now / self.health.max) * w, 3)
    love.graphics.rectangle('line', x, y - 16, w, 3)
end

-----------------------------------------------
-- Map route to goal
--
function Monster:maproute()
    local cell = _Grid:getCellByLocation(self.pos:unpack())
    local cx, cy

    self.points     = { cell:center() }
    self.route      = { Vec2(cell:center()) }
    self.routeIndex = 1

    while cell.comeFrom do
        cell   = cell.comeFrom
        cx, cy = cell:center()

        table.insert(self.points, cx)
        table.insert(self.points, cy)
        table.insert(self.route, Vec2(cell:center()))
    end
end

-- Find next target in path
--
function Monster:nextTarget()
    local index  = self.routeIndex
    local target = self.route[index]

    -- we are at the target
    if index == #self.route then
        return self.route[index], true
    end

    -- update target?
    if self.pos:distance(target) <= Config.map.cell.size then
        index  = index + 1
        target = self.route[index]
    end

    self.routeIndex = index

    return target, false
end

return Monster