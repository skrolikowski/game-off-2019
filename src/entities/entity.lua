-- Game entity
-- Shane Krolikowski
--

local Modern = require 'modern'
local Entity = Modern:extend()

function Entity:new()
    --
end

-- Entity top/left position
--
function Entity:position()
    local cx, cy = self:center()
    local w, h   = self:dimensions()
    local x      = cx - w / 2
    local y      = cy - h / 2

    return x, y
end

-- Entity center position
--
function Entity:center()
    return self.pos:unpack()
end

-- Entity's dimensions
--
function Entity:dimensions()
    return self.width, self.height
end

function Entity:inBounds()
    return Game.world:bounds():contains(self:bounds())
end

-- Get entity's bounding box
--
function Entity:bounds()
    local cx, cy   = self:center()
    local w, h     = self:dimensions()
    local rotation = self.rotation or 0

    w = w * (self.bx or 1)
    h = h * (self.by or 1)

    return AABB:compute(cx, cy, w, h, rotation)
end

-- Entity's container
--
function Entity:container()
    local cx, cy = self:center()
    local w, h   = self:dimensions()
    local x      = cx - w / 2
    local y      = cy - h / 2

    return x, y, w, h
end

-- Take damage
--
function Entity:takeDamage(other, damage)
    self.health.now = self.health.now - damage

    if self.health.now <= 0 then
        self:destroy(other)
    end
end

-- Destroy entity
--
function Entity:destroy(other)
    self.remove = true
end

-- Collision resoluation
--
function Entity:collidedWith(other, collision)
    --
end

-- Update entity
--
function Entity:update(dt)
    --
end

-- Draw entity
--
function Entity:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('line', self:container())
end

-----------------------------------------------
-- function Entity:follow()
--     local target, last = self:nextTarget()
--     local force = Vec2()

--     if last then
--         self:applyForce(self:arrive(target))
--     else
--         self:applyForce(self:seek(target))
--     end
-- end

-- function Entity:seek(target)
--     local desired, steer

--     desired = target - self.pos
--     desired:normalize()
--     desired:scale(self.maxSpeed)

--     steer = desired - self.vel
--     steer:limit(self.maxForce)

--     return steer
-- end

-- function Entity:arrive(target)
--     local desired  = target - self.pos
--     local distance = desired:magnitude()
--     local stopDist = 50
--     local maxSpeed = self.maxSpeed
--     local steer

--     if distance < stopDist then
--         maxSpeed = _:mapTo(distance, 0, stopDist, 0, self.maxSpeed)
--     end

--     desired:normalize()
--     desired:scale(maxSpeed)

--     steer = desired - self.vel
--     steer:limit(self.maxForce)

--     return steer
-- end

return Entity