require 'lua-lander'
--

-- pprint = require 'libs.pprint.pprint'
-- Timer  = require 'libs.hump.timer'
--

Queue  = require 'utils.queue'
Cell   = require 'map.cell'
Grid   = require 'map.grid'
Vec2   = require 'entities.vec2'
Entity = require 'entities.entity'
--

function love.conf(t)
    io.stdout:setvbuf('no')

    t.identity = 'tower-defense'
    t.version  = '11.2'
    t.console  = false

    t.window.title      = 'Tower Defense'
    -- t.window.icon       = 'res/ui/crossair_black.png'
    t.window.x          = 25
    t.window.y          = 50
    t.window.width      = 640
    t.window.height     = 640
    t.window.fullscreen = false
    t.window.highdpi    = true
    t.window.vsync      = true

    t.modules.physics = false
    t.modules.sound   = false
    t.modules.touch   = false
    t.modules.thread  = false
    t.modules.video   = false
end