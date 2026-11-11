
/// FIND THE LOBBY
var lobby_inst = instance_find(obj_lobby, 0);
var dt = delta_time / 1000000;

// Count the total building stay, except when leaving
if (visitor_state != "leaving") {
    building_stay_elapsed += dt;
}


/// STATE 1: WALK INTO THE HALLWAY
if (visitor_state == "to_hallway")
{
    if (target_hallway == noone ||
        !instance_exists(target_hallway))
    {
        visitor_state = "leaving";
        hallway_destination_set = false;
    }
    else
    {
        // Pick a destination only once
        if (!hallway_destination_set)
        {
            target_x = random_range(
                target_hallway.hall_left + 12,
                target_hallway.hall_right - 12
            );

            target_y = random_range(
                target_hallway.hall_top + 12,
                target_hallway.hall_bottom - 12
            );

            hallway_destination_set = true;
        }

        var dist = point_distance(
            ground_x, ground_y, target_x, target_y
        );

        if (dist > move_speed)
        {
            var dir = point_direction(
                ground_x, ground_y, target_x, target_y
            );

            ground_x += lengthdir_x(move_speed, dir);
            ground_y += lengthdir_y(move_speed, dir);
        }
        else
        {
            ground_x = target_x;
            ground_y = target_y;

            visitor_state = "hallway";
            hallway_destination_set = false;
            hallway_walking = false;
            hallway_pause_timer = 0;
            hallway_stand_duration = random_range(2, 5);
        }
    }
}


// =================================
// STATE 2: WANDER AND STAND IN HALLWAY
// =================================
else if (visitor_state == "hallway")
{
    if (target_hallway == noone ||
        !instance_exists(target_hallway))
    {
        visitor_state = "leaving";
    }
    else if (building_stay_elapsed >= building_stay_timer)
    {
        visitor_state = "leaving";
    }
    else if (hallway_walking)
    {
        target_x = hallway_target_x;
        target_y = hallway_target_y;

        var dist = point_distance(
            ground_x, ground_y, target_x, target_y
        );

        if (dist > move_speed)
        {
            var dir = point_direction(
                ground_x, ground_y, target_x, target_y
            );
            ground_x += lengthdir_x(move_speed, dir);
            ground_y += lengthdir_y(move_speed, dir);
        }
        else
        {
            ground_x = target_x;
            ground_y = target_y;

            hallway_walking = false;
            hallway_pause_timer = 0;
            hallway_stand_duration = random_range(2, 5);
        }
    }
    else
    {
        // Stand still while hanging out
        hop_height = 0;
        hallway_pause_timer += dt;

        if (hallway_pause_timer >= hallway_stand_duration)
        {
            hallway_pause_timer = 0;

            // Sometimes return to the assigned room
            if (random(1) < 0.30 &&
                target_room != noone &&
                instance_exists(target_room))
            {
                visitor_state = "to_room";
            }
            else
            {
               // Choose a new random hallway destination
hallway_target_x = random_range(
    target_hallway.hall_left + 12,
    target_hallway.hall_right - 12
);

hallway_target_y = random_range(
    target_hallway.hall_top + 12,
    target_hallway.hall_bottom - 12
);

// Avoid choosing the exact same spot
if (point_distance(
    ground_x, ground_y,
    hallway_target_x, hallway_target_y
) < hallway_spacing)
{
    hallway_target_x = clamp(
        hallway_target_x + hallway_spacing,
        target_hallway.hall_left + 12,
        target_hallway.hall_right - 12
    );
}

hallway_walking = true;
            }
        }
    }
}


/// STATE 3: WALK TO ASSIGNED ROOM

else if (visitor_state == "to_room")
{
    if (target_room == noone ||
        !instance_exists(target_room))
    {
        visitor_state = "leaving";
    }
    else
    {
        // Upstairs rooms require a stair climb first
        if (target_room.floor_level == 1 &&
            !has_climbed_stairs)
        {
            stairs_target = instance_find(obj_stairs, 0);

            if (stairs_target != noone)
            {
                // Calculate the bottom of the stairs
                stairs_bottom_x = stairs_target.x
                    + stairs_target.climb_x_offset;

                stairs_bottom_y = stairs_target.y
                    + stairs_target.climb_bottom_offset;

                // The top is directly above the bottom
                stairs_top_y = stairs_bottom_y
                    - stairs_target.floor_height;

                visitor_state = "to_stairs";
            }
            else
            {
                // No stairs available: do not enter the room
                visitor_state = "leaving";
            }
        }
        else
        {
            // Normal walk to the assigned room
            target_x = target_room.x
                + target_room.ground_offset_x;

            target_y = target_room.y
                + target_room.ground_offset_y;

            var dist = point_distance(
                ground_x, ground_y,
                target_x, target_y
            );

            if (dist > move_speed)
            {
                var dir = point_direction(
                    ground_x, ground_y,
                    target_x, target_y
                );

                ground_x += lengthdir_x(move_speed, dir);
                ground_y += lengthdir_y(move_speed, dir);
            }
            else
            {
                ground_x = target_x;
                ground_y = target_y;

                visitor_state = "mingle";
                room_visit_duration = random_range(5, 10);
                mingle_timer = 0;
                hop_timer = 0;
            }
        }
    }
}





