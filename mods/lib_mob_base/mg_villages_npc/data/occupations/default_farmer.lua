------------------------------------------------------
---- Farmer occupation for mg_villages_npc mod
---- By Zorman2000
------------------------------------------------------
---- This farmer implementation is still WIP. It is supposed to spawn
---- on buildings that have plots or there are fields nearby. Also, it
---- work on its crops during the morning, and sell some of them on the
---- afternoon.

local farming_plants = {
    "farming:cotton_1",
    "farming:cotton_2",
    "farming:cotton_3",
    "farming:cotton_4",
    "farming:cotton_5",
    "farming:cotton_6",
    "farming:cotton_7",
    "farming:cotton_8",
    "farming:wheat_1",
    "farming:wheat_2",
    "farming:wheat_3",
    "farming:wheat_4",
    "farming:wheat_5",
    "farming:wheat_6",
    "farming:wheat_7",
    "farming:wheat_8"
}

-- Special program to find the entrance to the fields of the farm_tiny buildings
npc.programs.register("mg_villages_npc:farmer:walk_to_field", function(self, args)
    local gate_found = false
    local target_pos = {}
    -- Get plotmarker
    local plotmarker_pos = npc.locations.get_by_type(self, npc.locations.data.other.home_plotmarker)
    -- There should always be just one plotmarker
    minetest.log("Got: "..dump(plotmarker_pos))
    plotmarker_pos = plotmarker_pos[1].pos
    -- Search building area for gates
    local meta = minetest.get_meta(plotmarker_pos)
    local start_pos = minetest.deserialize(meta:get_string("advanced_npc:area_pos1"))
    local end_pos = minetest.deserialize(meta:get_string("advanced_npc:area_pos2"))
    local gate_posns = minetest.find_nodes_in_area(start_pos, end_pos, {"cottages:gate_closed", "cottages:gate_opened"})
    -- If we found gates, iterate over them. Find a plant next to it will mark it as
    -- entrance
    if gate_posns and next(gate_posns) ~= nil then
        for i = 1, #gate_posns do
            local gate_node = minetest.get_node(gate_posns[i])
            -- Try to find a plant node behind it
            local new_pos = vector.add(gate_posns[i], minetest.facedir_to_dir(gate_node.param2))
            --minetest.log("Found pos: "..dump(new_pos))
            local node_behind = minetest.get_node(new_pos)
            --minetest.log("Node behind: "..dump(node_behind))
            for i = 1, #farming_plants do
                if node_behind.name == farming_plants[i] then
                    -- Found, break
                    target_pos = new_pos
                    gate_found = true
                    break
                end
            end
            if gate_found == true then break end
        end
    end

    if gate_found then
        -- Walk to position
        --minetest.log("Walking to pos: "..dump(target_pos))
        npc.programs.instr.execute(self, "advanced_npc:interrupt", {
            new_program = "advanced_npc:walk_to_pos",
            new_args = {
                end_pos = target_pos,
                walkable
                 = {"cottages:wagon_wheel"}
            },
            interrupt_options = {}
        })
        return
    end
end)

npc.programs.register("mg_villages_npc:farmer:dig_and_replant", function(self, args)
    --minetest.log("Got as argument: "..dump(args.pos))
    local pos = npc.programs.helper.get_pos_argument(self, args.pos, false)
    --minetest.log("Got from helper: "..dump(pos))
    if pos then
        -- Get node
        local node = minetest.get_node_or_nil(pos)
        if node then
            -- Calculate node name to plant
            local plant_name = string.split(node.name, "_")
            --minetest.log("Plant name: "..dump(plant_name))
            local new_plant_name = node.name
            if plant_name[1] and plant_name[2] then
                if plant_name[2] == "8" then
                    new_plant_name = plant_name[1].."_1"
                else
                    new_plant_name = plant_name[1].."_"..(plant_name[2] + 1)
                end
            end
            npc.log("DEBUG", "New plant_name: "..dump(new_plant_name))
            -- Decide whether to walk to the position or just rotate
            -- towards the plant if it's close enough
            local npc_pos = vector.round(self.object:getpos())
        
            -- Walk to position
            npc.programs.instr.execute(self, "advanced_npc:interrupt", {
                new_program = "advanced_npc:walk_to_pos",
                new_args = {
                    end_pos = {
                        place_type=npc.locations.data.calculated.target,
                        use_access_node=true
                    },
                    walkable = {}
                },
                interrupt_options = {}
            })
            
            -- Dig
            npc.exec.proc.enqueue(self, "advanced_npc:dig", {
                pos = pos,
                add_to_inventory = true,
                bypass_protection = true
            })
            -- Stand
            npc.exec.proc.enqueue(self, "advanced_npc:stand", {})
            -- Place new node
            npc.exec.proc.enqueue(self, "advanced_npc:place", {
                pos = pos,
                node = new_plant_name,
                bypass_protection = true,
                source = npc.programs.const.place_src.force_place
            })
            -- Stand
            npc.exec.proc.enqueue(self, "advanced_npc:stand", {})
        end
    end
end)

