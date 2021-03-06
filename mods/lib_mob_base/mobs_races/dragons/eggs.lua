-- eggs from mobs_dragon --------------------------------------------------------------------------
	
local dragonpairs = {
	fire = {colour="red",nest="gal:liquid_lava_source"},
	lightning = {colour="black",nest="gal:stone_obsidian"},
	poison = {colour="green",nest="gal:cactus_green_column"},
	ice = {colour="black",nest="gal:ice"},
	great = {colour="great",nest=""},
}

local function egg_transform(pos, node, clicker, item, _)
	local wield_item = clicker:get_wielded_item():get_name()
	if wield_item == "mobs_races:dragon_gem" then
	
		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local corner_name
		for x1 = -1,1 do
			for z1 = -1,1 do
				p.x = pos.x + x1
				p.z = pos.z + z1
				local nestfloor_name = minetest.get_node(p).name

				if x1 == -1 and z1 == -1 then
					corner_name = minetest.get_node(p).name

				elseif x1 == 0 and z1 == 0 then -- special case in centre
					-- must be obsidian
					if nestfloor_name ~= "default:obsidian" then return end

				else
					-- else ring must all be of the same type
					if nestfloor_name ~= corner_name then return end
				end
			end
		end
		
		local dragon_type
		for element,details in pairs(dragonpairs) do
			if corner_name == details.nest then
				dragon_type = element
				break
			end
		end
		
		minetest.chat_send_player(clicker:get_player_name()," ... something seems to be happening .... come back later?")
		
		minetest.after(mobs_races.eggtimer,
			function(pos, dragon, pname)
				minetest.set_node(pos, {name="mobs_races:dragon_egg_"..dragon_type})
			end,
			pos
		)
		
		item:take_item()
	end
end

local function egghatch(pos, node, clicker, item, _)
	local wield_item = clicker:get_wielded_item():get_name()
	local eggnode = minetest.get_node(pos).name
	
	for nature,details in pairs(dragonpairs) do
		if ( wield_item == "mobs_races:dragon_gem_"..nature and eggnode:find(nature) ) or
		   ( wield_item == "mobs_races:dragon_gem" and eggnode == "mobs_races:dragon_egg_great" ) then -- special case... because inconsiderate/inconsistent naming
		   
		   	minetest.chat_send_player(clicker:get_player_name(), " ... it ... swallowed the gem...")
		   	
			minetest.after(mobs_races.eggtimer,
				function(pos, dragon, pname)
					local neweggnode = minetest.get_node(pos).name
					if eggnode ~= neweggnode then return end -- prevent infinite hatchings

					minetest.remove_node(pos)

					local thedragon = "mobs_races:dragon_"..details.colour
					if eggnode == "mobs_races:dragon_egg_great" then
						thedragon = "mobs_races:dragon_great"
					end

					local ent = minetest.add_entity(pos, thedragon)
					minetest.sound_play("dmobs_chirrup",{pos=pos,max_hear_distance=20})
					
					local obj = ent:get_luaentity()
					if eggnode ~= "mobs_races:dragon_egg_great" then
						ent:set_properties({
							textures = {"dmobs_dragon_young.png"},
							visual_size = {x=1, y=1},
						})
					end
					obj.tamed = true
					obj.owner = clicker:get_player_name()
				end,
				pos, clicker:get_player_name()
			)
			item:take_item()
			break
		end
	end -- for loop
end

-- Egg form dfinitions -----------------------------------------

local base_egg = { -- base template for all dragon eggs
	description = "Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3},
	--sounds = default.node_sound_leaves_defaults(),	
	sounds = gal.node_sound_leaves_defaults(),	
	on_rightclick = egg_transform,
}


minetest.register_node("mobs_races:egg", mobs_races.deepclone(base_egg) ) -- clone, to not affect the base template

base_egg.groups.not_in_creative_inventory=1
base_egg.on_rightclick = egghatch

base_egg.tiles = {"dmobs_egg1.png"}
minetest.register_node("mobs_races:dragon_egg_fire", mobs_races.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg2.png"}
minetest.register_node("mobs_races:dragon_egg_lightning", mobs_races.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg3.png"}
minetest.register_node("mobs_races:dragon_egg_poison", mobs_races.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg4.png"}
minetest.register_node("mobs_races:dragon_egg_ice", mobs_races.deepclone(base_egg) )

base_egg.groups.not_in_creative_inventory=nil
base_egg.tiles = {"default_sandstone.png"}
base_egg.description = "Great Dragon Egg"
minetest.register_node("mobs_races:dragon_egg_great", mobs_races.deepclone(base_egg) )
