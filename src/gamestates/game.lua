-- Game Gamestate
-- Shane Krolikowski
--

local Game = {}

-- Init
--
function Game:init()
	local STI = require 'vendor.sti.sti'

	self.name        = 'game'
	self.map         = STI("res/map/Game.lua")
	self.textAreas   = {}  -- textareas
	self.waveManager = WaveManager()

	TextSpawner(self, self.map.layers['Text'])
end

-- Enter Game Screen
--
function Game:enter(from, ...)
	self.from  = from -- previous screen
	self.magic = Config.economy.init
	self.goal  = nil  -- location of monster goal

	-- flags
	self.isPaused  = false  -- game is paused?
	self.isPicking = nil    -- user is picking priest?

	self:bootstrap()
end

function Game:resume()
	self:registerControls()
end

-- Leave Game Screen
--
function Game:leave()
	self:destroy()
end

-- Bootstrap Screen
--
function Game:bootstrap()
	-- mark grid tiles
	_Grid:markTileTrait('walkable', self.map.layers['Walkable'])
	_Grid:markTileTrait('leapable', self.map.layers['Leaps'])

	-- register world entities
	ButtonSpawner(self.map.layers['Buttons'])
	GameSpawner(self.map.layers)

	-- start waves
	self.waveManager:bootstrap(self.map.layers['Spawns'])

	-- register game controls
	self:registerControls()
end

function Game:destroy()
	-- reset grid
	_Grid:reset()

	-- destroy all world entities
	_World:destroy()

	-- destroy wave spawners
	self.waveManager:destroy()

	-- clear timer functions
	Timer.clear()

	-- unregister game controls
	self:unregisterControls()
end

-- Register Game Controls
--
function Game:registerControls()
	-- mouse settings
	love.mouse.setVisible(true)
	love.mouse.setCursor(Config.ui.cursor.secondary)

	-- keyboard events
    _:on('key_escape', function() self:onEscape()      end)
    _:on('key_q',      function() self:switchToMenu()  end)
	_:on('key_1',      function() self:makePlacement('range') end)
	_:on('key_2',      function() self:makePlacement('trap')  end)
	_:on('key_3',      function() self:makePlacement('heavy') end)
end

-- Unregister Game Controls
--
function Game:unregisterControls()
	-- release keyboard events
	_:off('key_escape')
	_:off('key_q')
	_:off('key_1')
	_:off('key_2')
	_:off('key_3')
end

-- Player has lost, end the game
--
function Game:awardMagic(value)
	local soundCheck = _.__floor(self.magic) + 1

	-- update magic
	self.magic = self.magic + value

	if soundCheck == _.__floor(self.magic) then
		Config.audio.getCoin:play()
	end
end

-- Player has lost, end the game
--
function Game:endGame()
	self:switchToGameOver()
end

-- Player has lost, end the game
--
function Game:winGame()
	self:switchToGameWin()
end

-- Gamestate - Go to GameOver Screen
--
function Game:switchToGameOver()
	Gamestate.switch(GameOver)
end

-- Gamestate - Go to GameWin Screen
--
function Game:switchToGameWin()
	Gamestate.switch(GameWin)
end

-- Gamestate - Go to Menu Screen
--
function Game:switchToMenu()
	if self.isPaused then
		Gamestate.pop()
		Gamestate.switch(Menu)
	end
end

-- Place priest
--
function Game:makePlacement(name)
	if Game.isPicking ~= nil then
		Game.isPicking:placePriest(name)
	end
end

-- Event - ESC key pressed
--
function Game:onEscape()
	if self.isPicking then
		self.isPicking:resume()
	else
		self:pauseGame()
	end
end

-- Pause/unpause game
--
function Game:pauseGame()
	if self.isPaused then
		self.isPaused = false

		if Gamestate.current() ~= Game then
			return Gamestate.pop()
		end
	else
		self.isPaused = true
		self:unregisterControls()

		if Gamestate.current() ~= Pause then
			return Gamestate.push(Pause)
		end
	end
end

-- Update
--
function Game:update(dt)
	if self.isPaused then
		return
	end

	-- update global timer
    Timer.update(dt)
    
    -- update world entities
    _World:update(dt)

    -- update wave manager
    self.waveManager:update(dt)
end

-- Draw
--
function Game:draw()
	-- draw tiles/background
	love.graphics.setColor(Config.color.white)
	self.map:draw(Config.map.xOffset, Config.map.yOffset)
    
    -- draw entities
    _World:draw()

	-- draw stats
	love.graphics.setColor(Config.color.black)
	love.graphics.setFont(Config.ui.font.lg)
	-- round number
	love.graphics.printf(_CurrRound or 1, 930, 50, Config.map.cell.size * 2, 'center')
	-- magic count
	love.graphics.printf(_.__floor(self.magic), 930, 150, Config.map.cell.size * 2, 'center')

	-- draw textareas
	for __, textArea in pairs(self.textAreas) do
		local x, y    = textArea.x, textArea.y
		local width   = textArea.width
		local yOffset = textArea.yOffset

		love.graphics.setFont(Config.ui.font[textArea.font])
		love.graphics.setColor(Config.color[textArea.color])
		love.graphics.printf(textArea.text, x, y + yOffset, width, textArea.align)
	end
end

return Game