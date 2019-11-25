-- Game Entities
--

-- Priests
Priests = {
	range = require 'src.entities.priests.range',
	trap  = require 'src.entities.priests.trap',
	heavy = require 'src.entities.priests.heavy'
}

-- Spells
Bolt      = require 'src.entities.spells.bolt'
Blaze     = require 'src.entities.spells.blaze'
Brimstone = require 'src.entities.spells.brimestone'

-- Misc
Goal      = require 'src.entities.misc.goal'
Torch     = require 'src.entities.misc.torch'
Bound     = require 'src.entities.misc.bound'
Leap      = require 'src.entities.misc.leap'
Placement = require 'src.entities.misc.placement'

-- Monsters
Spawner  = require 'src.entities.monsters.spawner'
Skeleton = require 'src.entities.monsters.skeleton'
Skull    = require 'src.entities.monsters.skull'
Vampire  = require 'src.entities.monsters.vampire'

-- Buttons
Button     = require 'src.entities.buttons.button'
SpecialBtn = {
	range      = require 'src.entities.buttons.range',
	trap       = require 'src.entities.buttons.trap',
	heavy      = require 'src.entities.buttons.heavy',
	volumeup   = require 'src.entities.buttons.volumeup',
	volumedown = require 'src.entities.buttons.volumedown',
}

return {}