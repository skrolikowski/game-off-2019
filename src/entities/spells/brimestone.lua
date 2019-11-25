-- Brimstone Spell
-- Shane Krolikowski
--

local Entity    = require 'src.entities.entity'
local Brimstone = Entity:extend()

-- Create new projectile
--
function Brimstone:new(target, source)
	-- properties
	self.name         = 'brimestone'
	self.category     = 'spell'
	self.pos          = Vec2(target.entity:center())
	self.source       = source
	self.color        = Config.color.white
	self.sx           = 0.75
	self.sy           = 0.75
	self.target       = target
	self.atkPrimary   = 2
	self.atkSecondary = 1
	self.atkDistance  = Config.map.cell.size / 2

	self.strikeCount = 0
	self.strikeTotal = 10

	-- prepare attack
	local cx, cy  = self:center()
	local padding = Config.map.cell.size
	local adjX    = cx - padding
	local adjY    = cy - padding
	local adjW    = padding * 2
	local adjH    = padding * 2
	local filter  = function(item) return item.category == 'monster' end

	-- sprite/strike!
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.brimestone,
		width  = Config.map.cell.size * 2,
		height = Config.map.cell.size * 2,
		frames = { { 1, 1, 1, 8 } },
		total  = self.strikeTotal,
		fps    = 15,
		after  = function()
			-- strike!
			self:burn(adjX, adjY, adjW, adjH, filter)
		end
	})
end

-- Burn monsters!
--
function Brimstone:burn(x, y, w, h, filter)
	self.strikeCount = self.strikeCount + 1

	if self.strikeCount <= self.strikeTotal then
		local monsters = _World:queryRect(x, y, w, h, filter)
		local distance

		for __, monster in pairs(monsters) do
			distance = self.pos:distance(monster.pos)

			if distance <= self.atkDistance then
				monster:takeDamage(self, self.atkPrimary)
			else
				monster:takeDamage(self, self.atkSecondary)
			end
		end
	else
		self:destroy(nil)
	end
end

return Brimstone