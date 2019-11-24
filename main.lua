-- Tower Defense
-- Shane Krolikowski
--
require 'src.config'

-- Vendor packages
Inspect   = require 'inspect'
Gamestate = require 'vendor.hump.gamestate'
Timer     = require 'vendor.hump.timer'
Bump      = require 'vendor.bump.bump'
--

function love.load()
    _Grid  = Grid(Config.map.rows, Config.map.cols)
    _World = World()
    _Mouse = _Grid:getCellByLocation(love.mouse.getPosition())

    Gamestate.registerEvents()
    Gamestate.switch(Game)
end

-- Controls - Key Press
--
function love.keypressed(key)
    _:dispatch('key_' .. key)
end

-- Controls - Wheel Moved
--
function love.wheelmoved(x, y)
    if y > 0 then
        _:dispatch('wheel_up')
    elseif y < 0 then
        _:dispatch('wheel_down')
    end
end

-- Controls - Mouse Move
--
function love.mousemoved(x, y)
    _Mouse = _Grid:getCellByLocation(x, y)
    --
    local items, len = _World:queryPoint(x, y)

    if len then
        for __, entity in pairs(items) do
            _:dispatch('mouse_hover', entity)
        end
    end
end

-- Controls - Mouse Pressed
--
function love.mousepressed(x, y, button)
    local items, len = _World:queryPoint(x, y)

    if len then
        for __, entity in pairs(items) do
            _:dispatch('mouse_click_' .. button, entity)
        end
    end
end