-- Button Entity
--

local Entity = require 'src.entities.entity'
local Button = Entity:extend()

function Button:new(name, x, y, width, height)
	self.name     = name
	self.category = 'buttons'
	self.pos      = Vec2(x, y)
	self.width    = width
	self.height   = height
end

return Button