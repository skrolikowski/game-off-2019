-- Game Utils
-- Shane Krolikowski
--

local Utils = {}

function Utils:basename(source)
    return string.match(source, "([%a|%-_|%d]+)")
end

function Utils:filenameSplit(source)
    return string.match(source, "(.+%/)([%a|%-_|%d]+)%.(%a+)")
end

-- Globals
Vec2        = require 'src.utils.vec2'
AABB        = require 'src.utils.aabb'
Queue       = require 'src.utils.structures.queue'
Stack       = require 'src.utils.structures.stack'
Steer       = require 'src.utils.behavior.steering'
FSM         = require 'src.utils.behavior.fsm'
Tracker     = require 'src.utils.behavior.tracking'
Animator    = require 'src.utils.graphics.animator'
Spritesheet = require 'src.utils.graphics.spritesheet'
--

return Utils