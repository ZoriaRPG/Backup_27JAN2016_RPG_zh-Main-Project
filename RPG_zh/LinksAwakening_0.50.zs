//Pieces of Power, Guardian Acorns, and Secret Shells v0.50
//1st July, 2015


//Set-up: Make a new item (Green Ring), set it up/ as follows:
//Item Class Rings
//Level: 1
//Power: 1
//CSet Modifier : None
//Assign this ring to Link's starting equipment in Quest->Init Data->Items

//Change the blue ring to L2, red to L3, and any higher above these. 

int PlayingPowerUp[258]; //An array to hold values for power-ups. Merge with main array later?
int Z4_ItemsAndTimers[22]; //Array to hold the values for the Z4 items. 
int StoneBeaks[10];	//An array to hold if we have a stone beak per level. 
			//Each index corresponds to a level number.
			//If you need levels higher than '9', increase the index size to 
			//be eaqual to the number of levels in your game + 1.
			

//Settings

const int NEEDED_PIECES_OF_POWER = 3; //Number of Pieces of power needed for temporary boost.
const int NEEDED_ACORNS = 3; //Number of Acorns needed for temporary boost.
const int REQUIRED_SECRET_SHELLS = 20; //Number of Secret Shell items to unlock the secret.
const int BUFF_TIME = 900; //Duration of boost, in frames. Default is 15 seconds.

const int REQUIRE_CONSECUTIVE_KILLS = 12; 	//The number of enemies the player must kill without being hurt,
						// to obtain a free Guardian Acorn.
const int REQUIRE_KILLS_PIECE_OF_POWER_MIN = 40; //The minimum number of enemies to kill (random number min) 
						 //to obtain a free Piece of Power.
const int REQUIRE_KILLS_PIECE_OF_POWER_MAX = 45; //The maximum number of enemies to kill (random number max)
						 //to obtain a free Piece of Power.

const int PLAY_ACORN_MESSAGE = 1; //Set to 0 to turn off messages.
const int PLAY_PIECE_OF_POWER_MESSAGE = 1; //Set to 0 to disable messages for Piece of Power power-ups.
const int BONUS_SHELL_DIVISOR = 5; //Award bonus Secret Shell if number on hand is this number, on each visit to Seashell mansion.
const int WALK_SPEED_POWERUP = 4; //Number of extra Pixels Link walks when he has a Piece of Power

const int RANDOMISE_PER_PLAY = 0; //Set to '1' if you want to randomise the number of kills on each load (continue).
const int PLAY_POWERUP_MIDI = 1; //Set to '1' to play a MIDI while a power-up boost is in effect.
const int KILL_AWARDS = 1; //Set to '0' to disable automatic awards of Pieces of Power and Guardian Acorns
				//based on enemy kill counts.
const int REMOVE_ATTACK_BOOST_WHEN_PLAYER_DAMAGED = 1; //Set to '0' to disable removing the boost when player is damaged X times.
const int NUM_HITS_TO_LOSE_POWER_BOOST = 3; //The number of times a player with a Piece of Power power-up boost
					    //must be hit, before the effect prematurely ends.

const int ENEMIES_ALWAYS_EXPLODE = 1; //Set to '0' if enemies only explode when a player has a Piece of Power power-up.
const int EXPLOSIONS_RUN_WITH_FFCS = 0; //If set to 1, enemy explosions on death will run from FFCs
					//rather than from the global active infinite loop.

//Item Numbers : These are here for later expansion, and are unused at present.
const int I_GREEN_RING = 143; //Item number of Green Ring  
const int I_PIECE_POWER = 144; //Item number of Piece of Power
const int I_ACORN = 145; //Item number of Acorn
const int I_SHELL = 146; //Item number of Secret Shell

