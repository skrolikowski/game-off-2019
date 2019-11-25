-- Configurations
-- Shane Krolikowski
--

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
    image = {
        spritesheet = {
            entities   = love.graphics.newImage('res/spritesheets/entities1.png'),
            towers     = love.graphics.newImage('res/spritesheets/entities2.png'),
            bolt       = love.graphics.newImage('res/spritesheets/explosion-1.png'),
            blaze      = love.graphics.newImage('res/spritesheets/explosion-4.png'),
            brimestone = love.graphics.newImage('res/spritesheets/explosion-2.png'),
            ui         = love.graphics.newImage('res/spritesheets/interfacePack_sheet.png')
        }
    },
    ui = {
        cursor = {
            primary   = love.mouse.newCursor('res/ui/cursors/cursorGauntlet_grey.png'),
            secondary = love.mouse.newCursor('res/ui/cursors/cursorGauntlet_blue.png'),
        },
        font = {
            xs = love.graphics.newFont('res/ui/fonts/Kenney Future Narrow.ttf', 12),
            sm = love.graphics.newFont('res/ui/fonts/Kenney Future Narrow.ttf', 14),
            md = love.graphics.newFont('res/ui/fonts/Kenney Future Narrow.ttf', 16),
            lg = love.graphics.newFont('res/ui/fonts/Kenney Future Narrow.ttf', 24),
            xl = love.graphics.newFont('res/ui/fonts/Kenney Future Narrow.ttf', 32)
        }
    },
    color = {
        black    = { _:color('black') },
        gray     = { _:color('gray-700') },
        overlay  = { 0, 0, 0, 0.65 },
        health   = { _:color('red-700') },
        panel    = { _:color('#FFF1D2') },
        white    = { _:color('white') },
        bg       = { _:color('black') },
        cooldown = { _:color('green-300') },
        debug    = { _:color('red-500') },
        target   = { _:color('orange-800') },
        sight1   = { _:color('yellow-200') },
        sight2   = { _:color('blue-200') },
        sight3   = { _:color('green-200') }
    },
    economy = {
        init = 5,
        cost = {
            range = 1,
            trap  = 2,
            heavy = 3
        }
    },
    spritesheet = {
            ui = Spritesheet('res/spritesheets/interfacePack_sheet.json')
        }
}
Config.map.rows = _.__floor(Config.height / Config.map.cell.size)
Config.map.cols = _.__floor(Config.width / Config.map.cell.size)

-- Audio
Config.audio = {
    success     = love.audio.newSource('res/audio/coin5.ogg', 'static'),
    fail        = love.audio.newSource('res/audio/error5.ogg', 'static'),
    gameOver    = love.audio.newSource('res/audio/lose5.ogg', 'static'),
    takeHit     = love.audio.newSource('res/audio/hit3.ogg', 'static'),
    buttonClick = love.audio.newSource('res/audio/click3.ogg', 'static'),
    getCoin     = love.audio.newSource('res/audio/coin2.ogg', 'static'),
}