-- Goal Entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Goal   = Entity:extend()

function Goal:new(x, y)
    self.name   = 'goal'
    self.pos    = Vec2(x, y)
    self.width  = Config.map.cell.size
    self.height = Config.map.cell.size
    self.mass   = 10
    self.health = 10
    self.color  = Config.color.entities.goal
end

return Goal