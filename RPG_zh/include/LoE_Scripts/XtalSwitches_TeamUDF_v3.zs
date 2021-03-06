//Crystal Switch Combo IDs:

const int CMB_XTAL_RED_UP 		= 0;
const int CMB_XTAL_RED_DOWN		= 0;
const int CMB_XTAL_BLUE_UP 		= 0;
const int CMB_XTAL_BLUE_DOWN 		= 0;
const int CMB_XTAL_SWITCH_TRIG 		= 0;

//Switch States
const int XTAL_BLUE_UP 			= 1;
const int XTAL_RED_UP 			= 0;

//DMAP Constants
const int MAX_DMAPS 			= 512; ////Set to number of DMAPs in use.

//Arrays


bool XTalSwitchesList[262144]; //Set index size, to number of DMAPs in use, SQUARED.



//Add another DMAP to the switches affected by triggering them from a single DMAP.
void SetXTalSwitches(int row, int column, bool state){
	XTalSwitchesList[ (row * MAX_DMAPS) + column] = state;
}


//Sets switch positions for each DMAP, based on a list.
void XtalSwitches_SetDMAPs(){
	int curDMAP = Game->GetCurDMap();
	for ( int q = 0; q <= MAX_DMAPS; q++ ){
		if ( XTalSwitchesList[ (curDMAP * MAX_DMAPS) + q] != barriers[q] ) {
			barriers[q] = XTalSwitchesList[ (curDMAP * MAX_DMAPS) + q];
		}
	}
}



//Clear all Xtal switches on Exit.
void ClearXtalSwitches(){
	for ( int q = 0; q <= 512; q++ ){
		barriers[q] = false;
	}
}

ffc script SetXtalSwitches{
	void run(int dmap1, int dmap2,int dmap3, int dmap3, int dmap4, int dmap5, int dmap6, int dmap7, int dmap8){
		int row = Game->GetCurDMap();
		if ( dmap1) XTalSwitchesList[row] = dmap1;
		if ( dmap2) XTalSwitchesList[row+1] = dmap2;
		if ( dmap3) XTalSwitchesList[row+2] = dmap3;
		if ( dmap4) XTalSwitchesList[row+3] = dmap4;
		if ( dmap5) XTalSwitchesList[row+4] = dmap5;
		if ( dmap6) XTalSwitchesList[row+5] = dmap6;
		if ( dmap7) XTalSwitchesList[row+6] = dmap7;
		if ( dmap8) XTalSwitchesList[row+7] = dmap8;
	}
}


//The crystal switch code that Team is using...
const int SCRIPT_BARRIERS = 1; // Must refer to "Barrier"'s ffc script slot in the quest

// ID's of barrier-related combos
// Barriers in raised state
const int BARRIER_A_RAISED           = 32;
const int BARRIER_B_RAISED           = 33;

// Barriers in lowered state
const int BARRIER_A_LOWERED          = 34;
const int BARRIER_B_LOWERED          = 35;

// Barriers animating to raised state
const int BARRIER_A_ANIMRAISE        = 36;
const int BARRIER_B_ANIMRAISE        = 37;

// Barriers animating to lowered state
const int BARRIER_A_ANIMLOWER        = 38;
const int BARRIER_B_ANIMLOWER        = 39;

// Raised barriers that Link can walk on
const int BARRIER_A_WALKABLE         = 40;
const int BARRIER_B_WALKABLE         = 41;

// Barrier switches
const int BARRIER_A_SWITCH           = 42;
const int BARRIER_B_SWITCH           = 43;

const int BARRIER_SWITCH_DUMMY = 177; // ID of a switch hit detection dummy enemy
const int BARRIER_SWITCH_DUMMY_HP = 32767;

// Global array to store the state of barriers per dmap
// If you have more than 16 dmaps you can change the capacity in the []'s
// You may change the states in other scripts, but the changes will not be visible
// until there is a new screen, so set them before Barriers_NewScreen() is called.
bool barriers[512]; // false = blue barriers raised, true = red barriers raised


global script slot2 {
 void run() {
  // Initialize variables used to listen on screen changes
  int curscreen = -1;

  while (true) {
   // Keep track of screen changes
   // Run a Barrier script on every screen change
   if (Game->GetCurScreen() != curscreen) {
    curscreen = Game->GetCurScreen();
    Barriers_NewScreen();}

   Waitframe();}}}


