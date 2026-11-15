/// HALLWAY WALKABLE AREA

// Calculate the hallway boundaries from its sprite.
// Set the sprite origin to Top Left for this version.
hall_left = x;
hall_top = y;

hall_right = x + sprite_get_width(sprite_index);
hall_bottom = y + sprite_get_height(sprite_index);