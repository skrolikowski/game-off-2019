local Entity    = require 'src.entities.entity'
local Placement = Entity:extend()

function Placement:new(x, y, width, height)
	self.name     = 'placement'
	self.category = 'misc'
	self.pos      = Vec2(x, y)
	self.width    = width
	self.height   = height
end

return Placement