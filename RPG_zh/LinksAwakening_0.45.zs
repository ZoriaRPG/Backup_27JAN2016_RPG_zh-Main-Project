//Pieces of Power, Guardian Acorns, and Secret Shells v0.4.5
//1st July, 2015


//Set-up: Make a new item (Green Ring), set it up/ as follows:
//Item Class Rings
//Level: 1
//Power: 1
//CSet Modifier : None
//Assign this ring to Link's starting equipment in Quest->Init Data->Items

//Change the blue ring to L2, red to L3, and any higher above these. 

int PlayingPowerUp[258]; //An array to hold values for power-ups. Merge with main array later?
int Z4_ItemsAndTimers[9]; //Array to hold the values for the Z4 items. 
int StoneBeaks[10];	//An array to hold if we have a stone beak per level. 
			//Each index corresponds to a level number.
			//If you need levels higher than '9', increase the index size to 
			//be eaqual to the number of levels in your game + 1.
			

//Settings

const int NEEDED_PIECES_OF_POWER = 3; //Number of Pieces of power needed for temporary boost.
const int NEEDED_ACORNS = 3; //Number of Acorns needed for temporary boost.
const int REQUIRED_SECRET_SHELLS = 20; //Number of Secret Shell items to unlock the secret.
const int BUFF_TIME = 900; //Duration of boost, in frames. Default is 15 seconds.

const int PLAY_ACORN_MESSAGE = 1; //Set to 0 to turn off messages.
const int PLAY_PIECE_OF_POWER_MESSAGE = 1; //Set to 0 to disable messages for Piece of Power power-ups.
const int BONUS_SHELL_DIVISOR = 5; //Award bonus Secret Shell if number on hand is this number, on each visit to Seashell mansion.
const int WALK_SPEED_POWERUP = 4; //Number of extra Pixels Link walks when he has a Piece of Power

const int KILL_AWARDS = 1; //Set to '0' to disable automatic awards of Pieces of Power and Guardian Acorns
				//based on enemy kill counts.
const int RANDOMISE_PER_PLAY = 0; //Set to '1' if you want to randomise the number of kills on each load.

//Item Numbers : These are here for later expansion, and are unused at present.
const int I_GREEN_RING = 143; //Item number of Green Ring  
const int I_PIECE_POWER = 144; //Item number of Piece of Power
const int I_ACORN = 145; //Item number of Acorn
const int I_SHELL = 146; //Item number of Secret Shell

//Array Indices
const int POWER_TIMER = 0;
const int DEF_TIMER = 1;
const int NUM_PIECES_POWER = 2;
const int NUM_ACORNS = 3;
const int POWER_BOOSTED = 4;
const int DEF_BOOSTED = 5;
const int NUM_SHELLS = 6;
const int MSG_GUARDIAN_PLAYED = 7;
const int MSG_PIECE_POWER_PLAYED = 8;

//Sound effects constants.
const int SFX_POWER_BOOSTED = 65; //Sound to play when Attack Buffed
const int SFX_SECRET_SHELL = 66; //Sound to play when unlocking shell secret.
const int SFX_GUARDIAN_DEF = 68; //Sound to play when Defence buffed.
const int SFX_NERF_POWER = 72; //Sound to play when Piece of Power buff expires.
const int SFX_NERF_DEF = 73; //Sound to play when Guardian Acorn buff expires
const int SFX_BONUS_SHELL = 0; //Sound to play when awarded a bonus Secret Shell.

//MIDI Constants
const int PLAYING_POWER_UP_MIDI = 256;
const int NORMAL_DMAP_MIDI = 0; //Used for two things: Array index of normal DMap MIDIs (base), 
				//and as parameter in function PlayPowerUpMIDI()
const int PLAY_POWERUP_MIDI = 1;

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



