minetest.register_craftitem("mobs_npc:arrow_fire", {
	description = "Fire Arrow",
	inventory_image = "pmobs_arrow_fire.png",
})

minetest.register_node("mobs_npc:arrow_fire_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},
			
			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"pmobs_arrow_fire.png", "pmobs_arrow_fire.png", "pmobs_arrow_fire_back.png", "pmobs_arrow_fire_front.png", "pmobs_arrow_fire_2.png", "pmobs_arrow_fire.png"},
	groups = {not_in_creative_inventory=1},
})

local pmobs_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"mobs_npc:arrow_fire_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}

pmobs_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "mobs_npc:arrow_fire_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 5
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, nil)
					self.object:remove()
				end
			else
				local damage = 5
				obj:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= "air" and node.name ~= "mobs_npc:light" then
			minetest.env:set_node(self.lastpos, {name="fire:basic_flame"})
			self.object:remove()
		end
		if math.floor(self.lastpos.x+0.5) ~= math.floor(pos.x+0.5) or math.floor(self.lastpos.y+0.5) ~= math.floor(pos.y+0.5) or math.floor(self.lastpos.z+0.5) ~= math.floor(pos.z+0.5) then
			if minetest.env:get_node(self.lastpos).name == "mobs_npc:light" then
				minetest.env:remove_node(self.lastpos)
			end
			if minetest.env:get_node(pos).name == "air" then
				minetest.env:set_node(pos, {name="mobs_npc:light"})
			end
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity("mobs_npc:arrow_fire_entity", pmobs_ARROW_ENTITY)

minetest.register_craft({
	output = 'mobs_npc:arrow_fire 4',
	recipe = {
		{'default:stick', 'default:stick', 'bucket:bucket_lava'},
	},
	replacements = {
		{"bucket:bucket_lava", "bucket:bucket_empty"}
	}
})

minetest.register_node("mobs_npc:light", {
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"pmobs_empty.png"},
	light_source = 10,
	selection_box = {
		type = "fixed",
		fixed = {
			{0,0,0,0,0,0}
		}
	},
	groups = {not_in_creative_inventory=1}
})

minetest.register_abm({
	nodenames = {"mobs_npc:light"},
	interval = 10,
	chance = 1,
	action = function(pos, node)
		minetest.env:remove_node(pos)
	end
})
