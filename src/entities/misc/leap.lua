local Entity = require 'src.entities.entity'
local Leap   = Entity:extend()

function Leap:new(x, y, width, height)
	self.name     = 'leap'
	self.category = 'misc'
	self.pos      = Vec2(x, y)
	self.width    = width
	self.height   = height
end

return Leap