//Array Indices ( ! Do not change these ! )
const int POWER_TIMER = 0; //The timer for Piece of Power damage boost duration.
const int DEF_TIMER = 1; //The timer for Guardian Acorn defence boost duration.
const int NUM_PIECES_POWER = 2; //The present number of Pieces of Power held by the player.
const int NUM_ACORNS = 3; //The present number of Guardian Acorns held by the player.
const int POWER_BOOSTED = 4; //This == 1 if the player has a Piece of Power power-up boost.
const int DEF_BOOSTED = 5; //This == 1 if the player has a Guardian Acorn power-up boost.
const int NUM_SHELLS = 6; //The present number of Secret Shells held by player.
const int MSG_GUARDIAN_PLAYED = 7; //Reports if a message has played for a Guardian Acorn boost.
const int MSG_PIECE_POWER_PLAYED = 8; //Reports if a message has played for a Piece of Power boost.
const int POWERUP_PLAYER_HP = 9; //Holds player HP for this frame to compare to...
const int POWERUP_PLAYER_OLD_HP = 10; //Holds previous player HP.
const int POWERUP_ENEMY_KILLS = 11; //Number of enemies killed since last free Piece of Power.
const int POWERUP_CONSECUTIVE_ENEMY_KILLS = 12; //Number of enemies killed since player was last hurt.
const int POWERUP_NUM_ENEMIES = 13; //The number of enemies at present.
const int POWERUP_CURDMAP = 14; //The current DMap. used to determine if screen has changed.
const int POWERUP_CURSCREEN = 15; //The current Screen. used to determine if screen has changed.
const int POWERUP_SCREEN_HAS_CHANGED = 16; //Will return '1' (true) if screen has changed; otherwise '0' (false).
const int POWERUP_LINK_DAMAGED = 17; //Stores a value if Link was hit. Cleared after killing a monster.
const int POWERUP_PIECE_OF_POWER_NEEDED_KILLS = 18; //The present number of total enemy deaths needed for a free
						    //Piece of Power. Updated by PieceOfPowerKills() with a 
						    //randomly generated value each time a free Piece of Power
						    //is awarded from this value.
const int POWERUP_LINK_HURT_COUNTER = 19;
const int POWERUP_LINK_HURT_COUNTER_LAST = 20;

//Sound effects constants.
const int SFX_POWER_BOOSTED = 65; //Sound to play when Attack Buffed
const int SFX_SECRET_SHELL = 66; //Sound to play when unlocking shell secret.
const int SFX_GUARDIAN_DEF = 68; //Sound to play when Defence buffed.
const int SFX_NERF_POWER = 72; //Sound to play when Piece of Power buff expires.
const int SFX_NERF_DEF = 73; //Sound to play when Guardian Acorn buff expires
const int SFX_BONUS_SHELL = 0; //Sound to play when awarded a bonus Secret Shell.

//Enemy Explosion Constants
const int FFC_ENEMY_EXPLODE = 0; //Set to FFC script slot for death explosion FFC animation.
const int FFC_NUM_OF_EXPLOSIONS = 4; //Base number of explosions when killing an enemy.
const int FFC_EXPLOSION_SPRITE = 0; //Sprite for the explosion.
const int FFC_EXPLOSION_EXTEND = 4; //Size of explosion eweapon.
const int FFC_EXPLOSION_TILEWIDTH = 2; //Width of explosion, in tiles.
const int FFC_EXPLOSION_TILEHEIGHT = 2; //Height of explosion, in tiles.

const int FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS = 2; //Number of extra explosions if player has Piece of Power
							 //power-up (attack) boost.

//MIDI Constants
const int PLAYING_POWER_UP_MIDI = 256;
const int NORMAL_DMAP_MIDI = 0; //Used for two things: Array index of normal DMap MIDIs (base), 
				//and as parameter in function PlayPowerUpMIDI()


//Power-Up Messages

const int MSG_GUARDIAN_ACORN = 0; //ID of String for Guardian Acorn Message
const int MSG_PIECE_POWER = 0; //ID of String for Piece of Power Message
const int POWERUP_MIDI = 10; //Set the the number of a MIDI to play while a Power-Up is in effect.








