/// Toggle bulldoze

bulldoze_mode = !bulldoze_mode;

// Turn off regular building selection
if (bulldoze_mode)
{
    build_mode = "none";
    build_mode_active = false;
    preview_sprite = -1;
}