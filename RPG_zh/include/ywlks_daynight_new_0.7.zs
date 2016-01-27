//Revised Day/Night Cycle System for ywlks
//v0.7

 // Section 3. Modified Day/Night Script
// OoA style multiple Time Period dmap warping
 
const int TS_NUM_TIMEPERIODS = 4;     //Set this to the number of time periods.  I.e. Past/Present/Future = 3
 
//Set any combination of these for how you want to designate a TimeWarp combo.  Leave at -1 if not using.  At least one needs to not be -1.
const int TS_TIMEWARPCOMBO = -1;   // use a specific Combo#
const int TS_TIMEWARPTYPE  = -1;   // use a specific ComboType
const int TS_TIMEWARPFLAG  = 99;   // use a specific ComboFlag - placed or inherent doesn't matter
 
int TS_DMaps[13] = {0, 4,32,71,75,79,
					83,87,91,95,101,105,109};   //This array tells the script which DMaps are involved in the Time System. 
                            //Put the first DMap of every set of time periods separated by a comma inside the {}. 
                            //Put the number of things inside the {} inside the []. 
                            //****You'll want to make a new save file every time you change this.
 
int TS_CurrentState = 0;  //tracks which time period you are in
					
const int TIME_WARP_FFC = 25;
					
//float Vars[255]={-1};
					
const int MAPHOLDER_REG = 8; //Screen D
const int MAPHOLDER_DMAP = 0;
const int MAPHOLDER_SCREEN = 0;
 
 //Draws a closing and opening circle during time warp.
void TimeWarp(int linkdir){
	IsTimeWarping = false;
	closingWipe(60);
	TS_CheckandWarp(linkdir,false);
	openingWipe(60);
	PreviousDMap = Game->GetCurDMap();
	LastOverworldMap = Game->GetCurDMap();
	SetDmapChanged(0);
	TimeWarped(0);
}

// handles actually changing the Time Period dmap 
void TS_CheckandWarp(int linkdir, bool useffc){
	if ( !Game-GetDMapScreenD(MAPHOLDER_DMAP,MAPHOLDER_SCREEN,MAPHOLDER_REG) )
		Game->SetDMapScreenD(MAPHOLDER_DMAP, MAPHOLDER_SCREEN, MAPHOLDER_REG, Game->GetCurScreen());
		//Set the initial dmap id.

	int mapset;
	int warpMaps[]={	0,1,2,3,
				4,5,6,7,
				32,33,34,35,
				71,72,73,74,
				75,76,77,78,
				79,80,81,82,
				83,84,85,86,
				87,88,89,90,
				91,92,93,94,
				95,96,97,98,
				101,102,103,104,
				105,106,107,108,
				109,110,111,112 };
				
	int curmap = Game->GetCurDMap();
				
	for ( int q = 1; q <= 32; q++ ) {
		ffc f = Screen->LoadFFC(q);
		if ( q->Script == TIME_WARP_FFC ) {
			q->Script = 0;
			q->Data = 0;
		}
	}
			
	if ( curmap >=0 && curmap <= 3 ) mapset = MAPSET_1;
	if ( curmap >=4 && curmap <= 7 ) mapset = MAPSET_2;
	if ( curmap >=32 && curmap <= 35 ) mapset = MAPSET_3;
	if ( curmap >=71 && curmap <= 74 ) mapset = MAPSET_4;
	if ( curmap >=75 && curmap <= 78 ) mapset = MAPSET_5;
	if ( curmap >=79 && curmap <= 82 ) mapset = MAPSET_6;
	if ( curmap >=83 && curmap <= 86 ) mapset = MAPSET_7;
	if ( curmap >=87 && curmap <= 90 ) mapset = MAPSET_8;
	if ( curmap >=91 && curmap <= 94 ) mapset = MAPSET_9;
	if ( curmap >=95 && curmap <= 98 ) mapset = MAPSET_10;
	if ( curmap >=101 && curmap <= 104 ) mapset = MAPSET_11;
	if ( curmap >=105 && curmap <= 108 ) mapset = MAPSET_12;
	if ( curmap >=109 && curmap <= 112 ) mapset = MAPSET_13;
			
	if ( !useffc ) Link->PitWarp(warpMaps[mapset+linkdir]), Game->GetCurScreen());
	else {
		for(int i=0; i<SizeOfArray(TS_DMaps); i++){
			if(curmap >= TS_DMaps[i] && curmap < TS_DMaps[i]+TS_NUM_TIMEPERIODS){
				if(TS_DMaps[i] + TS_CurrentState != curmap)
				Link->PitWarp(TS_DMaps[i] + TS_CurrentState, Game->GetCurDMapScreen());
			}
		}
	}
}