//int NerfedAttack[]="Attack power nerfed."; //String for TraceS()

//////////////////////
/// MAIN FUNCTIONS ///
//////////////////////

//Run every frame **BEFORE** both Waitdraw() **AND** LinksAwakeningItems();
void ReduceBuffTimers(){
	if ( Z4_ItemsAndTimers[POWER_TIMER] > 0 ) {
		Z4_ItemsAndTimers[POWER_TIMER]--;
	}
	if ( Z4_ItemsAndTimers[DEF_TIMER] > 0 ) {
		Z4_ItemsAndTimers[DEF_TIMER]--;
	}
}

//Run every frame, before Waitdraw();
void LinksAwakeningItems(){
	PiecesOfPower();
	Acorns();
	WalkSpeed();
}

void Z4_EnemyKillRoutines(){
	Z4ScreenChanged();
	CountEnemies();
	StoreLinkHP();
	UpdateKilledEnemies();
	EnemiesExplodeOnDeath();
	KillPieceOfPower();
	KillAwards();
	
}

//Increase walking speed when Link has a Piece of Power and LA_NONE
void WalkSpeed(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
		if ( Link->Action == LA_NONE && !LinkJump() && Link->Z == 0 ) {
			if ( Link->PressDown && !isSideview() 
				&& !Screen->isSolid(Link->X,Link->Y+17) //SW Check Solidity
				&& !Screen->isSolid(Link->X+7,Link->Y+17) //S Check Solidity
				&& !Screen->isSolid(Link->X+15,Link->Y+17) //SE Check Solidity
			) {
				//Do we also need isSolid() checks here?
				Link->X += WALK_SPEED_POWERUP;
			}
			if ( Link->PressUp && !isSideview() 
				&& !Screen->isSolid(Link->X,Link->Y+6) //NW Check Solidity
				&& !Screen->isSolid(Link->X+7,Link->Y+6) //N Check Solidity
				&& !Screen->isSolid(Link->X+15,Link->Y+6) //NE Check Solidity
			) {
				Link->X -= WALK_SPEED_POWERUP;
			}
			if ( Link->PressRight && !Screen->isSolid(Link->X+17,Link->Y+8) //NE Check Solidity
				&& !Screen->isSolid(Link->X+17,Link->Y+15) //SE Check Solidity 
			) { 
				Link->Y += WALK_SPEED_POWERUP;
			}
			if ( Link->PressLeft && !Screen->isSolid(Link->X-2,Link->Y+8) //NW Check Solidity
				&& !Screen->isSolid(Link->X-2,Link->Y+15) //SW Check Solidity
			) {
				Link->Y -= WALK_SPEED_POWERUP;
			}
		}
	}
}

///Functions called by MAIN functions:

//Runs every frame from LinksAwakeningItems();
void PiecesOfPower(){
	if ( Z4_ItemsAndTimers[NUM_PIECES_POWER] >= NEEDED_PIECES_OF_POWER ) {
		Z4_ItemsAndTimers[NUM_PIECES_POWER] = 0; 
		Z4_ItemsAndTimers[POWER_TIMER] = BUFF_TIME;
		BoostAttack();
	}
	NerfAttack();
}

//Runs every frame from LinksAwakeningItems();
void Acorns(){
	if ( Z4_ItemsAndTimers[NUM_ACORNS] >= NEEDED_ACORNS ) {
		Z4_ItemsAndTimers[NUM_ACORNS] = 0; 
		Z4_ItemsAndTimers[DEF_TIMER] = BUFF_TIME;
		BoostDefence();
	}
	NerfDefence();
}

