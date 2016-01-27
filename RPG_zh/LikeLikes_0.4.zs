//Functions, and global ('OnExit') script, to determine if Link is eaten by a LikeLike enemy, and remove his shield automatically 
//if the player does an F6-Continue to cheat out of it. 

//v0.3 by ZoriaRPG
//18th September, 2015

int LikeLikeAndYou[353]; //Possible combos x2, plus one for a general boolean state.

//Settings
const int REMOVE_SHIELD_BY_PERCENT = 1; //Set to '0' to always remove.
const int REMOVE_SHIELD_WHEN_EATEN_PERCENT_CHANCE = 25; //Set to a value for the % chance of losing a shield OnExit. 
const int REMOVE_ITEMS_WHEN_EATEN = 0; 	//Set to '1' to remove other items. 
					//You must specify them in the function 'RemoveItemsWhenEaten()'

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

//Makes a random percentile chance check. if the result is less than, or equal to 'percentThreshold'
//then Link's shield will be eaten.
void RemoveShieldChance(int percentThreshold){
	int chance = Rand(1,100);
	if ( chance <= percentThreshold ) Link->Item[I_SHIELD2] = false;
}

//Makes a random percentile chance check. if the result is less than, or equal to 'percentThreshold'
//then the item specified by 'itm' will be removed.
void RemoveItemChance(int percentThreshold, int itm){
	int chance = Rand(1,100);
	if ( chance <= percentThreshold && Link->Item[itm] ) Link->Item[itm] = false;
}

//Removes items when eaten OnExit.
//Pass an array listing the items to remove as 'list'
//If 'random' is set to true, it will remove a number of items at random, specified by 'NumberOfItems'.
//Otherwise, it will remove a number of items **in order**, skipping over any that Link does not have. 
//If you want to remove a random number of items, set 'numberOfItems to '-1' and specify the min
//and max in 'minNumber' and 'maxNumber'.
//For a fixed number of items, set 'minNumber' and 'maxNumber' each to '-1'.

void RemoveItemsWhenEaten(int list, bool random, int numberOfItems, int minNumber, int maxNumber){
	int passes; //A variable to store the number of passes, so that if Link has lost
			//an item, the function will still remove a number of items equal to 'numberOfItems'
	int listsize = SizeOfArray(list);
	int passCount = 0; //A separate pass count, used for linear removal. 
	if ( numberOfitems > 0 ) {
			passes = numberOfItems; //We're using numberOfItems to specify the exact number of passes.
		}
	if ( nunberOfItems == -1 ) { //We're using a random number of items.
			passes = Rand(minNumber,maxNumber); 
	}
	if ( random ) {
		
		for ( ; passes > 0; passes-- ) {
				//Use the passes var, aso that if an item isn;t valid, we don;t waste a pass. 
			int pos = Rand(0,listsize); //Select a random position in the list.
			int it = list[pos]; //Set a var with that data of that index.
			if ( !Link->Item[it] ) {
				passes++;
				continue;
			}
			if ( Link->Item[it] ) Link->Item[it] = false;
		}
	}
	
	if ( !random ) {
		for ( ; passes > 0; passes-- ) {
			int pos = passCount; 
			int it - list[pos]
			if ( !Link->Item[it] ) {
				passes++;
				continue;
			}
			if ( Link->Item[it] ) {
				passCount++;
				Link->Item[it] = false;
			}
		}
	}
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