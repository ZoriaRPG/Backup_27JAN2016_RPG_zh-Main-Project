//Chest Minigame FFC
//By: ZoriaRPG
//v0.3.3

//!The initial combo for this ffc should be a rupee icon with a numeric cost. The next combo in the list, should be blank. 

const int CMB_CHEST_GAME_CLOSED = 0;
const int CMB_CHEST_GAME_OPEN = 0;

const int CHEST_GAME_NO_CHEST = 0;
const int CHEST_GAME_CHEST_CLOSED = 1;
const int CHEST_GAME_CHEST_OPEN = 2;

const int TIME_INPUT_UP_OPEN_CHEST = 100; //100 frames of inputting up will open a closed chest. 

const int MSG_CHEST_GAME_OVER = 0;
const int SFX_OPEN_CHEST = 63;

const int MSG_CHEST_GAME_OVER = 0;
const int MSG_CHEST_GAME_RULES = 0;

const int CHEST_GAME_LAYER = 2;
const int CHEST_GAME_SCREEN_D_REGISTER = 5; 
const int CHEST_GAME_HOLDUP_TYPE = LA_HOLD1LAND;

const int CHEST_GAME_ALLOW_REPLAY = 0; 

ffc script ChestMiniGame{	//layer for combos, number of plays, big prize, hold up animation, Screen->D register, percentage chance of main prize, backup prize if big prize already awarded, and rolled again. cost per play, message to play when game is over. 
	void run(int chestLayer, int max_chests_Link_can_open, int specialPrize, int holdUpType, int reg, int percentMainprize, int backupPrize, int costPerPlay, int msgEnd, int msgRules){
		//!We need to decide which args to keep. 
		
		//! chestLayer, and reg can easily be constants.
			//the sfx should only be a constant
		
		
		//Populate with the IDs of prizes to award. Each index is a 1% chance. 
		int chestPrizes[]= { 	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0,
					0,	0,	0,	0,	0,	0,	0,	0,	0,	0; 	}

		int initialData = this->Data; //Store the initial combo, to revert, if replay is enabled. 
		int chestComboSpots[176];
		int check;
		
		int mainprize;
		int input_up_timer = TIME_INPUT_UP_OPEN_CHEST; 
		bool openchest;
		int has_opened_number_of_chests;
		bool award_main_prize;
		bool gameRunning;
		bool gameOver;
		
		//Populate chestComboSpots with the coordinates of each closed chest. 
		for ( int q = 0; q < 176; q++ ) {
			int cmb = GetLayerComboD(chestLayer,q);
			if ( cmb == CMB_CHEST_GAME_CLOSED ) chestComboSpots[q] = CHEST_GAME_CHEST_CLOSED;
		}
		
		int spotsUnderChests[192]; //Populate with the combo positions under closed chests.
		
		for ( int q = 0; q < 176; q++ ) { //Each combo under a chest is 16 combos higher in number than the actual chest. 
			 spotsUnderChests[q+16] = chestComboSpots[q];
		}
		
		Screen->Message(MSG_CHEST_GAME_RULES);	//Show the string for the chest game rules. 
		
		while(true) {
			
			if ( gameOver && !CHEST_GAME_ALLOW_REPLAY ) break;
			
			if ( gameOver && CHEST_GAME_ALLOW_REPLAY ) {
				gameRunning = false;
				this->Data = initialData;
			}
			
			if ( LinkCollision(this) && Game->Counter[CR_RUPEES] > costPerPlay && Xor(Link->PressA,Link->PressB) && !gameRunning ) {	
					//If Link collides with the ffc, which should show the cost, and presses a button, start the game. 
				gameRunning = true;
				Game->DCounter[CR_RUPEES] -= costPerPlay;
				this->Data++; //increase to the next combo, removing the cost icon. 
			}
				
			
			
			if ( gameRunning ) {
			
				if ( input_up_timer <= 0 ) {
					openchest = true;
					input_up_timer = TIME_INPUT_UP_OPEN_CHEST;
				}
				
				//Check to see if the combo above Link is a chest.
			
				if ( spotsUnderChests[ ComboAt( CenterLinkX(), CenterLinkY() ) ] == CHEST_GAME_CHEST_CLOSED && Link->Dir == DIR_UP && has_opened_number_of_chests <= max_chests_Link_can_open) {
				
					//if Link is under a closed chest, and is facing up. 
					//if Link is pressing up
					if ( Link->InputUP && !openchest ) input_up_timer--;

					//if Link stops pressing up, reset the timer instantly. 
					if ( !Link->InputUp ) input_up_timer = TIME_INPUT_UP_OPEN_CHEST;
					
					//If the timer expires, and Link is still pressing up...
					if ( ( Link->InputUp && openchest ) || ( Xor(Link->PressA,Link->PressB) ) ) { //The timer is over, and Link is still pressing up, so open the chest.
						has_opened_number_of_chests++; //Update out counter, so that Link can only open as many chests as specified by arg 'max_chests_Link_can_open'.
						int combo_under_link = ComboAt( CenterLinkX(), CenterLinkY() ); //Store the position of Link's undercombo.
						int cmb_chest_to_open = ComboAt( CenterLinkX(), CenterLinkY() ) - 16; //and the position of the chest combo.
						
						if ( sfx ) Game->PlaySound(sfx); //if the sfx arg is set, play that SFX file.
						else Game->PlaySound(SFX_OPEN_CHEST); //otherwise, play the default.
						
						item i; //make an item pointer.
						SetLayerComboD(chestLayer,cmb_chest_to_open,CMB_CHEST_GAME_OPEN); //Change the chest to an open chest combo.
						
						spotsUnderChests[combo_under_link] = CHEST_GAME_CHEST_OPEN; //Mark the array indices as being open.
						chestComboSpots[cmb_chest_to_open] = CHEST_GAME_CHEST_OPEN; //in both arrays.
						
						check = Rand(1,100);  //Make a check, to use for determining if the main prize should e awarded.
						if ( check <= percentMainPrize ) award_main_prize = true; //If that check passes, then we will award the main prize.
						
						if ( check > percentMainPrize ) check = Rand(0,SizeOfArray(chestPrizes); //Otherwise, reuse that var, and make a new check to determine
															//the prize to award from the table. 
						
		
						int itm;
			
						if ( award_main_prize && !Screen->D[reg] ) { //The main prize has not been awarded, and has been randomly chosen. 
							Screen->D[reg] = 1; 	//Set the register so that Link cannot collect the special prize again. 
							i = Screen->CreateItem(specialPrize);	//Assign the pointer, and make the item.
							itm = specialPrize;	//Set the value of the item ID to a var so that we can use it for holding it up. 
						}
						if ( award_main_prize && Screen->D[reg] ) { 	//The main prize has already been awarded, so recheck. 
							check = Rand(0,SizeOfArray(chestPrizes)); //Make the new check, to determine what prize to award. 
							if ( check ) {	//If the array index is not zero...
								i = Screen->CreateItem(chestPrizes[check]); //Assign the pointer, and make the item.
								itm = chestPrizes[check];	//Set the value of the item ID to a var so that we can use it for holding it up. 
							}
						}
						else { 	//Otherwise, if the check to award a special prize did not pass..
							if ( check ) { //if the array index is not zero...
								i = Screen->CreateItem(chestPrizes[check]); //Award a normal prize, from the list. 
								itm = chestPrizes[check]; //Set the value of the item ID to a var so that we can use it for holding it up. 
							}
						}
						if ( check ) {	//if we're awarding a prize...
							i -> X = Link->X;
							i -> Y = Link->Y;
							if ( holdType == 1 ) { 
								Link->Action = LA_HOLD1LAND;
								Link->HeldItem =  itm;
							}
							if ( holdType == 2 ) {
								Link->Action = LA_HOLD2LAND;
								Link->HeldItem =  itm;
							}
						}
						else Remove(i);	//if check is zero, remove the item pointer. 
								//This allows chances of getting nothing at all. 
					}
				
					if ( has_opened_number_of_chests > max_chests_Link_can_open ) {
						gameOver = true;
						gameRunning = false;
						if ( msg_end ) Screen->Message(msg_end);
						else Screen->Message(MSG_CHEST_GAME_OVER);
						
					}
				
					Waitframe();

					//if ComboAt( ( GridX( CenterLinkX()  ) ), GridX( CenterLinkY() -8 ) ) 
				}
				Waitframe();
			}
		
			Waitframe();
		}
		//If we reach here, then the chest game is over. 
		this->Data = 0;
		this->Script = 0;
		Quit();
	}
}

		
		