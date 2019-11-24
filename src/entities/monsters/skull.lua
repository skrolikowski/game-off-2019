-- Skull Monster
-- Shane Krolikowski
--

local Monster = require 'src.entities.monsters.monster'
local Skull   = Monster:extend()

function Skull:new(x, y)
    Monster.new(self, x, y)

    self.name = 'skull'
    self.sx   = 1
	self.sy   = 1
	self.mass = 3
	self.value    = 0.03
	self.maxSpeed = 50
    self.maxForce = 25
    self.atkStr   = 1
    self.health   = { now = 5, max = 5 }

	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.entities,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 5, 1, 5, 4 } }
	})
end

return Skull