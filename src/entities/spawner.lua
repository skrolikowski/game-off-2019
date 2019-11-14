-- Entity Spawner
-- Shane Krolikowski
--

local Modern  = require 'modern'
local Spawner = Modern:extend()

function Spawner:new(world, layers)
	self.world = world

	self:markTileTrait('walkable', layers['Monsters'].objects)
    self:markTileTrait('leapable', layers['Leaps'].objects)
    self:markTileTrait('clickable', layers['Priests'].objects)
   	self:spawnGoal(layers['Goals'].objects)
   	self:spawnProps(layers['Props'].objects)
    -- self:spawnSpawners(self.map.layers['Spawns'].objects)
end

function Spawner:markTileTrait(trait, objects)
    for __, obj in pairs(objects) do
        local objBounds = AABB(obj.x, obj.y, obj.x + obj.width, obj.y + obj.height)
        local cellsWithinBounds = Game.grid:getCellsInBounds(objBounds)

        for __, cell in pairs(cellsWithinBounds) do
            cell[trait] = true
        end
    end
end

function Spawner:spawnGoal(objects)
    local goal = objects[1]
    local cell = Game.grid:getCellByLocation(goal.x + goal.width / 2, goal.y + goal.height / 2)

    -- (re)set goal
    if Game.goal then
        self.world:removeEntity(Game.goal)
    end

    Game.goal = Goal(cell:center())
    self.world:addEntity(Game.goal)
    ---
    local queue = Queue(cell)
    local distance = {}
    local current

    cell.distance = 0

    while not queue:isEmpty() do
        current = queue:get()

        for __, neighbor in pairs(current:getNeighbors()) do
            if neighbor.distance == nil then
                queue:put(neighbor)
                neighbor.distance = 1 + current.distance
                neighbor.comeFrom = current
            end
        end
    end
end

function Spawner:spawnProps(objects)
    for __, obj in pairs(objects) do
        local cx = obj.x + obj.width / 2
        local cy = obj.y + obj.height / 2

        self.world:addEntity(Torch(cx, cy, _.__random(2)))
    end
end

return Spawner