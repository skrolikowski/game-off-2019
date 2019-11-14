local Entity = require 'src.entities.entity'
local Torch  = Entity:extend()

function Torch:new(x, y, idx)
	self.name     = 'torch'
	self.category = 'misc'
	self.pos      = Vec2(x, y)
	self.color    = Config.color.white
	self.sx       = 2
	self.sy       = 2

	-- Sprite
	self.sprite = Animator()

	if idx == 1 then
		self.sprite:addAnimation('default', {
			image  = Config.spritesheet.entities,
			width  = Config.map.cell.size / 2,
			height = Config.map.cell.size / 2,
			frames = { { 2, 1, 2, 4 } }
		})
	else
		self.sprite:addAnimation('default', {
			image  = Config.spritesheet.entities,
			width  = Config.map.cell.size / 2,
			height = Config.map.cell.size / 2,
			frames = { { 1, 5, 1, 8 } }
		})
	end
end

-- Get entity's dimensions
--
function Torch:dimensions()
	return self.sprite:dimensions()
end

-- Keep the flame lit!
--
function Torch:update(dt)
	self.sprite:update(dt)
end

function Torch:draw()
	local cx, cy = self:center()
	local w, h   = self:dimensions()

	love.graphics.setColor(self.color)

	self.sprite:draw(cx, cy, 0, self.sx, self.sy, w/2, h)
end

return Torch