-- Trap Priest Entity (Tower)
-- Lays long-lasting, multi-attack traps
--

local Priest = require 'src.entities.priests.priest'
local Trap   = Priest:extend()

-- Create new Priest
--
function Trap:new(x, y)
	Priest.new(self, x, y)

	-- @overrides
	self.name  = 'trap'
	self.sight = 160
	self.sightColor = Config.color.sight3

	-- properties
	self.cooldown = { now = 0, max = 5 }

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.towers,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 3, 4, 3, 4 } }
	})
end

-- Lay Trap - Brimstone!
function Trap:attack(target)
	_World:addEntity(Brimstone(target, self))
end

return Trap