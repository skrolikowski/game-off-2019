-- GameOver Gamestate
-- Shane Krolikowski
--

local GameOver = {}

-- Init
--
function GameOver:init()
	local STI = require 'vendor.sti.sti'

	self.name      = 'gameover'
	self.map       = STI("res/map/GameOver.lua")
	self.textAreas = {}

	TextSpawner(self, self.map.layers['Text'])
end

-- Enter Menu Screen
--
function GameOver:enter(from, ...)
	self.from = from

	Config.audio.gameOver:play()

	self:bootstrap()
end

-- Leave Menu Screen
--
function GameOver:leave()
	self:destroy()
end

-- Bootstrap Screen
--
function GameOver:bootstrap()
	-- register world entities
	ButtonSpawner(self.map.layers['Buttons'])

	-- register game controls
	self:registerControls()
end

-- Destroy Screen
--
function GameOver:destroy()
	-- destroy all world entities
	_World:destroy()

	-- unregister game controls
	self:unregisterControls()
end

-- Register Game Controls
--
function GameOver:registerControls()
	-- mouse settings
	love.mouse.setVisible(true)
	love.mouse.setCursor(Config.ui.cursor.secondary)

	-- mouse events
	_:on('mouse_click', function(...) self:onClick(...) end)

	-- keyboard events
	_:on('key_escape', function() self:switchToMenu() end)
	_:on('key_q',      function() self:quitGame()     end)
	_:on('key_m',      function() self:switchToMenu() end)
	_:on('key_r',      function() self:retryGame()    end)
end

-- Unregister Game Controls
--
function GameOver:unregisterControls()
	-- release mouse events
	_:off('mouse_click')

	-- release keyboard events
	_:off('key_escape')
	_:off('key_q')
	_:off('key_m')
	_:off('key_r')
end

-- Event - handle onClick
--
function GameOver:onClick(entity, button)
	if entity.name == '[M]enu' then
		self:switchToMenu()
	elseif entity.name == '[R]etry' then
		self:retryGame()
	elseif entity.name == '[Q]uit' then
		self:quitGame()
	end
end

-- Quit game!
--
function GameOver:quitGame()
	love.event.quit()
end

-- Start Game!
--
function GameOver:switchToMenu()
	Gamestate.switch(Menu)
end

-- Retry Game!
--
function GameOver:retryGame()
	Gamestate.switch(Game)
end

-- Draw
--
function GameOver:draw()
	love.graphics.setColor(Config.color.white)
    self.map:draw(Config.map.xOffset, Config.map.yOffset)

    -- Draw banner
    Config.spritesheet.ui:draw('bannerScroll', 390, 132)
    
    -- Draw banner text
    love.graphics.setFont(Config.ui.font.md)
    love.graphics.printf('Game Over', 393, 150, 260, 'center')

	-- Draw textareas
	for __, textArea in pairs(self.textAreas) do
		local x, y    = textArea.x, textArea.y
		local width   = textArea.width
		local yOffset = textArea.yOffset

		love.graphics.setFont(Config.ui.font[textArea.font])
		love.graphics.setColor(Config.color[textArea.color])
		love.graphics.printf(textArea.text, x, y + yOffset, width, textArea.align)
	end
end

return GameOver