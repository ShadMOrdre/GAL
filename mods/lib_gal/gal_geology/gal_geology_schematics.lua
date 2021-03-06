

local S = gal_geology.intllib

local __ = {name = "air",param2 = 0,prob = 254}
local aa = {name = "air",param2 = 0,prob = 0}
local S0 = {name = "gal:stone_desert", param2 = 0, prob = 254}
local S1 = {name = "gal:stone_desert", param2 = 0, prob = 192}
local S2 = {name = "gal:stone_desert", param2 = 0, prob = 128}
local S3 = {name = "gal:stone_desert", param2 = 0, prob = 96}
local D0 = {name = "gal:dirt", param2 = 0, prob = 254}




	gal_geology.schem_rock_desert_01 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, __,
			__, __, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			__, S0, S0
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_desert_02 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			__, S0, S0,
			__, __, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_desert_03 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, S0,
			__, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			S0, S0, S0,
			__, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_desert_04 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, S0,
			__, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			S0, S0, S0,
			__, S0, S0,
			__, __, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_desert_05 = {
		size = {x = 3,y = 7,z = 3},
		data = {
			aa, aa, aa,
			S0, S0, aa,
			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,
			__, S0, S0,
			__, __, S0,

			aa, D0, D0,
			aa, S0, S0,
			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			D0, D0, aa,
			S0, S0, aa,
			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2},
			{prob = 254, ypos = 3},
			{prob = 254, ypos = 4},
			{prob = 254, ypos = 5},
			{prob = 254, ypos = 6}
		}
	}
	
	
	gal_geology.schem_rock_desert_02_01 = {
		size = {x = 4,y = 6,z = 3},
		data = {
			D0, D0, D0, D0,
			S0, S0, __, __,
			__, S0, __, __,
			__, __, __, __,
			__, __, __, __,
			__, __, __, __,

			D0, D0, D0, D0,
			S0, S0, S0, S0,
			S0, S0, S0, __,
			S0, S0, __, __,
			__, S0, __, __,
			__, S0, __, __,

			D0, D0, D0, D0,
			__, S0, __, __,
			__, S0, __, __,
			__, __, __, __,
			__, __, __, __,
			__, __, __, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2},
			{prob = 254, ypos = 3},
			{prob = 254, ypos = 4},
			{prob = 254, ypos = 5}
		}
	}

	gal_geology.schem_rock_desert_02_02 = {
		size = {x = 5,y = 6,z = 5},
		data = {
			__, S0, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __,

			S0, S0, S0, S0, __,
			__, S0, S0, __, __,
			__, __, S0, __, __,
			__, __, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __,

			S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0,
			__, S0, S0, S0, __,
			__, S0, S0, __, __,
			__, __, S0, __, __,
			__, __, S0, __, __,

			S0, S0, S0, S0, __,
			__, S0, S0, S0, __,
			__, __, S0, __, __,
			__, __, S0, __, __,
			__, __, __, __, __,
			__, __, __, __, __,

			__, __, S0, __, __,
			__, __, S0, __, __,
			__, __, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2},
			{prob = 254, ypos = 3},
			{prob = 254, ypos = 4},
			{prob = 254, ypos = 5}
		}
	}

	gal_geology.schem_rock_desert_02_03 = {
		size = {x = 5,y = 4,z = 5},
		data = {
			__, __, S0, __, __,
			__, __, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __,

			__, S0, S0, S0, __,
			__, __, S0, S0, __,
			__, __, S0, __, __,
			__, __, __, __, __,

			S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0,
			__, S0, S0, S0, __,
			__, __, S0, __, __,

			__, S0, S0, S0, __,
			__, S0, S0, __, __,
			__, __, S0, __, __,
			__, __, __, __, __,

			__, __, S0, __, __,
			__, __, __, __, __,
			__, __, __, __, __,
			__, __, __, __, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2},
			{prob = 254, ypos = 3}
		}
	}
	
	gal_geology.schem_rock_desert_03_01 = {
		size = {x = 9,y = 13,z = 9},
		data = {
			__, S0, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,

			__, S0, S0, __, __, __, S0, S0, __,
			__, __, S0, __, __, __, S0, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,

			S0, S0, S0, S0, __, __, S0, __, __,
			__, S0, S0, __, __, __, __, __, __,
			__, S0, S0, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,

			S0, S0, S0, S0, __, __, __, __, __,
			__, S0, S0, __, __, __, __, __, __,
			__, S0, S0, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,

			S0, S0, S0, S0, S0, S0, __, S0, __,
			S0, S0, S0, S0, S0, __, __, __, __,
			__, S0, S0, S0, __, __, __, __, __,
			__, S0, S0, S0, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,

			S0, S0, S0, S0, S0, __, S0, S0, __,
			__, S0, S0, S0, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,

			S0, S0, S0, S0, __, S0, S0, __, __,
			S0, S0, S0, S0, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,

			__, S0, S0, __, __, S0, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,

			__, S0, S0, S0, __, __, __, __, __,
			__, __, S0, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __,
			__, __, __, __, __, __, __, __, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2},
			{prob = 254, ypos = 3},
			{prob = 254, ypos = 4},
			{prob = 254, ypos = 5},
			{prob = 254, ypos = 6},
			{prob = 254, ypos = 7},
			{prob = 254, ypos = 8},
			{prob = 254, ypos = 9},
			{prob = 254, ypos = 10},
			{prob = 254, ypos = 11},
			{prob = 254, ypos = 12}
		}
	}



	
	__ = {name = "air",param2 = 0,prob = 254}
	S0 = {name = "gal:stone", param2 = 0, prob = 254}
	S1 = {name = "gal:stone", param2 = 0, prob = 192}
	S2 = {name = "gal:stone", param2 = 0, prob = 128}
	S3 = {name = "gal:stone", param2 = 0, prob = 96}
	D0 = {name = "gal:dirt", param2 = 0, prob = 254}


	gal_geology.schem_rock_01 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, __,
			__, __, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			__, S0, S0
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_02 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			__, S0, S0,
			__, __, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_03 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, S0,
			__, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			S0, S0, S0,
			__, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_04 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, S0,
			__, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			S0, S0, S0,
			__, S0, S0,
			__, __, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_05 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			__, S0, S0,
			__, __, S0,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			S0, S0, S0,
			S0, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}
	
	
	gal_geology.schem_rock_savanna_01 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			__, S0, S0,
			__, __, S0,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			S0, S0, S0,
			S0, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_savanna_02 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, S0,
			__, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			S0, S0, S0,
			__, S0, S0,
			__, __, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_savanna_03 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, S0,
			__, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, S0,

			S0, S0, S0,
			__, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_savanna_04 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			__, S0, S0,
			__, __, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			__, S0, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}

	gal_geology.schem_rock_savanna_05 = {
		size = {x = 3,y = 3,z = 3},
		data = {
			S0, S0, S0,
			S0, S0, __,
			__, __, __,

			S0, S0, S0,
			S0, S0, S0,
			S0, S0, __,

			S0, S0, S0,
			S0, S0, S0,
			__, S0, S0
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2}
		}
	}
	
	gal_geology.schem_erratic_01 = {
		size = {x = 11,y = 7,z = 5},
		data = {
			aa, aa, S0, S0, aa, S0, S0, S0, S0, aa, aa,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, aa, aa,
			S0, S0, S0, S0, aa, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			__, S0, S0, S0, S0, S0, S0, S0, S0, aa, aa,
			__, __, S0, S0, S0, S0, S0, S0, S0, aa, aa,

			aa, S0, S0, S0, S0, S0, S0, S0, aa, aa, aa,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, aa, aa,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, aa, aa,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, aa, aa,

			aa, S0, S0, S0, S0, S0, S0, S0, S0, aa, aa,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, aa,

			aa, S0, S0, S0, S0, S0, S0, S0, S0, aa, aa,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, aa,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			S0, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, aa, aa,

			aa, aa, aa, aa, S0, S0, S0, S0, aa, aa, aa,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, aa, 
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			aa, S0, S0, S0, S0, S0, S0, S0, S0, S0, S0,
			aa, S0, S0, S0, S0, S0, S0, S0, aa, aa, aa,
			__, S0, __, __, __, __, __, __, __, __, __
		},
		yslice_prob = {
			{prob = 254, ypos = 0},
			{prob = 254, ypos = 1},
			{prob = 254, ypos = 2},
			{prob = 254, ypos = 3},
			{prob = 254, ypos = 4},
			{prob = 254, ypos = 5},
			{prob = 254, ypos = 6}
		}
	}
	
	






	