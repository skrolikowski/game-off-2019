-- Heavy Priest Entity (Tower)
-- Short distance, strong, blast shots
--

local Priest = require 'src.entities.priests.priest'
local Heavy  = Priest:extend()

-- Create new Priest
--
function Heavy:new(x, y)
	Priest.new(self, x, y)

	-- @overrides
	self.name  = 'heavy'
	self.sight = 145
	self.sightColor = Config.color.sight2

	-- properties
	self.cooldown = { now = 0, max = 8 }

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.towers,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 3, 1, 3, 1 } }
	})
end

-- Raise Blaze!
--
function Heavy:attack(target)
	_World:addEntity(Blaze(target, self))
end

return Heavy