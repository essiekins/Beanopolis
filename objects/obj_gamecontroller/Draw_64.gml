/// DRAW BUILDING PREVIEW
if (build_mode != "none" &&
    preview_sprite != -1 &&
    (build_mode == "lobby" || build_mode_active))
{
    var gx =
        round(mouse_x / grid_width) * grid_width;

    var gy =
        round(mouse_y / grid_height) * grid_height;

    draw_sprite_ext(
        preview_sprite,
        0,
        gx,
        gy,
        1,
        1, 
        0,
        c_white,
        0.5
    );
}

/// ROOM PLACEMENT GUIDE LINES
if (build_mode_active && preview_sprite != -1)
{
    // Draw guides only while placing a building room
    if (build_mode == "room")
    {
        draw_set_alpha(1);
        draw_set_color(c_fuchsia);

        // Guide lines above each downstairs room
        for (var i = 0; i < instance_number(obj_building_room); i++)
        {
            var room_inst = instance_find(obj_building_room, i);

            if (room_inst != noone)
            {
                draw_line_width(
                    room_inst.bbox_left,
                    room_inst.bbox_top - 2,
                    room_inst.bbox_right,
                    room_inst.bbox_top - 2,
                    4
                );
            }
        }

        // Guide lines above each hallway
        for (var j = 0; j < instance_number(obj_hallway); j++)
        {
            var hall_inst = instance_find(obj_hallway, j);

            if (hall_inst != noone)
            {
                draw_line_width(
                    hall_inst.bbox_left,
                    hall_inst.bbox_top - 2,
                    hall_inst.bbox_right,
                    hall_inst.bbox_top - 2,
                    4
                );
            }
        }

        // Guide lines above each staircase
        for (var k = 0; k < instance_number(obj_stairs); k++)
        {
            var stairs_inst = instance_find(obj_stairs, k);

            if (stairs_inst != noone)
            {
                draw_line_width(
                    stairs_inst.bbox_left,
                    stairs_inst.bbox_top - 2,
                    stairs_inst.bbox_right,
                    stairs_inst.bbox_top - 2,
                    4
                );
            }
        }
    }

    draw_set_alpha(1);
    draw_set_color(c_white);
}

