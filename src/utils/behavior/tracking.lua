-- Tracking Behavior
--

local Modern  = require 'modern'
local Tracker = Modern:extend()

function Tracker:new(host, prey, priority)
	self.host     = host
	self.prey     = prey
	self.priority = priority
	self.tracking = {}
	self.target   = nil
end

-- Gather all prey within range
--
function Tracker:gather()
	self.tracking = {}  -- reset

	-- Get line of sight vector
	local cx, cy      = self.host:center()
	local rotation    = self.host.rotation
	local lineOfSight = Vec2(_.__cos(rotation), _.__sin(rotation))

	-- Query rect surrounding host
	local adjX    = cx - self.host.sight
	local adjY    = cy - self.host.sight
	local adjW    = self.host.sight * 2
	local adjH    = self.host.sight * 2
	local targets = Game.world:queryRect(adjX, adjY, adjW, adjH,
		function(item)
			return item.category == self.prey
		end)
	
	-- Cycle through possible targets and mark
	--   entities that are within our sights
	for __, target in pairs(targets) do
		toTarget     = target.pos - self.host.pos
		angleBetween = toTarget:angleBetween(lineOfSight)
		distance     = self.host.pos:distance(target.pos)

		if angleBetween < self.host.periphery and
		   distance > 0 and
		   distance < self.host.sight
		then
			table.insert(self.tracking, {
				entity       = target,
				distance     = distance,
				toTarget     = toTarget,
				angleBetween = angleBetween
			})
		end
	end
end

-- Remove prey not within immediate sight
--
function Tracker:verify()
	local cx, cy = self.host:center()

	for i = #self.tracking, 1, -1 do
		local entity = self.tracking[i].entity
		local items  = Game.world:querySegment(cx, cy, entity:center())
		
		if items[2] ~= entity then
			table.remove(self.tracking, i)
		end
	end
end

-- Assess which of the tracked targets
--   matches threat priority
--
function Tracker:assess()
	local pickTarget, pickValue

	if self.priority == 'closest' then
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
	self:verify()
	self:assess()
end

-- Draw tracker
--
function Tracker:draw()
	-- For debugging purposes..
	local cx, cy    = self.host:center()
	local sight     = self.host.sight
	local periphery = self.host.periphery
	local heading   = self.host.rotation

	love.graphics.setColor(0.99, 0.98, 0.75, 0.5)
	love.graphics.arc('fill', cx, cy, sight, heading - periphery, heading + periphery)

	love.graphics.setColor(0.96, 0.88, 0.37, 1)
	love.graphics.arc('line', cx, cy, sight, heading - periphery, heading + periphery)

	if self.target then
		local tx, ty = self.target.entity:center()

		love.graphics.setColor(Config.color.target)
		love.graphics.setLineWidth(1)
		love.graphics.circle('line', tx, ty, 6)
		love.graphics.circle('fill', tx, ty, 3)
	end
end

return Tracker