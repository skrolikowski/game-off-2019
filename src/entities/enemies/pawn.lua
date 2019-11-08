-- Pawn Enemy Entity
-- Shane Krolikowski
--

local Enemy = require 'src.entities.enemies.enemy'
local Pawn  = Enemy:extend()

function Pawn:new(x, y)
    self.__super.new(self, x, y)

    self.name   = 'pawn'
    self.width  = 8
    self.height = 15
end

return Pawn