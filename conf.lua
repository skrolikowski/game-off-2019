require 'lua-lander'
--

-- Vendor libraries
Bump = require 'vendor.bump.bump'  -- bump.lua
                                   -- Author: kikito
                                   -- Repo: https://github.com/kikito/bump.lua
-- STI  = require 'vendor.sti.sti'    -- Simple-Tiled-Implementation
                                   -- Author: karai17
                                   -- Repo: https://github.com/karai17/Simple-Tiled-Implementation

Inspect = require 'inspect'
Timer   = require 'hump.timer'
--

-- Google
-- ID 7-5102000028312

World         = require 'src.world'
Utils         = require 'src.utils'
EntityManager = require 'src.entities'
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