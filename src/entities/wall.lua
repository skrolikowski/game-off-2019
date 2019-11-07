-- Wall Entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Wall   = Entity:extend()

function Wall:new(x, y)
    self.name   = 'wall'
    self.pos    = Vec2(x, y)
    self.width  = Config.map.cell.size
    self.height = Config.map.cell.size
    self.mass   = 10
    self.color  = Config.color.entities.environ
end

return Wall