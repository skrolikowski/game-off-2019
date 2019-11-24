require 'lua-lander'
--

-- Globals
Spawners   = require 'src.spawners'
World      = require 'src.world'
Utils      = require 'src.utils'
Entities   = require 'src.entities'
Gamestates = require 'src.gamestates'
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
    t.window.width      = 1024
    t.window.height     = 800
    t.window.fullscreen = false
    t.window.highdpi    = true
    t.window.vsync      = true

    t.modules.physics = false
    t.modules.sound   = false
    t.modules.touch   = false
    t.modules.thread  = false
    t.modules.video   = false
end