
/// =================================
/// UPDATE GAME CLOCK
/// =================================
clock_timer += delta_time / 1000000;

while (clock_timer >= seconds_per_minute)
{
    clock_timer -= seconds_per_minute;
    game_minutes += 1;

    if (game_minutes >= 24 * 60)
    {
        game_minutes = 0;
    }
}


/// =================================
/// UPDATE WEATHER
/// =================================
weather_timer += delta_time / 1000000;

if (weather_timer >= 30)
{
    weather_timer = 0;

    var weather_roll = irandom(2);

    if (weather_roll == 0) weather = "Sunny";
    else if (weather_roll == 1) weather = "Cloudy";
    else weather = "Rainy";
}


/// =================================
/// COUNT GROUND-FLOOR ROOMS
/// =================================
var ground_room_count = 0;

for (var i = 0; i < instance_number(obj_building_room); i++)
{
    var room_inst = instance_find(obj_building_room, i);

    if (room_inst.floor_level == 0)
    {
        ground_room_count += 1;
    }
}


/// =================================
/// TOGGLE BUILD MODE WITH B
/// =================================
if (lobby_built && keyboard_check_pressed(ord("B")))
{
    build_mode_active = !build_mode_active;

    if (!build_mode_active)
    {
        build_mode = "none";
        current_build_floor = 0;
    }
}


/// =================================
/// SWITCH BUILDING FLOOR WITH F
/// =================================
if (build_mode_active && keyboard_check_pressed(ord("F")))
{
    current_build_floor = 1 - current_build_floor;

    // Cancel the current selection when switching floors.
    // Select Room or Hallway again to continue building.
    build_mode = "none";
}


/// =================================
/// UPDATE BUILDING PREVIEW SPRITE
/// =================================
if (build_mode == "lobby")
{
    preview_sprite = spr_lobbyroom;
}
else if (build_mode == "room")
{
    preview_sprite = spr_building_room;
}
else if (build_mode == "stairs")
{
    preview_sprite = spr_stairs;
}
else if (build_mode == "hallway")
{
    preview_sprite = spr_hallway;
}
else
{
    preview_sprite = -1;
}


/// =================================
/// TOOLBOX POSITION
/// =================================
var gui_w = display_get_gui_width();

var box_w = 155;
var box_x = gui_w - box_w - 15;
var box_y = 15;

var gui_mx = device_mouse_x_to_gui(0);
var gui_my = device_mouse_y_to_gui(0);

var over_toolbox =
    gui_mx >= box_x &&
    gui_mx <= box_x + box_w &&
    gui_my >= box_y &&
    gui_my <= box_y + 155;


