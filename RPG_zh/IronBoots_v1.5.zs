////////////////////////
/// Iron Boots Alpha ///
/// v1.5             ///
/// 22nd July, 2015  ///
/// ZoriaRPG         ///
////////////////////////

//General constants.
const int WALK_TIME = 24; //The timer for WalkSpeed().
const int WALK_SPEED_POWERUP = -4; //Number of extra Pixels Link walks when he has the boots enabled.
const int RING_COUNTER_BASE = 100; //The number of frames, before the blue ring activates. 
const int BOOTS_SENS = 1; //Sensitivity of collision. 
const int SFX_BOOTS_TRIGGER = 100; //Sound effect for triggering boots pressure panel. 
const float WALK_FRACTION = 0.016;
const int WALK_STEP = 1;


//Arrays
int IronBoots[10]; //Array to store Iron Boots variables. 

///////////////////////////////////////////
/// Combos Used for Iron Boots Triggers ///
///////////////////////////////////////////
int IronBootsCombos[]={0,0,0,0,0}; //Populate with Combo IDs for Boots Triggers...


//Array Indices
const int IRONBOOTS = 0; //Boolean for Iron Boots
const int POWER_WALK_TIMER = 1;
const int BLUE_RING_TIMER = 2;
const int WEAR_BLUE_RING = 3;
const int TRIGGER_PRESSURE_PLATE = 4;
const int WALK_SPEED_RIGHT = 5;
const int WALK_SPEED_LEFT = 6;
const int WALK_SPEED_UP = 7;
const int WALK_SPEED_DOWN = 8;
const int SLOW_WALK_TIMER = 9;
//5 through 7 reserved.


///////////////
/// SCRIPTS ///
///////////////

//! Global Active Script Template
//Place the commands for this, before waitdraw, in this order.

global script example{
	void run(){
		DecrementRingTimer();
		IronBootsPanel();
		ClearWalkTimer();
		WalkSpeed();
		Waitdraw();
		TriggerPressurePlate();
		Waitframe();
	}
}


//! Iron Boots Item Script