// D0 = select time period.  Between 0 and TS_NUM_TIMEPERIODS.
//      Set to -1 to cycle in reverse, set to TS_NUM_TIMEPERIODS+1 if you want to cycle forwards
// D1 = if setting the time period above (not cycling), and already in the D0 time period, warp to this instead.
 
item script I_ACT_TS_TimeChange{
	void run(int TS_SelectTP, int TS_WarpBack){
		if(isTimeWarp( ComboAt(Link->X+8,Link->Y+12)) ){
			TS_CurrentState = Link->Dir;
			IsTimeWarping = true;
		}  
	}
}


void DoWarp(){
	if (IsTimewarping){
		Game->SetDMapScreenD(MAPHOLDER_DMAP, MAPHOLDER_SCREEN, MAPHOLDER_REG, Game->GetCurScreen());
		NoAction();
		Timewarp(TS_CurrentState);
	}
}

item script I_ACT_TS_TimeChange{
	void run(int TS_SelectTP, int TS_WarpBack){
		if(isTimeWarp( ComboAt(Link->X+8,Link->Y+12)) ){
			TS_CurrentState = Link->Dir;
			IsTimeWarping = true;
		}  
	}
}

//Checks if the combo at your location has the right flag, type or number so you can time warp.
bool isTimeWarp(int loc){
   return (Cond(TS_TIMEWARPFLAG == -1, true, ComboFI(loc,TS_TIMEWARPFLAG) ) 
        && Cond(TS_TIMEWARPTYPE == -1, true, Screen->ComboT[loc] == TS_TIMEWARPTYPE)
        && Cond(TS_TIMEWARPCOMBO == -1, true, Screen->ComboD[loc] == TS_TIMEWARPCOMBO) );
}


const int LAST_OVERWORLD_REG = 0;
const int LAST_DMAP_REG = 1;
const int TIMEWARPED_REG = 2;

const int TIME_OF_DAY_REG_DMAP = 0; 
const int TIME_OF_DAY_REG_SCREEN = 0;

void TimeWarped(int state){
	SetDMapScreenD(TIME_OF_DAY_REG_DMAP, TIME_OF_DAY_REG_SCREEN, TIMEWARPED_REG, value);
}

int TimeWarped(){
	Return GetDMapScreenD(TIME_OF_DAY_REG_DMAP, TIME_OF_DAY_REG_SCREEN, TIMEWARPED_REG);
}

int GetLastOverworldDMap(){
	return GetDMapScreenD(TIME_OF_DAY_REG_DMAP, TIME_OF_DAY_REG_SCREEN, LAST_OVERWORLD_REG);
}

int GetPreviousDMap(int store_dmap, int store_screen){
	return GetDMapScreenD(TIME_OF_DAY_REG_DMAP, TIME_OF_DAY_REG_SCREEN, LAST_DMAP_REG);
}

void SetPreviousDMap(int value){
	SetDMapScreenD(TIME_OF_DAY_REG_DMAP, TIME_OF_DAY_REG_SCREEN, LAST_DMAP_REG, value);
}