//Runs from PiecesOfPower()();
void BoostAttack(){
	if ( Z4_ItemsAndTimers[POWER_TIMER] && !Z4_ItemsAndTimers[POWER_BOOSTED] ) {
		BuffSwords();
	}
	if ( PLAY_PIECE_OF_POWER_MESSAGE ) {
		PieceOfPowerMessage(MSG_PIECE_OF_POWER);
	}
}

//Runs from PiecesOfPower()
void NerfAttack(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] && Z4_ItemsAndTimers[POWER_TIMER] < 1 ) {
		Z4_ItemsAndTimers[POWER_BOOSTED] = 0;
		NerfSwords();
		Z4_ItemsAndTimers[POWER_TIMER] = 0;
	}
}

//Runs from Acorns();
void BoostDefence(){
	if ( Z4_ItemsAndTimers[DEF_TIMER] && !Z4_ItemsAndTimers[DEF_BOOSTED] ) {
		BuffRings();
	}
	if ( PLAY_ACORN_MESSAGE ) {
		AcornMessage(MSG_GUARDIAN_ACORN);
	}
}

//Runs from Acorns()
void NerfDefence(){
	if ( Z4_ItemsAndTimers[DEF_BOOSTED] && Z4_ItemsAndTimers[DEF_TIMER] < 1 ) {
		Z4_ItemsAndTimers[DEF_BOOSTED] = 0;
		NerfRings();
		Z4_ItemsAndTimers[DEF_TIMER] = 0;
	}
}

//Runs from BoostDefence();
void BuffSwords(){
	float presentPower;
	for ( int q = 0; q <= 255; q++ ) {
		itemdata id = Game->LoadItemData(q);
		if ( id->Family ==  IC_SWORD ) {
			presentPower = id->Power;
			id->Power = presentPower * 2;
		}
	}
	Game->PlaySound(SFX_POWER_BOOSTED);
	Z4_ItemsAndTimers[POWER_BOOSTED] = 1;
}

//Runs from BoostDefence();
void BuffRings(){
	float presentPower;
	for ( int q = 0; q <= 255; q++ ) {
		itemdata id = Game->LoadItemData(q);
		if ( id->Family ==  IC_RING ) {
			presentPower = id->Power;
			id->Power = presentPower * 2;
		}
	}
	Game->PlaySound(SFX_GUARDIAN_DEF);
	Z4_ItemsAndTimers[DEF_BOOSTED] = 1;
}

//Runs from BoostDefence();
void NerfSwords(){
	float presentPower;
	for ( int q = 0; q <= 255; q++ ) {
		itemdata id = Game->LoadItemData(q);
		if ( id->Family ==  IC_SWORD ) {
			presentPower = id->Power;
			id->Power = presentPower * 0.5;
		}
	}
	Game->PlaySound(SFX_NERF_POWER);
}

//Runs from BoostDefence();
void NerfRings(){
	float presentPower;
	for ( int q = 0; q <= 255; q++ ) {
		itemdata id = Game->LoadItemData(q);
		if ( id->Family ==  IC_RING ) {
			presentPower = id->Power;
			id->Power = presentPower * 0.5;
		}
	}
	Game->PlaySound(SFX_NERF_DEF);
}

/////////////////////////
/// Utility Functions ///
/////////////////////////

//Returns number of Secret Shells collected.
int NumShells(){
	return Z4_ItemsAndTimers[NUM_SHELLS];
}

//Awards a bonus Secret Shell
void BonusShell(){
	Z4_ItemsAndTimers[NUM_SHELLS]++;
}

//Returns true if the player has either an active Guardian Acorn Power-Up, or an active Piece of Power power-up.
bool HasPowerUp(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] || Z4_ItemsAndTimers[DEF_BOOSTED] ) {
		return true;
	}
	return false;
}

//Returns true if the player has a stone beak for the present level; and returns the number of beaks.
bool StoneBeak(){
	int lvl = Game->GetCurLevel();
	return StoneBeaks[lvl];
}

