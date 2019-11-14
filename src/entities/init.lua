-- Game Entities
--

-- Spawner
Spawner = require 'src.entities.spawner'

-- Priests
Towers = {
	require 'src.entities.priests.range',
	require 'src.entities.priests.trap',
	require 'src.entities.priests.heavy',
}


-- Misc
Goal  = require 'src.entities.misc.goal'
Torch = require 'src.entities.misc.torch'


-- Monsters
-- Skeleton = require 'src.entities.monsters.skeleton'
-- Skull = require 'src.entities.monsters.skull'
-- Vampire = require 'src.entities.monsters.vampire'

-- Projectiles
-- Projectile = require 'src.entities.projectiles.projectile'



return {}