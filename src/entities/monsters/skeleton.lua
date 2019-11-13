-- Skeleton Monster
-- Shane Krolikowski
--

local Enemy    = require 'src.entities.monsters.enemy'
local Skeleton = Enemy:extend()

function Skeleton:new(x, y)
    self.__super.new(self, x, y)

    self.name   = 'pawn'
    self.width  = 8
    self.height = 15
end

return Skeleton