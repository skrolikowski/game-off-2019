-- Credits Gamestate
-- Shane Krolikowski
--

local Credits = {}

-- Init
--
function Credits:init()
	local STI = require 'vendor.sti.sti'

	self.name      = 'credits'
	self.map       = STI("res/map/Credits.lua")
	self.textAreas = {}  -- textareas

	TextSpawner(self, self.map.layers['Text'])
end

-- Enter Credits Screen
--
function Credits:enter(from, ...)
	self.from = from  -- previous screen

	self:bootstrap()
end

-- Leave Credits Screen
--
function Credits:leave()
	self:destroy()
end

-- Bootstrap Screen
--
function Credits:bootstrap()
	-- register world entities
	ButtonSpawner(self.map.layers['Buttons'])

	-- register game controls
	self:registerControls()
end

-- Destroy Screen
--
function Credits:destroy()
	-- destroy all world entities
	_World:destroy()

	-- unregister game controls
	self:unregisterControls()
end

-- Register Game Controls
--
function Credits:registerControls()
	-- mouse settings
	love.mouse.setVisible(true)
	love.mouse.setCursor(Config.ui.cursor.secondary)

	-- mouse events
	_:on('mouse_click', function(...) self:onClick(...) end)

	-- keyboard events
	_:on('key_escape', function() Menu:showCredits() end)
	_:on('key_q',      function() Menu:quitGame()    end)
	_:on('key_m',      function() Menu:showCredits() end)
end

-- Unregister Game Controls
--
function Credits:unregisterControls()
	-- release mouse events
	_:off('mouse_click')

	-- release keyboard events
	_:off('key_escape')
	_:off('key_q')
	_:off('key_m')
end

-- Event - handle onClick
--
function Credits:onClick(entity, button)
	if entity.name == '[Q]uit' then
		Menu:quitGame()
	elseif entity.name == '[M]enu' then
		Menu:showCredits()
	end
end

-- Draw
--
function Credits:draw()
	self.from:draw()

	-- add dark overlay
	love.graphics.setColor(Config.color.overlay)
	love.graphics.rectangle('fill', 0, 0, Config.width, Config.height)

	-- display credits
	love.graphics.setColor(Config.color.white)
    self.map:draw(Config.map.xOffset, Config.map.yOffset)

    -- Draw banner
    Config.spritesheet.ui:draw('bannerScroll', 390, 170)
    
    -- Draw banner text
    love.graphics.setFont(Config.ui.font.md)
    love.graphics.printf('Credits', 393, 190, 260, 'center')

	-- Draw textareas
	for __, textArea in pairs(self.textAreas) do
		local x, y   = textArea.x, textArea.y
		local width  = textArea.width
		local yOffset = textArea.yOffset

		love.graphics.setFont(Config.ui.font[textArea.font])
		love.graphics.setColor(Config.color[textArea.color])
		love.graphics.printf(textArea.text, x, y + yOffset, width, textArea.align)
	end
end

return Credits