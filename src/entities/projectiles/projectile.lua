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
	-- if other.category == 'enemies' then
	-- 	self:destroy(other)
	-- 	other:takeDamage(self, self.atkStr)
	-- end
end

return Projectile