//Returns Link->Jump as an int. For whatever reason, this is recorded to allegro.log as a float, and some ZC versions
//have a bug involving this value, so we Floor it first.
int LinkJump(){
	int jmp = Floor(Link->Jump);
	return jmp;
}

//Automatically plays messages when the player has a Guardian Acorn power-up.
void AcornMessage(int msg){
	if ( ! Z4_ItemsAndTimers[MSG_GUARDIAN_PLAYED] && Z4_ItemsAndTimers[DEF_BOOSTED] ){
		Z4_ItemsAndTimers[MSG_GUARDIAN_PLAYED] = 1;
		Screen->Message(msg);
	}
}

//Automatically plays messages when the player has a Piece of Power power-up.
void PieceOfPowerMessage(int msg){
	if ( ! Z4_ItemsAndTimers[MSG_PIECE_POWER_PLAYED] && Z4_ItemsAndTimers[POWER_BOOSTED] ){
		Z4_ItemsAndTimers[MSG_PIECE_OF_POWER_PLAYED] = 1;
		Screen->Message(msg);
	}
}

//////////////////////////////
/// Powerup MIDI Functions ///
//////////////////////////////

//Back up the original MIDIs so that we can later restore them.
void Backup_MIDIs(){
	for ( int q = 0; q <= 255; q++ ) {
		PlayingPowerUp[q] = Game->DMapMIDI[q];
	}
}

//Copies all original MIDIs back to Game->DMapMIDI[]
void RestoreNonPowerUpMIDIs(){
	for ( int q = 0; q <= 255; q++ ) {
		Game->DMapMIDI[q] = PlayingPowerUp[q];
	}
}

//An easy way to determine if we are playing a special MIDI for the power-ups.
//bool PlayingPowerUpMIDI(){
//	return PlayingPowerUp[PLAYING_POWER_UP_MIDI];
//}

//An easy way to determine if we are playing a special MIDI for the power-ups.
bool PlayingPowerUpMIDI(){
	int lvl = Game->GetCurLevel();
	if ( Game->DMapMIDI[lvl] == POWERUP_MIDI ){
		return true;
	}
	return false;
}

//Change the value of this index, from 0 to 1, or 1 to 0, so that we can use it as a boolean flag to determine
//if we are playing a power-up MIDI.
void PlayingPowerUpMIDI(int setting){
	PlayingPowerUp[PLAYING_POWER_UP_MIDI] = setting;
}

//Copy the POWERUP_MIDI to DMapMIDI[] for this level, and hopefully auto-play it.
void PlayPowerUpMIDI(){
	int lvl = Game->GetCurLevel();
	Game->DMapMIDI[lvl] = POWERUP_MIDI;
}
	