/// =================================
/// HANDLE MOUSE CLICKS
/// =================================
if (mouse_check_button_pressed(mb_left))
{
    // BUTTON CLICKS
    if (over_toolbox)
    {
        // LOBBY BUTTON
        if (gui_my >= box_y + 30 &&
            gui_my <= box_y + 57)
        {
            if (!lobby_built)
            {
                build_mode = "lobby";
            }
        }

        // ROOM BUTTON
        else if (gui_my >= box_y + 62 &&
                 gui_my <= box_y + 89)
        {
            if (lobby_built &&
                instance_number(obj_hallway) > 0 &&
                build_mode_active &&
                money >= room_cost)
            {
                build_mode = "room";
            }
        }

        // STAIRS BUTTON
        else if (gui_my >= box_y + 94 &&
                 gui_my <= box_y + 121)
        {
            if (lobby_built &&
                build_mode_active &&
                money >= stairs_cost &&
                ground_room_count >= required_ground_rooms &&
                instance_number(obj_hallway) > 0)
            {
                // Stairs are placed from the ground floor.
                current_build_floor = 0;
                build_mode = "stairs";
            }
        }

        // HALLWAY BUTTON
        else if (gui_my >= box_y + 126 &&
                 gui_my <= box_y + 153)
        {
            if (lobby_built &&
                build_mode_active &&
                money >= hallway_cost)
            {
                build_mode = "hallway";
            }
        }
    }

    // BUILDING PLACEMENT
    else if (build_mode != "none" &&
             (build_mode == "lobby" || build_mode_active))
    {
        var build_x = round(mouse_x / grid_width) * grid_width;
        var build_y = round(mouse_y / grid_height) * grid_height;

        var place_sprite = -1;

        if (build_mode == "lobby") place_sprite = spr_lobbyroom;
        else if (build_mode == "room") place_sprite = spr_building_room;
        else if (build_mode == "stairs") place_sprite = spr_stairs;
        else if (build_mode == "hallway") place_sprite = spr_hallway;


        /// =================================
        /// ALIGN SECOND-FLOOR ROOMS/HALLWAYS
        /// =================================
        var support_found = false;

        if (current_build_floor == 1 &&
            (build_mode == "room" || build_mode == "hallway"))
        {
            // Look for a downstairs room beneath the mouse.
            for (var s = 0;
                 s < instance_number(obj_building_room);
                 s++)
            {
                var support_room = instance_find(obj_building_room, s);

                if (support_room.floor_level == 0 &&
                    build_x >= support_room.bbox_left &&
                    build_x <= support_room.bbox_right)
                {
                    build_y =
                        support_room.bbox_top
                        - sprite_get_bbox_bottom(place_sprite)
                        + sprite_get_yoffset(place_sprite);

                    support_found = true;
                    break;
                }
            }

            // If no room was found, look for a downstairs hallway.
            if (!support_found)
            {
                for (var h = 0;
                     h < instance_number(obj_hallway);
                     h++)
                {
                    var support_hall = instance_find(obj_hallway, h);

                    if (support_hall.floor_level == 0 &&
                        build_x >= support_hall.bbox_left &&
                        build_x <= support_hall.bbox_right)
                    {
                        build_y =
                            support_hall.bbox_top
                            - sprite_get_bbox_bottom(place_sprite)
                            + sprite_get_yoffset(place_sprite);

                        support_found = true;
                        break;
                    }
                }
            }
        }


        /// =================================
        /// FIND BUILDING BOUNDARIES
        /// =================================
        var place_left =
            build_x + sprite_get_bbox_left(place_sprite)
            - sprite_get_xoffset(place_sprite);

        var place_right =
            build_x + sprite_get_bbox_right(place_sprite)
            - sprite_get_xoffset(place_sprite);

        var place_top =
            build_y + sprite_get_bbox_top(place_sprite)
            - sprite_get_yoffset(place_sprite);

        var place_bottom =
            build_y + sprite_get_bbox_bottom(place_sprite)
            - sprite_get_yoffset(place_sprite);


        /// =================================
        /// CHECK FOR OVERLAPPING BUILDINGS
        /// =================================
        var occupied =
            collision_rectangle(
                place_left, place_top,
                place_right, place_bottom,
                obj_lobby, true, true
            ) != noone
            ||
            collision_rectangle(
                place_left, place_top,
                place_right, place_bottom,
                obj_building_room, true, true
            ) != noone
            ||
            collision_rectangle(
                place_left, place_top,
                place_right, place_bottom,
                obj_stairs, true, true
            ) != noone
            ||
            collision_rectangle(
                place_left, place_top,
                place_right, place_bottom,
                obj_hallway, true, true
            ) != noone;


        /// =================================
        /// CHECK BUILDING SUPPORT
        /// =================================
        var supported = abs(place_bottom - 730) <= grid_height;

        var total_lobbies = instance_number(obj_lobby);
        var total_rooms = instance_number(obj_building_room);
        var total_stairs = instance_number(obj_stairs);
        var total_hallways = instance_number(obj_hallway);

        var total_buildings =
            total_lobbies + total_rooms +
            total_stairs + total_hallways;

        for (var j = 0; j < total_buildings; j++)
        {
            var existing = noone;

            if (j < total_lobbies)
            {
                existing = instance_find(obj_lobby, j);
            }
            else if (j < total_lobbies + total_rooms)
            {
                existing = instance_find(
                    obj_building_room, j - total_lobbies
                );
            }
            else if (j < total_lobbies + total_rooms + total_stairs)
            {
                existing = instance_find(
                    obj_stairs,
                    j - total_lobbies - total_rooms
                );
            }
            else
            {
                existing = instance_find(
                    obj_hallway,
                    j - total_lobbies - total_rooms - total_stairs
                );
            }

            if (existing != noone)
            {
                var horizontal_overlap =
                    place_right > existing.bbox_left &&
                    place_left < existing.bbox_right;

                var vertical_overlap =
                    place_bottom > existing.bbox_top &&
                    place_top < existing.bbox_bottom;

                var on_top =
                    horizontal_overlap &&
                    abs(place_bottom - existing.bbox_top) <= grid_height;

                var beside =
                    vertical_overlap &&
                    (
                        abs(place_right - existing.bbox_left) <= grid_width ||
                        abs(place_left - existing.bbox_right) <= grid_width
                    );

                if (on_top || beside)
                {
                    supported = true;
                }
            }
        }

        var can_place = !occupied && supported;

        // Upstairs rooms and hallways must have a downstairs support.
        if (current_build_floor == 1 &&
            (build_mode == "room" || build_mode == "hallway") &&
            !support_found)
        {
            can_place = false;
        }


        /// =================================
        /// PLACE LOBBY
        /// =================================
        if (build_mode == "lobby" &&
            !lobby_built &&
            can_place)
        {
            instance_create_layer(
                build_x, build_y, "Instances", obj_lobby
            );

            lobby_built = true;
            build_mode = "none";
            show_lobby_message = false;
        }


        /// =================================
        /// PLACE ROOM
        /// =================================
        else if (build_mode == "room" &&
                 build_mode_active &&
                 lobby_built &&
                 instance_number(obj_hallway) > 0 &&
                 money >= room_cost &&
                 can_place)
        {
            var new_room = instance_create_layer(
                build_x, build_y, "Instances", obj_building_room
            );

            new_room.floor_level = current_build_floor;
            new_room.occupied = false;

            money -= room_cost;
        }


        /// =================================
        /// PLACE STAIRS
        /// =================================
        else if (build_mode == "stairs" &&
                 build_mode_active &&
                 lobby_built &&
                 ground_room_count >= required_ground_rooms &&
                 instance_number(obj_hallway) > 0 &&
                 money >= stairs_cost &&
                 can_place)
        {
            var new_stairs = instance_create_layer(
                build_x, build_y, "Instances", obj_stairs
            );

            money -= stairs_cost;
        }


        /// =================================
        /// PLACE HALLWAY
        /// =================================
        else if (build_mode == "hallway" &&
                 build_mode_active &&
                 lobby_built &&
                 money >= hallway_cost &&
                 can_place)
        {
            var new_hallway = instance_create_layer(
                build_x, build_y, "Instances", obj_hallway
            );

            new_hallway.floor_level = current_build_floor;

            money -= hallway_cost;
        }
    }
}


