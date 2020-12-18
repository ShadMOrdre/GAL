--------------------------
-- Advanced Lightsabers --
--------------------------
-------- Ver 1.0 ---------

force_ability = {}
ability_cooldown = {}

minetest.register_privilege("force_abilities", {
	description = "Allows player touse Force Abilities",
	give_to_singleplayer = false
})

minetest.register_on_joinplayer(function(player)
    ability_cooldown[player:get_player_name()] = 0.0
    force_ability[player:get_player_name()] = {}
end)

minetest.register_on_leaveplayer(function(player)
    ability_cooldown[player:get_player_name()] = nil
    force_ability[player:get_player_name()] = nil
end)

-------------------
-- Menu Formspec --
-------------------

function adv_lightsabers.force_menu_form(player)
    local formspec = {
        "size[6,3.476]",
        "real_coordinates[true]",
        "button[0.5,2.3;1.6,0.8;jump;Force Jump]",
        "button[2.25,2.3;1.6,0.8;throw;Saber Throw]",
        "button[4,2.3;1.6,0.8;push;Force Push]",
        "button[0.5,1.3;1.6,0.8;choke;Force Choke]",
        "button[2.25,1.3;1.6,0.8;bond;Crystal Bond]",
        "button[4,1.3;1.6,0.8;dash;Force Dash]",
        "button[0.5,0.3;1.6,0.8;heal;Force Heal]",
        "button[2.25,0.3;1.6,0.8;bleed;Crystal Bleed]",
        "button[4,0.3;1.6,0.8;stun;Force Stun]"
    }
    return table.concat(formspec, "")
end

function adv_lightsabers.show_force_menu(player)
    minetest.show_formspec(player, "adv_lightsabers:force_menu", adv_lightsabers.force_menu_form(player))
end

--------------------------------------
-- Use raycast to get pointed_thing --
--------------------------------------

local function ray_pointed_thing(player)
    local dir = player:get_look_dir()
    local pos = player:get_pos()
    pos.y = pos.y + player:get_properties().eye_height or 1.625
    local dest = vector.add(pos, vector.multiply(dir, 20))
    local ray = minetest.raycast(pos, dest, true, false)
    for pointed_thing in ray do
        if pointed_thing.type == "object" then
            local pointedobject = pointed_thing.ref
            if pointedobject:is_player() and pointedobject:get_player_name() == player:get_player_name() then
                pointedobject = nil
            else
                return pointedobject
            end
        end
    end
end

---------------------
-- Force Abilities --
---------------------

function force_jump(player) -- Heightened Jump
    local playername = player:get_player_name()
    local cooldown = ability_cooldown[playername]
    local ability = force_ability[playername]
    if player:get_player_control().sneak == true and player:get_player_control().jump == true then
        player:add_player_velocity({x=0,y=8,z=0})
        ability_cooldown[playername] = 20
        minetest.after(ability_cooldown[playername],function(playername)
            ability_cooldown[playername] = 0.0
        end, playername)
    end
end

function force_push(player) -- Push entities a far distance
    local playername = player:get_player_name()
    local cooldown = ability_cooldown[playername]
    local ability = force_ability[playername]
    local pointedobject = ray_pointed_thing(player)
    if player:get_player_control().sneak == true and player:get_player_control().LMB == true then
        if pointedobject and pointedobject:is_player() then
            local dir = player:get_look_dir()
            pointedobject:add_player_velocity(vector.multiply(dir,25))
            ability_cooldown[playername] = 30
            minetest.after(ability_cooldown[playername],function(playername)
                ability_cooldown[playername] = 0.0
            end, playername)
        end
    end
end

function force_choke(player) -- Lift a Player off the ground and slowly choke them
    local playername = player:get_player_name()
    local cooldown = ability_cooldown[playername]
    local ability = force_ability[playername]
    local pointedobject = ray_pointed_thing(player)
    if player:get_player_control().sneak == true and player:get_player_control().LMB == true then
        if pointedobject and pointedobject:is_player() then
            pointedobject:add_player_velocity({x=0,y=5,z=0})
            pointedobject:set_physics_override(0.1,0.1,0.1,false,false,false)
            pointedobject:punch(player,1.0,{full_punch_interval = 0.1,damage_groups = {fleshy = 1}},nil)
            minetest.after(1,function()
                pointedobject:punch(player,1.0,{full_punch_interval = 0.1,damage_groups = {fleshy = 1}},nil)
            end)
            minetest.after(2,function()
                pointedobject:punch(player,1.0,{full_punch_interval = 0.1,damage_groups = {fleshy = 1}},nil)
            end)
            minetest.after(3,function()
                pointedobject:punch(player,1.0,{full_punch_interval = 0.1,damage_groups = {fleshy = 1}},nil)
            end)
            minetest.after(7.5,function()
                pointedobject:set_physics_override(1.0,1.0,1.0,true,true,false)
            end)
            ability_cooldown[playername] = 60
            minetest.after(ability_cooldown[playername],function(playername)
                ability_cooldown[playername] = 0.0
            end, playername)
        end
    end
end

