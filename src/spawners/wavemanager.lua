-- Wave Manager
-- Shane Krolikowski
--

local Modern      = require 'modern'
local WaveManager = Modern:extend()

function WaveManager:new()
	self.name     = 'wave-manager'
	self.category = 'spawners'
	self.timer    = Timer.new()
	self.spawners = {}
end

-- Bootstrap wave manager
-- 
function WaveManager:bootstrap(layer)
	for __, obj in pairs(layer.objects) do
        table.insert(self.spawners, {
        	x          = obj.x + obj.width / 2,
        	y          = obj.y + obj.height / 2,
        	width      = obj.width,
        	height     = obj.height,
        	cooldown   = obj.properties["Cooldown"]   or 2,
        	startRound = obj.properties["StartRound"] or 1,
        	endRound   = obj.properties["EndRound"]   or Config.rounds.total,
        	monsters   = obj.properties["Monsters"]    or "75-25-10",
        	timer      = nil
        })
    end

    -- reset current round
    _CurrRound = 0

    -- start first round
    self:startRound()

    -- start subsequent round timer..
    self.timer:every(
    	Config.rounds.delay,
    	function() self:startRound() end,
    	Config.rounds.total
    )
end

-- Destroy wave manager
--
function WaveManager:destroy()
	-- remove spawners
	for i = #self.spawners, 1, -1 do
		table.remove(self.spawners, i)
	end

	-- remove local timed functions
	self.timer:clear()
end

-- Start the next wave.
-- ...start monster spawners!
--
function WaveManager:startRound()
	self:updateRound()

	if _CurrRound > Config.rounds.total then
		Game:winGame()
	else
		local breakTime  = _.__floor(Config.rounds.delay / 4)
		local multiplier = _.__floor(_CurrRound / 2)

		-- no break if last round..
		if _CurrRound == Config.rounds.total then
			breakTime = 0
		end

		-- start the wave!
		self:startWave(multiplier)

		-- end wave with a break..
		self.timer:after(
			Config.rounds.delay - breakTime,
			function() self:stopRound() end
		)
	end
end

-- The round has ended!
-- ...stop monster spawners.
--
function WaveManager:stopRound()
	self:stopWave()

	Config.audio.roundOver:play()

	Game:awardMagic(1)
end

-- Start the wave!
-- Spawning monster hordes...
--
function WaveManager:startWave(multiplier)
	for __, spawner in pairs(self.spawners) do
		if _CurrRound < spawner.startRound then
			-- skip round
		elseif _CurrRound > spawner.endRound then
			-- skip round
		else
			-- calculate the number of spawns..
			local cooldown = spawner.cooldown - (spawner.cooldown * multiplier / 100)
			local count    = _.__floor(Config.rounds.delay / cooldown)

			spawner.timer = self.timer:every(
				cooldown,
				function()
					self:spawnMonster(spawner.x, spawner.y, spawner.monsters)
				end,
				count
			)
		end
	end
end

-- Start the wave!
-- Spawning monster hordes...
function WaveManager:stopWave()
	for __, spawner in pairs(self.spawners) do
		if spawner.timer then
			self.timer:cancel(spawner.timer)
		end
	end
end

-- Spawn monster at spawner location
--
function WaveManager:spawnMonster(x, y, weights)
	local choices = {}
	local sum     = 0
	local index

	for weight in _.__gmatch(weights, "%d+") do
		sum = sum + tonumber(weight)
		table.insert(choices, tonumber(weight))
	end
	
	index = self:weightedChoice(choices, sum)

	_World:addEntity(Monsters[index](x, y))
end

-- Pick monster based on weighted choices
--
function WaveManager:weightedChoice(choices, sum)
    local index    = 0
    local selector = _.__random() * sum

    while selector > 0 do
        index    = index + 1
        selector = selector - choices[index]
    end

    return index
end

-- Update round variables
--
function WaveManager:updateRound()
	Config.audio.roundStart:play()

	-- update current round
	_CurrRound = _CurrRound + 1

	-- update high round, if applicable
	if _CurrRound > _HighRound then
		_HighRound = _CurrRound
	end
end

-- Update timer
--
function WaveManager:update(dt)
	self.timer:update(dt)
end

-- Draw all spawners
--
function WaveManager:draw()
	for __, spawner in pairs(self.spawners) do
		love.graphics.setColor(Config.color.white)
		love.graphics.rectangle('line', spawner.x, spawner.y, spawner.width, spawner.height)
	end
end

return WaveManager