-- Enemy Entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Enemy  = Entity:extend()

function Enemy:new(x, y)
    self.category = 'enemy'
    self.pos      = Vec2(x, y)
    self.color    = Config.color.entities.enemy
    self.health   = { now = 10, max = 10 }

    -- Movement
    self.vel      = Vec2()
    self.acc      = Vec2()
    self.mass     = 1
    self.drag     = -0.015
    self.maxSpeed = 200
    self.maxForce = 20

    -- Behavior
    self.points = {}
    self.route  = nil
    self.index  = 0
    self.steer  = Steer(self)

    self:maproute()
end

-- Apply force
--
function Enemy:applyForce(force)
    self.acc = self.acc + force:scale(1 / self.mass)
end

-- Apply drag force
--
function Enemy:applyDrag()
    local drag = self.vel:copy()
          drag:normalize()
          drag:scale(self.drag * self.vel:magnitudeSq())

    self:applyForce(drag)
end

function Enemy:nextPosition(dt)
    self:applyDrag()

    -- steering forces
    self.steer:follow()

    -- update velocity
    self.vel = self.vel + self.acc
    self.acc:scale(0)

    -- limit velocity
    self.vel:limit(self.maxSpeed)

    return self.pos + self.vel * dt
end

-- Collision resoluation
--
function Enemy:collidedWith(other, collision)
	if other.name == 'goal' then
		self:destroy(other)
		other:takeDamage(self, 1)
	end
end

-- Update entity
--
function Enemy:update(dt)
    Game.world:moveEntity(self, self:nextPosition(dt))

    if not self:inBounds() then
        self:destroy(nil)
    end
end

-- Draw entity
--
function Enemy:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self:container())

    if #self.points >= 4 then
        love.graphics.setColor(Config.color.debug)
        love.graphics.line(self.points)
    end

    -- health bar
    love.graphics.setColor(Config.color.health)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle('fill', x, y - 8, (self.health.now / self.health.max) * w, 3)
    love.graphics.rectangle('line', x, y - 8, w, 3)
end

-----------------------------------------------
-- Map route to goal
--
function Enemy:maproute()
    local cell = Game.grid:getCellByLocation(self.pos:unpack())
    local cx, cy

    self.points = { cell:center() }
    self.route  = { Vec2(cell:center()) }
    self.index  = 1

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
function Enemy:nextTarget()
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

return Enemy