// Function that makes preparations for barriers on each screen and starts an FFC script
void Barriers_NewScreen() {

 // Search for a barrier-related combo
 for (int i = 0; i <= 175; i++) {
  int cd = Screen->ComboD[i];
  if (cd == BARRIER_A_RAISED || cd == BARRIER_A_LOWERED || cd == BARRIER_A_SWITCH ||
      cd == BARRIER_B_RAISED || cd == BARRIER_B_LOWERED || cd == BARRIER_B_SWITCH) {
   // A barrier-related combo was found

   // Make initial changes to combos
   if (barriers[Game->GetCurDMap()]) {
    for (int j = i; j <= 175; j++) {
     int cd = Screen->ComboD[j];
     if (cd == BARRIER_A_RAISED) Screen->ComboD[j] = BARRIER_A_LOWERED;
     else if (cd == BARRIER_B_LOWERED) Screen->ComboD[j] = BARRIER_B_RAISED;
     else if (cd == BARRIER_A_SWITCH) Screen->ComboD[j] = BARRIER_B_SWITCH;}}
   else {
    for (int j = i; j <= 175; j++) {
     int cd = Screen->ComboD[j];
     if (cd == BARRIER_B_RAISED) Screen->ComboD[j] = BARRIER_B_LOWERED;
     else if (cd == BARRIER_A_LOWERED) Screen->ComboD[j] = BARRIER_A_RAISED;
     else if (cd == BARRIER_B_SWITCH) Screen->ComboD[j] = BARRIER_A_SWITCH;}}
   
   // So run FFCscript to control barriers
   int args[] = {0,0,0,0,0,0,0,0};
   RunFFCScript(SCRIPT_BARRIERS, args);
   break;}
}}

// This lets you toggle barriers on any dmap
bool ToggleBarriers(int dmap) {
 if (dmap == Game->GetCurDMap()) ToggleBarriers();
 else barriers[dmap] = !barriers[dmap];
 return barriers[dmap];}

// This toggles barriers on the desired dmaps
bool ToggleBarriers(int dmap1, int dmap2, int dmap3, int dmap4, int dmap5, int dmap6, int dmap7, int dmap8) {
 int bars[8]={dmap1,dmap2,dmap3,dmap4,dmap5,dmap6,dmap7,dmap8};
 for ( int q = 0; q < 8; q++ ){
	 int dmp = bars[q];
	 if ( dmp ) {
		 if ( barriers[dmp] == true ) barriers[dmp] = false;
		 else barriers[dmp] = true;
	 }
 }
 int curdmap = Game->GetCurDMap();
 if (!barriers[curdmap]) {
	 
	 //! This is where we need to modify the script.
  barriers[curdmap] = true;
  for (int i = 0; i <= 175; i++) {
   int cd = Screen->ComboD[i];
   if (cd == BARRIER_A_RAISED || cd == BARRIER_A_WALKABLE || cd == BARRIER_A_ANIMRAISE) {
    Screen->ComboD[i] = BARRIER_A_ANIMLOWER;}
   else if (cd == BARRIER_B_LOWERED || cd == BARRIER_B_ANIMLOWER) {
    Screen->ComboD[i] = BARRIER_B_ANIMRAISE;}
   else if (cd == BARRIER_A_SWITCH) {Screen->ComboD[i] = BARRIER_B_SWITCH;}}}
 else {
  barriers[curdmap] = false;
  for (int i = 0; i <= 175; i++) {
   int cd = Screen->ComboD[i];
   if (cd == BARRIER_B_RAISED || cd == BARRIER_B_WALKABLE || cd == BARRIER_B_ANIMRAISE) {
    Screen->ComboD[i] = BARRIER_B_ANIMLOWER;}
   else if (cd == BARRIER_A_LOWERED || cd == BARRIER_A_ANIMLOWER) {
    Screen->ComboD[i] = BARRIER_A_ANIMRAISE;}
   else if (cd == BARRIER_B_SWITCH) {Screen->ComboD[i] = BARRIER_A_SWITCH;}}}

 return barriers[curdmap];
}


