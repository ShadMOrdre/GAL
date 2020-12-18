-- Advanced NPC by Zorman2000
-- Based on original NPC by Tenplus1 

local S = mobs.intllib

-- Constants
a_npc.FEMALE = "female"
a_npc.MALE = "male"

a_npc.INVENTORY_ITEM_MAX_STACK = 99

a_npc.ANIMATION_STAND_START = 0
a_npc.ANIMATION_STAND_END = 79
a_npc.ANIMATION_SIT_START = 81
a_npc.ANIMATION_SIT_END = 160
a_npc.ANIMATION_LAY_START = 162
a_npc.ANIMATION_LAY_END = 166
a_npc.ANIMATION_WALK_START = 168
a_npc.ANIMATION_WALK_END = 187

a_npc.direction = {
  north = 0,
  east  = 1,
  south = 2,
  west  = 3
}

a_npc.action_state = {
  none = 0,
  executing = 1,
  interrupted = 2
}

---------------------------------------------------------------------------------------
-- General functions
---------------------------------------------------------------------------------------
-- Gets name of player or NPC
function a_npc.get_entity_name(entity)
  if entity:is_player() then
    return entity:get_player_name()
  else
    return entity:get_luaentity().nametag
  end
end

-- Returns the item "wielded" by player or NPC
-- TODO: Implement NPC
function a_npc.get_entity_wielded_item(entity)
  if entity:is_player() then
    return entity:get_wielded_item()
  end
end

---------------------------------------------------------------------------------------
-- Spawning functions
---------------------------------------------------------------------------------------
-- These functions are used at spawn time to determine several
-- random attributes for the NPC in case they are not already
-- defined. On a later phase, pre-defining many of the NPC values
-- will be allowed.

