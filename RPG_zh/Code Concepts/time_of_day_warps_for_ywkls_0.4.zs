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
 
// handles actually changing the Time Period dmap 
void TS_CheckandWarp(int linkdir, bool useffc){
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
				109,110,11,112 };
				
		int curmap = Game->GetCurDMap();
				
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
				
		if ( !useffc) Link->PitWarp(warpMaps[mapset+linkdir]), Game->GetCurScreen());
		else {
			if(TS_DMaps[i] + TS_CurrentState != Game->GetCurDMap() ) {
				Link->PitWarp(TS_DMaps[i] + TS_CurrentState, Game->GetCurDMapScreen());
			}
		}
}



//Draws a closing and opening circle during time warp.
void TimeWarp(int linkdir){
	IsTimeWarping = false;
	closingWipe(60);
	TS_CheckandWarp(linkdir,false);
	openingWipe(60);
}
 
// put this on any Time Period screens where you return from a warp, script run on screen init
ffc script FFC_TS_WarpReturnCheck{
	void run(){
		TS_CheckandWarp(TS_CurrentState,true);
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


//Checks if the combo at your location has the right flag, type or number so you can time warp.
bool isTimeWarp(int loc){
   return (Cond(TS_TIMEWARPFLAG == -1, true, ComboFI(loc,TS_TIMEWARPFLAG) ) 
        && Cond(TS_TIMEWARPTYPE == -1, true, Screen->ComboT[loc] == TS_TIMEWARPTYPE)
        && Cond(TS_TIMEWARPCOMBO == -1, true, Screen->ComboD[loc] == TS_TIMEWARPCOMBO) );
}

//replace if (isTimewarping)Timewarp(); with this, and put before Waitdraw()

void DoWarp(){
	if (isTimewarping){
		NoAction();
		Timewarp(TS_CurrentState);
	}
}