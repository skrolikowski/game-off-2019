-- Game Spawner
-- Shane Krolikowski
--

local Modern        = require 'modern'
local GameSpawner = Modern:extend()

function GameSpawner:new(layers)
    self:spawnPlacements(layers['Placements'])
    self:spawnProps(layers['Props'])
   	self:spawnGoal(layers['Goal'])

    -- :)
    self:spawnLeaps(layers['Leaps'])
    self:spawnBounds(layers['Bounds'])
end

-- Remove an entity by name from the World
--
function GameSpawner:removeFromWorld(name)
    local entities, len = _World:getItems()

    if len > 0 then
        for __, entity in pairs(entities) do
            if entity.name == name then
                _World:removeEntity(entity)
            end
        end
    end
end

function GameSpawner:spawnGoal(layer)
    local goal = layer.objects[1]
    local cx   = goal.x + goal.width / 2
    local cy   = goal.y + goal.height / 2
    local cell = _Grid:getCellByLocation(cx, cy)

    if Game.goal then
        -- remove old goal
        _World:removeEntity(Game.goal)
    end

    -- set new goal
    Game.goal = Goal(cell:center())
    _World:addEntity(Game.goal)

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

function GameSpawner:spawnPlacements(layer)
    for __, obj in pairs(layer.objects) do
        local width  = obj.width
        local height = obj.height
        local cx     = obj.x + width / 2
        local cy     = obj.y + height / 2

        _World:addEntity(Placement(cx, cy, width, height))
    end
end

function GameSpawner:spawnProps(layer)
    for __, obj in pairs(layer.objects) do
        local cx = obj.x + obj.width / 2
        local cy = obj.y + obj.height / 2

        _World:addEntity(Torch(cx, cy))
    end
end

function GameSpawner:spawnBounds(layer)
    for __, obj in pairs(layer.objects) do
        local cx = obj.x + obj.width / 2
        local cy = obj.y + obj.height / 2

        _World:addEntity(Bound(cx, cy, obj.width, obj.height))
    end
end

function GameSpawner:spawnLeaps(layer)
    for __, obj in pairs(layer.objects) do
        local cx = obj.x + obj.width / 2
        local cy = obj.y + obj.height / 2

        _World:addEntity(Leap(cx, cy, obj.width, obj.height))
    end
end

return GameSpawner