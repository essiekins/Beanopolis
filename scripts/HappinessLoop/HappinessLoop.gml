
/*====BEANTOPOLIS MAIN HAPPINESS LOOP====*/

// Starting Values: Happiness begins at 100 because starting with a negative value would = game over
// Remember, Beans have demands. They subtract from Happiness by nature.

global.Recreation = 0; //fun
global.Purpose = 0; //employment
global.Health = 0; //Health
global.Happiness= 0; //Current happiness
global.maxHappiness = 100; //Start Happiness
global.Beans = 0; //starting beans

//==== OBJECT VALUES ====
/*Each object will add or substract from Happiness, these are the demands the Beans or 
or said Object requires in order to function */

//====HOME====

function O_Home(){
	global.Beans +=2; //+Beans default home pop
	global.Purpose -=2; // demands per bean
	global.Recreation -=2; //demands per bean
}
//====PARK====
function O_Park(){
	global.Recreation +=20; //Beans capacity
}

//====HOSPITAL====
function O_Hospital(){
	global.Health += 16; // 16 patients
	global.Purpose += 6; //8 available jobs
}

//Happiness is the sum of Recreation,Purpose and Health
function Happiness(){
	global.Happiness = (global.Recreation + global.Purpose + global.Health)/global.maxHealth;
	
	
	//if game started, use tile values show me the logic is active
	/*
	if (ev_game_start){
		global.happiness = global.maxHappiness - global.Happiness;
	 
	show_debug_message("ding ding ding!");
	}
	*/
}





