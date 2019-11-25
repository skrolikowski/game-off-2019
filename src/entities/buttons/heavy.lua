local HeavyBtn = Button:extend()

function HeavyBtn:new(name, x, y, width, height)
	Button.new(self, name, x, y, width, height)

	-- @overrides
	self.cost      = Config.economy.cost['heavy']
	self.highlight = false
end

-- Event - handle onClick
--
function HeavyBtn:onClick()
	if Game.isPicking ~= nil then
		Game.isPicking:placePriest('heavy')
	end
end

-- Event - handle onEnter
--
function HeavyBtn:onEnter()
	self.highlight = true
end

-- Event - handle onLeave
--
function HeavyBtn:onLeave()
	self.highlight = false
end

function HeavyBtn:draw()
	local x, y, w, h = self:container()
	local color

	if self.cost <= Game.coins then
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

return HeavyBtn