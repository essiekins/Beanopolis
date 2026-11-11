
/// Construction menu clicks

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (mouse_check_button_pressed(mb_left))
{
    // Clicked Lobby button
    if (mouse_y >= gui_h - 65 && mouse_y <= gui_h - 15
    && mouse_x >= 10 && mouse_x <= 130)
    {
        if (!lobby_built)
        {
            build_mode = "lobby";
        }
    }

    // Clicked Room button
    else if (mouse_y >= gui_h - 65 && mouse_y <= gui_h - 15
    && mouse_x >= 140 && mouse_x <= 260)
    {
        if (lobby_built && money >= room_cost)
        {
            build_mode = "room";
        }
    }

    // Clicked Stairs button
    else if (mouse_y >= gui_h - 65 && mouse_y <= gui_h - 15
    && mouse_x >= 270 && mouse_x <= 390)
    {
        if (lobby_built && money >= stairs_cost)
        {
            build_mode = "stairs";
        }
    }
}
