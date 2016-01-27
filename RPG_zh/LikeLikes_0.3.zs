//Functions, and global ('OnExit') script, to determine if Link is eaten by a LikeLike enemy, and remove his shield automatically 
//if the player does an F6-Continue to cheat out of it. 

//v0.3 by ZoriaRPG
//18th September, 2015

int LikeLikeAndYou[353]; //Possible combos x2, plus one for a general boolean state.

//Settings
const int REMOVE_SHIELD_BY_PERCENT = 1; //Set to '0' to always remove.
const int REMOVE_SHIELD_WHEN_EATEN_PERCENT_CHANCE = 25; //Set to a value for the % chance of losing a shield OnExit. 

void LikeLikePosition(int enemID){ //Stores the combo position of all LikeLike enemies, per frame.
	if ( NPCsOf(enemID) {
		for ( int q = 1; q <= Screen->NumNPCs(); q++ ) { //Parse the enemies, and look for LikeLikes.
			npc n = Screen->LoadNPC(q);
			if ( n->Type != enemID ) continue;
			if ( n->Type == enemID { //if we find one...
				int nx = GridX(n->X); //Store its X position on the grid.
				int ny = GridY(n->Y); //Store its Y position on the grid. 
				int cmb = ComboAt(nx,ny); // of the coordinatesDetermine the combo position.
				LikeLikeAndYou[cmb] = 1; //Set the array index matching this position so that we can compare it to Link's position. 
			}
		}
	}
}

int LinkPosition(){ //Stores the Combo Position under Link.
	int cmb = ComboAt(Link->X, Link->Y); //Get combo ID at link's position.
	for ( int q = 176; q < 176*2; q++ ) LikeLikeAndYou[q] = 0; //Clear the positions from last frame.
	LikeLikeAndYou[176+cmb] = 1; //Set the combo in the array to 1.
	
}

const int EVENT_LINK_EATEN_LIKELIKE = 176*2+1; //A constant for the boolean LinkIsEaten().

void LinkEaten(){
	for ( int q = 0; q < 176*2; q++ ) { //Check if the LikeLike position, and Link's Position Match
		if ( LikeLikeAndYou[q] + LikeLikeAndYou[q+176] == 2 ) SetLinkEaten(true); //if they match, Link is eaten.
	}
	SetLinkEaten(false); //If there are no matches, Link is NOT eaten.
}

int LinkIsEaten(){ //Returns if Link is eaten at present.
	return LikeLikeAndYou[EVENT_LINK_EATEN_LIKELIKE];
}
		
void SetLinkEaten(bool state){ //Sets if Link is, or is not eaten.
	if ( state ) LikeLikeAndYou[EVENT_LINK_EATEN_LIKELIKE] = 1; 
	else LikeLikeAndYou[EVENT_LINK_EATEN_LIKELIKE] = 0;
}

//Prevents F6-ing out of a Like Like eating your shield. 
global script onExit{
	void run(){
		if ( LinkIsEaten() && Link->Item[I_SHIELD2] ) { //if Link is eaten, has a magic shield, and tries to F65->Continue.
			if ( REMOVE_SHIELD_BY_PERCENT ) RemoveShieldChance(REMOVE_SHIELD_WHEN_EATEN_PERCENT_CHANCE); 
			//If the setting REMOVE_SHIELD_BY_PERCENT is NOT ZERO ('0')...
			//Remove shield if random number is less than or equal to REMOVE_SHIELD_WHEN_EATEN_PERCENT_CHANCE 
			else if ( !REMOVE_SHIELD_BY_PERCENT ) Link->Item[I_SHIELD2] = false; 
		}	//If the setting REMOVE_SHIELD_BY_PERCENT is ZERO ('0')...
			//Remove his shield. 
		
	}
}

void RemoveShieldChance(int percentThreshold){
	int chance = Rand(1,100);
	if ( chance <= percentThreshold ) Link->Item[I_SHIELD2] = false;
}

global script active{
	void run(){
		LinkPosition();
		LikeLikePosition(53);
		LinkEaten();
		Waitdraw();
		Waitframe();
	}
}

//!Eppy's Lps inspired this evil package. 