//Attach to the iron boots item:
//Assign to the active inventory item. using it will equip the Iron Boots, if not equipped, or the reverse.
//Arg D0, if non-zero, should match the item ID of a dummy item that has an Iron Boots tile. 
//	This is used only to show the item equipped on the subscreen.
//! If you want to draw a special icon on the passive subscreen, I can add that to this header for you.
item script IronBoots{
	void run(int dummyItem){
		if ( !IronBoots() ){
			IronBoots(true);
			if ( dummyItem && !Link->Item[dummyItem] ) Link->Item[dummyItem] = true;
		else {
			IronBoots(false);
			if ( dummyItem && Link->Item[dummyItem] ) Link->Item[dummyItem] = true;
		}
	}
}

///////////////////////////
/// Modified FFC Script ///
///////////////////////////

//! Note: Arg D3 removed, as it's no longer needed. 

ffc script WindBlower_IronBoots {
	void run(int flag, int dirOfWind, float windStrength){
		int blowAmount;
		float remainder;
		while (true) {
        
		    // If Link doesn't have the item that makes him immune to wind equipped,
		    // the wind will blow him away.
		if ( !IronBoots() ) {
			// Check all 4 corners of Link's sprite to see if he is touching the flag.
			if (ComboFI(Link->X, Link->Y, flag) || ComboFI(Link->X+15, Link->Y, flag)
				|| ComboFI(Link->X, Link->Y+15, flag) || ComboFI(Link->X+15, Link->Y+15, flag))
				{
					// If the wind strength is not a whole number, we want to make sure
					// Link gets blown away at the correct rate.
					blowAmount=windStrength;
					remainder+=windStrength-blowAmount;
					if (remainder>=1) {
						blowAmount+=Floor(remainder);
						remainder-=Floor(remainder);
					}
					bool canBlow=true;
					// Check walkability along path of blowing.
					for (int i=1; i<=blowAmount; i++){
						if (!CanWalk(Link->X, Link->Y, dirOfWind, i, false)){
							canBlow=false;
							break;
						}
					}
					// Blow Link away!
					if (canBlow){
						if (dirOfWind==DIR_UP) Link->Y-=blowAmount;
						else if (dirOfWind==DIR_DOWN) Link->Y+=blowAmount;
						else if (dirOfWind==DIR_LEFT) Link->X-=blowAmount;
						else if (dirOfWind==DIR_RIGHT) Link->X+=blowAmount;
					}
				}
				else remainder=0;
			}
			Waitframe();
		}
	}

}


/////////////////
/// FUNCTIONS ///
/////////////////

//Reduces the timer, to create a delay before Link has the blue ring. 
//Takes it away instantly, if he unequips the boots, and resets the delay timer. 
void DecrementRingTimer(){
	if ( !IronBoots() ){
		if ( Link->Item[I_RING1] ) Link->Item[I_RING1] = false;
		if ( IronBoots[BLUE_RING_TIMER] != RING_COUNTER_BASE ) IronBoots[BLUE_RING_TIMER] = RING_COUNTER_BASE;
	}
	if ( IronBoots() ) {
		if ( IronBoots[BLUE_RING_TIMER] > 0 && !Link->Item[I_RING1] ){
			IronBoots[BLUE_RING_TIMER]--;
		}
		if ( IronBoots[BLUE_RING_TIMER] < 1 && !Link->Item[I_RING1] ) {
			Link->Item[I_RING1] = true;
		}
	}
}

void TriggerPressurePlate(){
	if ( IronBoots[TRIGGER_PRESSURE_PLATE] ) {
		IronBoots[TRIGGER_PRESSURE_PLATE] = 0;
		Game->PlaySound(SFX_BOOTS_TRIGGER);
		Screen->TriggerSecrets();
	}
}



//Triggers Screen Secrets if the player touches an Iron Boots combo trigger while wearing them.
void IronBootsPanel(){
	if ( IronBoots() ) {
		for ( int q = 0; q < 176; q++ ) {
			for ( int w = 0; w < SizeOfArray(IronBootsCombos); w++ ) {
				if ( Screen->ComboD[q] == IronBootsCombos[w] && _LinkComboCollision(q,BOOTS_SENS) ) {
					IronBoots[TRIGGER_PRESSURE_PLATE] = 1;
				}
			}
		}
	}
}

//Retruns true if the Iron Boots are equipped.
int IronBoots(){
	return IronBoots[IRONBOOTS];
}

//Equips, or unequips the Iron Boots.
void IronBoots(bool setting){
	if ( setting ) IronBoots[IRONBOOTS] = 1;
	else IronBoots[IRONBOOTS] = 0;
}

void ClearWalkTimer(){
	if ( !IronBoots() ) {
		IronBoots[POWER_WALK_TIMER] == WALK_TIME;
	}
}

//Increase walking speed when Link has a Piece of Power and LA_WALKING
void WalkSpeed(){
	int linkX;
	int linkY;
	if ( IronBoots() ) { //Check to see if Link has a Piece of Power power-up boost...
		if ( Link->Action == LA_HOLD1LAND ) return;
		if ( Link->Action == LA_WALKING && !LinkJump() && Link->Z == 0 ) { //If he isnt attacking, swimming, hurt, or casting, and h
			if ( Link->InputDown && !IsSideview() //If the player presses down, and we aren't in sideview mode...
				&& !Screen->isSolid(Link->X,Link->Y+17) //SW Check Solidity
				&& !Screen->isSolid(Link->X+7,Link->Y+17) //S Check Solidity
				&& !Screen->isSolid(Link->X+15,Link->Y+17) //SE Check Solidity
			) {
				IronBoots[WALK_SPEED_DOWN] += WALK_FRACTION;
				
				//We use a timer to choke the walk speed. Without it, Link would move the full additional number of
				//pixels PER FRAME. THus, a walk speed bonus of +1 would be +60 pixels (almost four tiles) PER SECOND!
				if ( IronBoots[WALK_SPEED_DOWN] >= WALK_STEP ) {  //If our timer is fresh, or has reset...
					IronBoots[WALK_SPEED_DOWN] = 0;
					Link->Y += WALK_SPEED_POWERUP; //Let Link move faster...
				}
			}
			else if ( Link->InputUp && !IsSideview()  //If the player presses up, and we aren't in sideview mode...
				&& !Screen->isSolid(Link->X,Link->Y+6) //NW Check Solidity
				&& !Screen->isSolid(Link->X+7,Link->Y+6) //N Check Solidity
				&& !Screen->isSolid(Link->X+15,Link->Y+6) //NE Check Solidity
			) {
				IronBoots[WALK_SPEED_UP] += WALK_FRACTION;
				if ( IronBoots[WALK_SPEED_UP] >= WALK_STEP ) { //If our timer is fresh, or has reset...
					IronBoots[WALK_SPEED_UP] = 0;
					Link->Y -= WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
				}
			}
			else if ( Link->InputRight && !Screen->isSolid(Link->X+17,Link->Y+8) //If the player presses right, check NE solidity...
				&& !Screen->isSolid(Link->X+17,Link->Y+15) //and check SE Solidity 
			) { 
				IronBoots[WALK_SPEED_RIGHT] += WALK_FRACTION;
				if ( IronBoots[WALK_SPEED_RIGHT] >= WALK_STEP ) { //If our timer is fresh, or has reset...
					IronBoots[WALK_SPEED_RIGHT] = 0;
					Link->X += WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
				}
			}
			else if ( Link->InputLeft && !Screen->isSolid(Link->X-2,Link->Y+8)  //If the player presses right, check NW solidity...
				&& !Screen->isSolid(Link->X-2,Link->Y+15) //SW Check Solidity
			) {
				IronBoots[WALK_SPEED_LEFT] += WALK_FRACTION;
				if ( IronBoots[WALK_SPEED_LEFT] >= WALK_STEP ) { //If our timer is fresh, or has reset...
					IronBoots[WALK_SPEED_RIGHT] = 0;
					Link->X -= WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
				}
			}
		}
	}
	if ( IronBoots[POWER_WALK_TIMER] > 0 && IronBoots[POWER_WALK_TIMER] != WALK_TIME ) IronBoots[POWER_WALK_TIMER]--; 
	//Decrement the timer if it is greater than zero, and not = to WALK_TIME.
	if ( IronBoots[POWER_WALK_TIMER] <= 0 ) IronBoots[POWER_WALK_TIMER] = WALK_TIME; //If it's back to zero, reset it.
}


//Returns TRUE if Link touches the combo.
bool _LinkComboCollision(int loc, int sens){
	int ax = Link->X;
	int ay = Link->Y;
	int bx = (Link->X)+(Link->HitWidth);
	int by = (Link->Y)+(Link->HitHeight);
	if(!(RectCollision( ComboX(loc), ComboY(loc), (ComboX(loc)+16), (ComboY(loc)+16), ax, ay, bx, by))) return false;
	else if (!(Distance(CenterLinkX(), CenterLinkY(), (ComboX(loc)+8), (ComboY(loc)+8)) < (sens+8))) return false;
	else return true;
}

void SlowLink(){
	if ( IronBoots[SLOW_WALK_TIMER] % 2 ) Waitframe();
}

