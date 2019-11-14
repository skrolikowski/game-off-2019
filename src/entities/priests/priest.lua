-- Priest Entity (Tower)
--

local Entity = require 'src.entities.entity'
local Priest = Entity:extend()

function Priest:new(x, y)
	self.name     = 'priest'
	self.category = 'priests'

	-- properties
	self.pos    = Vec2(x, y)
	self.width  = Config.map.cell.size
	self.height = Config.map.cell.size
	self.color  = Config.color.white
	self.sx     = 2
	self.sy     = 2

	-- behaviors
	self.tracker = Tracker(self, 'enemy')
	self.react   = 'cross'
end

-- Launch attack on target
--
function Priest:attack(target)
	local cx, cy = self:center()
	local nx     = cx + _.__cos(self.rotation) * self.width  * 1.25
	local ny     = cy + _.__sin(self.rotation) * self.height * 1.25
	local projectile

	projectile = Projectile(nx, ny)
	projectile.rotation = self.rotation

	Game.world:addEntity(projectile)
end

function Priest:dimensions()
	return self.sprite:dimensions()
end

-- Update priest behaviors
--
function Priest:update(dt)
	self.sprite:update(dt)
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
function Priest:draw()
	local cx, cy = self:center()
	local w, h   = self:dimensions()

	love.graphics.setColor(self.color)

	self.sprite:draw(cx, cy, 0, self.sx, self.sy, w / 2, h - 5)

	-- debug
	--self.tracker:draw()
end

return Priest