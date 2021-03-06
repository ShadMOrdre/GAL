mobs:register_mob("mobs_animals_2:fish_river", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0.5,
	attack_type = "dogfight",
	hp_min = 10,
	hp_max = 25,
	armor = 120,
	collisionbox = {-0.2, -0.2, -0.2, 0.2, 0.2, 0.2},
	visual_size = {x=1.6, y=1.6},
	visual = "mesh",
	mesh = "ma2_fish.b3d",
	textures = {
		{"ma2_fish_river.png"},
	},
	makes_footstep_sound = false,
	view_range = 10,
	walk_velocity = 3,
	run_velocity = 6,
	runaway = false,
	runaway_timer = 40,
	jump = false,
	jump_height = 0,
	stepheight = 0,
	fly = true,
	fly_in = "gal:liquid_water_river_source",
	fall_damage = 0,
	fall_speed = 0,
	drops = {
		{name = "mobs_animals_2:fish_small_raw",
		chance = 9, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 1,
		stand_end = 20,
		walk_start = 1,
		walk_end = 20,
		run_start = 1,
		run_end = 20,
	},
})


mobs:register_mob("mobs_animals_2:fish_small", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 1,
	hp_max = 3,
	armor = 100,
	collisionbox = {-0.2, -0.2, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "ma2_fish.b3d",
	textures = {
		{"ma2_fish_small.png"},
	},
	makes_footstep_sound = false,
	view_range = 10,
	walk_velocity = 3,
	run_velocity = 6,
	runaway = true,
	runaway_timer = 40,
	jump = false,
	jump_height = 0,
	stepheight = 0,
	fly = true,
	fly_in = "gal:liquid_water_river_source",
	fall_damage = 0,
	fall_speed = 0,
	drops = {
		{name = "mobs_animals_2:fish_small_raw",
		chance = 9, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 1,
		stand_end = 20,
		walk_start = 1,
		walk_end = 20,
		run_start = 1,
		run_end = 20,
	},
})

