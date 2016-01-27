///////////////////////////////////
/// Global Variables and Arrays ///
///////////////////////////////////

bool Unsecret; //Merge this into LastSixScreens[14] !
int LastSixScreens[14]={	QUEST_START_SCREEN, 0,0,0,0,0,
				QUEST_START_DMAP,   0,0,0,0,0 
				0,0};

/////////////////
/// Constants ///
/////////////////

const int QUEST_START_SCREEN = 0;
const int QUEST_START_DMAP = 1;

const int SIX_SCREENS_DMAP = 6;
const int SCREEN_RECENTLY_VISITED = 13;
				

///////////////////
/// FFC Scripts ///
///////////////////
				
//The following script replaces killed Lanmolas, on a screen with more than one Lanmola, if the player kills one, 
//leaves, and returns, in an attempt to cheat.
	//! Note: The script does not un-do enemy->secret triggers.

//It also stores the number of enemies on a screen with splitting enemies, and silently removes any that have been killed,
//if the player returns before moving six screens away.

//D0: The ID of the enemy to remove.
//D1: The enemi ID that the D0 splits into. 
//D2: the starting number of enemies on this screen (the number of times it is in the enemy list)
//D3: The register to use to store enemy counts. 
//D4: the register to check for intialisation. 
//D5: Total number of lanmola enemies on the screen.
//D6: Lanmola enemy ID.
//D7: Register for tracking lanmolas. 

ffc script RemoveKilledSpliiters{
	void run(int enemID, int splitsInto, int startNum, int reg, int regInit, int totalLanmolas, int lanmolaID, int lanmolasReg){
		int curNum = NumNPCsOf(enemID);
		int presentMax = Screen->D[reg];
		int children;
		int numLanmolas;
		Waitframes(5);
		bool firstRun = true;
		int segments;
		if ( lanmolaID ) { 
			for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
				npc a = Screen->LoadNPC(q);
				if ( a->ID == lanmolaID ) {
					segments = a->Attributes[0] + 1;
					break;
				}
			}
		}
		
		float segs = segments / 10;
		Screen->D[lanmolasReg] += segs;
		int lanmolasValid = Floor(Screen->D[lanmolasReg]);
		float deciSegs = ( Screen->D[lanmolasReg] - Floor(Screen->D[lanmolasReg]) ) * 10 ;
		
		while(true){
			segments = deciSegs;
			lanmolasValid = Floor(Screen->D[lanmolasReg]);
			
			if ( presentMax == 0 && Screen->D[regInit] == 0 ) {
				Screen->D[regInit] = 1;
				Screen->D[reg] = startNum;
				Trace(Screen->D[reg]);
				TraceNL();
			}
			
			if ( lanmolasValid && NumNPCsOf(lanmolaID) == 0 && firstRun ) {
				Unsecret = true;
				for ( int q = ( Floor(Screen->D[lanmolasReg]) / segments ); q > 0; q-- ) {
					Screen->CreateNPC(lanmolaID);
				}
				firstRun = false;
			}
			
			
			
			
			curNum = NumNPCsOf(enemID);
			presentMax = Screen->D[reg];
			if ( presentMax == 0 && Screen->D[regInit] > 0 && !ScreenRecentlyVisited() ) {
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					
					npc n = Screen->LoadNPC(q);
					if ( n->ID == enemID ) Remove(n);
				}
			}
			curNum = NumNPCsOf(enemID);
			children = NumNPCsOf(splitsInto);
			if ( Screen->D[reg] > curNum+children ) Screen->D[reg] = curNum;
			
			if ( curNum > Screen->D[reg] ) {
				int diff = curNum - Screen->D[reg];
				int removed;
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					if ( removed == diff ) break;
					npc n = Screen->LoadNPC(q);
					if ( enemID != lanmolaID ) {
						if ( n->ID == enemID ) {
							Remove(n);
							removed++;
						}
					}
				}
			}
			int lanmolasOffscreen;
			
			if ( curNum == totalLanmolas ) {
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					npc n = Screen->LoadNPC(q);
					if ( n->ID == lanmolaID && n->X == -32768 ) lanmolasOffscreen++;
				}
			}
			
			if ( lanmolasOffscreen == totalLanmolas ) {
				for ( ; lanmolasOffscreen < 0; lanmolasOffscreen -- ){
					npc n = Screen->LoadNPC(lanmolasOffscreen);
					n->HP = -9999;
				}
			}
			
			lanmolasOffscreen = 0;
			
			Screen->D[lanmolasReg] = NumNPCsOf(lanmolaID) + ( segments / 10 );
			
			if ( !NumNPCsOf(lanmolaID) ) {
				Screen->D[lanmolasReg] = 0;
				//! Add secret triggers. 
			}
			
			Waitframe();
		}
	}
}

