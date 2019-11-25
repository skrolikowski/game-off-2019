local Entity    = require 'src.entities.entity'
local Placement = Entity:extend()

function Placement:new(x, y, width, height)
	self.name      = 'placement'
	self.category  = 'misc'
	self.pos       = Vec2(x, y)
	self.width     = width
	self.height    = height
	self.sx        = 2
	self.sy        = 2
	self.oy        = 8
	self.color     = Config.color.white

	-- flags
	self.hasPriest = false
	self.highlight = false
	self.isPicking = false

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.entities,
		width  = Config.map.cell.size / 2,
		height = Config.map.cell.size / 2,
		frames = { { 1, 1, 1, 4 } }
	})
end

-- Purchase Priest (w/ validation)
--
function Placement:placePriest(name)
	if Config.economy.cost[name] <= Game.coins then
		_World:addEntity(
			Priests[name](self.pos:unpack())
		)

		self.hasPriest = true
		self.isPicking = false

		-- reset
		Game.isPaused  = false
		Game.isPicking = nil

		-- purchase!
		Game.coins = Game.coins - Config.economy.cost[name]

		-- play sfx - success
		Config.audio.success:play()
	else
		-- play sfx - fail
		Config.audio.fail:play()
	end
end

-- Event - onClick
--
function Placement:onClick(button)
	if button == 1 then
		-- search for priest in cell..
		if not self.hasPriest and not Game.isPicking then
			self.isPicking = true

			Game.isPaused  = true
			Game.isPicking = self
		end
	end
end

function Placement:onEnter()
	if not self.hasPriest then
		self.highlight = true
	end
end

function Placement:onLeave()
	self.highlight = false
end

function Placement:draw()
	if self.highlight or self.isPicking then
		Entity.draw(self)
	end
end

return Placement