// This toggles barriers on the current dmap
bool ToggleBarriers() {

 int curdmap = Game->GetCurDMap();
 if (!barriers[curdmap]) {
	 
	 //! This is where we need to modify the script.
  barriers[curdmap] = true;
  for (int i = 0; i <= 175; i++) {
   int cd = Screen->ComboD[i];
   if (cd == BARRIER_A_RAISED || cd == BARRIER_A_WALKABLE || cd == BARRIER_A_ANIMRAISE) {
    Screen->ComboD[i] = BARRIER_A_ANIMLOWER;}
   else if (cd == BARRIER_B_LOWERED || cd == BARRIER_B_ANIMLOWER) {
    Screen->ComboD[i] = BARRIER_B_ANIMRAISE;}
   else if (cd == BARRIER_A_SWITCH) {Screen->ComboD[i] = BARRIER_B_SWITCH;}}}
 else {
  barriers[curdmap] = false;
  for (int i = 0; i <= 175; i++) {
   int cd = Screen->ComboD[i];
   if (cd == BARRIER_B_RAISED || cd == BARRIER_B_WALKABLE || cd == BARRIER_B_ANIMRAISE) {
    Screen->ComboD[i] = BARRIER_B_ANIMLOWER;}
   else if (cd == BARRIER_A_LOWERED || cd == BARRIER_A_ANIMLOWER) {
    Screen->ComboD[i] = BARRIER_A_ANIMRAISE;}
   else if (cd == BARRIER_B_SWITCH) {Screen->ComboD[i] = BARRIER_A_SWITCH;}}}

 return barriers[curdmap];
}


// This script controls barriers on the screen
// The FFC is automatically created by Barriers_NewScreen()
ffc script Barriers {
 void run(int dmap1, int dmap2, int dmap3, int dmap4, int dmap5, int dmap6, int dmap7, int dmap8) {

  // Initialize storage for bswitch hit dummies
  int bswitch_count;
  npc bswitch[8];

  for (int i = 0; i <= 175; i++) {
   if (Screen->ComboD[i] == BARRIER_A_SWITCH || Screen->ComboD[i] == BARRIER_B_SWITCH) {
    npc bs = CreateNPCAt(BARRIER_SWITCH_DUMMY, ComboX(i), ComboY(i));
    bs->HitWidth = 8; // Smaller hit box to avoid annoying collisions with Link
    bs->HitHeight = 8;
    bs->HP = BARRIER_SWITCH_DUMMY_HP;
    bswitch[bswitch_count++] = bs;}}

  // Change raised barriers to walkable ones if Link enters screen on a raised barrier
  int lcombo = LinkOnComboD();
  bool onbarrier = (lcombo == BARRIER_A_RAISED || lcombo == BARRIER_B_RAISED);
  if (onbarrier) for (int i = 0; i < 176; i++) {
   if (Screen->ComboD[i] == BARRIER_A_RAISED) {Screen->ComboD[i] = BARRIER_A_WALKABLE;}
   else if (Screen->ComboD[i] == BARRIER_B_RAISED) {Screen->ComboD[i] = BARRIER_B_WALKABLE;}}


  while (true) {

   // Detect hits on bswitches, and change combos accordingly
   for (int j = 0; j < bswitch_count; j++) {
    if (bswitch[j]->HP < BARRIER_SWITCH_DUMMY_HP) {
     bswitch[j]->HP = BARRIER_SWITCH_DUMMY_HP;
     ToggleBarriers(dmap1,dmap2,dmap3,dmap4,dmap5,dmap6,dmap7,dmap8);
     break;}} //break so that only one bswitch hit may register per frame


   // Make barriers walkable if Link is on raised barriers, or unwalkable if not
   lcombo = LinkOnComboD();
   if (!onbarrier && (lcombo == BARRIER_A_RAISED || lcombo == BARRIER_B_RAISED)) {
    onbarrier = true;
    for (int i = 0; i <= 175; i++) {
     if (Screen->ComboD[i] == BARRIER_A_RAISED) {Screen->ComboD[i] = BARRIER_A_WALKABLE;}
     else if (Screen->ComboD[i] == BARRIER_B_RAISED) {Screen->ComboD[i] = BARRIER_B_WALKABLE;}}}
   else if (onbarrier && !(lcombo == BARRIER_A_WALKABLE || lcombo == BARRIER_B_WALKABLE)) {
    onbarrier = false;
    for (int i = 0; i <= 175; i++) {
     if (Screen->ComboD[i] == BARRIER_A_WALKABLE) {Screen->ComboD[i] = BARRIER_A_RAISED;}
     else if (Screen->ComboD[i] == BARRIER_B_WALKABLE) {Screen->ComboD[i] = BARRIER_B_RAISED;}}}

   Waitframe();}
}}



// A utility function that returns the ID of the combo that Link appears to stand on
int LinkOnComboD() {
 return Screen->ComboD[ComboAt(Link->X+8, Link->Y+13)];
}

