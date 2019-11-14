-- Range Priest Entity (Tower)
-- Long distance, weak, rapid shots
--

local Priest = require 'src.entities.priests.priest'
local Range  = Priest:extend()

-- Create new Priest
--
function Range:new(x, y)
	self.__super.new(self, x, y)

	-- @overrides
	self.name  = 'range-priest'
	self.sight = 200

	-- properties
	self.cooldown = { now = 0, max = 1 }
end

return Range