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
	self.oy     = 5

	-- behaviors
	self.tracker = Tracker(self, 'monster')
end

-- Event - onClick
--
function Priest:onClick()
    --
end

-- Event - onHover
--
function Priest:onHover()
    --
end

-- Update priest behaviors
--
function Priest:update(dt)
	Entity.update(self, dt)
	
	self.tracker:update(dt)

	-- cooldown/attack
	if self.tracker.target ~= nil then
		if self.cooldown.now <= 0 then
			self.cooldown.now = self.cooldown.max
			self:attack(self.tracker.target)
		else
			self.cooldown.now = self.cooldown.now - dt
		end
	else
		self.cooldown.now = 0
	end
end

-- Draw priest
--
function Priest:draw()
	Entity.draw(self)

	local x, y, w, h = self:container()
	local padding    = Config.map.cell.size / 2

	-- cooldown meter
	if self.tracker.target then
		love.graphics.setColor(Config.color.cooldown)
		love.graphics.setLineWidth(1)
		love.graphics.rectangle('fill', x - padding, y - padding * 2, (self.cooldown.now / self.cooldown.max) * (w + padding * 2), 5)
		love.graphics.rectangle('line', x - padding, y - padding * 2, w + padding * 2, 5)
	end

	-- debug
	-- self.tracker:draw()
end

return Priest