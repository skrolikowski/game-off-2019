-- Range Priest Entity (Tower)
-- Long distance, weak, rapid shots
--

local Priest = require 'src.entities.priests.priest'
local Range  = Priest:extend()

-- Create new Priest
--
function Range:new(x, y)
	self.__super.new(self, x, y)

	-- @overrides
	self.name  = 'range-priest'
	self.sight = 200
	self.sightColor = Config.color.sight1

	-- properties
	self.cooldown = { now = 0, max = 1 }

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.spritesheet.towers,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 3, 2, 3, 2 } }
	})
end

return Range