npc.programs.register("mg_villages_npc:farmer:random_walk", function(self, args)
    local start_pos = self.object:getpos()
    npc.programs.instr.execute(self, "advanced_npc:walk_step", {
        start_pos = start_pos,
        dir = "random_orthogonal"
    })
    npc.exec.proc.enqueue(self, "advanced_npc:stand", {})
end)

local farmer_def = {
    dialogues = {},
    textures = {
        {name="npc_male_farmer1.png", tags={"male", "adult", "mg_villages_npc:farmer"}},
        {name="npc_male_farmer2.png", tags={"male", "adult", "mg_villages_npc:farmer"}},
        {name="npc_male_farmer3.png", tags={"male", "adult", "mg_villages_npc:farmer"}},
        {name="npc_male_farmer4.png", tags={"male", "adult", "mg_villages_npc:farmer"}},
        {name="npc_male_farmer5.png", tags={"male", "adult", "mg_villages_npc:farmer"}},
        {name="npc_male_farmer6.png", tags={"male", "adult", "mg_villages_npc:farmer"}},
        {name="npc_female_farmer1.png", tags={"female", "adult", "mg_villages_npc:farmer"}},
    },
    building_types = {
        "farm_tiny", "farm_full"
    },
    surrounding_building_types = {
        {type="field", origin_building_types={"hut", "house", "lumberjack"}}
    },
    walkable_nodes = farming_plants,
    initial_inventory = {
        {name="farming:seed_cotton", count=6}
    },
    state_program = {
        name = "advanced_npc:wander",
        args = {
            acknowledge_nearby_objs = false,
            max_acknowledge_time = 10
        },
        interrupt_options = {}
    },
    schedules_entries = {
        -- schedule entry for 7 in the morning
        [6] = {
            [1] = {
                program_name = "advanced_npc:internal_property_change",
                arguments = {
                    property = npc.programs.internal_properties.change_trader_status,
                    args = {
                        status = npc.trade.NONE
                    }
                },
                interrupt_options = {}
            },
            [2] = {
                program_name = "schedules:default:wake_up",
                arguments = {},
                interrupt_options = {}
            },
            -- walk to home inside
            [3] = {
                program_name = "advanced_npc:walk_to_pos",
                arguments = {
                    end_pos = npc.locations.data.other.home_inside,
                    walkable = {}
                },
                interrupt_options = {},
                chance = 75
            },
            [4] = {
                program_name = "advanced_npc:idle",
                arguments = {
                    acknowledge_nearby_objs = true
                },
                interrupt_options = {},
                is_state_program = true
            }
        },
        [7] = {
            [1] =
            {
                program_name = "mg_villages_npc:farmer:walk_to_field",
                arguments = {},
                interrupt_options = {}
            },
            [2] =
            {
                program_name = "advanced_npc:node_query",
                arguments = {
                    range = 3,
                    nodes = farming_plants,
                    prefer_last_acted_upon_node = true,
                    walkable_nodes = farming_plants,
                    on_found_executables =
                    {
                        -- Actions for cotton - harvest and replant
                        ["farming:cotton_1"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:cotton_2"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:cotton_3"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:cotton_4"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:cotton_5"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:cotton_6"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:cotton_7"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:cotton_8"] = {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:wheat_1"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:wheat_2"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:wheat_3"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:wheat_4"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:wheat_5"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:wheat_6"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:wheat_7"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        },
                        ["farming:wheat_8"] =
                        {
                            [1] = {
                                program_name = "mg_villages_npc:farmer:dig_and_replant",
                                arguments = {
                                    pos = npc.locations.data.calculated.target
                                },
                                interrupt_options = {}
                            }
                        }
                    },
                    on_not_found_executables =
                    {
                        [1] = {
                            program_name = "mg_villages_npc:farmer:random_walk",
                            arguments = {},
                            interrupt_options = {}
                        }
                    }
                },
                interrupt_options = {},
                is_state_program = true
            }
        },
        -- schedule entry for 12 midday
        [13] = {
            -- walk to a sittable node
            [1] = {
                program_name = "advanced_npc:walk_to_pos",
                arguments = {
                    end_pos = {
                        place_category = npc.locations.data.categories.sittable,
                        place_type = npc.locations.data.sittable.primary,
                        use_access_node = true,
                        try_alternative_if_used = true,
                        mark_target_as_used = true
                    },
                    walkable = {"cottages:bench"}
                },
                chance = 75,
                interrupt_options = {},
            },
            -- sit on the node
            [2] = {
                program_name = "advanced_npc:use_sittable",
                arguments = {
                    pos = npc.locations.data.calculated.target,
                    action = npc.programs.const.node_ops.sittable.SIT
                },
                depends = {1},
                interrupt_options = {}
            },
            -- stay put
            [3] = {
                program_name = "advanced_npc:idle",
                arguments = {
                    acknowledge_nearby_objs = false,
                    wander_chance = 0
                },
                interrupt_options = {},
                is_state_program = true
            }
        },
        -- schedule entry for 1 in the afternoon
        [14] = {
            -- get up from sit
            [1] = {
                program_name = "advanced_npc:use_sittable",
                arguments = {
                    pos = npc.locations.data.calculated.target,
                    action = npc.programs.const.node_ops.sittable.GET_UP
                },
                interrupt_options = {}
            },
            -- give npc money to buy from player
            [2] = {
                program_name = "advanced_npc:internal_property_change",
                arguments = {
                    property = npc.programs.internal_properties.put_multiple_items,
                    args = {
                        itemlist = {
                            {name="default:iron_lump", random=true, min=2, max=4}
                        }
                    },
                },
                interrupt_options = {},
                chance = 75
            },
            -- Set trade list - what NPC will buy and what NPC will sell
            [3] = {
                program_name = "advanced_npc:internal_property_change",
                arguments = {
                    property = npc.schedule_properties.set_trade_list, args = {
                        items = {
                            [1] = {name="farming:seed_cotton", sell=5, keep=5},
                            [2] = {name="farming:cotton", sell=10},
                            [3] = {name="bucket:bucket_empty", buy=2},
                            [4] = {name="farming:hoe_stone", buy=2}
                        }
                    }
                },
                interrupt_options = {}
            },
            -- change trader status to "casual trader"
            [4] = {
                program_name = "advanced_npc:internal_property_change",
                arguments = {
                    property = npc.programs.internal_properties.change_trader_status,
                    args = {
                        status = npc.trade.TRADER
                    },
                },
                interrupt_options = {},
                chance = 75
            },
            [5] = {
                program_name = "advanced_npc:internal_property_change",
                arguments = {
                    property = npc.programs.internal_properties.can_receive_gifts,
                    args = {
                        can_receive_gifts = false
                    },
                },
                interrupt_options = {},
                depends = {3}
            },
            -- stay put
            [6] = {
                program_name = "advanced_npc:idle",
                arguments = {
                    acknowledge_nearby_objs = true,
                    max_acknowledge_time = 20,
                    wander_chance = 5
                },
                interrupt_options = {},
                is_state_program = true
            }
        },
--        [14] = {
--            -- Give NPC money to buy from player
--            [1] = {
--                property = npc.schedule_properties.put_multiple_items, args = {
--                    itemlist = {
--                        {name="default:iron_lump", random=true, min=2, max=4}
--                    }
--                },
--                chance = 50
--            },
--            -- Set trade list - what NPC will buy and what NPC will sell
--            [2] = {
--                property = npc.schedule_properties.set_trade_list, args = {
--                    items = {
--                        [1] = {name="farming:seed_cotton", sell=5, keep=5},
--                        [2] = {name="farming:cotton", sell=10},
--                        [3] = {name="bucket:bucket_empty", buy=2},
--                        [4] = {name="farming:hoe_stone", buy=2}
--                    }
--                }
--            },
--            -- Change trader status to "trader"
--            [3] = {
--                property = npc.schedule_properties.trader_status, args = {
--                    status = npc.trade.TRADER
--                },
--                chance = 90
--            },
--            [4] = {
--                property = npc.schedule_properties.can_receive_gifts, args = {
--                    can_receive_gifts = false
--                },
--                depends = {1}
--            },
--            -- Allow mobs_redo wandering
--            [5] = {action = npc.commands.cmd.FREEZE, args = {freeze = false}}
--        },
        -- Schedule entry for 6 in the evening
        -- schedule entry for 6 in the evening
        [18] = {
            -- change trader status to "none"
            [1] = {
                program_name = "advanced_npc:internal_property_change",
                arguments = {
                    {
                        property = npc.programs.internal_properties.change_trader_status,
                        args = {
                            status = npc.trade.NONE
                        },
                    },
                    {
                        property = npc.programs.internal_properties.can_receive_gifts,
                        args = {
                            can_receive_gifts = true
                        },
                    }

                },
                interrupt_options = {},
            },
            -- get inside home
            [2] = {
                program_name = "advanced_npc:walk_to_pos",
                arguments = {
                    end_pos = npc.locations.data.other.home_inside,
                    walkable = {}
                },
                interrupt_options = {},
            }
        },
        [22] = {
            [1] = {
                program_name = "advanced_npc:walk_to_pos",
                arguments = {
                    end_pos = {place_type=npc.locations.data.bed.primary, use_access_node=true},
                    walkable = {}
                },
                interrupt_options = {}
            },
            [2] = {
                program_name = "advanced_npc:use_bed",
                arguments = {
                    pos = npc.locations.data.bed.primary,
                    action = npc.programs.const.node_ops.beds.LAY
                },
                interrupt_options = {
                    allow_rightclick = false
                }
            },
            [3] = {
                program_name = "advanced_npc:idle",
                arguments = {
                    acknowledge_nearby_objs = false,
                    wander_chance = 0
                },
                interrupt_options = {
                    allow_rightclick = false
                },
                is_state_program = true
            }
        }
    }
}

-- Register occupation
npc.occupations.register_occupation("mg_villages_npc:farmer", farmer_def)
