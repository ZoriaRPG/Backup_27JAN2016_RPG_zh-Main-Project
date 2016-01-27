int LastSixScreens[14]={	QUEST_START_SCREEN, 0,0,0,0,0,
				QUEST_START_DMAP,   0,0,0,0,0 
				0,0};
	

const int QUEST_START_SCREEN = 0;
const int QUEST_START_DMAP = 1;

const int SIX_SCREENS_DMAP = 6;
const int SCREEN_RECENTLY_VISITED = 13;
				
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
	else arr[SCREEN_RECENTLY_VISITED] = 1; //THis value is used by scripts, as a flag.
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
	

//bool ScreenVisitedRecently;

//void SetScreenVisitation(int dmap, int screen){
//	int scr = Game->GetCurScreen();
//	int dmp = Game->GetCurDMap();
	