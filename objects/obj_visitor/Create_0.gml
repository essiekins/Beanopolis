
// RANDOM VISITOR APPEARANCE
if (random(1) < 0.5) {
    sprite_index = male_bean;
} else {
    sprite_index = female_bean;
}

image_index = 0;
image_speed = 1;
image_alpha = 1;
image_xscale = 1;
image_yscale = 1;


/// VISITOR SETUP

// Room assignment
target_room = noone;
target_hallway = noone;
target_floor = 0;

// Movement
move_speed = 1;
ground_x = x;
ground_y = y;
target_x = x;
target_y = y;

// Visitor state
visitor_state = "to_room";

// Total time spent in the building, in seconds
building_stay_timer = irandom_range(45, 90);
building_stay_elapsed = 0;

// Room stay
room_visit_duration = irandom_range(5, 10);
mingle_timer = 0;

// Hallway hangout
hallway_chance = 0.5;
hallway_timer = 0;
hallway_duration = irandom_range(3, 8);
hallway_pause_timer = 0;
hallway_stand_duration = 0;
hallway_target_x = x;
hallway_target_y = y;
hallway_walking = false;
// Unique hallway movement
hallway_destination_set = false;
hallway_spacing = 12;


// VISITOR SIZE
image_xscale = 0.5;
image_yscale = 0.5;


/// Upstairs stair movement

has_climbed_stairs = false;
stairs_target = noone;

stairs_bottom_x = x;
stairs_bottom_y = y;
stairs_top_y = y - 128;

stairs_climb_speed = 1.5;



// Hopping animation
hop_height = 0;
hop_timer = 0;
hop_speed = 0.15;
hop_amount = 2;

// Choose a hallway if one exists
/// RANDOM HALLWAY SELECTION
var hallway_count = instance_number(obj_hallway);

if (hallway_count > 0 && random(1) < hallway_chance)
{
    var hallway_choice = irandom(hallway_count - 1);
    target_hallway = instance_find(obj_hallway, hallway_choice);
}
else
{
    target_hallway = noone;
}

