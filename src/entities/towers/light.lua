-- Light Tower Entity
--

local Entity = require 'src.entities.entity'
local Light  = Entity:extend()

-- Create new Tower
--
function Light:new(x, y)
	self.__super.new(self, x, y)

	-- Properties
	self.pos      = Vec2(x, y)
	self.rotation = 0
	self.name     = 'light-tower'
	self.category = 'tower'
	self.width    = Config.map.cell.size
	self.height   = Config.map.cell.size
	self.color    = Config.color.entities.tower

	-- Attack/health
	self.cooldown = { max = 3, now = 3 }
	self.atkSpd   = 10
	self.atkStr   = 1
	self.health   = 10

	-- Behaviors
	self.sight     = 150
	self.periphery = _.__pi / 6
	self.fsm       = FSM(self, 'idle')
	self.tracker   = Tracker(self, 'enemies', 'closest')
end

-- FSM: idle
--
function Light:idle()
	if self.tracker.target == nil then
		self.rotation = self.rotation + 0.01
	else
		self.fsm:pushState('track')
	end
end

-- FSM: track target
--
function Light:track()
	if self.tracker.target ~= nil then
		local target      = self.tracker.target
		local lineOfSight = Vec2(_.__cos(self.pos.x), _.__sin(self.pos.y))
		local direction   = target.toTarget:cross(lineOfSight)

		if direction < 0 then
			self.rotation = self.rotation + 0.01
		else
			self.rotation = self.rotation - 0.01
		end
	else
		self.fsm:popState()
	end
end

-- Launch attack on target
--
function Light:attack(target)
	local cx, cy = self:center()
	local nx     = cx + _.__cos(self.rotation) * Config.map.cell.size / 2
	local ny     = cy + _.__sin(self.rotation) * Config.map.cell.size / 2
	local projectile

	projectile = Projectile(nx, ny, self.atkSpd, self.atkStr)
	projectile:launch()

	Game.world:addEntity(projectile)
end

-- Collision resoluation
--
function Light:collidedWith(other, collision)
    -- TODO: take damage from enemy projectiles?
end

-- Update tower
--
function Light:update(dt)
	self.fsm:update(dt)
	self.tracker:update(dt)

	-- cooldown/attack
	if self.tracker.target ~= nil then
		if self.cooldown.now <= 0 then
			self.cooldown.now = self.cooldown.max
			self:attack(self.tracker.target)
		else
			self.cooldown.now = self.cooldown.now - dt
		end
	end
end

-- Draw tower
--
function Light:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle('fill', self:container())

	-- debug
	self.fsm:draw()
	self.tracker:draw()
end

return Light