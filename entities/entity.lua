-- Game entity
-- Shane Krolikowski
--

local Modern = require 'modern'
local Entity = Modern:extend()

function Entity:new(x, y)
    self.pos    = Vec2(x, y)
    self.vel    = Vec2()
    self.acc    = Vec2()
    self.mass   = 1
    self.drag   = -0.015
    self.maxSpeed = 200
    self.maxForce = 20
    self.width  = 8
    self.height = 15

    self.points = {}
    self.route  = nil
    self.index  = 0
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

-- Entity's container
--
function Entity:container()
    local cx, cy = self:center()
    local w, h   = self:dimensions()
    local x      = cx - w / 2
    local y      = cy - h / 2

    return x, y, w, h
end

-- Map route to goal
--
function Entity:maproute(cell)
    self.points = { cell:center() }
    self.route  = { Vec2(cell:center()) }
    self.index  = 1
    local cx, cy

    while cell.comeFrom do
        cell   = cell.comeFrom
        cx, cy = cell:center()

        table.insert(self.points, cx)
        table.insert(self.points, cy)
        table.insert(self.route, Vec2(cell:center()))
    end
end

function Entity:applyForce(force)
    self.acc = self.acc + force:scale(1 / self.mass)
end

function Entity:applyDrag()
    local drag = self.vel:copy()
          drag:normalize()
          drag:scale(self.drag * self.vel:magnitudeSq())

    self:applyForce(drag)
end

-- Update entity
--
function Entity:update(dt)
    self:applyDrag()

    -- steering forces
    self:follow()

    -- update velocity
    self.vel = self.vel + self.acc
    self.acc:scale(0)

    -- limit velocity
    self.vel:limit(self.maxSpeed)

    -- update position
    self.pos = self.pos + self.vel * dt
end

-- Draw entity
--
function Entity:draw()
    love.graphics.setColor(Config.color.debug)
    love.graphics.rectangle('fill', self:container())

    if #self.points >= 4 then
        love.graphics.setColor(Config.color.debug)
        love.graphics.line(self.points)
    end
end

-----------------------------------------------
function Entity:follow()
    local target, last = self:nextTarget()
    local force = Vec2()

    if last then
        self:applyForce(self:arrive(target))
    else
        self:applyForce(self:seek(target))
    end
end

function Entity:seek(target)
    local desired, steer

    desired = target - self.pos
    desired:normalize()
    desired:scale(self.maxSpeed)

    steer = desired - self.vel
    steer:limit(self.maxForce)

    return steer
end

function Entity:arrive(target)
    local desired  = target - self.pos
    local distance = desired:magnitude()
    local stopDist = 50
    local maxSpeed = self.maxSpeed
    local steer

    if distance < stopDist then
        maxSpeed = _:mapTo(distance, 0, stopDist, 0, self.maxSpeed)
    end

    desired:normalize()
    desired:scale(maxSpeed)

    steer = desired - self.vel
    steer:limit(self.maxForce)

    return steer
end

-----------------------------------------------
function Entity:nextTarget()
    local index  = self.index
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

    self.index = index

    return target, false
end

return Entity