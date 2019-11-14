local Entity = require 'src.entities.entity'
local Torch  = Entity:extend()

function Torch:new(x, y, idx)
	self.name     = 'torch'
	self.category = 'props'
	self.pos      = Vec2(x, y)
	self.color    = Config.color.white

	-- Sprite
	self.sprite = Animator()

	if idx == 1 then
		self.sprite:addAnimation('default', {
			image  = Config.spritesheet.entities,
			width  = Config.map.cell.size,
			height = Config.map.cell.size,
			frames = { { 1, 1, 1, 4 } }
		})
	else
		self.sprite:addAnimation('default', {
			image  = Config.spritesheet.entities,
			width  = Config.map.cell.size,
			height = Config.map.cell.size,
			frames = { { 1, 5, 1, 8 } }
		})
	end
end

function Torch:dimensions()
	return self.sprite:dimensions()
end

function Torch:update(dt)
	self.sprite:update(dt)
end

function Torch:draw()
	local x, y   = self:position()
	local sx, sy = 0.9, 0.9

	love.graphics.setColor(self.color)

	self.sprite:draw(x + 2, y - 10, 0, sx, sy)
end

return Torch