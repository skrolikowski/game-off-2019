local TrapBtn = Button:extend()

function TrapBtn:new(name, x, y, width, height)
	Button.new(self, name, x, y, width, height)

	-- @overrides
	self.cost      = Config.economy.cost['trap']
	self.highlight = false
end

-- Event - handle onClick
--
function TrapBtn:onClick()
	if Game.isPicking ~= nil then
		Game.isPicking:placePriest('trap')
	end
end

-- Event - handle onEnter
--
function TrapBtn:onEnter()
	self.highlight = true
end

-- Event - handle onLeave
--
function TrapBtn:onLeave()
	self.highlight = false
end

function TrapBtn:draw()
	local x, y, w, h = self:container()
	local color

	if self.cost <= Game.magic then
		color = Config.color.white
	else
		color = Config.color.health
	end

	love.graphics.setColor(color)
	love.graphics.printf(self.cost, x, y + h, w, 'right')

	if self.highlight and Game.isPicking then
		love.graphics.setColor(color)
		love.graphics.rectangle('line', x, y, w, h)
	end
end

return TrapBtn