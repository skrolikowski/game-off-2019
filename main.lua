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
    spritesheet = {
        entities = love.graphics.newImage('res/entity_tilesheet.png')
    },
    color = {
        black  = { _:color('black') },
        white  = { _:color('white') },
        bg     = { _:color('black') },
        debug  = { _:color('red-500') },
        target = { _:color('red-800') },
        entities = {
            enemy      = { _:color('orange-400') },
            environ    = { _:color('green-400') },
            goal       = { _:color('yellow-500') },
            tower      = { _:color('gray-800') },
            projectile = { _:color('yellow-500') }
        }
    }
}
Config.map.rows = _.__floor(Config.height / Config.map.cell.size)
Config.map.cols = _.__floor(Config.width / Config.map.cell.size)

Game = {}
--

function love.load()
    Game.grid  = Grid(Config.map.rows, Config.map.cols)
    Game.world = World()
    Game.goal  = nil
    -- Game.timer = Timer.new()


    -------------------------------------
    -- Quickstart simulation
    -- setGoal(Game.grid:getCell(1, Config.map.cols / 2))
    
    -- Game.world:addEntity(Light(Game.grid:getCell(15, 13):center()))

    -- Game.world:addEntity(Wall(Game.grid:getCell(13, 11):center()))
    -- Game.world:addEntity(Wall(Game.grid:getCell(14, 11):center()))
    -- Game.world:addEntity(Wall(Game.grid:getCell(15, 11):center()))

    -- Game.timer:every(1, function()
    --     spawnEnemy(Game.grid:getCell(Config.map.rows, Config.map.cols / 2))
    -- end)
end

function love.update(dt)
    -- Game.timer:update(dt)
    Game.world:update(dt)
end

function love.draw()
    Game.world:draw()
    Game.grid:draw()
end

-----------------------------------------------
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'e' then
        -- spawnEnemy(Game.grid:getCellByLocation(love.mouse.getPosition()))
    elseif key == 't' then
        -- spawnTower(Game.grid:getCellByLocation(love.mouse.getPosition()))
    end
end

-- function love.mousepressed(x, y, button)
--     local cell   = Game.grid:getCellByLocation(x, y)
--     local cx, cy = cell:center()

--     if button == 1 then
--         Game.world:addEntity(Wall(cx, cy))
--         cell.active = false
--     elseif button == 2 then
--         setGoal(Game.grid:getCellByLocation(love.mouse.getPosition()))
--         resetEnemyPaths()
--     end
-- end

-----------------------------------------------
-- function spawnEnemy(cell)
--     Game.world:addEntity(Skeleton(cell:center()))
-- end

-- function spawnTower(cell)
--     Game.world:addEntity(Light(cell:center()))
-- end

