-- Goal Entity
--

local Entity = require 'src.entities.entity'
local Goal   = Entity:extend()

function Goal:new(x, y)
	self.name     = 'goal'
	self.category = 'misc'
	self.pos      = Vec2(x, y)
	self.health   = { now = 10, max = 10 }
	self.color    = Config.color.white
	self.sx       = 2
	self.sy       = 2

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.entities,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 8, 5, 8, 8 } }
	})
end

function Goal:draw()
	Entity.draw(self)

	local x, y, w, h = self:container()

	-- health bar
    love.graphics.setColor(Config.color.health)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle('fill', x-10, y - 16, (self.health.now / self.health.max) * (w+20), 3)
    love.graphics.rectangle('line', x-10, y - 16, w+20, 3)
end

return Goal