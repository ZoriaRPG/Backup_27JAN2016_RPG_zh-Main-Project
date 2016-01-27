//Pieces of Power && Acorns v0.2.1


//Set-up: Make a new item (Green Ring), set it up/ as follows:
//Item Class Rings
//Level: 1
//Power: 1
//CSet Modifier : None
//Assign this ring to Link's starting equipment in Quest->Init Data->Items

//Change the blue ring to L2, red to L3, and any higher above these. 

int Z4_ItemsAndTimers[7]; //Array to hold the values for the Z4 items. 

//Item Numbers
const int I_GREEN_RING = 100; //Item number of green ring
const int I_PIECE_POWER = 101;
const int I_ACORN = 102; 

//Settings
const int NEEDED_PIECES_OF_POWER = 3; //Number of Pieces of power needed for temporary boost.
const int NEEDED_ACORNS = 3; //Number of Acorns needed for temporary boost.
const int BUFF_TIME = 720; //Duration of boost, in frames. Default is 2 minutes. 


//Array Indices
const int POWER_TIMER = 0;
const int DEF_TIMER = 1;
const int NUM_PIECES_POWER = 2;
const int NUM_ACORNS = 3;
const int POWER_BOOSTED = 4;
const int DEF_BOOSTED = 5;
const int NUM_SHELLS = 6;

//Run every frame, before Waitdraw();
void LinksAwakeningItems(){
	PiecesOfPower();
	Acorns();
	BoostAttack();
	BoostDefense();	
}


//Run every frame **AFTER** Waitdraw();
void ReduceBuffTimers(){
	if ( Z4_ItemsAndTimers[POWER_TIMER] > 0 ) {
		Z4_ItemsAndTimers[POWER_TIMER]--;
	}
	if ( Z4_ItemsAndTimers[DEF_TIMER] > 0 ) {
		Z4_ItemsAndTimers[DEF_TIMER]--;
	}
}



//Runs every frame from LinksAwakeningItems();
void PiecesOfPower(){
	if ( Z4_ItemsAndTimers[NUM_PIECES_POWER] >= NEEDED_PIECES_OF_POWER ) {
		Z4_ItemsAndTimers[NUM_PIECES_POWER] = 0; 
		Z4_ItemsAndTimers[POWER_TIMER] = BUFF_TIME;
	}
}

//Runs every frame from LinksAwakeningItems();
void Acorns(){
	if ( Z4_ItemsAndTimers[NUM_ACORNS] >= NEEDED_ACORNS ) {
		Z4_ItemsAndTimers[NUM_ACORNS] = 0; 
		Z4_ItemsAndTimers[DEF_TIMER] = BUFF_TIME;
	}
}

//Runs every frame from LinksAwakeningItems();
void BoostAttack(){
	if ( Z4_ItemsAndTimers[POWER_TIMER] && !Z4_ItemsAndTimers[POWER_BOOSTED] ) {
		BuffSwords();
	}
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] && Z4_ItemsAndTimers[POWER_TIMER] < 1 ) {
		NerfSowrds();
		Z4_ItemsAndTimers[POWER_TIMER] = 0;
	}
}

//Runs every frame from LinksAwakeningItems();
void BoostDefense(){
	if ( Z4_ItemsAndTimers[DEF_TIMER] && !Z4_ItemsAndTimers[DEF_BOOSTED] ) {
		BuffRings();
	}
	if ( Z4_ItemsAndTimers[DEF_BOOSTED] && Z4_ItemsAndTimers[DEF_TIMER] < 1 ) {
		NerfRings();
		Z4_ItemsAndTimers[DEF_TIMER] = 0;
	}
}

//Runs every frame from BoostDefense();
void BuffSwords(){
	float presentPower;
	for ( int q = 0, q <= 255, q++ ) {
		itemdata id = Game->LoadItemData(q);
		if ( id->Family ==  IC_SWORD ) {
			presentPower = id->Power;
			id->Power = presentPower * 2;
		}
	}
	Z4_ItemsAndTimers[POWER_BOOSTED] = 1;
}

//Runs every frame from BoostDefense();
void BuffRings(){
	float presentPower;
	for ( int q = 0, q <= 255, q++ ) {
		itemdata id = Game->LoadItemData(q);
		if ( id->Family ==  IC_RING ) {
			presentPower = id->Power;
			id->Power = presentPower * 2;
		}
	}
	Z4_ItemsAndTimers[DEF_BOOSTED] = 1;
}

//Runs every frame from BoostDefense();
void NerfSwords(){
	float presentPower;
	for ( int q = 0, q <= 255, q++ ) {
		itemdata id = Game->LoadItemData(q);
		if ( id->Family ==  IC_SWORD ) {
			presentPower = id->Power;
			id->Power = presentPower * 0.5;
		}
	}
}

//Runs every frame from BoostDefense();
void BuffRings(){
	float presentPower;
	for ( int q = 0, q <= 255, q++ ) {
		itemdata id = Game->LoadItemData(q);
		if ( id->Family ==  IC_RING ) {
			presentPower = id->Power;
			id->Power = presentPower * 0.5;
		}
	}
}
		

////////////////////
/// Item Scripts ///
////////////////////

//Piece of Power item PICKUP script. 
item script PieceOfPower{
	void run(){
		Z4_ItemsAndTimers[NUM_PIECES_POWER]++;
	}
}

//Acorn item PICKUP script. 
item script Acorn{
	void run(){
		Z4_ItemsAndTimers[NUM_ACORNS]++;
	}
}

//Shell item PICKUP script. 
item script Shell{
	void run(){
		Z4_ItemsAndTimers[NUM_SHELLS]++;
	}
}


/////////////////////////////
/// Sample Global Scripts ///
/////////////////////////////


global script LA_Active{
	void run(){
		while(true){
			LinksAwakeningItems();
			Waitdraw();
			ReduceBuffTimers();
			Waitframe();
		}
	}
}

global acript LA_OnContinue{
	void run(){
		//Set timers back to 0, disabling the boost?
	}
}

global script OnExit{
	void run(){
		//Set timers back to 0, disabling the boost?
	}
}

//void LinksAwakeningItems(int swords, int rings){
//}


//int TempBoostItems[6];
//int TempBoostTimers[2];


//int SwordItems[4]={1};
//int DefItems[4]={64};