//Increase walking speed when Link has a Piece of Power and LA_NONE
void WalkSpeed(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
		if ( Link->Action == LA_NONE && !LinkJump() && Link->Z == 0 ) {
			if ( Link->PressDown ) {
				Link->X += WALK_SPEED_POWERUP;
			}
			if ( Link->PressUp && !isSideView() ) {
				Link->X -= WALK_SPEED_POWERUP;
			}
			if ( Link->PressRight && !isSideView() ) {
				Link->Y += WALK_SPEED_POWERUP;
			}
			if ( Link->PressLeft ) {
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
	if ( PLAY_PIECE_OF_POWER_MESSAGE ) {
		Z4_ItemsAndTimers[MSG_PIECE_OF_POWER_PLAYED] = 0;
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
	if ( PLAY_ACORN_MESSAGE ) {
		Z4_ItemsAndTimers[MSG_GUARDIAN_PLAYED] = 0;
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

void Backup_MIDIs(){
	for ( int q = 0; q <= 255; q++ ) {
		PlayingPowerUp[q] = Game->DMapMIDI[q];
	}
}

void RestoreNonPowerUpMIDIs(){
	for ( int q = 0; q <= 255; q++ ) {
		Game->DMapMIDI[q] = PlayingPowerUp[q];
	}
}

bool PlayingPowerUpMIDI(){
	return PlayingPowerUp[PLAYING_POWER_UP_MIDI];
}

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
ffc script SecretShellMansion{
	void run(int reg){
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

Global Script Init{
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
const int POWERUP_PLAYER_HP = 9;
const int POWERUP_PLAYER_OLD_HP = 10;
const int POWERUP_ENEMY_KILLS = 11;
const int POWERUP_CONSECUTIVE_ENEMY_KILLS = 12;
const int POWERUP_NUM_ENEMIES = 13;
const int POWERUP_CURDMAP = 14;
const int POWERUP_CURSCREEN = 15;
const int POWERUP_SCREEN_HAS_CHANGED = 16;
const int POWERUP_LINK_DAMAGED = 17; //Stores a value if Link was hit. Cleared after killing a monster.
const int POWERUP_PIECE_OF_POWER_NEEDED_KILLS = 18;

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

void Z4_EnemyKillRoutines(){
	Z4ScreenChanged();
	CountEnemies();
	StoreLinkHP();
	UpdateKilledEnemies();
	EnemyExplosion();
	KillAwards();
	
}

void CountEnemies(){
	if ( PowerUpScreenChanged() ) {
		if ( Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] > 0 ) {
			Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = 0;
		}
		Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = ( Screen->NumNPCs() - NumNPCsOf(NPCT_FAIRY) );
}
	
void UpdateKilledEnemies(){
	int diff;
	int numEnem = ( Screen->NumNPCs() - NumNPCsOf(NPCT_FAIRY) 
	if  ( numEnem < Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] ) {
		diff = ( Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] - numEnem );
		Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] += diff;
		Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = numEnem;
		if ( Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] == 0 ) {
			Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS]++;
		}
		else if Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] == 1 ) {
			Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 0;
		}
	}
}

int StoreLinkHP(){
	Z4_ItemsAndTimers[POWERUP_PLAYER_HP] = Link->HP;
	if ( Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] > Z4_ItemsAndTimers[POWERUP_PLAYER_HP] ){
		//Link was hit.
		Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 1;
		Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] = Link->HP;
	}
}

const int REQUIRE_CONSECUTIVE_KILLS = 12;

const int REQUIRE_KILLS_PIECE_OF_POWER_MIN = 40;
const int REQUIRE_KILLS_PIECE_OF_POWER_MAX = 45;


void KillAwards(){
	if ( KILL_AWARDS ) {
		GiveAcorn();
		GivePieceOfPower();
	}
}

//Drop one Piece of Power after killing 40 to 45 monsters
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


const int FFC_ENEMY_EXPLODE = 0; //Set to FFC script slot for death explosion FFC animation.
const int ENEMIES_ALWAYS_EXPLODE = 1;
const int FFC_NUM_OF_EXPLOSIONS = 4;
const int FFC_EXPLOSION_SPRITE = 0; 
const int FFC_EXPLOSION_EXTEND = 4;
const int FFC_EXPLOSION_TILEWIDTH = 2;
const int FFC_EXPLOSION_TILEHEIGHT = 2;

const int FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS = 2;


void EnemyExplosion(){
	int fX;
	int fY;
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
		if ( !ENEMIES_ALWAYS_EXPLODE && !Z4_ItemsAndTimers[POWER_BOOSTED] ){
			break;
		}
		npc n = Screen->LoadNPC(q);
		if ( q->HP <= 0 ) {
			fX = q->X;
			fY = q->Y;
			int f_args[2]={fX,fY};
			
			RunFFCScript(FFC_ENEMY_EXPLODE, f_args);
		}
	}
}




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


	