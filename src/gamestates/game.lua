-- Game Gamestate
-- Shane Krolikowski
--

local Game = {}

-- Init
--
function Game:init()
	local STI = require 'vendor.sti.sti'

	self.map       = STI("res/map/Game.lua")
	self.textAreas = {}  -- textareas

	TextSpawner(self, self.map.layers['Text'])
end

-- Enter Game Screen
--
function Game:enter(from, ...)
	self.isPaused = false  -- is game paused?
	self.from     = from   -- previous screen
	self.priest   = nil    -- currently selected priest
	self.coins    = 5      -- count count
	self.goal     = nil    -- location of monster goal
	self.place    = 1      -- currently selected priest placement

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
	-- ButtonSpawner(self.map.layers['Buttons'])
	GameSpawner(self.map.layers)

	-- register game controls
	self:registerControls()

	local cx, cy = _Grid:getCell(6, 1):center()
	local properties = {}
	_World:addEntity(Spawner(cx, cy, properties))
end

function Game:destroy()
	-- reset grid
	_Grid:reset()

	-- destroy all world entities
	_World:destroy()

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

	-- mouse events
	_:on('mouse_click_1', function(entity) self:onClick(entity) end)
	_:on('mouse_hover',   function(entity) self:onHover(entity) end)

	-- mouse wheel events
	_:on('wheel_up',   function() self:prevPlacement() end)
	_:on('wheel_down', function() self:nextPlacement() end)

	-- keyboard events
    _:on('key_escape', function() self:pauseGame()     end)
    _:on('key_q',      function() self:switchToMenu()  end)
	_:on('key_up',     function() self:prevPlacement() end)
	_:on('key_down',   function() self:nextPlacement() end)
	_:on('key_1',      function() self:setPlacement(1) end)
	_:on('key_2',      function() self:setPlacement(2) end)
	_:on('key_3',      function() self:setPlacement(3) end)
end

-- Unregister Game Controls
--
function Game:unregisterControls()
	-- release mouse events
	_:off('mouse_click_1')
	_:off('mouse_hover')

	-- release mouse wheel events
	_:off('wheel_up')
	_:off('wheel_down')

	-- release keyboard events
	_:off('key_escape')
	_:off('key_q')
	_:off('key_up')
	_:off('key_down')
	_:off('key_1')
	_:off('key_2')
	_:off('key_3')
end

-- Gamestate - Go to Menu Screen
--
function Game:switchToMenu()
	if self.isPaused then
		Gamestate.pop()
		Gamestate.switch(Menu)
	end
end

--  onClick Event
--
function Game:onClick(entity)
	local name = _:replace(entity.name, '%p', '')
	      name = _:capitalize(name)

	if _:isFunction(self['onClick' .. name]) then
		self['onClick' .. name](self)
	end
end

--  onHover Event
--
function Game:onHover(entity)
	local name = _:replace(entity.name, '%p', '')
	      name = _:capitalize(name)

	if _:isFunction(self['onHover' .. name]) then
		self['onHover' .. name](self)
	end
end

-- On Click - Placement Entity
--
function Game:onClickPlacement()
	self.priest = nil  -- reset

	-- search for priest in cell..
	local x, y, w, h    = _Mouse:container()
	local entities, len = _World:queryRect(x, y, w, h,
		function(item) return item.category == 'priests' end
	)

	if len == 0 then
		-- add priest
		local cx, cy = _Mouse:center()
		local priest = Priests[self.place](cx, cy)

		_World:addEntity(priest)
	else
		-- select priest
		self.priest = entities[1]
	end
end

-- Set priest placement
--
function Game:setPlacement(place)
	self.place = place
end

-- Previous priest placement
--
function Game:prevPlacement()
	self.place = self.place - 1

    if self.place < 1 then
        self.place = #Priests
    end
end

-- Next priest placement
--
function Game:nextPlacement()
	self.place = self.place + 1

    if self.place > #Priests then
        self.place = 1
    end
end

-- Pause/unpause game
--
function Game:pauseGame()
love.event.quit()
	if self.isPaused then
		self.isPaused = false

		return Gamestate.pop()
	else
		self.isPaused = true
		self:unregisterControls()

		return Gamestate.push(Pause)
	end
end

-- Update
--
function Game:update(dt)
	if self.isPaused then
		return
	end

    Timer.update(dt)
    _World:update(dt)
end

-- Draw
--
function Game:draw()
	love.graphics.setColor(Config.color.white)
	self.map:draw(Config.map.xOffset, Config.map.yOffset)
    
    _World:draw()
	-- _Grid:draw()

	-- draw Stats
	love.graphics.setColor(Config.color.black)
	love.graphics.setFont(Config.ui.font.lg)
	-- coin count
	love.graphics.printf(_.__floor(self.coins), 930, 50, Config.map.cell.size * 2, 'center')
	-- round number
	love.graphics.printf(Spawner.roundCount or 1, 930, 150, Config.map.cell.size * 2, 'center')

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