/// STATE 3B: CLIMB STRAIGHT UP

else if (visitor_state == "climbing_stairs")
{
    if (stairs_target == noone ||
        !instance_exists(stairs_target))
    {
        visitor_state = "leaving";
    }
    else
    {
        // Keep X fixed; only change Y
        ground_x = stairs_bottom_x;

        if (ground_y > stairs_top_y)
        {
            ground_y = max(
                ground_y - stairs_climb_speed,
                stairs_top_y
            );
        }
        else
        {
            ground_y = stairs_top_y;

            has_climbed_stairs = true;

            // Now continue toward the upstairs room
            visitor_state = "to_room";
        }
    }
}


// =================================
// STATE 4: STAY IN ASSIGNED ROOM
// =================================
else if (visitor_state == "mingle")
{
    if (target_room == noone ||
        !instance_exists(target_room))
    {
        visitor_state = "leaving";
    }
    else
    {
        ground_x = target_room.x
            + target_room.ground_offset_x;
        ground_y = target_room.y
            + target_room.ground_offset_y;

        mingle_timer += dt;

        // Small hopping animation in the room
        hop_timer += hop_speed;
        hop_height = abs(sin(hop_timer)) * hop_amount;

        if (mingle_timer >= room_visit_duration)
        {
            hop_height = 0;

            if (building_stay_elapsed >= building_stay_timer)
            {
                visitor_state = "leaving";
            }
            else if (target_hallway != noone &&
                     instance_exists(target_hallway))
            {
                visitor_state = "return_hallway";
            }
            else
            {
                // No hallway: visit the room again
                visitor_state = "to_room";
            }
        }
    }
}

// =================================
// STATE 5: RETURN TO HALLWAY
// =================================
else if (visitor_state == "return_hallway")
{
    if (target_hallway == noone ||
        !instance_exists(target_hallway))
    {
        visitor_state = "to_room";
    }
    else
    {
        target_x = clamp(
            ground_x,
            target_hallway.hall_left + 8,
            target_hallway.hall_right - 8
        );

        target_y = clamp(
            ground_y,
            target_hallway.hall_top + 8,
            target_hallway.hall_bottom - 8
        );

        // If already inside the hallway, choose a fresh spot
        if (point_in_rectangle(
            ground_x, ground_y,
            target_hallway.hall_left,
            target_hallway.hall_top,
            target_hallway.hall_right,
            target_hallway.hall_bottom
        ))
        {
            target_x = random_range(
                target_hallway.hall_left + 8,
                target_hallway.hall_right - 8
            );
            target_y = random_range(
                target_hallway.hall_top + 8,
                target_hallway.hall_bottom - 8
            );
        }

        var dist = point_distance(
            ground_x, ground_y, target_x, target_y
        );

        if (dist > move_speed)
        {
            var dir = point_direction(
                ground_x, ground_y, target_x, target_y
            );
            ground_x += lengthdir_x(move_speed, dir);
            ground_y += lengthdir_y(move_speed, dir);
        }
        else
        {
            ground_x = target_x;
            ground_y = target_y;

            visitor_state = "hallway";
            hallway_walking = false;
            hallway_pause_timer = 0;
            hallway_stand_duration = random_range(2, 5);
        }
    }
}

// =================================
// STATE 6: CHECK OUT AT THE LOBBY
// =================================
else if (visitor_state == "leaving")
{
    hop_height = 0;

    if (lobby_inst != noone)
    {
        target_x = lobby_inst.x;
        target_y = lobby_inst.y + 32;

        var dist = point_distance(
            ground_x, ground_y, target_x, target_y
        );

        if (dist > move_speed)
        {
            var dir = point_direction(
                ground_x, ground_y, target_x, target_y
            );
            ground_x += lengthdir_x(move_speed, dir);
            ground_y += lengthdir_y(move_speed, dir);
        }
        else
        {
            ground_x = target_x;
            ground_y = target_y;

            if (target_room != noone &&
                instance_exists(target_room))
            {
                target_room.occupied = false;
            }

            instance_destroy();
        }
    }
    else
    {
        if (target_room != noone &&
            instance_exists(target_room))
        {
            target_room.occupied = false;
        }

        instance_destroy();
    }
}

// =================================
// UPDATE OBJECT POSITION
// =================================
x = ground_x;
y = ground_y;
