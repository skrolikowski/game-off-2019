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
    self.world = Bump.newWorld()
    self.selected = {}  -- currently selected entities
    self.hovered  = {}  -- currently hovered entities
end

-- Event - handle onClick
--
function World:onClick(x, y, button)
    local entities, len = _World:queryPoint(x, y)

    if len > 0 then
        for __, entity in pairs(entities) do
            -- notify controller
            _:dispatch('mouse_click', entity, button)

            -- notify entity
            entity:onClick(button)
        end
    end

    -- update current selected entities
    self.selected = entities
end

-- Event - handle onHover
--
function World:onHover(x, y)
    local hovers, len = _World:queryPoint(x, y)

    self:onEnter(hovers)
    self:onLeave(hovers)

    -- update current hovered entities
    self.hovered = hovers
end

-- Event - handle onEnter
--
function World:onEnter(entities)
    for k1, entity in pairs(entities) do
        local existing = false

        for k2, hovered in pairs(self.hovered) do
            if entity == hovered then
                existing = true
            end
        end

        if not existing then
            -- notify controller
            _:dispatch('mouse_enter', entity)

            -- notify entity
            entity:onEnter()
        end
    end
end

-- Event - handle onLeave
--
function World:onLeave(entities)
    for k1, hovered in pairs(self.hovered) do
        local leaving = true

        for k2, entity in pairs(entities) do
            if entity == hovered then
                leaving = false
            end
        end

        if leaving then
            -- notify controller
            _:dispatch('mouse_leave', entity)

            -- notify entity
            hovered:onLeave()
        end
    end
end

-- Destroy all entities in world
--
function World:destroy()
    local entities, len = self.world:getItems()

    for i = #entities, 1, -1 do
        self:removeEntity(entities[i])
    end
end

-- Add an entity to the world
--
function World:addEntity(entity)
    entity.from = Gamestate.current().name

    self.world:add(entity, entity:container())
end

-- Remove entities from world from gamestate
--
function World:removeEntitiesFrom(name)
    local entities, len = self.world:getItems()

    for i = #entities, 1, -1 do
        if entities[i].from == name then
            self:removeEntity(entities[i])
        end
    end
end

-- Remove an entity from the world
--
function World:removeEntity(entity)
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
        local filter          = entity.react or function() return "cross" end
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

    return entity.pos
end

function World:convertToWorldPosition(x, y, w, h)
    return x - w / 2,
           y - h / 2
end

function World:convertToEntityPosition(x, y, w, h)
    return x + w / 2,
           y + h / 2
end

-- Query point for entities
--
function World:queryPoint(x, y, filter)
    return self.world:queryPoint(x, y, filter)
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

-- Get world's dimensions
--
function World:dimensions()
    return Config.width, Config.height
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
    -- draw entities..
    local entities, len = self:queryScreen()

    for __, entity in pairs(entities) do
        entity:draw()
    end
end

return World