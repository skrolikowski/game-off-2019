-- Heavy Priest Entity (Tower)
-- Short distance, strong, blast shots
--

local Priest = require 'src.entities.priests.priest'
local Heavy  = Priest:extend()

-- Create new Priest
--
function Heavy:new(x, y)
	self.__super.new(self, x, y)

	-- @overrides
	self.name = 'heavy-priest'
	self.sight = 150

	-- properties
	self.cooldown = { now = 0, max = 3 }
end

return Heavy