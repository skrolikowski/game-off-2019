-- Skeleton Monster
-- Shane Krolikowski
--

local Monster    = require 'src.entities.monsters.monster'
local Skeleton = Monster:extend()

function Skeleton:new(x, y)
    Monster.new(self, x, y)

	self.name     = 'skeleton'
	self.sx       = 1.25
	self.sy       = 1.25
	self.mass     = 5
	self.value    = 0.0125  -- 75 / coin
	self.maxSpeed = 30
    self.maxForce = 15
    self.atkStr   = 2
    self.scale    = { min = 1.25, max = 1.75 }
    self.health   = { now = 15, max = 15 }

	self.sprite = Animator()
	if (_.__random(2) == 1) then
		self.sprite:addAnimation('default', {
			image  = Config.image.spritesheet.entities,
			width  = Config.map.cell.size / 2,
			height = Config.map.cell.size / 2,
			frames = { { 4, 1, 4, 4 } }
		})
	else
		self.sprite:addAnimation('default', {
			image  = Config.image.spritesheet.entities,
			width  = Config.map.cell.size / 2,
			height = Config.map.cell.size / 2,
			frames = { { 4, 5, 4, 8 } }
		})
	end
end

return Skeleton