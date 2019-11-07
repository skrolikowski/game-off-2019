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
        debug = { _:color('red-500')  },
        entities = {
            enemy   = { _:color('orange-400') },
            environ = { _:color('green-400')  },
            goal    = { _:color('yellow-500') }
        }
    }
}
Config.map.rows = _.__floor(Config.height / Config.map.cell.size)
Config.map.cols = _.__floor(Config.width / Config.map.cell.size)

Game = {}
--

love.graphics.setBackgroundColor(Config.color.bg)
--

function love.load()
    Game.world = World()
    Game.grid  = Grid(Config.map.rows, Config.map.cols)
    Game.goal  = nil
end

function love.update(dt)
    Game.world:update(dt)
end

function love.draw()
    Game.grid:draw()
    Game.world:draw()
end

-----------------------------------------------
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'e' then
        spawnEnemy(Game.grid:getCellByLocation(love.mouse.getPosition()))
    elseif key == 'space' then
        pathfinder(Game.grid:getCellByLocation(love.mouse.getPosition()))
    end
end

function love.mousepressed(x, y, button)
    local cell   = Game.grid:getCellByLocation(x, y)
    local cx, cy = cell:center()

    if button == 1 then
        Game.world:addEntity(Wall(cx, cy))
        cell.active = false
    elseif button == 2 then
        setGoal(Game.grid:getCellByLocation(love.mouse.getPosition()))
        resetEnemyPaths()
    end
end

-----------------------------------------------
function spawnEnemy(cell)
    Game.world:addEntity(Pawn(cell:center()))
end

function resetEnemyPaths()
    local entities, len = Game.world.world:getItems()

    for __, entity in pairs(entities) do
        if entity.maproute then
            entity:maproute()
        end
    end
end

function setGoal(cell)
    if Game.goal then
        Game.world:removeEntity(Game.goal)
    end

    Game.goal = Goal(cell:center())
    Game.world:addEntity(Game.goal)
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