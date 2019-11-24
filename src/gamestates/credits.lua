-- Credits Gamestate
-- Shane Krolikowski
--

local Credits = {}

-- Init
--
function Credits:init()
	local STI = require 'vendor.sti.sti'

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
	-- reset grid
	_Grid:reset()

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
	_:on('mouse_click_1', function(entity) self:onClick(entity) end)
	_:on('mouse_hover',   function(entity) self:onHover(entity) end)

	-- keyboard events
	_:on('key_escape', function() Menu:showCredits() end)
	_:on('key_q',      function() Menu:quitGame()    end)
end

-- Unregister Game Controls
--
function Credits:unregisterControls()
	-- release mouse events
	_:off('mouse_click_1')
	_:off('mouse_hover')

	-- release keyboard events
	_:off('key_escape')
	_:off('key_b')
	_:off('key_q')
end

--  onClick Event
--
function Credits:onClick(entity)
	local name = _:replace(entity.name, '%p', '')
	      name = _:capitalize(name)

	if _:isFunction(self['onClick' .. name]) then
		self['onClick' .. name](self)
	end
end

--  onHover Event
--
function Credits:onHover(entity)
	local name = _:replace(entity.name, '%p', '')
	      name = _:capitalize(name)

	if _:isFunction(self['onHover' .. name]) then
		self['onHover' .. name](self)
	end
end

-- On Click - Quit Button
--
function Credits:onClickBack()
	Menu:showCredits()
end

-- On Hover - Quit Button
--
function Credits:onHoverBack()
	--TODO: highlight button
end

-- On Click - Quit Button
--
function Credits:onClickQuit()
	Menu:quitGame()
end

-- On Hover - Quit Button
--
function Credits:onHoverQuit()
	--TODO: highlight button
end

-- Draw
--
function Credits:draw()
	self.from:draw()

	-- add dark overlay
	love.graphics.setColor(Config.color.overlay)
	love.graphics.rectangle('fill', 0, 0, Config.width, Config.height)

	-- display pause menu
	love.graphics.setColor(Config.color.white)
    self.map:draw(Config.map.xOffset, Config.map.yOffset)

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