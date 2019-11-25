-- Button Spawner
-- Shane Krolikowski
--

local Modern        = require 'modern'
local ButtonSpawner = Modern:extend()

-- Add Button Entities to World
--
function ButtonSpawner:new(buttons)
    for __, obj in pairs(buttons.objects) do
        local name    = obj.name
        local x       = obj.x + obj.width / 2
        local y       = obj.y + obj.height / 2
        local special = obj.properties['Special'] or false

        if special then
			button = SpecialBtn[special](name, x, y, obj.width, obj.height)
		else
			button = Button(name, x, y, obj.width, obj.height)
		end

		_World:addEntity(button)
    end
end

-- Remove Button Entities from World
--
function ButtonSpawner:removeFromWorld()
	local entities, len = _World:getItems()

	if len > 0 then
		for __, entity in pairs(entities) do
			if entity.category == 'buttons' then
				_World:removeEntity(entity)
			end
		end
	end
end

return ButtonSpawner