//Plays MIDI set as POWERUP_MIDI while a powerup is in effect.
void PowerUpMIDI(){
	if ( HasPowerUp() && !PlayingPowerUpMIDI() ) {
		
		//! I believe we need to copy the special MIDI to all DMAPs.
		
		PlayingPowerUpMIDI(PLAY_POWERUP_MIDI);
		PlayPowerUpMIDI();
		//Game->PlayMIDI(POWERUP_MIDI);
	}
	if ( !HasPowerUp() && PlayingPowerUpMIDI() ) {
		RestoreNonPowerUpMIDIs();
		PlayingPowerUpMIDI(NORMAL_DMAP_MIDI);
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
item script GuardianAcorn{
	void run(){
		Z4_ItemsAndTimers[NUM_ACORNS]++;
	}
}

//Shell item PICKUP script. 
item script SecretShell{
	void run(){
		Z4_ItemsAndTimers[NUM_SHELLS]++;
	}
}



//Attach as the Pick-Up script for the stone beak item.
item script StoneBeak_Pickup{
	void run(){
		int level = Game->GetCurLevel();
		StoneBeaks[level]++;
	}
}

///////////////////
/// FFC Scripts ///
///////////////////

// Attach to an FFC of an owl statue. If Link has a stone beak for this level, this statue will play
// the message set by arg D0.
ffc script OwlStatue {
	void run (int msg){
		if ( DistanceLink(this->X+8,this->Y+8) < 14 && StoneBeak() && Link->PressA ){ //
			//If Link has the stone beak for this level, and presses A...
			Screen->Message(msg); //Display the string set by arg D0.
			Link->InputA = false; //Don't swing sword.
		}
	}
}

// FFC Script for Secret Shell Mansion
// D0: The Screen->D Register to use to store datum. 
// D1: Set to a value of '1' or higher, to make secret permanent. 
ffc script SecretShellMansion{
	void run(int reg, int perm){
		if ( NumShells % BONUS_SHELL_DIVISOR == 0 ) {
			int shellsST = Game->GetScreenD[dat];
			if ( NumShells() > shellsST ) {
				Game->SetScreenD[dat] = NumShells();
				Game->PlaySound(SFX_BONUS_SHELL);
				BonusShell();
			}
		}
		if ( NumShells() >= REQUIRED_SECRET_SHELLS ) {
			Game->PlaySound(SFX_SECRET_SHELL);
			if ( perm ) {
				Screen->State[ST_SECRET] = true;
			}
			Screen->TriggerSecrets();
		}
	}
}


/////////////////////////////
/// Sample Global Scripts ///
/////////////////////////////


global script LA_Active{
	void run(){
		while(true){
			Z4_EnemyKillRoutines();
			ReduceBuffTimers();
			LinksAwakeningItems();
			Waitdraw();
			
			Waitframe();
		}
	}
}

global script LA_OnContinue{
	void run(){
		if ( RANDOMISE_PER_PLAY ) {
			PieceOfPowerKills();
		}
		InitLinkHP(); //Store Link's HP again, so that if we continue with more HP, the values aren;t out of sync.
		Z4_ItemsAndTimers[DEF_TIMER] = 0;
		Z4_ItemsAndTimers[POWER_TIMER] = 0;
		//Set timers back to 0, disabling the boost.
	}
}

global script LA_OnExit{
	void run(){
		Z4_ItemsAndTimers[DEF_TIMER] = 0;
		Z4_ItemsAndTimers[POWER_TIMER] = 0;
		//Set timers back to 0, disabling the boost.
	}
}

global Script Init{
	void run(){
		InitZ4();
	}
}

//void LinksAwakeningItems(int swords, int rings){
//}


//int TempBoostItems[6];
//int TempBoostTimers[2];


//int SwordItems[4]={1};
//int DefItems[4]={64};


//Drop one Guardian Acorn if the player kills 12 consecutive enemies without being hurt.

//Call in Global Script ~Init.
void InitZ4(){
	InitScreenChanged();
	InitLinkHP();
	PieceOfPowerKills();
}

//Run before Waitdraw.
void Z4ScreenChanged(){
	PowerupStoreScreenChange();
	PowerupScreenUpdateScrolling();
}


////

//Runs from InitZ4 in Global script ~Init
void InitScreenChanged(){
	Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 1;
}

//Runs from InitZ4 in Global script ~Init
void InitLinkHP(){
	Z4_ItemsAndTimers[POWERUP_PLAYER_HP] = Link->HP;
	Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] = Link->HP;
}
	
//Runs from InitZ4 in Global script ~Init
//Call elsewhere to reset the value.
void PieceOfPowerKills(){
	int numKills = Rand(REQUIRE_KILLS_PIECE_OF_POWER_MIN,REQUIRE_KILLS_PIECE_OF_POWER_MAX);
	Z4_ItemsAndTimers[POWERUP_PIECE_OF_POWER_NEEDED_KILLS] = numKills;
}

/// ! Check these functions to ensure they aren't broken !
	
//Runs before Waitdraw() from Z4ScreenChanged()
void PowerupStoreScreenChange(){
	int thisScreen = Game->GetCurScreen();
	int thisDMap = Game->GetCurDMap();
	if ( thisScreen != Z4_ItemsAndTimers[POWERUP_CURSCREEN] || thisDMap != Z4_ItemsAndTimers[POWERUP_CURDMAP] ){
		Z4_ItemsAndTimers[POWERUP_CURSCREEN] = thisScreen;
		Z4_ItemsAndTimers[POWERUP_CURDMAP] = thisDMap;
		Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 1;
	}
	else (Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 0);
}

//Run in conjunction with PowerupStoreScreenChange(). Runs from Z4ScreenChanged()
void PowerupScreenUpdateScrolling(){
	if ( Link->Action == LA_SCROLLING ) {
		Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 1;
	}
}

//Utility function to determine if screen has changed.
int PowerUpScreenChanged(){
	if ( Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] ) {
		return true;
	}
	return false;
}
	

