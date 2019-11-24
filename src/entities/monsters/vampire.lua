-- Vampire Monster
-- Shane Krolikowski
--

local Monster = require 'src.entities.monsters.monster'
local Vampire = Monster:extend()

function Vampire:new(x, y)
    Monster.new(self, x, y)

    self.name = 'skull'
    self.sx   = 1.5
	self.sy   = 1.5
	self.mass = 5
	self.value    = 0.1
	self.maxSpeed = 20
    self.maxForce = 10
    self.atkStr   = 3
    self.health   = { now = 15, max = 15 }

	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.entities,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 8, 1, 8, 4 } }
	})
end

return Vampire