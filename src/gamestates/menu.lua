-- Menu Gamestate
-- Shane Krolikowski
--

local Menu = {}

-- Init
--
function Menu:init()
	local STI = require 'vendor.sti.sti'

	self.map       = STI("res/map/Menu.lua")
	self.textAreas = {}

	TextSpawner(self, self.map.layers['Text'])
end

-- Enter Menu Screen
--
function Menu:enter(from, ...)
	self.from      = from   -- previous screen
	self.isCredits = false  -- on credits screen?

	self:bootstrap()
end

-- Resume Screen From Pop
--
function Menu:resume()
	self:bootstrap()
end

-- Leave Menu Screen
--
function Menu:leave()
	self:destroy()
	
end

-- Bootstrap Screen
--
function Menu:bootstrap()
	-- register world entities
	ButtonSpawner(self.map.layers['Buttons'])

	-- register game controls
	self:registerControls()
end

-- Destroy Screen
--
function Menu:destroy()
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
function Menu:registerControls()
	-- mouse settings
	love.mouse.setVisible(true)
	love.mouse.setCursor(Config.ui.cursor.secondary)

	-- mouse events
	_:on('mouse_click_1', function(entity) self:onClick(entity) end)
	_:on('mouse_hover',   function(entity) self:onHover(entity) end)

	-- keyboard events
	_:on('key_escape', function() self:quitGame()    end)
	_:on('key_q',      function() self:quitGame()    end)
	_:on('key_s',      function() self:startGame()   end)
	_:on('key_c',      function() self:showCredits() end)
end

-- Unregister Game Controls
--
function Menu:unregisterControls()
	-- release mouse events
	_:off('mouse_click_1')
	_:off('mouse_hover')

	-- release keyboard events
	_:off('key_escape')
	_:off('key_q')
	_:off('key_s')
	_:off('key_c')
end

-- Quit game!
--
function Menu:quitGame()
	love.event.quit()
end

-- Start Game!
--
function Menu:startGame()
	Gamestate.switch(Game)
end

-- Show/unshow Credits Screen
--
function Menu:showCredits()
	if self.isCredits then
		self.isCredits = false

		return Gamestate.pop()
	else
		self.isCredits = true
		self:destroy()

		return Gamestate.push(Credits)
	end
end

--  onClick Event
--
function Menu:onClick(entity)
	local name = _:replace(entity.name, '%p', '')
	      name = _:capitalize(name)

	if _:isFunction(self['onClick' .. name]) then
		self['onClick' .. name](self)
	end
end

--  onHover Event
--
function Menu:onHover(entity)
	local name = _:replace(entity.name, '%p', '')
	      name = _:capitalize(name)

	if _:isFunction(self['onHover' .. name]) then
		self['onHover' .. name](self)
	end
end

-- On Click - Start Button
--
function Menu:onClickStart()
	self:startGame()
end

-- On Hover - Start Button
--
function Menu:onHoverStart()
	--TODO: highlight button
end

-- On Click - Credits Button
--
function Menu:onClickCredits()
	self:showCredits()
end

-- On Hover - Credits Button
--
function Menu:onHoverCredits()
	--TODO: highlight button
end

-- On Click - Quit Button
--
function Menu:onClickQuit()
	self:quitGame()
end

-- On Hover - Quit Button
--
function Menu:onHoverQuit()
	--TODO: highlight button
end

-- Update
--
function Menu:update(dt)
	if self.isCredits then
		return
	end

	Timer.update(dt)
end

-- Draw
--
function Menu:draw()
	love.graphics.setColor(Config.color.white)
    self.map:draw(Config.map.xOffset, Config.map.yOffset)

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

return Menu