//void Update_Powerup_HP(){
//	
//}

/// ! Check these functions to ensure they aren't broken !


//Count screen enemies and store the value.
void CountEnemies(){
	if ( PowerUpScreenChanged() ) {
		if ( Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] > 0 ) {
			Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = 0;
		}
		Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = ( Screen->NumNPCs() - NumNPCsOf(NPCT_FAIRY) );
}
	
//Check if any enemies have been killed.
void UpdateKilledEnemies(){
	int diff;
	int numEnem = ( Screen->NumNPCs() - NumNPCsOf(NPCT_FAIRY) );
	if  ( numEnem < Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] ) {
		diff = ( Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] - numEnem );
		Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] += diff;
		Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = numEnem;
		if ( Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] == 0 ) {
			Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] += diff;
		}
		else if Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] == 1 ) {
			Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] = 0;
			Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 0;
		}
	}
}

//Store Link HP to check if he was hurt.
int StoreLinkHP(){
	Z4_ItemsAndTimers[POWERUP_PLAYER_HP] = Link->HP;
	if ( Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] > Z4_ItemsAndTimers[POWERUP_PLAYER_HP] ){
		//Link was hit.
		Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 1;
		Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] = Link->HP;
	}
}



//End timer for a Piece of Power if the player was hurt a specified number of times.
void KillPieceOfPower(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] && REMOVE_ATTACK_BOOST_WHEN_PLAYER_DAMAGED ) {
		if ( Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] ) {
			//this is set to either 0 or 1 each frame by UpdateKilledEnemies()
			Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER]++; //Increase this counter if Link was hurt.
			//Because Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] is set to either 0 or 1 before this runs, it 
			//should only increase once, unless Link is hurt multiple times in consecutive frames. 
		}
		
		if ( Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] >= NUM_HITS_TO_LOSE_POWER_BOOST ){
			//If Link was hurt more times than specified by constant NUM_HITS_TO_LOSE_POWER_BOOST
			Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] = 0; //Reset hurt counters.
			Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER_LAST] = 0;
			Z4_ItemsAndTimers[POWER_TIMER] = 0; //Set POWER_TIMER to 0, ending the effect of a Piece of Power boost.
		}
	}
}
	
	

//If the flag KILL_AWARDS is set true, award buff items for killing enemies. 
void KillAwards(){
	if ( KILL_AWARDS ) {
		GiveAcorn();
		GivePieceOfPower();
	}
}

//Award a free GFuardian Acorn for killing a number of monsters specified in settings, without being hit. 
void GiveAcorn(){
	if ( Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] >= REQUIRE_CONSECUTIVE_KILLS ){
		item itm = Screen->CreateItem(I_ACORN);
		itm->X = Link->X;
		itm->Y = Link->Y;
		itm->Z = Link->Z;
		Link->Action = LA_HOLD1LAND;
		Link->HeldItem = itm;
		Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] = 0;
	}
}

