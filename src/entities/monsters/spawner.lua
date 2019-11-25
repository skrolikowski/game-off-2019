-- Monster Spawner
--

local Entity  = require 'src.entities.entity'
local Spawner = Entity:extend()

function Spawner:new(x, y, properties)
	self.name     = 'monster-spawner'
	self.category = 'spawners'
	self.pos      = Vec2(x, y)
	self.width    = Config.map.cell.size
	self.height   = Config.map.cell.size

	-- timer instance
	self.timer = Timer.new()

	-- waves
	self.waveCurrent = nil
	self.waveDelay   = properties['WaveDelay'] or 1

	-- rounds
	self.roundCurrent = nil
	self.roundCount   = 1
	self.roundTotal   = properties['RoundTotal'] or 1
	self.roundLength  = properties['RoundLength'] or 15

	-- start round
	self:startRound()
end

-- Start round
--
function Spawner:startRound()
	if self.roundCount <= self.roundTotal then
		-- start wave
		-- after `roundLength` end wave and start next round
		self:startWave()
		self.timer:after(self.roundLength, function()
			self:endWave()
			self:nextRound()
		end)

		self.roundCount = self.roundCount + 1
	end
end

function Spawner:nextRound()
	print('next round')
	-- self.timer:after(
	-- 	self.roundBreak,
	-- 	function()
	-- 		self:startRound()
	-- 	end
	-- )
end

function Spawner:endRound()
	print('end round')
	-- self:endWave()
	-- self.timer:cancel(self.roundCurrent)
end

-- Start current wave
--
function Spawner:startWave()
	-- every x seconds spawn a new monster
	self.waveCurrent = self.timer:every(
		self.waveDelay,
		function() self:spawn() end
	)
end

-- End current wave
--
function Spawner:endWave()
	print('end wave')
	-- if self.waveCurrent then
	-- 	Timer.cancel(self.waveCurrent)
	-- end
end

-- Spawn monster
--
function Spawner:spawn()
	local Entity = self:weightedChoice({
		{ monster = Skeleton, weight = 0.5 },
		{ monster = Skull,    weight = 0.3 },
		{ monster = Vampire,  weight = 0.2 },
	})

	_World:addEntity(Entity(self.pos:unpack()))
end

function Spawner:weightedChoice(choices)
	local sum      = _:sumBy(choices, function(v) return v.weight end)
    local index    = 0
    local selector = _.__random() * sum

    while selector > 0 do
        index    = index + 1
        selector = selector - choices[index].weight
    end

    return choices[index].monster
end

-- Update timer instance
--
function Spawner:update(dt)
	self.timer:update(dt)
end

return Spawner