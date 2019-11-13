-- Game World
-- Shane Krolikowski
--

-- Globals
Grid = require 'src.world.map.grid'
Cell = require 'src.world.map.cell'
--

local Modern = require 'modern'
local World  = Modern:extend()

-- Create new world
--
function World:new()
    local STI  = require 'vendor.sti.sti'

    self.world  = Bump.newWorld()
    self.map    = STI("res/map/A.lua")
    self.width  = self.map.width * self.map.tilewidth
    self.height = self.map.height * self.map.tileheight

    self:markTileTrait('walkable', self.map.layers['Monsters'].objects)
    self:markTileTrait('leapable', self.map.layers['Leaps'].objects)
    self:markTileTrait('clickable', self.map.layers['Priests'].objects)
    self:spawnGoal(self.map.layers['Goals'].objects)
    -- self:spawnProps(self.map.layers['Props'].objects)
    -- self:spawnSpawners(self.map.layers['Spawns'].objects)
end

function World:markTileTrait(trait, objects)
    for __, obj in pairs(objects) do
        local objBounds = AABB(obj.x, obj.y, obj.x + obj.width, obj.y + obj.height)
        local cellsWithinBounds = Game.grid:getCellsInBounds(objBounds)

        for __, cell in pairs(cellsWithinBounds) do
            cell[trait] = true
        end
    end
end

function World:spawnGoal(objects)
    local goal = objects[1]
    local cell = Game.grid:getCellByLocation(goal.x + goal.width / 2, goal.y + goal.height / 2)

    -- (re)set goal
    if Game.goal then
        self:removeEntity(Game.goal)
    end

    Game.goal = Goal(cell:center())
    self:addEntity(Game.goal)
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

-- Get world's width/height values
--
function World:dimensions()
    return self.width, self.height
end

-- Add an entity to the world
--
function World:addEntity(entity)
    -- TODO: register events?
    self.world:add(entity, entity:container())
end

function World:removeEntity(entity)
    -- TODO: uneregister events?
    self.world:remove(entity)
end

-- Remove entities marked for removal from world
--
function World:removeEntities()
    local entities, len = self.world:getItems()

    for i = #entities, 1, -1 do
        if entities[i].remove then
            self:removeEntity(entities[i])
        end
    end
end

-- Update entities in world
--
function World:updateEntities(dt)
    local entities, len = self.world:getItems()

    for __, entity in pairs(entities) do
        entity:update(dt)
    end
end

-- Move an entity in the world
--
function World:moveEntity(entity, nextPos)
    if self.world:hasItem(entity) then
        local width, height   = entity:dimensions()
        local wX, wY          = self:convertToWorldPosition(nextPos.x, nextPos.y, width, height)
        local filter          = entity.react or function() return "slide" end
        local x, y, cols, len = self.world:move(entity, wX, wY, filter)
        local newX, newY      = self:convertToEntityPosition(x, y, width, height)

        -- update entity's position/rotation..
        entity.pos.x = newX
        entity.pos.y = newY

        -- notify entity of collision(s)..
        for i = 1, len do
            entity:collidedWith(cols[i].other, cols[i])
        end
    end
end

function World:convertToWorldPosition(x, y, w, h)
    return x - w / 2,
           y - h / 2
end

function World:convertToEntityPosition(x, y, w, h)
    return x + w / 2,
           y + h / 2
end

-- Query segment for entities
--
function World:querySegment(x1, y1, x2, y2, filter)
    return self.world:querySegment(x1, y1, x2, y2, filter)
end

-- Query rectangle for entities
--
function World:queryRect(x, y, width, height, filter)
    return self.world:queryRect(x, y, width, height, filter)
end

-- Query entire screen for entities
--
function World:queryScreen()
    return self.world:queryRect(0, 0, self:dimensions())
end

-- Get world's axis-aligned bounding box
--
function World:bounds()
    return AABB(0, 0, self:dimensions())
end

-- Update world entities
--
function World:update(dt)
    self:removeEntities()
    self:updateEntities(dt)
end

-- Draw world entities
--
function World:draw()
    love.graphics.setColor(Config.color.white)
    self.map:draw(Config.map.xOffset, Config.map.yOffset)

    -- draw entities..
    local entities, len = self:queryScreen()

    for __, entity in pairs(entities) do
        entity:draw()
    end
end

return World