void SetLastOverworldDMap(int value){
	SetDMapScreenD(TIME_OF_DAY_REG_DMAP, TIME_OF_DAY_REG_SCREEN, LAST_OVERWORLD_REG, value);
}



//Returns if the present dmap differs from the last stored dmap change. 
bool DMapChanged(){
	return Game->GetCurDMap() != PreviousDMap;
}

//Call every frame before Waitdraw()
void CheckDMap(){
	//if PreviousDMap is uninitialised...
	if ( GetPreviousDMap() == -1 ) SetPreviousDMap(Game->GetCurDMAP());
	//if LastOverworldDMap is uninitialised (start of the game)
	if ( GetLastOverworldDMap() == -1 ) SetLastOverworldDMap(Game->GetCurDMAP());
	
	//Check of the dmap has changed. 
	//if ( Game->GetCurDMap() != PreviousDMap ) DMapChanged = 1;
	
	
	//if we are using the harp to warp
	//! Moved intot he DoWarp() function, or the item script. 
	//if ( DMapChanged() && TimeWarped() ) {
	//	PreviousDMap = Game->GetCurDMap();
	//	LastOverworldMap = Game->GetCurDMap();
	//	SetDmapChanged(0);
	//	TimeWarped(0);
	//}
	
	if ( DMapChanged() && !TimeWarped() ) {
		
		
		//if the player moves from one overworld map to another
		
		//if from an outdoors dmap to another, update the overworld and main last dmap settings
		if ( IsWarpAllowed(Game->GetCurDMap()) && IsWarpAllowed(GetPreviousMap()) ){
			SetLastOverworldMap(Game->GetCurDMap());
			SetPreviousDMap(Game->GetCurDMap());
		}
		
		
		//if from an outdoors dmap to a cave
		if ( !IsWarpAllowed(Game->GetCurDMap()) && IsWarpAllowed(GetPreviousMap()) ){
			SetLastOverworldMap(PreviousDMap);
			SetPreviousDMap(Game->GetCurDMap());
		}
		
		//if from an indoors dmap to outdoors
		if ( IsWarpAllowed(Game->GetCurDMap()) && !IsWarpAllowed(GetPreviousMap()) ){
			SetPreviousDMap(Game->GetCurDMap());
			Link->PitWarp(GetLastOverworldDMap(), Game->GetCurScreen());
		}
		
		//if the map allwos warps, and it doesn;t match the last offset, fix it. 
		
		
		//if the player moves from an overworld map, to a dungeon
		if ( IsDungeonDMap(Game->GetCurDMap()) && IsWarpAllowed(GetPreviousMap()) ) {
			SetLastOverworldMap(PreviousDMap);
			SetPreviousDMap(Game->GetCurDMap());
			
		}
		
		//if the player warps from one dungeon dmap to another
		if ( IsDungeonDMap(Game->GetCurDMap()) && IsDungeonDMap(GetPreviousDMap()) {
			SetPreviousDMap(Game->GetCurDMap());
		}
		
		
		
		//if the player moves out of a dungeon, to another overworld dmap. 
		
		//if the overworld dmap is outdoors...
		
		if ( IsDungeonDMap(GetPreviousDMap()) && IsWarpAllowed(Game->GetCurDMap()) {
			SetPreviousMap(Game->GetCurDMap());
			Link->PitWarp(GetLastOverworldMap(),Game->GetCurScreen());
		}

		
	}
}

int IsDungeonDMap(int dmap){
	int DungeonDMaps[]={
	11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	32, 33, 34, 35, 36 };

	for ( int q = 0; q < SizeOfArray(DungeonDMaps); q++ ) {
		if ( dmap == DungeonDMaps[q] ) return q;
	}
	return 0;
}

//These need to return q+1, so that we can use them, asd 0 is a value value...sigh...

int IsOverworldDMap(int dmap){
	int OverworldDMaps[]={
		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 
		37, 38, 39, 40, 41, 42, 43, 44, 45, 
		46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 
		56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 
		66, 67, 68, 69, 70, 
		71, 72, 73, 74, 75, 76, 77, 78, 79, 80. 
		81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 
		91, 92, 93, 94, 95, 96, 97, 98, 
		99, 100, 101, 102, 103,
		104, 105, 106, 107, 108, 109, 110, 111, 112 };
	for ( int q = 0; q < SizeOfArray(OverworldDMaps); q++ ) {
		if ( dmap == OverworldDMaps[q] ) return q+1;
	}
	return 0;
}



int IsWarpAllowed(int dmap){
	
	int WarpAllowedDMaps[]={
	0, 1, 2, 3, 
	4, 5, 6, 7, 
	11, 12, 13, 14, 
	15, 16, 17, 18, 
	19, 20, 21, 22, 
	23, 24, 25, 26, 
	27, 28, 29, 30,
	32, 33, 34, 35, 
	71, 72, 73, 74, 
	75, 76, 77, 78, 
	79, 80, 81, 82, 
	83, 84, 85, 86, 
	87, 88, 89, 90, 
	91, 92, 93, 94, 
	95, 96, 97, 98, 
	101, 102, 103, 104, 
	105, 106, 107, 108, 
	109, 110, 111, 112 };

	
	for ( int q = 0; q < SizeOfArray(WarpAllowedDMaps); q++ ) {
		if ( dmap == WarpAllowedDMaps[q] ) return q+1;
	}
	return 0;
}


//returns the phase of a dmap cycle, 0 through 3
int ProcessPresentTimeOfDay(int dmap){
	int phase = 0;
	int WarpAllowedDMaps[]={
	0, 1, 2, 3, 
	4, 5, 6, 7, 
	11, 12, 13, 14, 
	15, 16, 17, 18, 
	19, 20, 21, 22, 
	23, 24, 25, 26, 
	27, 28, 29, 30,
	32, 33, 34, 35, 
	71, 72, 73, 74, 
	75, 76, 77, 78, 
	79, 80, 81, 82, 
	83, 84, 85, 86, 
	87, 88, 89, 90, 
	91, 92, 93, 94, 
	95, 96, 97, 98, 
	101, 102, 103, 104, 
	105, 106, 107, 108, 
	109, 110, 111, 112 };
	
	for ( int q = 0; q < SizeOfArray(WarpAllowedDMaps); q++ ) {
		if ( phase > 3 ) phase = 0;
		if ( dmap == WarpAllowedDMaps[q] ) return phase;
		phase++;
	}
	return -1;
}

//! These arrays are now at the scope of the functions that use them.

//These DMaps have day/night cycles. 
//int WarpAllowedDMaps[]={
//	0, 1, 2, 3, 
//	4, 5, 6, 7, 
//	11, 12, 13, 14, 
//	15, 16, 17, 18, 
//	19, 20, 21, 22, 
//	23, 24, 25, 26, 
//	27, 28, 29, 30,
//	32, 33, 34, 35, 
//	71, 72, 73, 74, 
//	75, 76, 77, 78, 
//	79, 80, 81, 82, 
//	83, 84, 85, 86, 
//	87, 88, 89, 90, 
//	91, 92, 93, 94, 
//	95, 96, 97, 98, 
//	101, 102, 103, 104, 
//	105, 106, 107, 108, 
//	109, 110, 111, 112 };


//int DungeonDMaps[]={
//	11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
//	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
//	32, 33, 34, 35, 36 };


//int OverworldDMaps[]={
//	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 
//	37, 38, 39, 40, 41, 42, 43, 44, 45, 
//	46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 
//	56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 
//	66, 67, 68, 69, 70, 
//	71, 72, 73, 74, 75, 76, 77, 78, 79, 80. 
//	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 
//	91, 92, 93, 94, 95, 96, 97, 98, 
//	99, 100, 101, 102, 103,
//	104, 105, 106, 107, 108, 109, 110, 111, 112 };



