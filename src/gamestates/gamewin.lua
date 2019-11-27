-- GameWin Gamestate
-- Shane Krolikowski
--

local GameWin = {}

-- Init
--
function GameWin:init()
	local STI = require 'vendor.sti.sti'

	self.name      = 'gamewin'
	self.map       = STI("res/map/GameWin.lua")
	self.textAreas = {}

	TextSpawner(self, self.map.layers['Text'])
end

-- Enter Menu Screen
--
function GameWin:enter(from, ...)
	self.from = from

	Config.audio.gameWin:play()

	self:bootstrap()
end

-- Leave Menu Screen
--
function GameWin:leave()
	self:destroy()
end

-- Bootstrap Screen
--
function GameWin:bootstrap()
	-- register world entities
	ButtonSpawner(self.map.layers['Buttons'])

	-- register game controls
	self:registerControls()
end

-- Destroy Screen
--
function GameWin:destroy()
	-- destroy all world entities
	_World:destroy()

	-- unregister game controls
	self:unregisterControls()
end

-- Register Game Controls
--
function GameWin:registerControls()
	-- mouse settings
	love.mouse.setVisible(true)
	love.mouse.setCursor(Config.ui.cursor.secondary)

	-- mouse events
	_:on('mouse_click', function(...) self:onClick(...) end)

	-- keyboard events
	_:on('key_escape', function() self:switchToMenu() end)
	_:on('key_q',      function() self:quitGame()     end)
	_:on('key_m',      function() self:switchToMenu() end)
end

-- Unregister Game Controls
--
function GameWin:unregisterControls()
	-- release mouse events
	_:off('mouse_click')

	-- release keyboard events
	_:off('key_escape')
	_:off('key_q')
	_:off('key_m')
end

-- Event - handle onClick
--
function GameWin:onClick(entity, button)
	if entity.name == '[M]enu' then
		self:switchToMenu()
	elseif entity.name == '[Q]uit' then
		self:quitGame()
	end
end

-- Quit game!
--
function GameWin:quitGame()
	love.event.quit()
end

-- Start Game!
--
function GameWin:switchToMenu()
	Gamestate.switch(Menu)
end

-- Draw
--
function GameWin:draw()
	love.graphics.setColor(Config.color.white)
    self.map:draw(Config.map.xOffset, Config.map.yOffset)

    -- Draw banner
    Config.spritesheet.ui:draw('bannerScroll', 390, 132)
    
    -- Draw banner text
    love.graphics.setFont(Config.ui.font.md)
    love.graphics.printf('You Won!', 393, 150, 260, 'center')

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

return GameWin