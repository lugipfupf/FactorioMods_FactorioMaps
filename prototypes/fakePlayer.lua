--Taken with small modifications from YARM.
local empty_animation = {
    filename = "__FactorioMaps__/graphics/nil.png",
    priority = "medium",
    width = 0,
    height = 0,
    direction_count = 18,
    frame_count = 1,
    animation_speed = 0,
    shift = {0,0},
    axially_symmetrical = false,
}

local empty_anim_level = {
    idle = empty_animation,
    idle_mask = empty_animation,
    idle_with_gun = empty_animation,
    idle_with_gun_mask = empty_animation,
    mining_with_hands = empty_animation,
    mining_with_hands_mask = empty_animation,
    mining_with_tool = empty_animation,
    mining_with_tool_mask = empty_animation,
    running_with_gun = empty_animation,
    running_with_gun_mask = empty_animation,
    running = empty_animation,
    running_mask = empty_animation,
}

local fakePlayer = table.deepcopy(data.raw.player.player)
fakePlayer.name = "FactorioMaps_remote-viewer"
fakePlayer.crafting_categories = {}
fakePlayer.mining_categories = {}
fakePlayer.healing_per_tick = 100
fakePlayer.inventory_size = 0
fakePlayer.build_distance = 0
fakePlayer.drop_item_distance = 0
fakePlayer.reach_distance = 0
fakePlayer.reach_resource_distance = 0
fakePlayer.mining_speed = 0
fakePlayer.running_speed = 0
fakePlayer.distance_per_frame = 0
fakePlayer.animations = {
    level1 = empty_anim_level,
    level2addon = empty_anim_level,
    level3addon = empty_anim_level,
}
fakePlayer.light = {{ intensity=0, size=0 }}
fakePlayer.flags = {"placeable-off-grid", "not-on-map", "not-repairable"}
fakePlayer.collision_mask = {"ground-tile"}

data:extend({ fakePlayer })