//Drop one Piece of Power after killing a number of monsters specified by settings.
void GivePieceOfPower(){
	if ( Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] >= Z4_ItemsAndTimers[POWERUP_PIECE_OF_POWER_NEEDED_KILLS]){
		item itm = Screen->CreateItem(I_PIECE_POWER);
		itm->X = Link->X;
		itm->Y = Link->Y;
		itm->Z = Link->Z;
		Link->Action = LA_HOLD1LAND;
		Link->HeldItem = itm;
		Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] = 0;
		PieceOfPowerKills();
	}
}



//Cause enemies to have a death animation explosion with custom sprites.
void EnemiesExplodeOnDeath(){
	if ( EXPLOSIONS_RUN_WITH_FFCS ) {
		EnemyExplosionFFC();
	}
	else {
		EnemyExplosion();
	}
}

/// ! Check these functions to ensure they aren't broken !

//Death explosion animation function, for global use.
void EnemyExplosion(){
	int fX;
	int fY;
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
		if ( !ENEMIES_ALWAYS_EXPLODE && !Z4_ItemsAndTimers[POWER_BOOSTED] ){
			break;
		}
		npc n = Screen->LoadNPC(q);
		if ( n->isValid() ) {
			//and assign it to each valid NPC in the for loop.
			if ( q->HP <= 0 ) {
				fX = q->X;
				fY = q->Y;
				eweapon explosion;
				for ( int q = 0; q <= FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS; q++ ) {
					explosion = Screen->CreateEWeapon(EW_BOMBBLAST);
					explosion->CollDetection = false;
					explosion->X = fX + Rand(1,16)-8;
					explosion->Y = fY + Rand(1,16)-8;
					explosion->UseSprite(FFC_EXPLOSION_SPRITE);
					explosion->Extend = FFC_EXPLOSION_EXTEND;
					explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH;
					explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT;
					Waitframe();
				}
				explosion->DeadState = WDS_DEAD;
				Remove(explosion);
			}
		}
	}
}

//Alternate to EnemyExplosion() that calls an FFC with its own Waitframe().
void EnemyExplosionFFC(){
	int fX;
	int fY;
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
		if ( !ENEMIES_ALWAYS_EXPLODE && !Z4_ItemsAndTimers[POWER_BOOSTED] ){
			break;
		}
		npc n = Screen->LoadNPC(q);
		if ( n->isvalid() ) {
			if ( q->HP <= 0 ) {
				fX = q->X;
				fY = q->Y;
				int f_args[2]={fX,fY};
				
				RunFFCScript(FFC_ENEMY_EXPLODE, f_args);
			}
		}
	}
}



//FFC of death animation explosion, to use as alternative to global function.
ffc script Explosion{
	void run (int fX, int fY){
		eweapon explosion;
		for ( int q = 0; q <= FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS; q++ ) {
			explosion = Screen->CreateEWeapon(EW_BOMBBLAST);
			explosion->CollDetection = false;
			explosion->X = this->X + Rand(1,16)-8;
			explosion->Y = this->Y + Rand(1,16)-8;
			explosion->UseSprite(FFC_EXPLOSION_SPRITE);
			explosion->Extend = FFC_EXPLOSION_EXTEND;
			explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH;
			explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT;
			Waitframe();
		}
		explosion->DeadState = WDS_DEAD;
		Remove(explosion);
		this->Data = 0;
		return;
	}
}

//Deprecated / non-working variant.
void _KillPieceOfPower(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
		if ( Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] ) {
			if ( Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] == 0 ) {
				Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] = 1;
			}
			if ( Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] > 0 && Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] < NUM_HITS_TO_LOSE_POWER_BOOST ) {
				int timesHurt = Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] + 1;
				Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER_LAST] = POWERUP_LINK_HURT_COUNTER_LAST[POWERUP_LINK_HURT_COUNTER];
				Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] = timesHurt;
			}
			if ( Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] >= NUM_HITS_TO_LOSE_POWER_BOOST ){
				Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] = 0;
				Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER_LAST] = 0;
				Z4_ItemsAndTimers[POWER_TIMER] = 0;
			}
		}
	}
}
	
	