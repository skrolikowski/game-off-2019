Config = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),
    map = {
        xOffset = 0,
        yOffset = 0,
        cell = {
            size = 32
        }
    },
    color = {
        black = { _:color('black')    },
        white = { _:color('white')    },
        bg    = { _:color('gray-100') },
        debug = { _:color('red-500')  }
    }
}
Config.map.rows = _.__floor(Config.height / Config.map.cell.size)
Config.map.cols = _.__floor(Config.width / Config.map.cell.size)

Game = {}
--

love.graphics.setBackgroundColor(Config.color.bg)
--

function love.load()
    Game.grid     = Grid(Config.map.rows, Config.map.cols)
    -- Game.timer    = Timer.new()
    Game.entities = {}


    -- local goal = Game.grid:getCell(4, 5)
    -- goal.goal = true

    -- Game.grid:getCell(2, 3).wall = true
    -- Game.grid:getCell(2, 4).wall = true
    -- Game.grid:getCell(2, 5).wall = true
    -- Game.grid:getCell(2, 6).wall = true
    -- Game.grid:getCell(3, 3).wall = true
    -- Game.grid:getCell(4, 3).wall = true
    -- Game.grid:getCell(5, 3).wall = true
    -- Game.grid:getCell(6, 3).wall = true

    -- pathfinder(goal)
    -- spawnEnemies()
end

function love.update(dt)
    -- Game.timer:update(dt)

    -- remove entities
    for i = #Game.entities, 1, -1 do
        if Game.entities[i].remove then
            table.remove(Game.entities, i)
        end
    end

    -- update entities
    for __, entity in pairs(Game.entities) do
        entity:update(dt)
    end
end

function love.draw()
    Game.grid:draw()

    -- draw entities
    for __, entity in pairs(Game.entities) do
        entity:draw()
    end
end

-----------------------------------------------
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'space' then
        spawnEnemies()
    end
end

function love.mousepressed(x, y, button)
    local cell = Game.grid:getCellByLocation(x, y)

    if button == 1 then
        cell.wall = not cell.wall
    elseif button == 2 then
        pathfinder(cell)
        cell.goal = true
    elseif button == 3 then
        spawnEnemies()
    end
end

-----------------------------------------------
function spawnEnemies()
    local cells = {
        Game.grid:getCellByLocation(16, 16),
        Game.grid:getCellByLocation(Config.width - 16, 16),
        Game.grid:getCellByLocation(16, Config.height - 16),
        Game.grid:getCellByLocation(Config.width - 16, Config.height - 16)
    }

    for __, cell in pairs(cells) do
        local entity

        entity = Entity(cell:center())
        entity:maproute(cell)

        table.insert(Game.entities, entity)
    end
end

-----------------------------------------------
function pathfinder(goal)
    Game.grid:reset()

    local queue = Queue(goal)
    local distance = {}
    local current

    goal.distance = 0

    while not queue:isEmpty() do
        current = queue:get()

        for __, cell in pairs(current:getNeighbors()) do
            if cell.distance == nil then
                queue:put(cell)
                cell.distance = 1 + current.distance
                cell.comeFrom = current
            end
        end
    end
end

-----------------------------------------------
-- function maproute(cell)
--     local points = { cell:center() }
--     local cx, cy

--     while cell.comeFrom do
--         cell   = cell.comeFrom
--         cx, cy = cell:center()

--         table.insert(points, cx)
--         table.insert(points, cy)
--     end

--     return points
-- end