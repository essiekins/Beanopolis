
/// DRAW VISITOR SAFELY

// Only draw if this visitor has a valid sprite
if (sprite_index != -1)
{
    draw_sprite_ext(
        sprite_index,
        image_index,
        x + 8,
        y - hop_height,
        image_xscale,
        image_yscale,
        image_angle,
        image_blend,
        image_alpha
    );
}
