
/*
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
/// MONEY, CLOCK, AND WEATHER
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//var hours = floor(game_minutes / 60);
//var minutes = game_minutes mod 60;

var clock_text = string(hours) + ":";
/*

//DEBUG TIME #I'M RUSTY

// if the minutes are equal to or less then zero subtract hours and reset minutes back to sixty
if (minutes <= 0){
	hours -= 1;
	minutes = 59;
}

// if FPS Counting is greater then 0 then subtract by 1
if (fruitypersecond > 0){
	fruitypersecond -=1;
}

// if it's less then or equal to 0 then check if statement inside if statement then reset back to a second
if (fruitypersecond <= 0){
	//NEVER DO SHIT LIKE THIS I'M RUSTY THIS IS BAD DON'T OVER DO THIS TRICK IT'S ASS!!!
	//If minutes is greater then 0 then subtract by one, doing this just incase of errors so they don't happen
	if (minutes > 0){
		minutes += 1;
		if (minutes = 59)
		minutes -= 0;
	}
	fruitypersecond = 60;
}
*/

// trying to get it to switch fron minute 59 to minute 0, and hour 12 to hour 1
/*
if (minutes > 59){
	hours += 1;
	minutes = 0;
	if (hours > 12 && minute >= 59 ){
		hours = 1;
		minutes = 0;
	}
}
*/

//You can delete this it's just to check in the output menu to check if it's correct
//show_debug_message(string(hours) + "" + string(minutes));

/*
if (minutes < 10)
{
    clock_text += "0";
}

clock_text += string(minutes);

draw_text(20, 20, "Beanopolis");
draw_text(20, 45, "Money: $" + string(money));
draw_text(20, 70, "Time: " + clock_text);
draw_text(20, 95, "Weather: " + weather);

/// BUILD TOOLBOX
var box_w = 155;
var box_h = 170;
var box_x = gui_w - box_w - 15;
var box_y = 15;

draw_set_alpha(0.9);
draw_set_color(c_black);

draw_rectangle(
    box_x, box_y,
    box_x + box_w, box_y + box_h,
    false
);

draw_set_alpha(1);
draw_set_color(c_white);

draw_text(
    box_x + 10, box_y + 8,
    "BUILD TOOLBOX"
);

/// LOBBY BUTTON
draw_set_color(c_gray);

draw_rectangle(
    box_x + 5, box_y + 30,
    box_x + box_w - 5, box_y + 57,
    false
);

draw_set_color(c_white);

if (lobby_built)
{
    draw_text(
        box_x + 10, box_y + 36,
        "Lobby: Built"
    );
}
else
{
    draw_text(
        box_x + 10, box_y + 36,
        "Build Lobby"
    );
}

/// ROOM BUTTON
draw_set_color(c_gray);

draw_rectangle(
    box_x + 5, box_y + 62,
    box_x + box_w - 5, box_y + 89,
    false
);

draw_set_color(c_white);

draw_text(
    box_x + 10, box_y + 68,
    "Room: $" + string(room_cost)
);

/// STAIRS BUTTON
draw_set_color(c_gray);

draw_rectangle(
    box_x + 5, box_y + 94,
    box_x + box_w - 5, box_y + 121,
    false
);

draw_set_color(c_white);

draw_text(
    box_x + 10, box_y + 100,
    "Stairs: $" + string(stairs_cost)
);

/// HALLWAY BUTTON
draw_set_color(c_gray);

draw_rectangle(
    box_x + 5, box_y + 126,
    box_x + box_w - 5, box_y + 153,
    false
);

draw_set_color(c_white);

draw_text(
    box_x + 10, box_y + 132,
    "Hallway: $" + string(hallway_cost)
);



/// BUILD MODE STATUS
if (lobby_built)
{
    if (build_mode_active)
    {
        draw_text(
            20, 125,
            "Build Mode: ON (Press B to exit)"
        );
    }
    else
    {
        draw_text(
            20, 125,
            "Build Mode: OFF (Press B to build)"
        );
    }
}

/// STARTING MESSAGE
if (show_lobby_message)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_lime);
    draw_set_alpha(message_alpha);

    draw_text_transformed(
        gui_w / 2,
        gui_h / 2,
        "Place lobby first to get started!",
        2,
        2,
        0
    );
}

/// RESET DRAW SETTINGS
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

*/