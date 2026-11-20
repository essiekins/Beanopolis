
//==== HAPPINESS VALUE BAR DISPLAY ====
draw_healthbar(100, 50, 300, 20, global.Happiness/global.maxHappiness*100, $FF264360 & $FFFFFF, $FF4C4CFF & $FFFFFF, $FF59B259 & $FFFFFF, 0, (($FF264360>>24) != 0), (($FF24FF19>>24) != 0));

/// @description Execute Code
global.maxHappiness = 100;
//global.happiness = global.maxHappiness - global.Happiness;

//==== ALL VALUES TEXT DISPLAY ====
draw_text_transformed(150, 70, string("Happiness: ") + string
(global.Purpose + global.Health + global.Recreation/global.maxHappiness*100), 1, 1, 0);

draw_text_transformed(30, 100, string("Beans: ") + string
(global.Beans), 1, 1, 0);

draw_text_transformed(30, 115, string("Purpose: ") + string
(global.Purpose), 1, 1, 0);

draw_text_transformed(30, 130, string("Health: ") + string
(global.Health), 1, 1, 0);

draw_text_transformed(30, 145, string("Recreation: ") + string
(global.Recreation), 1, 1, 0);

// Bulldoze Instructions 

if (instance_exists(obj_gamecontroller))
{
    var controller = instance_find(obj_gamecontroller, 0);

    if (controller.bulldoze_mode)
    {
        draw_set_color(c_red);
        draw_text(30, 165, "Bulldoze: ON - Click a building");
    }
    else
    {
        draw_set_color(c_white);
        draw_text(30, 165, "Press D: Toggle Bulldoze");
    }
}

draw_set_color(c_white);




