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

	-- flags
	self.highlight = false
	self.mirrored  = false

	-- behaviors
	self.tracker = Tracker(self, 'monster')
end

-- Event - onClick
--
function Priest:onClick(button)
    if button == 2 then
    	-- sell back
    	Game.magic = Game.magic + 1

    	self:destroy(nil)
    end
end

-- Event - onEnter
--
function Priest:onEnter()
    self.highlight = true
end

-- Event - onLeave
--
function Priest:onLeave()
    self.highlight = false
end

function Priest:destroy(other)
	Entity.destroy(self, other)

	Config.audio.takeHit:play()
end

-- Update priest behaviors
--
function Priest:update(dt)
	Entity.update(self, dt)
	
	self.tracker:update(dt)

	-- cooldown/attack
	if self.tracker.target ~= nil then
		-- face target
	    local heading = self.pos:headingTo(self.tracker.target.entity.pos)
	    self.mirrored = not (heading >= -_.__pi / 2 and heading <= _.__pi / 2)

		if self.cooldown.now <= 0 then
			self:attack(self.tracker.target)
		end
	end

	if self.cooldown.now <= 0 then
		self.cooldown.now = self.cooldown.max
	else
		self.cooldown.now = self.cooldown.now - dt
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
	if self.highlight then
		self.tracker:draw()
	end
end

return Priest