local Entity = require 'src.entities.entity'
local Torch  = Entity:extend()

function Torch:new(x, y)
	self.name     = 'torch'
	self.category = 'misc'
	self.pos      = Vec2(x, y)
	self.color    = Config.color.white
	self.sx       = 2
	self.sy       = 2
	self.oy       = 8
	self.react    = 'bounce'

	-- Sprite
	self.sprite = Animator()

	if _.__random(2) == 1 then
		self.sprite:addAnimation('default', {
			image  = Config.image.spritesheet.entities,
			width  = Config.map.cell.size / 2,
			height = Config.map.cell.size / 2,
			frames = { { 2, 1, 2, 4 } }
		})
	else
		self.sprite:addAnimation('default', {
			image  = Config.image.spritesheet.entities,
			width  = Config.map.cell.size / 2,
			height = Config.map.cell.size / 2,
			frames = { { 1, 5, 1, 8 } }
		})
	end
end

return Torch