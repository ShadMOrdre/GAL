-- Sabertooth Tiger
mobs:register_mob("mobs_animals_2:smilodon", {
stepheight = 0.7,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = false,
	attack_npcs = true,
	attack_monsters = true,
	attack_animals = true,
	attack_tas = true,
	peaceful = false,
	attack_chance = 75,
	reach = 2,
	damage = 5,
	hp_min = 10,
	hp_max = 24,
	armor = 200,
	collisionbox = {-0.4, -0.45, -0.4, 0.4, 0.45, 0.4},
	visual = "mesh",
	mesh = "st_smilodon.b3d",
	textures = {
		{"animal_sm.png"},
	},
	visual_size = {x=1.2, y=1.2},
	makes_footstep_sound = true,
	sounds = {
		random = "roar",
		attack = "velociraptor",
	},
	walk_chance = 95,
	walk_velocity = .5,
	run_velocity = 3.5,
	jump = true,
	jump_height = 2.1,
	view_range = 18,
	pathfinding = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3.5,
	animation = {
		speed_normal = 15,		speed_run = 35,
		stand_start = 0,		stand_end = 0,
		walk_start = 0,		walk_end = 40,
		run_start = 0,		run_end = 40,
	},
})
