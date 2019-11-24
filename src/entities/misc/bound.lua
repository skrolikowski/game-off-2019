local Entity = require 'src.entities.entity'
local Bound  = Entity:extend()

function Bound:new(x, y, width, height)
	self.name     = 'bound'
	self.category = 'misc'
	self.pos      = Vec2(x, y)
	self.width    = width
	self.height   = height
end

return Bound