function force_dash(player) -- Give yourself a short but quick burst of speed
    local playername = player:get_player_name()
    local cooldown = ability_cooldown[playername]
    local ability = force_ability[playername]
    local pointedobject = ray_pointed_thing(player)
    if player:get_player_control().sneak == true and player:get_player_control().up == true and player:get_player_control().down == true then
        local dir = player:get_look_dir()
        dir.y = dir.y * 0.1
        player:add_player_velocity(vector.multiply(dir,25))
        ability_cooldown[playername] = 20
        minetest.after(ability_cooldown[playername],function(playername)
            ability_cooldown[playername] = 0.0
        end, playername)
    end
end

function force_heal(player) -- Heal yourself by 4 hearts
    local playername = player:get_player_name()
    local cooldown = ability_cooldown[playername]
    local ability = force_ability[playername]
    local pointedobject = ray_pointed_thing(player)
    if player:get_player_control().sneak == true and player:get_player_control().RMB then
        local hp = player:get_hp()
        player:set_hp(hp + 8)
        ability_cooldown[playername] = 60
        minetest.after(ability_cooldown[playername],function(playername)
            ability_cooldown[playername] = 0.0
        end, playername)
    end
end

function force_stun(player) -- Freeze Players in place for 5 seconds
    local playername = player:get_player_name()
    local cooldown = ability_cooldown[playername]
    local ability = force_ability[playername]
    local pointedobject = ray_pointed_thing(player)
    if player:get_player_control().sneak == true and player:get_player_control().LMB == true then
        if pointedobject and pointedobject:is_player() then
            pointedobject:set_physics_override(-0.01,-0.01,-0.01,false,false,false)
            minetest.after(5,function()
                pointedobject:set_physics_override(1.0,1.0,1.0,true,true,false)
            end)
            ability_cooldown[playername] = 60
            minetest.after(ability_cooldown[playername],function(playername)
                ability_cooldown[playername] = 0.0
            end, playername)
        end
    end
end

----------
-- Menu --
----------

function adv_lightsabers.force_menu()
    for _,player in ipairs(minetest.get_connected_players()) do
        if minetest.check_player_privs(player:get_player_name(), {force_abilities = true}) then
            local playername = player:get_player_name()
            local cooldown = ability_cooldown[playername]
            local ability = force_ability[playername]
            if player:get_player_control().LMB == true and player:get_player_control().up == true and player:get_player_control().down == true then
                adv_lightsabers.show_force_menu(player:get_player_name())
            end
            if ability == "force_jump" and cooldown == 0.0 then
                force_jump(player)
            elseif ability == "force_push" and cooldown == 0.0 then
                force_push(player)
            elseif ability == "force_choke" and cooldown == 0.0 then
                force_choke(player)
            elseif ability == "force_dash" and cooldown == 0.0 then
                force_dash(player)
            elseif ability == "force_heal" and cooldown == 0.0 then
                force_heal(player)
            elseif ability == "force_stun" and cooldown == 0.0 then
                force_stun(player)
            end
        end
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "adv_lightsabers:force_menu" then
        return
    end
    if fields.jump then
        local playername = player:get_player_name()
        force_ability[playername] = "force_jump"
        minetest.chat_send_player(playername,"Force Ability:Force Jump")
    end
    if fields.throw then
        local playername = player:get_player_name()
        force_ability[playername] = "saber_throw"
        minetest.chat_send_player(playername,"Force Ability:Saber Throw")
    end
    if fields.push then
        local playername = player:get_player_name()
        force_ability[playername] = "force_push"
        minetest.chat_send_player(playername,"Force Ability:Force Push")
    end
    if fields.choke then
        local playername = player:get_player_name()
        force_ability[playername] = "force_choke"
        minetest.chat_send_player(playername,"Force Ability:Force Choke")
    end
    if fields.bond then
        local playername = player:get_player_name()
        if player:get_wielded_item():get_name() == "adv_lightsabers:kyber_crystal" then
            minetest.chat_send_player(playername,"You have bonded with your Kyber Crystal")
            if math.random(1,2) == 1 then
                player:set_wielded_item("adv_lightsabers:kyber_crystal_blue")
            else
                player:set_wielded_item("adv_lightsabers:kyber_crystal_green")
            end
        end
    end
    if fields.dash then
        local playername = player:get_player_name()
        force_ability[playername] = "force_dash"
        minetest.chat_send_player(playername,"Force Ability:Force Dash")
    end
    if fields.heal then
        local playername = player:get_player_name()
        force_ability[playername] = "force_heal"
        minetest.chat_send_player(playername,"Force Ability:Force Heal")
    end
    if fields.bleed then
        local playername = player:get_player_name()
        if player:get_wielded_item():get_name() == "adv_lightsabers:kyber_crystal_blue" or player:get_wielded_item():get_name() == "adv_lightsabers:kyber_crystal_green" then
            minetest.chat_send_player(playername,"You have bled your Kyber Crystal")
            player:set_wielded_item("adv_lightsabers:kyber_crystal_red")
        end
    end
    if fields.stun then
        local playername = player:get_player_name()
        force_ability[playername] = "force_stun"
        minetest.chat_send_player(playername,"Force Ability:Force Stun")
    end
end)

minetest.register_globalstep(function(dtime)
    adv_lightsabers.force_menu()
end)