/// =================================
/// FADE STARTING MESSAGE
/// =================================
if (show_lobby_message)
{
    message_alpha += message_fade;

    if (message_alpha <= 0.2)
    {
        message_alpha = 0.2;
        message_fade = 0.02;
    }
    else if (message_alpha >= 1)
    {
        message_alpha = 1;
        message_fade = -0.02;
    }
}


/// =================================
/// HIDE MESSAGE AFTER LOBBY IS BUILT
/// =================================
if (lobby_built)
{
    show_lobby_message = false;
}


/// =================================
/// VISITOR ARRIVAL SYSTEM
/// GROUND-FLOOR ROOMS ONLY FOR NOW
/// =================================
if (lobby_built &&
    instance_number(obj_building_room) > 0)
{
    visitor_spawn_timer += delta_time / 1000000;

    if (visitor_spawn_timer >= visitor_spawn_interval)
    {
        var free_room = noone;

        for (var k = 0;
             k < instance_number(obj_building_room);
             k++)
        {
            var room_inst = instance_find(obj_building_room, k);

            if (!room_inst.occupied &&
                room_inst.floor_level == 0)
            {
                free_room = room_inst;
                break;
            }
        }

        var lobby_inst = instance_find(obj_lobby, 0);

        if (free_room != noone && lobby_inst != noone)
        {
            var new_visitor = instance_create_layer(
                lobby_inst.x,
                lobby_inst.y + 32,
                "Visitors",
                obj_visitor
            );

            new_visitor.target_room = free_room;
            new_visitor.target_floor = 0;

            free_room.occupied = true;
            money += visitor_payment;
        }

        visitor_spawn_timer = 0;
    }
}
else
{
    visitor_spawn_timer = 0;
}