local function get_random_name(sex)
  local i = math.random(#a_npc.data.FIRST_NAMES[sex])
  return a_npc.data.FIRST_NAMES[sex][i]
end

local function initialize_inventory()
  return {
    [1] = "",  [2] = "",  [3] = "",  [4] = "",
    [5] = "",  [6] = "",  [7] = "",  [8] = "",
    [9] = "",  [10] = "", [11] = "", [12] = "",
    [13] = "", [14] = "", [15] = "", [16] = "",
  }
end

-- This function checks for "female" text on the texture name
local function is_female_texture(textures)
  for i = 1, #textures do
    if string.find(textures[i], "female") ~= nil then
      return true
    end
  end
  return false
end

-- Choose whether NPC can have relationships. Only 30% of NPCs cannot have relationships
local function can_have_relationships()
  local chance = math.random(1,10)
  return chance > 3
end

-- Choose a maximum of two items that the NPC will have at spawn time
-- These items are chosen from the favorite items list.
local function choose_spawn_items(self)
  local number_of_items_to_add = math.random(1, 2)
  local number_of_items = #a_npc.FAVORITE_ITEMS[self.sex].phase1
  
  for i = 1, number_of_items_to_add do
    a_npc.add_item_to_inventory(
       self,
       a_npc.FAVORITE_ITEMS[self.sex].phase1[math.random(1, number_of_items)].item, 
       math.random(1,5)
      )
  end
  -- Add currency to the items spawned with. Will add 5-10 tier 3
  -- currency items
  local currency_item_count = math.random(5, 10)
  a_npc.add_item_to_inventory(self, a_npc.trade.prices.currency.tier3.string, currency_item_count)

  -- For test
  a_npc.add_item_to_inventory(self, "gal:tree_default_trunk", 10)
  a_npc.add_item_to_inventory(self, "gal:stone_cobble", 10)
  a_npc.add_item_to_inventory(self, "gal:mineral_diamond", 2)
  a_npc.add_item_to_inventory(self, "gal:mineral_mese_crystal", 2)
  a_npc.add_item_to_inventory(self, "gal:flower_rose", 2)
  a_npc.add_item_to_inventory(self, "a_npc:marriage_ring", 2)
  a_npc.add_item_to_inventory(self, "gal:flower_geranium_blue", 2)
  a_npc.add_item_to_inventory(self, "mobs:meat", 2)
  a_npc.add_item_to_inventory(self, "mobs:leather", 2)
  a_npc.add_item_to_inventory(self, "lib_handtools:tool_sword_stone", 2)
  a_npc.add_item_to_inventory(self, "lib_handtools:tool_shovel_stone", 2)
  a_npc.add_item_to_inventory(self, "lib_handtools:tool_axe_stone", 2)

  --minetest.log("Initial inventory: "..dump(self.inventory))
end

-- Spawn function. Initializes all variables that the
-- NPC will have and choose random, starting values
function a_npc.initialize(entity, pos, is_lua_entity)

	minetest.log("[advanced_npc] INFO: Initializing NPC at "..minetest.pos_to_string(pos))

	-- Get variables
	local ent = entity
	if not is_lua_entity then
		ent = entity:get_luaentity()
	end

	ent.initialized = true

	-- Avoid NPC to be removed by mobs_redo API
	ent.remove_ok = false
  
	local t_texture, t_vsize, t_collision, t_gender, t_age, t_name = a_npc.random_appearence()
	local i_text = t_name .. " - " .. t_gender
	if t_age and t_age ~= nil then
		i_text = i_text .. " - " .. t_age
	end

	ent.textures = {t_texture[1], t_texture[2], t_texture[3]}
	ent.visual_size = t_vsize
	ent.collisionbox = {t_collision[1], t_collision[2], t_collision[3], t_collision[4], t_collision[5], t_collision[6]}
	ent.infotext = i_text

	ent.v_texture = {t_texture[1], t_texture[2], t_texture[3]}
	ent.v_vsize = t_vsize
	ent.v_colbox = {t_collision[1], t_collision[2], t_collision[3], t_collision[4], t_collision[5], t_collision[6]}
	ent.v_name = t_name
	ent.v_gender = t_gender
	ent.v_age = t_age

	-- Determine sex based on textures
	--if (is_female_texture(ent.base_texture)) then
	--	ent.sex = a_npc.FEMALE
	--else
	--	ent.sex = a_npc.MALE
	--end
	ent.sex = t_gender

	-- Set name
	--ent.nametag = get_random_name(ent.sex)
	ent.nametag = t_name

	-- Set ID
	ent.npc_id = tostring(math.random(1000, 9999))..":"..ent.nametag
  
	-- Initialize all gift data
	ent.gift_data = {
		-- Choose favorite items. Choose phase1 per default
		favorite_items = a_npc.relationships.select_random_favorite_items(ent.sex, "phase1"),
		-- Choose disliked items. Choose phase1 per default
		disliked_items = a_npc.relationships.select_random_disliked_items(ent.sex),
	}
  
	-- Flag that determines if NPC can have a relationship
	ent.can_have_relationship = can_have_relationships()

	-- Initialize relationships object
	ent.relationships = {}

	-- Determines if NPC is married or not
	ent.is_married_to = nil

	-- Initialize dialogues
	ent.dialogues = a_npc.conversation.select_random_dialogues_for_npc(ent.sex, 
                                                               "phase1",
                                                               ent.gift_data.favorite_items,
                                                               ent.gift_data.disliked_items)
  
  -- Declare NPC inventory
  ent.inventory = initialize_inventory()

  -- Choose items to spawn with
  choose_spawn_items(ent)

	-- Flags: generic booleans or functions that help drive functionality
	ent.flags = {}

	-- Declare trade data
	ent.trader_data = {
		-- Type of trader
		trader_status = a_npc.trade.get_random_trade_status(),
		-- Current buy offers
		buy_offers = {},
		-- Current sell offers
		sell_offers = {},
		-- Items to buy change timer
		change_offers_timer = 0,
		-- Items to buy change timer interval
		change_offers_timer_interval = 60,
		-- Trading list: a list of item names the trader is expected to trade in.
		-- It is mostly related to its occupation.
		-- If empty, the NPC will revert to casual trading
		-- If not, it will try to sell those that it have, and buy the ones it not.
		trade_list = {
			sell = {},
			buy = {},
			both = {}
		},
		-- Custom trade allows to specify more than one payment
		-- and a custom prompt (instead of the usual buy or sell prompts)
		custom_trades = {}
	}

  -- Initialize trading offers for NPC
  --a_npc.trade.generate_trade_offers_by_status(ent)
  -- if ent.trader_data.trader_status == a_npc.trade.CASUAL then
  --   select_casual_trade_offers(ent)
  -- end

  -- Actions data
  ent.actions = {
    -- The queue is a queue of actions to be performed on each interval
    queue = {},
    -- Current value of the action timer
    action_timer = 0,
    -- Determines the interval for each action in the action queue
    -- Default is 1. This can be changed via actions
    action_interval = 1,
    -- Avoid the execution of the action timer
    action_timer_lock = false,
    -- Defines the state of the current action
    current_action_state = a_npc.action_state.none,
    -- Store information about action on state before lock
    state_before_lock = {
      -- State of the mobs_redo API
      freeze = false,
      -- State of execution
      action_state = a_npc.action_state.none,
      -- Action executed while on lock
      interrupted_action = {}
    },
		-- Walking variables -- required for implementing accurate movement code
		walking = {
			-- Defines whether NPC is walking to specific position or not
			is_walking = false,
			-- Path that the NPC is following
			path = {},
			-- Target position the NPC is supposed to walk to in this step. NOTE: 
			-- This is NOT the end of the path, but the next position in the path
			-- relative to the last position
			target_pos = {}
		}
  }

  -- This flag is checked on every step. If it is true, the rest of 
  -- Mobs Redo API is not executed
  ent.freeze = nil

  -- This map will hold all the places for the NPC
  -- Map entries should be like: "bed" = {x=1, y=1, z=1}
  ent.places_map = {}

  -- Schedule data
  ent.schedules = {
    -- Flag to enable or disable the schedules functionality
    enabled = true, 
    -- Lock for when executing a schedule
    lock = false,
    -- An array of schedules, meant to be one per day at some point
    -- when calendars are implemented. Allows for only 7 schedules,
    -- one for each day of the week
    generic = {},
    -- An array of schedules, meant to be for specific dates in the 
    -- year. Can contain as many as possible. The keys will be strings
    -- in the format MM:DD
    date_based = {}
  }

  -- Temporary initialization of actions for testing
  local nodes = a_npc.places.find_node_nearby(ent.object:getpos(), {"cottages:bench"}, 20)

  --minetest.log("Self destination: "..minetest.pos_to_string(nodes[1]))

  --local path = pathfinder.find_path(ent.object:getpos(), nodes[1], 20, {})
  --minetest.log("Path to node: "..dump(path))
  --a_npc.add_action(ent, a_npc.actions.use_door, {self = ent, pos = nodes[1], action = a_npc.actions.door_action.OPEN})
  --a_npc.add_action(ent, a_npc.actions.stand, {self = ent})
  --a_npc.add_action(ent, a_npc.actions.stand, {self = ent})
  -- if nodes[1] ~= nil then
  --   a_npc.add_task(ent, a_npc.actions.walk_to_pos, {end_pos=nodes[1], walkable={}})
  --   a_npc.actions.use_furnace(ent, nodes[1], "default:cobble 5", false)
  --   --a_npc.add_action(ent, a_npc.actions.sit, {self = ent})
  --   -- a_npc.add_action(ent, a_npc.actions.lay, {self = ent})
  --   -- a_npc.add_action(ent, a_npc.actions.lay, {self = ent})
  --   -- a_npc.add_action(ent, a_npc.actions.lay, {self = ent})
  --   --a_npc.actions.use_sittable(ent, nodes[1], a_npc.actions.const.sittable.GET_UP)
  --   --a_npc.add_action(ent, a_npc.actions.set_interval, {self=ent, interval=10, freeze=true})
  --   a_npc.add_action(ent, a_npc.actions.freeze, {freeze = false})
  --end

  -- Dedicated trade test
  ent.trader_data.trade_list.both = {
    ["gal:tree_default_trunk"] = {},
    ["gal:stone_cobble"] = {},
    ["gal:tree_default_wood"] = {},
    ["gal:mineral_diamond"] = {},
    ["gal:mineral_mese_crystal"] = {},
    ["gal:flower_rose"] = {},
    ["a_npc:marriage_ring"] = {},
    ["gal:flower_geranium_blue"] = {},
    ["mobs:meat"] = {},
    ["mobs:leather"] = {},
    ["lib_handtools:tool_sword_stone"] = {},
    ["lib_handtools:tool_shovel_stone"] = {},
    ["lib_handtools:tool_axe_stone"] = {}
  }

  --a_npc.trade.generate_trade_offers_by_status(ent)

  -- Add a custom trade offer
  local offer1 = a_npc.trade.create_custom_sell_trade_offer("Do you want me to fix your steel sword?", "Fix steel sword", "Fix steel sword", "default:sword_steel", {"default:sword_steel", "default:iron_lump 5"})
  table.insert(ent.trader_data.custom_trades, offer1)
  local offer2 = a_npc.trade.create_custom_sell_trade_offer("Do you want me to fix your mese sword?", "Fix mese sword", "Fix mese sword", "default:sword_mese", {"default:sword_mese", "default:copper_lump 10"})
  table.insert(ent.trader_data.custom_trades, offer2)

  -- Add a simple schedule for testing
  a_npc.create_schedule(ent, a_npc.schedule_types.generic, 0)
  -- Add schedule entries
  local morning_actions = { 
    [1] = {task = a_npc.actions.cmd.WALK_TO_POS, args = {end_pos=nodes[1], walkable={}} } ,
    [2] = {task = a_npc.actions.cmd.USE_SITTABLE, args = {pos=nodes[1], action=a_npc.actions.const.sittable.SIT} }, 
    [3] = {action = a_npc.actions.cmd.FREEZE, args = {freeze = true}}
  }
  --a_npc.add_schedule_entry(ent, a_npc.schedule_types.generic, 0, 7, nil, morning_actions)
  --local afternoon_actions = { [1] = {action = a_npc.actions.stand, args = {}} }
  local afternoon_actions = {[1] = {task = a_npc.actions.cmd.USE_SITTABLE, args = {pos=nodes[1], action=a_npc.actions.const.sittable.GET_UP} } }
  --a_npc.add_schedule_entry(ent, a_npc.schedule_types.generic, 0, 9, nil, afternoon_actions)
  -- local night_actions = {action: a_npc.action, args: {}}
  -- a_npc.add_schedule_entry(self, a_npc.schedule_type.generic, 0, 19, check, actions)

  -- a_npc.add_action(ent, a_npc.action.stand, {self = ent})
  -- a_npc.add_action(ent, a_npc.action.stand, {self = ent})
  -- a_npc.add_action(ent, a_npc.action.walk_step, {self = ent, dir = a_npc.direction.east})
  -- a_npc.add_action(ent, a_npc.action.walk_step, {self = ent, dir = a_npc.direction.east})
  -- a_npc.add_action(ent, a_npc.action.walk_step, {self = ent, dir = a_npc.direction.east})
  -- a_npc.add_action(ent, a_npc.action.walk_step, {self = ent, dir = a_npc.direction.east})
  -- a_npc.add_action(ent, a_npc.action.walk_step, {self = ent, dir = a_npc.direction.east})
  -- a_npc.add_action(ent, a_npc.action.walk_step, {self = ent, dir = a_npc.direction.east})
  -- a_npc.add_action(ent, a_npc.action.sit, {self = ent})
  -- a_npc.add_action(ent, a_npc.action.rotate, {self = ent, dir = a_npc.direction.south})
  -- a_npc.add_action(ent, a_npc.action.lay, {self = ent})

  -- Temporary initialization of places
  -- local bed_nodes = a_npc.places.find_new_nearby(ent, a_npc.places.nodes.BEDS, 8)
  -- minetest.log("Number of bed nodes: "..dump(#bed_nodes))
  -- if #bed_nodes > 0 then
  --   a_npc.places.add_owned(ent, "bed1", a_npc.places.PLACE_TYPE.OWN_BED, bed_nodes[1])
  -- end

  --minetest.log(dump(ent))
  minetest.log("Successfully spawned NPC with name "..dump(ent.nametag))
  -- Refreshes entity
  ent.object:set_properties(ent)
end

---------------------------------------------------------------------------------------
-- Inventory functions
---------------------------------------------------------------------------------------
-- NPCs inventories are restrained to 16 slots.
-- Each slot can hold one item up to 99 count.

-- Utility function to get item name from a string
function a_npc.get_item_name(item_string)
  return ItemStack(item_string):get_name()
end

-- Utility function to get item count from a string
function a_npc.get_item_count(item_string)
  return ItemStack(item_string):get_count()
end

-- Add an item to inventory. Returns true if add successful
-- These function can be used to give items to other NPCs
-- given that the "self" variable can be any NPC
function a_npc.add_item_to_inventory(self, item_name, count)
  -- Check if NPC already has item
  local existing_item = a_npc.inventory_contains(self, item_name)
  if existing_item ~= nil and existing_item.item_string ~= nil then
    -- NPC already has item. Get count and see
    local existing_count = a_npc.get_item_count(existing_item.item_string)
    if (existing_count + count) < a_npc.INVENTORY_ITEM_MAX_STACK then
      -- Set item here
      self.inventory[existing_item.slot] = 
        a_npc.get_item_name(existing_item.item_string).." "..tostring(existing_count + count)
        return true
    else
      --Find next free slot
      for i = 1, #self.inventory do
        if self.inventory[i] == "" then
          -- Found slot, set item
          self.inventory[i] = 
            item_name.." "..tostring((existing_count + count) - a_npc.INVENTORY_ITEM_MAX_STACK)
          return true
        end
      end
      -- No free slot found
      return false
    end
  else
    -- Find a free slot
    for i = 1, #self.inventory do
      if self.inventory[i] == "" then
        -- Found slot, set item
        self.inventory[i] = item_name.." "..tostring(count)
        return true
      end
    end
    -- No empty slot found
    return false
  end
end

-- Same add method but with itemstring for convenience
function a_npc.add_item_to_inventory_itemstring(self, item_string)
  local item_name = a_npc.get_item_name(item_string)
  local item_count = a_npc.get_item_count(item_string)
  a_npc.add_item_to_inventory(self, item_name, item_count)
end

-- Checks if an item is contained in the inventory. Returns
-- the item string or nil if not found
function a_npc.inventory_contains(self, item_name)
  for key,value in pairs(self.inventory) do
    if value ~= "" and string.find(value, item_name) then
      return {slot=key, item_string=value}
    end
  end
  -- Item not found
  return nil
end

-- Removes the item from an NPC inventory and returns the item
-- with its count (as a string, e.g. "default:apple 2"). Returns
-- nil if unable to get the item.
function a_npc.take_item_from_inventory(self, item_name, count)
  local existing_item = a_npc.inventory_contains(self, item_name)
  if existing_item ~= nil then
    -- Found item
    local existing_count = a_npc.get_item_count(existing_item.item_string)
    local new_count = existing_count
    if existing_count - count  < 0 then
      -- Remove item first
      self.inventory[existing_item.slot] = ""
      -- TODO: Support for retrieving from next stack. Too complicated
      -- and honestly might be unecessary.
      return item_name.." "..tostring(new_count)
    else
      new_count = existing_count - count
      if new_count == 0 then
        self.inventory[existing_item.slot] = ""
      else
        self.inventory[existing_item.slot] = item_name.." "..new_count
      end
      return item_name.." "..tostring(count)
    end
  else
    -- Not able to take item because not found
    return nil
  end
end

-- Same take method but with itemstring for convenience
function a_npc.take_item_from_inventory_itemstring(self, item_string)
  local item_name = a_npc.get_item_name(item_string)
  local item_count = a_npc.get_item_count(item_string)
  a_npc.take_item_from_inventory(self, item_name, item_count)
end

---------------------------------------------------------------------------------------
-- Flag functionality
---------------------------------------------------------------------------------------
-- TODO: Consider removing them as they are pretty simple and straight forward.
-- Generic variables or function that help drive some functionality for the a_npc.
function a_npc.add_flag(self, flag_name, value)
  self.flags[flag_name] = value
end

function a_npc.update_flag(self, flag_name, value)
  self.flags[flag_name] = value
end

function a_npc.get_flag(self, flag_name)
  return self.flags[flag_name]
end

---------------------------------------------------------------------------------------
-- Dialogue functionality
---------------------------------------------------------------------------------------
function a_npc.start_dialogue(self, clicker, show_married_dialogue)

  -- Call dialogue function as normal
  a_npc.conversation.start_dialogue(self, clicker, show_married_dialogue)

  -- Check and update relationship if needed
  a_npc.relationships.dialogue_relationship_update(self, clicker)

end

---------------------------------------------------------------------------------------
-- Action functionality
---------------------------------------------------------------------------------------
-- This function adds a function to the action queue.
-- Actions should be added in strict order for tasks to work as expected.
function a_npc.add_action(self, action, arguments)
  local action_entry = {action=action, args=arguments, is_task=false}
  table.insert(self.actions.queue, action_entry)
end

-- This function adds task actions in-place, as opposed to
-- at the end of the queue. This allows for continued order
function a_npc.add_task(self, task, args)
  local action_entry = {action=task, args=args, is_task=true}
  table.insert(self.actions.queue, action_entry)
end

-- This function removes the first action in the action queue
-- and then executes it
function a_npc.execute_action(self)
  -- Check if an action was interrupted
  if self.actions.current_action_state == a_npc.action_state.interrupted then
    minetest.log("[advanced_npc] DEBUG Re-inserting interrupted action for NPC: '"..dump(self.nametag).."': "..dump(self.actions.state_before_lock.interrupted_action))
    -- Insert into queue the interrupted action
    table.insert(self.actions.queue, 1, self.actions.state_before_lock.interrupted_action)
    -- Clear the action
    self.actions.state_before_lock.interrupted_action = {}
    -- Clear the position
    self.actions.state_before_lock.pos = {}
  end
  local result = nil
  if table.getn(self.actions.queue) == 0 then
    -- Set state to none
    self.actions.current_action_state = a_npc.action_state.none
    -- Keep state the same if there are no more actions in actions queue
    return self.freeze
  end
  local action_obj = self.actions.queue[1]
  if action_obj.action == nil then
    return
  end
  -- If the entry is a task, then push all this new operations in
  -- stack fashion
  if action_obj.is_task == true then
    minetest.log("[advanced_npc] DEBUG Executing task for NPC '"..dump(self.nametag).."': "..dump(action_obj))
    -- Backup current queue
    local backup_queue = self.actions.queue
    -- Remove this "task" action from queue
    table.remove(self.actions.queue, 1)
    -- Clear queue
    self.actions.queue = {}
    -- Now, execute the task with its arguments
    result = a_npc.actions.execute(self, action_obj.action, action_obj.args)
    --result = action_obj.action(self, action_obj.args)
    -- After all new actions has been added by task, add the previously
    -- queued actions back
    for i = 1, #backup_queue do
      table.insert(self.actions.queue, backup_queue[i])
    end
  else
    minetest.log("[advanced_npc] DEBUG Executing action for NPC '"..dump(self.nametag).."': "..dump(action_obj))
    -- Store the action that is being executed
    self.actions.state_before_lock.interrupted_action = action_obj
    -- Store current position
    self.actions.state_before_lock.pos = self.object:getpos()
    -- Execute action as normal
    result = a_npc.actions.execute(self, action_obj.action, action_obj.args)
    --result = action_obj.action(self, action_obj.args)
    -- Remove task
    table.remove(self.actions.queue, 1)
    -- Set state
    self.actions.current_action_state = a_npc.action_state.executing
  end
  return result
end

function a_npc.lock_actions(self)

  -- Avoid re-locking if already locked
  if self.actions.action_timer_lock == true then
    return
  end

  local pos = self.object:getpos()

  if self.freeze == false then
    -- Round current pos to avoid the NPC being stopped on positions
    -- where later on can't walk to the correct positions
    -- Choose which position is to be taken as start position
    if self.actions.state_before_lock.pos ~= {} then
      pos = vector.round(self.actions.state_before_lock.pos)
    else
      pos = vector.round(self.object:getpos())
    end
    pos.y = self.object:getpos().y
  end
  -- Stop NPC
  a_npc.actions.execute(self, a_npc.actions.cmd.STAND, {pos=pos})
  -- Avoid all timer execution
  self.actions.action_timer_lock = true
  -- Reset timer so that it has some time after interaction is done
  self.actions.action_timer = 0
  -- Check if there are is an action executing
  if self.actions.current_action_state == a_npc.action_state.executing 
    and self.freeze == false then
    -- Store the current action state
    self.actions.state_before_lock.action_state = self.actions.current_action_state
    -- Set current action state to interrupted
    self.actions.current_action_state = a_npc.action_state.interrupted
  end
  -- Store the current freeze variable
  self.actions.state_before_lock.freeze = self.freeze
  -- Freeze mobs_redo API
  self.freeze = false

  minetest.log("Locking")
end

function a_npc.unlock_actions(self)
  -- Allow timers to execute
  self.actions.action_timer_lock = false
  -- Restore the value of self.freeze
  self.freeze = self.actions.state_before_lock.freeze
  
  if table.getn(self.actions.queue) == 0 then
    -- Allow mobs_redo API to execute since action queue is empty
    self.freeze = true
  end

  minetest.log("Unlocked")
end

---------------------------------------------------------------------------------------
-- Schedule functionality
---------------------------------------------------------------------------------------
-- Schedules allow the NPC to do different things depending on the time of the day.
-- The time of the day is in 24 hours and is consistent with the Minetest Game 
-- /time command. Hours will be written as numbers: 1 for 1:00, 13 for 13:00 or 1:00 PM
-- The API is as following: a schedule can be created for a specific date or for a
-- day of the week. A date is a string in the format MM:DD
a_npc.schedule_types = {
  ["generic"] = "generic",
  ["date_based"] = "date_based"
}

local function get_time_in_hours() 
  return minetest.get_timeofday() * 24
end

-- Create a schedule on a a_npc.
-- Schedule types:
--  - Generic: Returns nil if there are already
--    seven schedules, one for each day of the
--    week or if the schedule attempting to add
--    already exists. The date parameter is the 
--    day of the week it represents as follows:
--      - 1: Monday
--      - 2: Tuesday
--      - 3: Wednesday
--      - 4: Thursday
--      - 5: Friday
--      - 6: Saturday
--      - 7: Sunday
--  - Date-based: The date parameter should be a
--    string of the format "MM:DD". If it already
--    exists, function retuns nil
function a_npc.create_schedule(self, schedule_type, date)
  if schedule_type == a_npc.schedule_types.generic then
    -- Check that there are no more than 7 schedules
    if #self.schedules.generic == 7 then
      -- Unable to add schedule
      return nil
    elseif #self.schedules.generic < 7 then
      -- Check schedule doesn't exists already
      if self.schedules.generic[date] == nil then
        -- Add schedule
        self.schedules.generic[date] = {}
      else
        -- Schedule already present
        return nil
      end
    end
  elseif schedule_type == a_npc.schedule_types.date then
    -- Check schedule doesn't exists already
    if self.schedules.date_based[date] == nil then
      -- Add schedule 
      self.schedules.date_based[date] = {}
    else
      -- Schedule already present
      return nil
    end
  end
end

function a_npc.delete_schedule(self, schedule_type, date)
  -- Delete schedule by setting entry to nil
  self.schedules[schedule_type][date] = nil
end

-- Schedule entries API
-- Allows to add, get, update and delete entries from each
-- schedule. Attempts to be as safe-fail as possible to avoid crashes. 

-- Actions is an array of actions and tasks that the NPC
-- will perform at the scheduled time on the scheduled date
function a_npc.add_schedule_entry(self, schedule_type, date, time, check, actions)
  -- Check that schedule for date exists
  if self.schedules[schedule_type][date] ~= nil then
    -- Add schedule entry
    if check == nil then
      self.schedules[schedule_type][date][time] = actions
    else
      self.schedules[schedule_type][date][time].check = check
    end
  else
    -- No schedule found, need to be created for date
    return nil
  end
end

function a_npc.get_schedule_entry(self, schedule_type, date, time)
  -- Check if schedule for date exists
  if self.schedules[schedule_type][date] ~= nil then
    -- Return schedule
    return self.schedules[schedule_type][date][time]
  else
    -- Schedule for date not found
    return nil
  end
end

function a_npc.update_schedule_entry(self, schedule_type, date, time, check, actions)
  -- Check schedule for date exists
  if self.schedules[schedule_type][date] ~= nil then
    -- Check that a schedule entry for that time exists
    if self.schedules[schedule_type][date][time] ~= nil then
      -- Set the new actions
      if check == nil then
        self.schedules[schedule_type][date][time] = actions
      else
        self.schedules[schedule_type][date][time].check = check
      end
    else
      -- Schedule not found for specified time
      return nil
    end
  else
    -- Schedule not found for date
    return nil
  end
end

function a_npc.delete_schedule_entry(self, schedule_type, date, time)
  -- Check schedule for date exists
  if self.schedules[schedule_type][date] ~= nil then
    -- Remove schedule entry by setting to nil
    self.schedules[schedule_type][date][time] = nil
  else
    -- Schedule not found for date
    return nil
  end
end

---------------------------------------------------------------------------------------
-- NPC Definition
---------------------------------------------------------------------------------------
mobs:register_mob("a_npc:npc", {
	type = "npc",
	passive = false,
	damage = 3,
	attack_type = "dogfight",
	attacks_monsters = true,
	group_attack = true,
	pathfinding = 1,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	visual = "mesh",
	mesh = "3d_armor_character_sfc.b3d",
	drawtype = "front",
	child_texture = {
		{"mobs_npc_baby_male1.png"}, -- derpy baby by AmirDerAssassine
	},
	makes_footstep_sound = true,
	sounds = {},
	-- Added walk chance
	walk_chance = 30,
	-- Added stepheight
	stepheight = 0.6,
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = "gal:tree_default_wood", chance = 1, min = 1, max = 3},
		{name = "gal:fruit_apple", chance = 2, min = 1, max = 2},
		{name = "lib_handtools:tool_axe_stone", chance = 5, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {"gal:food_bread", "mobs:meat", "gal:mineral_diamond"},
	view_range = 15,
	owner = "",
	order = "follow",
	--order = "stand",
	fear_height = 3,
	animation = {
		speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
	},

	on_rightclick = function(self, clicker)
	
		-- Rotate NPC toward its clicker
		a_npc.conversation.rotate_npc_to_player(self)
	
		-- Get information from clicker
			local item = clicker:get_wielded_item()
			local name = clicker:get_player_name()
	
		minetest.log(dump(self))
	
		-- Receive gift or start chat. If player has no item in hand
		-- then it is going to start chat directly
		if self.can_have_relationship and item:to_table() ~= nil then
			-- Get item name
			local item = minetest.registered_items[item:get_name()]
			local item_name = item.description
	
			-- Show dialogue to confirm that player is giving item as gift
			a_npc.conversation.show_yes_no_dialogue(self,
				"Do you want to give "..item_name.." to "..self.nametag.."?",
				a_npc.conversation.POSITIVE_GIFT_ANSWER_PREFIX..item_name,
				function()
					a_npc.relationships.receive_gift(self, clicker)
				end,
				a_npc.conversation.NEGATIVE_ANSWER_LABEL,
				function()
					a_npc.start_dialogue(self, clicker, true)
				end,
				name
				)
		else
			a_npc.start_dialogue(self, clicker, true)
		end
	
	end,

	do_custom = function(self, dtime)
		
		if self.initialized == nil then

			-- Initialize NPC if spawned using the spawn egg built in from
			-- mobs_redo. This functionality will be removed in the future in
			-- favor of a better manual spawning method with customization 
			minetest.log("[a_npc] WARNING: Initializing NPC from entity step. This message should only be appearing if an NPC is being spawned from inventory with egg!")

			a_npc.initialize(self, self.object:getpos(), true)

			return self.initialized

		else

			self.object:set_properties({textures={self.v_texture[1], self.v_texture[2], self.v_texture[3]}})
			self.object:set_properties({visual_size=self.visual_size})
			self.object:set_properties({collisionbox={self.v_colbox[1], self.v_colbox[2], self.v_colbox[3], self.v_colbox[4], self.v_colbox[5], self.v_colbox[6]}})
			self.object:set_properties({nametag=self.nametag})
			self.object:set_properties({infotext=self.infotext})

			self.tamed = false
			self.owner = nil

			-- NPC is initialized, check other variables
			-- Timer function for casual traders to reset their trade offers  
			self.trader_data.change_offers_timer = self.trader_data.change_offers_timer + dtime

		-- Check if time has come to change offers
		if self.trader_data.trader_status == a_npc.trade.CASUAL and self.trader_data.change_offers_timer >= self.trader_data.change_offers_timer_interval then

			-- Reset timer
			self.trader_data.change_offers_timer = 0

			-- Re-select casual trade offers
			a_npc.trade.generate_trade_offers_by_status(self)

		end
		
			-- Timer function for gifts
		for i = 1, #self.relationships do

			local relationship = self.relationships[i]

			-- Gift timer check
			if relationship.gift_timer_value < relationship.gift_interval then

				relationship.gift_timer_value = relationship.gift_timer_value + dtime

			elseif relationship.talk_timer_value < relationship.gift_interval then

				-- Relationship talk timer - only allows players to increase relationship
				-- by talking on the same intervals as gifts
				relationship.talk_timer_value = relationship.talk_timer_value + dtime

			else

				-- Relationship decrease timer
				if relationship.relationship_decrease_timer_value < relationship.relationship_decrease_interval then

					relationship.relationship_decrease_timer_value = 
					relationship.relationship_decrease_timer_value + dtime

				else

					-- Check if married to decrease half
					if relationship.phase == "phase6" then

						-- Avoid going below the marriage phase limit
						if (relationship.points - 0.5) >= a_npc.relationships.RELATIONSHIP_PHASE["phase5"].limit then

							relationship.points = relationship.points - 0.5

						end

					else

						relationship.points = relationship.points - 1

					end

					relationship.relationship_decrease_timer_value = 0

					--minetest.log(dump(self))

				end
			end
		end

		-- Action queue timer
		-- Check if actions and timers aren't locked
		if self.actions.action_timer_lock == false then

			-- Increment action timer
			self.actions.action_timer = self.actions.action_timer + dtime

			if self.actions.action_timer >= self.actions.action_interval then

				-- Reset action timer
				self.actions.action_timer = 0

				-- Check if NPC is walking
				if self.actions.walking.is_walking == true then

					local pos = self.actions.walking.target_pos
					self.object:moveto({x=pos.x, y=pos.y + 1, z=pos.z})

				end

				-- Execute action
				self.freeze = a_npc.execute_action(self)

				-- Check if there are still remaining actions in the queue
				if self.freeze == nil and table.getn(self.actions.queue) > 0 then

					self.freeze = false

				end
			end
		end
		
		-- Schedule timer
		-- Check if schedules are enabled
		if self.schedules.enabled == true then

			-- Get time of day
			local time = get_time_in_hours()

			-- Check if time is an hour
			if time % 1 < 0.1 and self.schedules.lock == false then

				-- Activate lock to avoid more than one entry to this code
				self.schedules.lock = true

				-- Get integer part of time
				time = (time) - (time % 1)

				-- Check if there is a schedule entry for this time
				-- Note: Currently only one schedule is supported, for day 0
				--minetest.log("Time: "..dump(time))
				local schedule = self.schedules.generic[0]

				if schedule ~= nil then

					-- Check if schedule for this time exists
					--minetest.log("Found default schedule")
					if schedule[time] ~= nil then

						-- Check if schedule has a check function
						if schedule[time].check ~= nil then

							-- Execute check function and then add corresponding action
							-- to action queue. This is for jobs.
							-- TODO: Need to implement

						else

							minetest.log("Adding actions to action queue")

							-- Add to action queue all actions on schedule
							for i = 1, #schedule[time] do

								if schedule[time][i].action == nil then

									-- Add task
		 							a_npc.add_task(self, schedule[time][i].task, schedule[time][i].args)

								else

									-- Add action
									a_npc.add_action(self, schedule[time][i].action, schedule[time][i].args)

								end

							end

							minetest.log("New action queue: "..dump(self.actions))

						end
					end
				end

			else

				-- Check if lock can be released
				if time % 1 > 0.1 then

					-- Release lock
					self.schedules.lock = false

				end
			end
		end
      
		return self.freeze

	end
end
})

-- Spawn
-- mobs:spawn({
--   name = "advanced_npc:npc",
--   nodes = {"advanced_npc:plotmarker_auto_spawner", "mg_villages:plotmarker"},
--   min_light = 3,
--   active_object_count = 1,
--   interval = 5,
--   chance = 1,
--   --max_height = 0,
--   on_spawn = a_npc.initialize
-- })

-------------------------------------------------------------------------
-- Item definitions
-------------------------------------------------------------------------

mobs:register_egg("a_npc:npc", S("A NPC"), "marriage_ring.png", 1)

-- compatibility
--mobs:alias_mob("mobs:npc", "advanced_npc:npc")

-- Marriage ring
minetest.register_craftitem("a_npc:marriage_ring", {
	description = S("Marriage Ring"),
	inventory_image = "marriage_ring.png",
})

-- Marriage ring craft recipe
minetest.register_craft({
	output = "a_npc:marriage_ring",
	recipe = { {"", "", ""},
             {"", "gal:mineral_diamond", ""},
             {"", "gal:metal_gold_ingot", ""} },
})
