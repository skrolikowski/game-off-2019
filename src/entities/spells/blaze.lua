-- Blaze Spell
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Blaze  = Entity:extend()

-- Create new projectile
--
function Blaze:new(target, source)
	-- properties
	self.name         = 'bolt'
	self.category     = 'spell'
	self.pos          = Vec2(target.entity:center())
	self.source       = source
	self.color        = Config.color.white
	self.sx           = 0.75
	self.sy           = 0.75
	self.target       = target
	self.atkPrimary   = 5
	self.atkSecondary = 2.5
	self.atkDistance  = Config.map.cell.size

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.blaze,
		width  = Config.map.cell.size * 4,
		height = Config.map.cell.size * 4,
		frames = { { 1, 1, 1, 8 } },
		total  = 1,
		fps    = 8,
		after  = function() self:destroy(nil) end
	})

	-- attack
	self:strike()
end

-- Strike!
--
function Blaze:strike()
	local cx, cy   = self:center()
	local padding  = Config.map.cell.size * 2
	local adjX     = cx - padding
	local adjY     = cy - padding
	local adjW     = padding * 2
	local adjH     = padding * 2
	local filter     = function(item) return item.category == 'monster' end
	local monsters   = _World:queryRect(adjX, adjY, adjW, adjH, filter)
	local distance

	for __, monster in pairs(monsters) do
		distance = self.pos:distance(monster.pos)

		if distance <=  self.atkDistance then
			monster:takeDamage(self, self.atkPrimary)
		else
			monster:takeKnockback(self.source, self.atkSecondary, 1)
		end
	end
end

return Blaze