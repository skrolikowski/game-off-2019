local RangeBtn = Button:extend()

function RangeBtn:new(name, x, y, width, height)
	Button.new(self, name, x, y, width, height)

	-- @overrides
	self.cost      = Config.economy.cost['range']
	self.highlight = false
end

-- Event - handle onClick
--
function RangeBtn:onClick()
	if Game.isPicking ~= nil then
		Game.isPicking:placePriest('range')
	end
end

-- Event - handle onEnter
--
function RangeBtn:onEnter()
	self.highlight = true
end

-- Event - handle onLeave
--
function RangeBtn:onLeave()
	self.highlight = false
end

function RangeBtn:draw()
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

return RangeBtn