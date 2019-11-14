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

	-- behaviors
	self.fsm     = FSM(self, 'hunt')
	self.tracker = Tracker(self, 'enemy')
end

-- FSM: hunt for next target
--
function Priest:hunt()
	if self.tracker.target == nil then
		--self.rotation = self.rotation + 0.01
	else
		self.fsm:pushState('track')
	end
end

-- FSM: track target
--
function Priest:track()
	if self.tracker.target ~= nil then
		
	else
		self.fsm:popState()
	end
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

-- Update priest behaviors
--
function Priest:update(dt)
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
function Priest:draw()
	local x, y, w, h = self:container()

	love.graphics.setColor(self.color)
	love.graphics.rectangle('fill', x, y, w, h)

	-- debug
	self.fsm:draw()
	self.tracker:draw()
end

return Priest