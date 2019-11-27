-- Tracking Behavior
--

local Modern  = require 'modern'
local Tracker = Modern:extend()

function Tracker:new(host, prey, priority)
	self.host     = host
	self.prey     = prey
	self.priority = priority or 'furthest'
	self.tracking = {}
	self.target   = nil
end

-- Gather all prey within range
--
function Tracker:gather()
	self.tracking = {}  -- reset
	
	local cx, cy = self.host:center()
	local adjX   = cx - self.host.sight
	local adjY   = cy - self.host.sight
	local adjW   = self.host.sight * 2
	local adjH   = self.host.sight * 2

	-- Use Bump to pull in `prey` within range..
	local targets = _World:queryRect(adjX, adjY, adjW, adjH,
		function(item)
			return item.category == self.prey
		end)

	-- Cycle through possible targets,
	--   recording their properties..
	for __, target in pairs(targets) do
		table.insert(self.tracking, {
			entity   = target,
			distance = self.host.pos:distance(target.pos),
			toTarget = target.pos - self.host.pos,
		})
	end
end

-- Assess which of the tracked targets
--   matches threat priority
--
function Tracker:assess()
	local pickTarget, pickValue

	if self.priority == 'furthest' then
		for __, track in pairs(self.tracking) do
			local value = track.entity:cell().distance

			if pickValue == nil or (value and value < pickValue) then
				pickTarget = track
				pickValue  = value
			end
		end
	elseif self.priority == 'closest' then
		for __, track in pairs(self.tracking) do
			if pickValue == nil or track.distance < pickValue then
				pickTarget = track
				pickValue  = track.distance
			end
		end
	end

	self.target = pickTarget
end

-- Update tracker's target(s)
--
function Tracker:update(dt)
	self:gather()
	self:assess()
end

-- Draw tracker
--
function Tracker:draw()
	-- For debugging purposes..
	local cx, cy = self.host:center()
	local sight  = self.host.sight

	love.graphics.setColor(self.host.sightColor[1], self.host.sightColor[2], self.host.sightColor[3], 0.25)
	love.graphics.circle('fill', cx, cy, self.host.sight)

	-- line to target
	-- if self.target then
	-- 	love.graphics.setColor(Config.color.target)
	-- 	love.graphics.setLineWidth(1)
	-- 	love.graphics.line(cx, cy, self.target.entity:center())
	-- end
end

return Tracker