//THis creates a one-time-purchase heart container. Strings may use the values in Screen->D[reg] set by this, via SCCs.

//If D2 is > 0 , an NPC Guy will be removed, with an ID matching D2. 

ffc script HeartContainerOneTimeBuy{
	void run(int reg, int amount, int removeGuy){
		bool bought;
		Waitframes(5);
		if ( Screen->D[reg] ) {
			if ( Screen->NumNPCs() && removeGuy ) {
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					npc n = Screen->LoadNPC(q); 
					if ( q->Type == NPC_GUY ) remove(n);
				}
			}
			this->data = 0;
			Quit();
		}
		
		while ( true ) {
			if ( ! Screen->D[reg] ) Screen->DrawInteger(1, (this->X + 4), (this->Y + 18), FONT_Z1, 1, 0, -1, -1, amount, 0, 128);
			if ( bought ) {
				Screen->D[reg]++;
				this->data = 0; 
				//Remove NPC guy if D2 > 0
				//?Set sa global var to the ID of the guy, and run a remove instructionbefore Waitdraw()
				//! No, the NPC needs five frames to spawn.
				if ( Screen->NumNPCs() && removeGuy ) {
					for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
						npc n = Screen->LoadNPC(q); 
						if ( q->Type == NPC_GUY ) remove(n);
					}
				}
					
				Quit();
			}
			//Check distances.
			if ( LinkCollision(this) {
				if ( Game->Counter[CR_RUPEES] >= amount ) {
					bought = true;
					Link->DCounter[CR_RUPEES] = amount;
					//Game->PlaySound(25);
					this->data = 1;
					item h = Screen->CreateItem(28);
					h->X = Link->X;
					h->Y = Link->Y;
					h->X = Link->Z;
					Link->Action = LA_HOLD1LAND;
					Link->HeldItem = 28;
				}
			}
			Waitframe();
		}
	}
}

ffc script HeartContainerOneTimeBuyWithStrings{
	void run(int reg, int amount, int removeGuy, int string1, int string2){
		bool bought;
		Waitframes(5);
		if ( Screen->D[reg] ) {
			if ( Screen->NumNPCs() && removeGuy ) {
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					npc n = Screen->LoadNPC(q); 
					if ( q->Type == NPC_GUY ) remove(n);
				}
			}
			this->data = 0;
			Quit();
		}
		
		while ( true ) {
			if ( ! Screen->D[reg] ) {
				Screen->ShowMessage(string1);
				Screen->DrawInteger(1, (this->X + 4), (this->Y + 18), FONT_Z1, 1, 0, -1, -1, amount, 0, 128);
			if ( bought ) 
				Screen->D[reg]++;
				this->data = 0; 
				//Remove NPC guy if D2 > 0
				//?Set sa global var to the ID of the guy, and run a remove instructionbefore Waitdraw()
				//! No, the NPC needs five frames to spawn.
				if ( Screen->NumNPCs() && removeGuy ) {
					for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
						npc n = Screen->LoadNPC(q); 
						if ( q->Type == NPC_GUY ) remove(n);
					}
				}
					
				Quit();
			}
			//Check distances.
			if ( LinkCollision(this) {
				if ( Game->Counter[CR_RUPEES] >= amount ) {
					bought = true;
					Link->DCounter[CR_RUPEES] = amount;
					//Game->PlaySound(25);
					this->data = 1;
					item h = Screen->CreateItem(28);
					h->X = Link->X;
					h->Y = Link->Y;
					h->X = Link->Z;
					Link->Action = LA_HOLD1LAND;
					Link->HeldItem = 28;
				}
			}
			Waitframe();
		}
	}
}

