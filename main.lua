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
        entities = love.graphics.newImage('res/entities1.png'),
        towers   = love.graphics.newImage('res/entities2.png'),
    },
    color = {
        black  = { _:color('black') },
        health = { _:color('red-700') },
        white  = { _:color('white') },
        bg     = { _:color('black') },
        debug  = { _:color('red-500') },
        target = { _:color('orange-800') },
        sight1 = { _:color('yellow-200') },
        sight2 = { _:color('blue-200') },
        sight3 = { _:color('green-200') }
    }
}
Config.map.rows = _.__floor(Config.height / Config.map.cell.size)
Config.map.cols = _.__floor(Config.width / Config.map.cell.size)

Game = {}
--

function love.load()
    Game.grid      = Grid(Config.map.rows, Config.map.cols)
    Game.world     = World()
    Game.selection = nil
    Game.goal      = nil
    Game.controls  = {
        cell  = nil,
        mouse = Vec2(love.mouse.getPosition()),
        tower = 1
    }
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
    Game.grid:update(dt)
    Game.world:update(dt)
end

function love.draw()
    Game.grid:draw()
    Game.world:draw()
end

-----------------------------------------------

-- Controls -  Key Press
--
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'up' then
        nextTower()
    elseif key == 'down' then
        prevTower()
    end
end

-- Controls - Mouse Move
--
function love.mousemoved(x, y)
    Game.controls.cell  = Game.grid:getCellByLocation(x, y)
    Game.controls.mouse = Vec2(x, y)
end

-- Controls - Mouse Scroll
--
function love.wheelmoved(x, y)
    if y > 0 then
        nextTower()
    elseif y < 0 then
        prevTower()
    end
end

-- Controls - Mouse Pressed
--
function love.mousepressed(x, y, button)
    Game.selection = nil  -- reset

    if Game.controls.cell and Game.controls.cell.clickable then
        local x, y, w, h    = Game.controls.cell:container()
        local entities, len = Game.world:queryRect(x, y, w, h,
            function(item)
                return item.category == 'priests'
            end)

        if len == 0 then
            Game.world:addEntity(
                Towers[Game.controls.tower](
                    Game.controls.cell:center()
                )
            )
        else
            Game.selection = entities[1]
        end
    end
end

-----------------------------------------------

-- Controls -  Key Press
--

function nextTower()
    Game.controls.tower = Game.controls.tower + 1

    if Game.controls.tower > #Towers then
        Game.controls.tower = 1
    end
end

function prevTower()
    Game.controls.tower = Game.controls.tower - 1

    if Game.controls.tower < 1 then
        Game.controls.tower = #Towers
    end
end