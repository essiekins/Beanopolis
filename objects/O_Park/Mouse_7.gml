// on release, tile should go back to opaque
if (!is_placed){
    image_alpha = 1.0;
    is_placed = true;
    // make sure it's placed on the right grid pos
    // unless it's 0,0 which means I never collided with any slot
    if (grid_x != 0 and grid_y != 0){
        x = grid_x;
        y = grid_y;
    } 
	//if not in slot, cancel tile placement/destroy held tile
	else{
        instance_destroy()
    }
	if (!is_placed == true){
		global.Recreation +=20; //Beans capacity
	}
}