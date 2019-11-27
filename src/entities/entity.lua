-- Game Entity
-- Shane Krolikowski
--

local Modern = require 'modern'
local Entity = Modern:extend()

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
    if self.sprite then
        return self.sprite:dimensions()
    else
        return self.width, self.height
    end
end

function Entity:inBounds()
    return _World:bounds():contains(self:bounds())
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

-- Get entity's current cell location
function Entity:cell()
    return _Grid:getCellByLocation(self:center())
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

-- Event - onClick
--
function Entity:onClick(button)
    --
end

-- Event - onLeave
--
function Entity:onLeave()
    --
end

-- Event - onEnter
--
function Entity:onEnter()
    --
end

-- Event - Collision Resolution
--
function Entity:collidedWith(other, collision)
    --
end

-- Update entity
--
function Entity:update(dt)
    if self.sprite then
        self.sprite:update(dt)
    end
end

-- Draw entity
--
function Entity:draw()
    if self.sprite then
        local cx, cy = self:center()
        local w, h   = self:dimensions()
        local ox, oy = self.ox or 0, self.oy or 0
        local sx, sy = self.sx, self.sy

        if self.mirrored then
            sx = -sx
        end

        love.graphics.setColor(self.color)

        self.sprite:draw(cx, cy, 0, sx, sy, w/2 + ox, h/2 + oy)
    end
end

return Entity