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

-- Props
Torch = require 'src.entities.props.torch'

-- Monsters
-- Skeleton = require 'src.entities.monsters.skeleton'
-- Skull = require 'src.entities.monsters.skull'
-- Vampire = require 'src.entities.monsters.vampire'

-- Projectiles
-- Projectile = require 'src.entities.projectiles.projectile'

-- Environment
-- Wall = require 'src.entities.environment.wall'
Goal = require 'src.entities.environment.goal'

return {}