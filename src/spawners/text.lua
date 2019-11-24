-- Text Spawner
-- Shane Krolikowski
--

local Modern      = require 'modern'
local TextSpawner = Modern:extend()

--
function TextSpawner:new(gamestate, textAreas)
    self.gamestate = gamestate

    for __, textArea in pairs(textAreas.objects) do
        self:spawnText(textArea)
    end
end

-- Spawn text
--
function TextSpawner:spawnText(textArea)
    table.insert(self.gamestate.textAreas, {
        text    = textArea.name,
        x       = textArea.x,
        y       = textArea.y,
        width   = textArea.width,
        height  = textArea.height,
        font    = textArea.properties['Font'] or 'md',
        color   = textArea.properties['Color'] or 'white',
        align   = textArea.properties['Align'] or 'center',
        yOffset = textArea.properties['yOffset'] or 8,
    })
end

return TextSpawner