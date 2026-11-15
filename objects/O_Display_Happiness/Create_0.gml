global.Happiness = 100;

if(ev_game_start == true){
	global.maxHappiness = 100;
	global.Happiness = 0;
}
	else {
		if (O_Home){
			is_placed = true;
		}
		global.maxHappiness -= global.Happiness;
	}
	
		if (global.Happiness = -100){
			game_end();
		}

// make better game over later
