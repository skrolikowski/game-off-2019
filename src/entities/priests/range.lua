-- Range Priest Entity (Tower)
-- Long distance, weak, rapid shots
--

local Priest = require 'src.entities.priests.priest'
local Range  = Priest:extend()

-- Create new Priest
--
function Range:new(x, y)
	Priest.new(self, x, y)

	-- @overrides
	self.name  = 'range'
	self.sight = 180
	self.sightColor = Config.color.sight1

	-- properties
	self.cooldown = { now = 0, max = 0.8 }

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.towers,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 3, 2, 3, 2 } }
	})
end

-- Fire Bolt!
--
function Range:attack(target)
	_World:addEntity(Bolt(target, self))
end

return Range