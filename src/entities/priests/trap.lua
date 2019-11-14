-- Trap Priest Entity (Tower)
-- Lays long-lasting, multi-attack traps
--

local Priest = require 'src.entities.priests.priest'
local Trap   = Priest:extend()

-- Create new Priest
--
function Trap:new(x, y)
	self.__super.new(self, x, y)

	-- @overrides
	self.name  = 'trap-priest'
	self.sight = 175

	-- properties
	self.cooldown = { now = 0, max = 5 }
end

return Trap