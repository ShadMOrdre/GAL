mobs:register_mob("mobs_animals_2:trilobite", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 10,
	hp_max = 25,
	armor = 110,
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "ma2_trilobite.b3d",
	textures = {
		{"ma2_trilobite.png"},
	},
	makes_footstep_sound = false,
	view_range = 5,
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	runaway_timer = 40,
	jump = 0,
	floats = 0,
	jump_height = 0,
	stepheight = 1.3,
	fall_damage = 0,
	fall_speed = -5,
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 40,
		stand_end = 60,
		walk_start = 1,
		walk_end = 30,
		run_start = 1,
		run_end = 30,
	},
})
