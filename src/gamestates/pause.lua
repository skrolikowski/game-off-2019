-- Pause Gamestate
-- Shane Krolikowski
--

local Pause = {}

-- Init
--
function Pause:init()
	local STI = require 'vendor.sti.sti'

	self.name      = 'pause'
	self.map       = STI("res/map/Pause.lua")
	self.textAreas = {}  -- textareas

	TextSpawner(self, self.map.layers['Text'])
end

-- Enter Pause Screen
--
function Pause:enter(from, ...)
	self.from = from  -- previous screen

	self:bootstrap()
end

-- Leave Credits Screen
--
function Pause:leave()
	self:destroy()
end

-- Bootstrap Screen
--
function Pause:bootstrap()
	-- register world entities
	ButtonSpawner(self.map.layers['Buttons'])

	-- register game controls
	self:registerControls()
end

-- Destroy Screen
--
function Pause:destroy()
	_World:removeEntitiesFrom('pause')

	-- unregister game controls
	self:unregisterControls()
end

-- Register Game Controls
--
function Pause:registerControls()
	-- mouse settings
	love.mouse.setVisible(true)
	love.mouse.setCursor(Config.ui.cursor.secondary)

	-- mouse events
	_:on('mouse_click', function(...) self:onClick(...) end)

	-- keyboard events
	_:on('key_escape', function() Game:pauseGame()    end)
	_:on('key_m',      function() Game:switchToMenu() end)
	_:on('key_e',      function() Game:pauseGame()    end)
end

-- Unregister Game Controls
--
function Pause:unregisterControls()
	-- release mouse events
	_:on('mouse_click')

	-- release keyboard events
	_:off('key_escape')
	_:off('key_m')
	_:off('key_e')
end

-- Event - handle onClick
--
function Pause:onClick(entity, button)
	if entity.name == '[M]enu' then
		Game:switchToMenu()
	elseif entity.name == '[E]sc' then
		Game:pauseGame()
	end
end

-- Draw
--
function Pause:draw()
	self.from:draw()

	-- add dark overlay
	love.graphics.setColor(Config.color.overlay)
	love.graphics.rectangle('fill', 0, 0, Config.width, Config.height)

	-- display pause menu
	love.graphics.setColor(Config.color.white)
	self.map:draw(Config.map.xOffset, Config.map.yOffset)

	-- Draw banner
    Config.spritesheet.ui:draw('bannerScroll', 390, 132)
    
    -- Draw banner text
    love.graphics.setFont(Config.ui.font.sm)
    love.graphics.printf('Pause / Instructions', 393, 150, 260, 'center')

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

return Pause