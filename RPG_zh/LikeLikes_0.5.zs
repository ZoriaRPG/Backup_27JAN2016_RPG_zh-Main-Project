//Functions, and global ('OnExit') script, to determine if Link is eaten by a LikeLike enemy, and remove his shield automatically 
//if the player does an F6-Continue to cheat out of it. 

//v0.5 by ZoriaRPG
//17th September, 2015

/// Arrays
int LikeLikeAndYou[353]; //Possible combos x2, plus one for a general boolean state.
int EdibleItemList[]=	{ 8 }; //Fill in a list, if desired. 

/// Settings
const int REMOVE_SHIELD_BY_PERCENT = 1; //Set to '0' to always remove.
const int REMOVE_SHIELD_WHEN_EATEN_PERCENT_CHANCE = 25; //Set to a value for the % chance of losing a shield OnExit. 
const int REMOVE_ITEMS_WHEN_EATEN = 0; 	//Set to '1' to remove other items. 
					//You must specify them in the function 'RemoveItemsWhenEaten()'
	//The following two settings ar eonly valid uf REMOVE_ITEMS_WHEN_EATEN is enabled. 
const int REMOVE_ITEMS_BY_PERCENT = 1; //Set to '0; to always remove. 
const int REMOVE_ITEMS_WHEN_EATEN_PERCENT_CHANCE = 20; //Set to percentage chance of lising an item from a list, OnExit. 

const int REMOVE_BOTH_SHIELD_AND_ITEMS = 0; //Removes both shield, and items, if REMOVE_ITEMS_WHEN_EATEN is enabled. 

/// Array Constants
const int EVENT_LINK_EATEN_LIKELIKE = 176*2+1; //A constant for the boolean LinkIsEaten().

/// Functions

//Stores the combo position of all LikeLike enemies, per frame.
void LikeLikePosition(int enemID){ 
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

//Stores the Combo Position under Link.
int LinkPosition(){ 
	int cmb = ComboAt(Link->X, Link->Y); //Get combo ID at link's position.
	for ( int q = 176; q < 176*2; q++ ) LikeLikeAndYou[q] = 0; //Clear the positions from last frame.
	LikeLikeAndYou[176+cmb] = 1; //Set the combo in the array to 1.
	
}

//Check if the LikeLike position, and Link's Position Match
void LinkEaten(){
	for ( int q = 0; q < 176*2; q++ ) { 
		if ( LikeLikeAndYou[q] + LikeLikeAndYou[q+176] == 2 ) SetLinkEaten(true); //if they match, Link is eaten.
	}
	SetLinkEaten(false); //If there are no matches, Link is NOT eaten.
}

//Returns if Link is eaten at present.
int LinkIsEaten(){ 
	return LikeLikeAndYou[EVENT_LINK_EATEN_LIKELIKE];
}

//Sets if Link is, or is not eaten.
void SetLinkEaten(bool state){ 
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

void RemoveItemsWhenEaten(){
	//RemoveItemChance(REMOVE_ITEMS_WHEN_EATEN_PERCENT_CHANCE,I_SWORD2);
	//RemoveItemsWhenEaten(EdibleItemList,true,-1, 1, 3);
	//Populate this with functions that you want to run, and their arguments, if you enable edible items. 
}


//! Removes a list of items when eaten OnExit.
//* Pass an array listing the items to remove as 'list'
//* If 'random' is set to true, it will remove a number of items at random, specified by 'NumberOfItems'.
//* Otherwise, it will remove a number of items **in order**, skipping over any that Link does not have. 
//* If you want to remove a random number of items, set 'numberOfItems to '-1' and specify the min
//* and max in 'minNumber' and 'maxNumber'.
//* For a fixed number of items, set 'minNumber' and 'maxNumber' each to '-1'.

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
				if ( numberOfItems > 0 && passes >= (numberOfitems * numberOfitems) ) break; //Stop if we seem to be in an infinite cycle. 
				if ( numberOfItems == -1 && passes >= maxNumber * maxNumber ) break; //..or if we have a specified min, and max, and seem to be in an infinite loop, exit. 
				passes++;
				continue;
			}
			if ( Link->Item[it] ) Link->Item[it] = false;
		}
	}
	
	if ( !random ) {
		for ( ; passes > 0; passes-- ) {
			int pos = passCount; 
			int it = list[pos]
			if ( !Link->Item[it] ) {
				if ( pos >= listSize) break; 	//If we reach the end of the list, stop, even if we would
								//otherwise remove items, because we have nothing left to remove
								//and are in an infinite cycle. 
				passes++;
				continue;
			}
			if ( Link->Item[it] ) {
				passCount++; //Move to the next array index. 
				Link->Item[it] = false;
			}
		}
	}
}

//////////////////////
/// Global Scripts ///
//////////////////////

//OnExit Script: Prevents F6-ing out of a Like Like eating your shield. 
global script onExit{
	void run(){
		if ( LinkIsEaten() {
			if ( !REMOVE_ITEMS_WHEN_EATEN || REMOVE_BOTH_SHIELD_AND_ITEMS ) ) { 
				if ( Link->Item[I_SHIELD2] && REMOVE_SHIELD_BY_PERCENT ) RemoveShieldChance(REMOVE_SHIELD_WHEN_EATEN_PERCENT_CHANCE); 
					//if Link is eaten, has a magic shield, and tries to F6->Continue,
					//and we aren't using a LIST of items to remove AT RANDOM. 
					//If the setting REMOVE_SHIELD_BY_PERCENT is NOT ZERO ('0')...
					//Remove shield if random number is less than or equal to REMOVE_SHIELD_WHEN_EATEN_PERCENT_CHANCE 
				else if ( Link->Item[I_SHIELD2] && !REMOVE_SHIELD_BY_PERCENT ) Link->Item[I_SHIELD2] = false; 
				//If the setting REMOVE_SHIELD_BY_PERCENT is ZERO ('0')...
				//Remove his shield. 
			}
			if ( REMOVE_ITEMS_WHEN_EATEN ) RemoveItemsWhenEaten();
			//If the setting REMOVE_ITEMS_WHEN_EATEN is enabled, the functions and parameters
			//set in RemoveItemsWhenEaten will execute. 
		}
	}
}


//Example Global Active Script
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