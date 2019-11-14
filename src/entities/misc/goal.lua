local Entity = require 'src.entities.entity'
local Goal   = Entity:extend()

function Goal:new(x, y, idx)
	self.name     = 'goal'
	self.category = 'misc'
	self.pos      = Vec2(x, y)
	self.react    = 'cross'
	self.color    = Config.color.white
	self.sx       = 2
	self.sy       = 2

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.spritesheet.entities,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 8, 5, 8, 8 } }
	})
end

-- Get entity's dimensions
--
function Goal:dimensions()
	return self.sprite:dimensions()
end

-- Animate entity
--
function Goal:update(dt)
	self.sprite:update(dt)
end

function Goal:draw()
	local cx, cy = self:center()
	local w, h   = self:dimensions()

	love.graphics.setColor(self.color)

	self.sprite:draw(cx, cy, 0, self.sx, self.sy, w/2, h/2)
end

return Goal