ffc script HeartContainerOneTimeBuyWithHardcodedStrings{
	void run(int reg, int amount, int removeGuy){
		bool bought;
		int buffer[20]=" ";
		int bufferAmount[3]=" ";
		int string1[]="Have a heart, and help";
		int string2[]="out an old man by";
		
		int string3[]="donating ";
		int string4[]="rupees?";
		itoa(amount,bufferAMount);
		strcat(string3,buffer);
		strcat(bufferAmount,buffer);
		strcat(string4,buffer);
		
		Waitframes(5);
		if ( Screen->D[reg] ) {
			if ( Screen->NumNPCs() && removeGuy ) {
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					npc n = Screen->LoadNPC(q); 
					if ( q->Type == NPC_GUY ) remove(n);
				}
			}
			this->data = 0;
			Quit();
		}
		
		while ( true ) {
			if ( ! Screen->D[reg] ) {
				Screen->DrawString(1, 120, 24, FONT_Z1, 1, 0,  string1, TF_CENTERED, string1, 128);
				Screen->DrawString(1, 120, 34, FONT_Z1, 1, 0,  string2, TF_CENTERED, string1, 128);
				Screen->DrawString(1, 120, 44, FONT_Z1, 1, 0,  buffer, TF_CENTERED, string1, 128);
				Screen->DrawInteger(1, (this->X + 4), (this->Y + 18), FONT_Z1, 1, 0, -1, -1, amount, 0, 128);
			if ( bought ) 
				Screen->D[reg]++;
				this->data = 0; 
				//Remove NPC guy if D2 > 0
				//?Set sa global var to the ID of the guy, and run a remove instructionbefore Waitdraw()
				//! No, the NPC needs five frames to spawn.
				if ( Screen->NumNPCs() && removeGuy ) {
					for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
						npc n = Screen->LoadNPC(q); 
						if ( q->Type == NPC_GUY ) remove(n);
					}
				}
					
				Quit();
			}
			//Check distances.
			if ( LinkCollision(this) {
				if ( Game->Counter[CR_RUPEES] >= amount ) {
					bought = true;
					Link->DCounter[CR_RUPEES] = amount;
					//Game->PlaySound(25);
					this->data = 1;
					item h = Screen->CreateItem(28);
					h->X = Link->X;
					h->Y = Link->Y;
					h->X = Link->Z;
					Link->Action = LA_HOLD1LAND;
					Link->HeldItem = 28;
				}
			}
			Waitframe();
		}
	}
}


//Global Scripts

global script active{
	void run(){
		while(true){
			StoreScreenVisited(LastSixScreens);
			if ( Unsecret ) {
				Screen->State[ST_SECRET] = false;
				Unsecret = false;
				
			}
			Waitdraw();
			Waitframe();
		}
	}
}
		
global script OnContinue{
	void run(){
		for ( int q = 0; q < SizeOfArray(LastSixScreens); q++) LastSixScreens[q] = 0;
	}
}


//Global Functions
				
int ScreenRecentlyVisited(){
	return LastSixScreens[SCREEN_RECENTLY_VISITED];
}


void StoreScreenVisited(int arr){
	int scr = Game->GetCurScreen();
	int dmp = Game->GetCurDMap();
	bool match;
	for ( int q = 0; q < ( SizeOfArray(arr) / 2 ) -1 ); q++ ) {
		if ( arr[q] == scr && arr[q+SIX_SCREENS_DMAP] == dmp ) match = true;
	}
	if ( !match ) {
		arr[SCREEN_RECENTLY_VISITED] = 0;
		ShiftArrayDownward(arr);

	}
	else arr[SCREEN_RECENTLY_VISITED] = 1; //This value is used by scripts, as a flag.
}
	
void ShiftArrayDownward(int arr){
	for ( int q = ( SizeOfArray(arr) / 2 ) -1 ); q < 0; q --){
		if ( q > 0 ) {
			arr[q] = arr[q-1];
			arr[q+SIX_SCREENS_DMAP] = arr[q-1+SIX_SCREENS_DMAP];
			arr[0] = Game->GetCurScreen();
			arr[0+SIX_SCREENS_DMAP] = Game->GetCurDMap();
		}
	}
}
	