
--Swamp Tree Model
	L0 = {name = "gal:tree_default_leaves",param2 = 0,prob = 254}
	T0 = {name = "gal:tree_default_trunk",param2 = 0,prob = 254}
	--minetest.log(S("TREES - tree_schem_swamp_tree"))
	le_temp_schem = {
		size = {x = 6,y = 8,z = 5},
		data = {
			__, __, __, T0, __, __,
			__, __, __, TS, __, __,
			__, __, __, __, __, __,
			__, __, __, __, __, __,
			__, __, __, __, __, __,
			__, __, TS, __, __, __,
			__, __, T0, __, __, __,
			__, __, __, __, __, __,

			__, T0, T0, T0, __, __,
			__, TW, T0, T0, __, __,
			__, __, T0, T0, __, __,
			__, __, T0, T0, __, __,
			__, __, T0, T0, __, __,
			TW, TW, T0, T0, __, __,
			T0, __, __, __, __, __,
			T0, __, __, __, __, __,

			__, __, T0, T0, T0, __,
			__, __, T0, T0, TE, __,
			__, __, T0, T0, __, __,
			__, __, T0, T0, __, __,
			__, __, T0, T0, __, __,
			__, __, T0, T0, TE, TE,
			__, __, T0, __, __, T0,
			__, __, T0, __, __, T0,

			__, __, __, T0, __, __,
			__, __, __, TN, __, __,
			__, __, __, __, __, __,
			__, __, __, __, __, __,
			__, __, __, __, __, __,
			__, __, TN, __, __, __,
			__, __, __, __, __, __,
			__, __, __, __, __, __,

			__, __, __, __, __, __,
			__, __, __, __, __, __,
			__, __, __, __, __, __,
			__, __, __, __, __, __,
			__, __, __, __, __, __,
			__, __, TN, __, __, __,
			__, __, T0, __, __, __,
			__, __, __, __, __, __
		},
		yslice_prob = {
			{ypos = 0,prob = 254},
			{ypos = 1,prob = 254},
			{ypos = 2,prob = 254},
			{ypos = 3,prob = 254},
			{ypos = 4,prob = 254},
			{ypos = 5,prob = 254},
			{ypos = 6,prob = 254},
			{ypos = 7,prob = 254}
		}
	}
	gal_ecology_trees.schematics.insert("tree_schem_swamp_tree", le_temp_schem)

