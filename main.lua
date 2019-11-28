-- Tower Defense
-- Shane Krolikowski
--
require 'src.config'

-- Vendor packages
Gamestate = require 'vendor.hump.gamestate'
Timer     = require 'vendor.hump.timer'
Bump      = require 'vendor.bump.bump'
--

function love.load()
    _Grid   = Grid(Config.map.rows, Config.map.cols)
    _World  = World()
    _Cell   = _Grid:getCellByLocation(love.mouse.getPosition())
    _Volume = 0.75

    _CurrRound   = 0
    _HighRound   = 0

    Gamestate.registerEvents()
    Gamestate.switch(Menu)
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
    _Cell = _Grid:getCellByLocation(x, y)
    _World:onHover(x, y)
end

-- Controls - Mouse Pressed
--
function love.mousepressed(x, y, button)
    _World:onClick(x, y, button)
end