/// GAME SETTINGS
money = 500;

build_mode = "none";
preview_sprite = -1;
build_mode_active = false;
lobby_built = false;

/// BUILDING COSTS
room_cost = 100;
stairs_cost = 50;

// FLOOR PROGRESSION
required_ground_rooms = 5;

/// PLACEMENT GRID
grid_width = 16;
grid_height = 16;

/// GAME CLOCK
game_minutes = 8 * 60;
clock_timer = 0;
seconds_per_minute = 0.5;

/// WEATHER
weather = "Sunny";
weather_timer = 0;

/// STARTING MESSAGE
show_lobby_message = true;
message_alpha = 1;
message_fade = -0.02;

// Visitor arrival settings
visitor_spawn_timer = 0;
visitor_spawn_interval = 8;
visitor_payment = 50;
/// VISITOR SETTINGS
visitor_spawn_timer = 0;
visitor_spawn_interval = 8; // Seconds between visitors
visitor_payment = 50;


// Hallway building settings
hallway_cost = 25;
hallway_object = obj_hallway;
hallway_sprite = spr_hallway;

/// FLOOR SETTINGS
current_build_floor = 0;
floor_height = 128;

occupied = false;

hours = floor(game_minutes / 60);
minutes = game_minutes mod 60;

//Follow frames per second, multiples of 60 depending on seconds!!!!
// 60 frames on your project = 1 second, 120 = 2 seconds
fruitypersecond = 60;

//Hi Marcelo =)