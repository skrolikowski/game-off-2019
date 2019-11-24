-- Bolt Spell
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Bolt   = Entity:extend()

-- Create new projectile
--
function Bolt:new(target, source)
	-- properties
	self.name     = 'bolt'
	self.category = 'spell'
	self.pos      = Vec2(target.entity:center())
	self.source   = source
	self.color    = Config.color.white
	self.sx       = 0.5
	self.sy       = 0.5
	self.target       = target
	self.atkPrimary   = 3
	self.atkSecondary = 1
	
	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.bolt,
		width  = Config.map.cell.size,
		height = Config.map.cell.size,
		frames = { { 1, 1, 1, 7 } },
		total  = 1,
		fps    = 12,
		after  = function() self:destroy(nil) end
	})

	-- attack
	self:strike()
end

-- Strike!
--
function Bolt:strike()
	-- primary attack
	self.target.entity:takeKnockback(self.source, self.atkPrimary, 0.75)

	-- secondary attack
	local sx, sy   = self.source:center()
	local tx, ty   = self.pos:unpack()
	local filter   = function(item) return item.category == 'monster' and item ~= self.target.entity end
	local monsters = _World:querySegment(sx, sy, tx, ty, filter)

	for __, monster in pairs(monsters) do
		monster:takeDamage(self.atkSecondary)
	end
end

-- Draw projectile
--
function Bolt:draw()
	Entity.draw(self)

	local sx, sy = self.source:center()
	local tx, ty = self.pos:unpack()

    love.graphics.setColor({ _:color('red-800') })
    love.graphics.line(sx, sy, tx, ty)
end

return Bolt