-- Trap Priest Entity (Tower)
-- Lays long-lasting, multi-attack traps
--

local Priest = require 'src.entities.priests.priest'
local Trap   = Priest:extend()

-- Create new Priest
--
function Trap:new(x, y)
	self.__super.new(self, x, y)

	-- @overrides
	self.name  = 'trap-priest'
	self.sight = 175
	self.sightColor = Config.color.sight3

	-- properties
	self.cooldown = { now = 0, max = 5 }

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.spritesheet.towers,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 3, 4, 3, 4 } }
	})
end

return Trap