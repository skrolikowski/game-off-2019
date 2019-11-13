-- Projectile entity
--

local Entity     = require 'src.entities.entity'
local Projectile = Entity:extend()

-- Create new projectile
--
function Projectile:new(x, y, rotation, atkSpd, atkStr)
	-- Properties
	self.name     = 'projectile'
    self.pos      = Vec2(x, y)
    self.width    = 25
    self.height   = 25
    self.color    = Config.color.entities.projectile
    self.rotation = rotation

    -- Attack/health
	self.atkSpd = atkSpd
	self.atkStr = atkStr

	-- Movement
    self.vel = Vec2(
		_.__cos(rotation) * atkSpd,
		_.__sin(rotation) * atkSpd
	)
end

-- Update entity
--
function Projectile:update(dt)
	local nextPos = self.pos + self.vel * dt

    Game.world:moveEntity(self, nextPos)

	if not self:inBounds() then
		self:destroy(nil)
	end
end

-- Collision resoluation
--
function Projectile:collidedWith(other, collision)
	if other.category == 'enemy' then
		self:destroy(other)
		other:takeDamage(self, self.atkStr)
	end
end

-- Draw projectile
--
function Projectile:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self:container())
end

return Projectile