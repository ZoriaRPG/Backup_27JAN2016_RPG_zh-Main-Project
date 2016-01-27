//Revised Day/Night Cycle System for ywlks
//v0.6

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
	if ( DMapChanged() && TimeWarped() ) {
		PreviousDMap = Game->GetCurDMap();
		LastOverworldMap = Game->GetCurDMap();
		SetDmapChanged(0);
		TimeWarped(0);
	}
	
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



