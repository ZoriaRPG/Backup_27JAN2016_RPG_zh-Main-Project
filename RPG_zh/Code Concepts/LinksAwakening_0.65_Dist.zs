//Includes
//Disable these if you already import them!
import "std.zh"
//import "ffcscript_LA.zh" //This is included, starting at line 1468
//import "stdExtra.zh" //This is included, starting at line 1604
//These headers are included to ensure that you can recompile this, from the buffer.

//Pieces of Power, Guardian Acorns, and Secret Shells v0.64
//26th July, 2015


//Set-up: Make a new item (Green Ring), set it up/ as follows:
//Item Class Rings
//Level: 1
//Power: 1
//CSet Modifier : None
//Assign this ring to Link's starting equipment in Quest->Init Data->Items

//Change the blue ring to L2, red to L3, and any higher above these. 

//Arrays: These are used to store the variables for this header.

int PlayingPowerUp[258]; //An array to hold values for power-ups. Merge with main array later?
float Z4_ItemsAndTimers[30]; //Array to hold the values for the Z4 items. 
int StoneBeaks[10];	//An array to hold if we have a stone beak per level. 
			//Each index corresponds to a level number.
			//If you need levels higher than '9', increase the index size to 
			//be eaqual to the number of levels in your game + 1.

// A list of Boss enemies, by Enemy ID
/// Add, or remove values from this list, to increase, or decrease the enemies treated 
/// as Bosses for determining the number of explosions.
int BossList[]={	58,	61,	62,	63, 
			64, 	65, 	71, 	72, 
			73, 	76, 	77, 	93, 	
			94, 	103, 	104, 	105, 	
			109, 	110, 	111, 	112, 	
			114, 	121, 	122};
	
//  A list of Mini-boss enemies by Enemy ID
/// Add, or remove values from this list, to increase, or decrease the enemies treated 
/// as Mini-bosses for determining the number of explosions.
int MiniBossList[]={	59, 	66,	67,	68,	
			69, 	70,	71,	74,	
			75};



//Settings

/// Variable Settings: These values are constants that are used to determine the amounts of values in the scripts, 
/// and functions. Modify these with any values that you require.

const int NEEDED_PIECES_OF_POWER = 3; //Number of Pieces of power needed for temporary boost.
const int NEEDED_ACORNS = 3; //Number of Acorns needed for temporary boost.
const int REQUIRED_SECRET_SHELLS = 20; //Number of Secret Shell items to unlock the secret.
const int BUFF_TIME = 900; //Duration of boost, in frames. Default is 15 seconds.

const int REQUIRE_CONSECUTIVE_KILLS = 12; 	//The number of enemies the player must kill without being hurt,
						// to obtain a free Guardian Acorn.
const int REQUIRE_KILLS_PIECE_OF_POWER_MIN = 35; //The minimum number of enemies to kill (random number min) 
						 //to obtain a free Piece of Power.
const int REQUIRE_KILLS_PIECE_OF_POWER_MAX = 45; //The maximum number of enemies to kill (random number max)
						 //to obtain a free Piece of Power.
const int BONUS_SHELL_DIVISOR = 5; //Award bonus Secret Shell if number on hand is this number, on each visit to Seashell mansion.


//Walk Speed Constants
const int WALK_SPEED_POWERUP = 8; //Number of extra Pixels Link walks when he has a Piece of Power
const int WALK_TIME = 8; //Increase this value to slow the speed at which Link walks when sped up, 
			  //and to speed him up when slowed down.
const float WALK_FRACTION = 0.0167; //The number of fake, decimal pixels to move per frame.
const float WALK_STEP = 1; //The value needed, before Link actually moves. 

/// Boolean SETTINGS: THese constants are used forBOOLEAN CONTROL. That is, if they have a value of '0', expressions
/// will regard them as 'false, and if they have a value of '1', expressions will regard them as true. 
/// Think of them as 'toggle switches' for different settings that you may apply. 


//Power-Up Message Constants
//! Use these for BOTH their corresponding boolean controls, and for the Message  String ID..
/// These will play when the player obtains a power-up item, if they are set to '1' or higher.

const int PLAY_ACORN_MESSAGE = 0; //Set to 0 to turn off Guardian Acorn messages.
				  //If set to aq value of '1' or higher, when the player obtains a
				  //Guardian Acorn, ZC will display a Screen->Message string using
				  //the ID equal to the value you assign here. 
const int PLAY_PIECE_OF_POWER_MESSAGE = 0; //Set to 0 to disable messages for Piece of Power power-ups.
					   //If set to aq value of '1' or higher, when the player obtains a
					   //Guardian Acorn, ZC will display a Screen->Message string using
					   //the ID equal to the value you assign here. 


const int RANDOMISE_PER_PLAY = 0; //Set to '1' if you want to randomise the number of kills on each load (continue).

const int PLAY_POWERUP_MIDI = 1; //Set to '1' to play a MIDI while a power-up boost is in effect.

const int REMOVE_ATTACK_BOOST_WHEN_PLAYER_DAMAGED = 1; //Set to '0' to disable removing the boost when player is damaged X times.
const int NUM_HITS_TO_LOSE_POWER_BOOST = 3; //The number of times a player with a Piece of Power power-up boost
					    //must be hit, before the effect prematurely ends.

const int ENEMIES_ALWAYS_EXPLODE = 1; //Set to '0' if enemies only explode when a player has a Piece of Power power-up.
const int EXPLOSIONS_RUN_WITH_FFCS = 1; //If set to 1, enemy explosions on death will run from FFCs
					//rather than from the global active infinite loop.
					
const int ENEMY_POWERUPS_ARE_FULL = 1; //If set to '1' awarded Pieces of Power and Guardian Acorns from killing enemies
					//grant an instant *full* power-up. Otherwise, if set to '0', they only give a 
					//single power-up item.
					
const int KILL_AWARDS = 1; //Set to '0' to disable automatic awards of Pieces of Power and Guardian Acorns
				//based on enemy kill counts.
				
const int FINAL_BOSS_EXPLOSIONS = 1; //Set to '0' if you are using the stock Ganon as a final boss! 
				     //Disabling this, disables explosion animations for the enemy specified as
				     //FINAL_BOSS_ID in variable settings, below.
				     
const int RESET_ENEMY_COUNT_ON_CONTINUE = 0; //Reset the count of enemies killed for a Piece of Power when continuing.
					     //Set to '1' to enable, or '0' to disable.
const int RESET_CONSECUTIVE_ENEMY_COUNT_ON_CONTINUE = 0; //Reset thenumber of consecutive ennemies killed when continuing. 
							 //Set to '1' to enable, or '0' to disable.

				
/// Game Constants: You MUST establish these values on a PER-QUEST basis. They cover things such as
/// item numbers, sound effects, FFC slots, and the like. 

//Item Numbers : These are here for later expansion, and are unused at present.
const int I_GREEN_RING = 143; //Item number of Green Ring  
const int I_PIECE_POWER = 144; //Item number of Piece of Power
const int I_ACORN = 145; //Item number of Acorn
const int I_SHELL = 146; //Item number of Secret Shell


//Sound effects constants.
const int SFX_POWER_BOOSTED = 65; //Sound to play when Attack Buffed
const int SFX_SECRET_SHELL = 66; //Sound to play when unlocking shell secret.
const int SFX_GUARDIAN_DEF = 68; //Sound to play when Defence buffed.
const int SFX_NERF_POWER = 72; //Sound to play when Piece of Power buff expires.
const int SFX_NERF_DEF = 73; //Sound to play when Guardian Acorn buff expires
const int SFX_BONUS_SHELL = 0; //Sound to play when awarded a bonus Secret Shell.
const int SFX_ENEMY_EXPLOSION = 99; //Explosion SFX
const int SFX_SCREEN_CHANGED = 100; //Sound to play if the screen changes. Deprecated for this version.

const int SFX_KILL_BONUS_POWERUP = 101; //Sound effect for a power-uop awarded by killing enemies.

//Enemy Explosion Constants
const int FFC_ENEMY_EXPLODE = 1; //Set to FFC script slot for death explosion FFC animation.
const int FFC_NUM_OF_EXPLOSIONS = 4; //Base number of explosions when killing an enemy.
const int FFC_EXPLOSION_SPRITE = 0; //Sprite for the explosion.
const int FFC_EXPLOSION_EXTEND = 3; //Size of explosion eweapon.
const int FFC_EXPLOSION_TILEWIDTH = 1; //Width of explosion, in tiles.
const int FFC_EXPLOSION_TILEHEIGHT = 1; //Height of explosion, in tiles.

const int FFC_EXPLOSIONS_MINIBOSS_EXTRA = 4; //Add this many explosions if the enemy is a miniboss.
const int FFC_EXPLOSIONS_BOSS_EXTRA = 12; //Add this many explosions if the enemy is a full boss.
const int FFC_EXPLOSIONS_FINALBOSS_EXTRA = 16; //Add this many explosions if the enemy is the FINAL boss.

const int FFC_EXPLOSION_SPRITE_NORMAL_ENEM = 87; //Sprite to use for ordinary enemy explosions.
const int FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS = 9; //Sprite for explosions if the enemy is a mini-boss.
const int FFC_EXPLOSION_SPRITE_ENEM_BOSS = 17; //Sprite for explosions if the enemy is a Boss.
const int FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS = 81; //Sprite for explosions if the enemy if the FINAL BOSS in the game.

const int FFC_EXPLOSION_DELAY = 4; //The delay in frames between explosions.

const int FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS = 2; //Number of extra explosions if player has Piece of Power
							 //power-up (attack) boost.
							 
const int EXPLODE_INVIS_COMBO = 735; //A general use invisible combo, that we never actually use. This is here as a reference only.

const int EXPLOSION_TWO_DIST = 2; //The distance modifier (in PIXELS) for the second explolsion effect (layered explosions).
const int EXPLOSION_THREE_DIST = 3; //The distance modifier (in PIXELS) for the third explolsion effect (layered explosions).
const int EXPLOSION_FOUR_DIST = 4; //The distance modifier (in PIXELS) for the fourth explolsion effect (layered explosions).

const int EXPLOSION_DIST_NORMAL = 8; 	//The -N and +N values to Randomise for distance of explosion 
					//FFC for normal enemies.
const int EXPLOSION_DIST_MINIBOSS = 12; //The -N and +N values to Randomise for distance of explosion 
				        //FFC for Mini-Boss enemies.
const int EXPLOSION_DIST_BOSS = 16; 	//The -N and +N values to Randomise for distance of explosion
					//FFC for Boss enemies.
const int EXPLOSION_DIST_FINAL_BOSS = 24; //The -N and +N values to Randomise for distance of explosion 
				          //FFC for your FINAL BOSS enemy.
const int EXPLOSION_DIST_OTHER = 10;  //The -N and +N values to Randomise for distance of explosion FFC 
				      //as a CATCH_ALL for enemies not included elsewhere.



//MIDI Constants
const int POWERUP_MIDI = 10; //Set the the number of a MIDI to play while a Power-Up is in effect.
const int PLAYING_POWER_UP_MIDI = 256;
const int NORMAL_DMAP_MIDI = 0; //Used for two things: Array index of normal DMap MIDIs (base), 
				//and as parameter in function PlayPowerUpMIDI()






//Enemy Table Constanta
const int FINAL_BOSS_ID = 78; //Enemy ID of the FINAL boss. Ganon, by default.
			      //Note: The standard Ganon battle has its own, SPECIAL DEATH ANIMATION 
			      //that is incompatible with custom explosion animations. 
			      //Change this value to your actual, custom, final boss.
			      //If you are using the stock Ganon, you will need to disable FINAL_BOSS_EXPLOSIONS.



/// ROUTINE Constants: These are used to reference things with labels, instead of numbers. 
/// DO NOT CHANGE THEM unless you are ABSOLUTELY CERTAIN that you know what each one does. 

//Array Indices ( ! Do not change these ! )
//These point to the index number of arrays. 
const int POWER_TIMER = 0; //The timer for Piece of Power damage boost duration.
const int DEF_TIMER = 1; //The timer for Guardian Acorn defence boost duration.
const int NUM_PIECES_POWER = 2; //The present number of Pieces of Power held by the player.
const int NUM_ACORNS = 3; //The present number of Guardian Acorns held by the player.
const int POWER_BOOSTED = 4; //This == 1 if the player has a Piece of Power power-up boost.
const int DEF_BOOSTED = 5; //This == 1 if the player has a Guardian Acorn power-up boost.
const int NUM_SHELLS = 6; //The present number of Secret Shells held by player.
const int MSG_GUARDIAN_PLAYED = 7; //Reports if a message has played for a Guardian Acorn boost.
				   //Used as a boolean flag to prevent re-playing the string.
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
const int POWERUP_LINK_HURT_COUNTER = 19; //Holds a value if Link was hurt. May be deprecated.
const int POWERUP_LINK_HURT_COUNTER_LAST = 20; //Holds a value if Link was hurt. May be deprecated.
const int MSG_PIECE_OF_POWER_PLAYED = 21; //Used as a boolean flag, if a message was played, to prevent re-playing.
const int AWARD_PIECE_OF_POWER = 22; //A boolean flag. If this is '1' (true), a Piece of power will be awarded (based on settings).
const int AWARD_GUARDIAN_ACORN = 23; //A boolean flag. If this is '1' (true), a Guardian Acorn will be awarded (based on settings).
const int POWER_WALK_TIMER = 24; //The timer for WalkSpeed().
const int WALK_SPEED_RIGHT = 25;
const int WALK_SPEED_LEFT = 26;
const int WALK_SPEED_UP = 27;
const int WALK_SPEED_DOWN = 28;

/// Constants for enemy types: DO NOT CHANGE!
/// These are used as a label to identify enemy types, when comparing Screen->NPCs with the arrays BossList[] and MiniBossList[].
const int ENEM_TYPE_NORMAL = 0; //Normal enemies.
const int ENEM_TYPE_MINIBOSS = 1; //Bosses from the array MiniBossList[]
const int ENEM_TYPE_BOSS = 2; //Bosses from the array BossList[].
const int ENEM_TYPE_FINAL_BOSS = 3; //The enemy specified as FINAL_BOSS_ID.





 

//int NerfedAttack[]="Attack power nerfed."; //String for TraceS()

//////////////////////
/// MAIN FUNCTIONS ///
//////////////////////

//Run every frame **BEFORE** both Waitdraw() **AND** LinksAwakeningItems();
void ReduceBuffTimers(){
	if ( Z4_ItemsAndTimers[POWER_TIMER] > 0 ) { //If the Piece of Power timer is active...
		Z4_ItemsAndTimers[POWER_TIMER]--; //Reduce Piece of Power timer.
	}
	if ( Z4_ItemsAndTimers[DEF_TIMER] > 0 ) { //If the Guardian Acorn timer is active...
		Z4_ItemsAndTimers[DEF_TIMER]--; //Reduce the timer
	}
}

//Run every frame, before Waitdraw();
void LinksAwakeningItems(){ //This is a container function. Using these simplifies reading your global acript later, by reducing the number of direct calls.
	//Now we need only call this one function, to run all of these. This is a *true function*, while the functions it calls are *routines*. 
	PiecesOfPower(); //Call these functions, as routines, and sub-routines.
	Acorns();
	//WalkSpeed();
	
}


//Increase walking speed when Link has a Piece of Power and LA_WALKING
void WalkSpeed(){
	int linkX;
	int linkY;
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) { //Check to see if Link has a Piece of Power power-up boost...
		if ( Link->Action == LA_HOLD1LAND ) return;
		if ( Link->Action == LA_WALKING && !LinkJump() && Link->Z == 0 ) { //If he isnt attacking, swimming, hurt, or casting, and h
			if ( Link->InputDown && !IsSideview() //If the player presses down, and we aren't in sideview mode...
				&& !Screen->isSolid(Link->X,Link->Y+17) //SW Check Solidity
				&& !Screen->isSolid(Link->X+7,Link->Y+17) //S Check Solidity
				&& !Screen->isSolid(Link->X+15,Link->Y+17) //SE Check Solidity
			) {
				int walkDownFloor = Floor(Z4_ItemsAndTimers[WALK_SPEED_DOWN]);
				if ( walkDownFloor < 1 ){
					Z4_ItemsAndTimers[WALK_SPEED_DOWN] += WALK_FRACTION;
				}
				
				//We use a timer to choke the walk speed. Without it, Link would move the full additional number of
				//pixels PER FRAME. THus, a walk speed bonus of +1 would be +60 pixels (almost four tiles) PER SECOND!
				if ( Z4_ItemsAndTimers[WALK_SPEED_DOWN] >= WALK_STEP ) {  //If our timer is fresh, or has reset...
					TraceNL();
					int S_DWALK[]="WALK_SPEED_DOWN = ";
					TraceS(S_DWALK);
					Trace(WALK_SPEED_DOWN);
					TraceNL();
					
					Link->Y += WALK_SPEED_DOWN * WALK_SPEED_POWERUP; //Let Link move faster...
					Z4_ItemsAndTimers[WALK_SPEED_DOWN] = 0;
					Link->InputDown = false;
					//! Trace WALK_SPEED_DIR
				}
			}
			else if ( Link->InputUp && !IsSideview()  //If the player presses up, and we aren't in sideview mode...
				&& !Screen->isSolid(Link->X,Link->Y+6) //NW Check Solidity
				&& !Screen->isSolid(Link->X+7,Link->Y+6) //N Check Solidity
				&& !Screen->isSolid(Link->X+15,Link->Y+6) //NE Check Solidity
			) {
				int walkUpFloor = Floor(Z4_ItemsAndTimers[WALK_SPEED_UP]);
				if ( walkUpFloor < 1 ){
					Z4_ItemsAndTimers[WALK_SPEED_UP] += WALK_FRACTION;
				}
				if ( Z4_ItemsAndTimers[WALK_SPEED_UP] >= WALK_STEP ) { //If our timer is fresh, or has reset...
					TraceNL();
					int S_UWALK[]="WALK_SPEED_UP = ";
					TraceS(S_UWALK);
					Trace(WALK_SPEED_UP);
					TraceNL();
					
					Link->Y -= WALK_SPEED_UP * WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
					Z4_ItemsAndTimers[WALK_SPEED_UP] = 0;
					Link->InputUp = false;
				}
			}
			else if ( Link->InputRight && !Screen->isSolid(Link->X+17,Link->Y+8) //If the player presses right, check NE solidity...
				&& !Screen->isSolid(Link->X+17,Link->Y+15) //and check SE Solidity 
			) { 
				int walkRightFloor = Floor(Z4_ItemsAndTimers[WALK_SPEED_RIGHT]);
				if ( walkRightFloor < 1 ){
					Z4_ItemsAndTimers[WALK_SPEED_RIGHT] += WALK_FRACTION;
				}
				if ( Z4_ItemsAndTimers[WALK_SPEED_RIGHT] >= WALK_STEP ) { //If our timer is fresh, or has reset...
					TraceNL();
					int S_RWALK[]="WALK_SPEED_RIGHT = ";
					TraceS(S_RWALK);
					Trace(WALK_SPEED_RIGHT);
					TraceNL();
	
					Link->X += WALK_SPEED_RIGHT * WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
					Z4_ItemsAndTimers[WALK_SPEED_RIGHT] = 0;
					Link->InputRight = false;
				}
			}
			else if ( Link->InputLeft && !Screen->isSolid(Link->X-2,Link->Y+8)  //If the player presses right, check NW solidity...
				&& !Screen->isSolid(Link->X-2,Link->Y+15) //SW Check Solidity
			) {
				int walkLeftFloor = Floor(Z4_ItemsAndTimers[WALK_SPEED_LEFT]);
				if ( walkLeftFloor < 1 ){
					Z4_ItemsAndTimers[WALK_SPEED_LEFT] += WALK_FRACTION;
				}
				if ( Z4_ItemsAndTimers[WALK_SPEED_LEFT] >= WALK_STEP ) { //If our timer is fresh, or has reset...
					TraceNL();
					int S_LWALK[]="WALK_SPEED_LEFT = ";
					TraceS(S_LWALK);
					Trace(WALK_SPEED_LEFT);
					TraceNL();
					Link->X -= WALK_SPEED_LEFT * WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
					Z4_ItemsAndTimers[WALK_SPEED_LEFT] = 0;
					Link->InputLeft = false;
				}
			}
		}
	}
}


//We check for Solidity above, to prevent the game forcing Link->X/Y into a solid combo, and we also check 
//sideview mode, as in sideview gravity, with this, would allow the player to walk upwards or downwards, where he shouldn't.


///Functions called by MAIN functions:

//Runs every frame from LinksAwakeningItems();
void PiecesOfPower(){
	if ( Z4_ItemsAndTimers[NUM_PIECES_POWER] >= NEEDED_PIECES_OF_POWER ) { //Check to see if the number of Pieces of Power collected by ther player
										//is at least the number required in settings.
		//if so...
		Z4_ItemsAndTimers[NUM_PIECES_POWER] = 0;  //Clear the number of Pieces of Power collected.
		Z4_ItemsAndTimers[POWER_TIMER] = BUFF_TIME; //Set the timer to the value of this constant, set in settings. This allows the timer to start.
							//When the timer is active, other functions that rely on it will run.
		BoostAttack();	//Run this routine.
	}
	NerfAttack(); //Otherwise, run this routine.
}

//Runs every frame from LinksAwakeningItems();
void Acorns(){
	if ( Z4_ItemsAndTimers[NUM_ACORNS] >= NEEDED_ACORNS ) { //Check to see if the number of Guardian Acorns that the
								//player collected is at least the amount specified in the settings
		//If so...
		Z4_ItemsAndTimers[NUM_ACORNS] = 0;  //Clear the number of acorns collected.
		Z4_ItemsAndTimers[DEF_TIMER] = BUFF_TIME; //Set the timer, to the value of this constant. 
		//When the timer is active, functions that rely on it run automatically.
		BoostDefence(); //Run this routine.
	}
	NerfDefence(); //Otherwise, run this routine. 
}

//Runs from PiecesOfPower()();
void BoostAttack(){
	if ( Z4_ItemsAndTimers[POWER_TIMER] && !Z4_ItemsAndTimers[POWER_BOOSTED] ) { //If Link's power is not boosted, and the timer has a positive value above 0...
		BuffSwords(); //Run this function to double his sword attacks.
	}
	if ( PLAY_PIECE_OF_POWER_MESSAGE ) { //If this setting is greater than '0'...
		PieceOfPowerMessage(PLAY_PIECE_OF_POWER_MESSAGE); //Play a message specified by this constant.
	}
}

//Runs from PiecesOfPower()
void NerfAttack(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] && Z4_ItemsAndTimers[POWER_TIMER] < 1 ) { //If Link's power is boosted, and the timer has expired...
		Z4_ItemsAndTimers[POWER_BOOSTED] = 0; //Clear the flag that tells us that his power is boosted.
		NerfSwords(); //Run this function to reduce his attack back to normal.
		Z4_ItemsAndTimers[POWER_TIMER] = 0; //Ensure that the timer is exactly zero.
	}
}

//Runs from Acorns();
void BoostDefence(){
	if ( Z4_ItemsAndTimers[DEF_TIMER] && !Z4_ItemsAndTimers[DEF_BOOSTED] ) { //If Link's defence is NOT boosted by an acorn powerup and the timer is running...
		BuffRings(); //Run this dunction to double his defence.
	}
	if ( PLAY_ACORN_MESSAGE ) { //If this setting is greater than '0'...
		AcornMessage(PLAY_ACORN_MESSAGE); //Play the message specified by this constant.
	}
}

//Runs from Acorns()
void NerfDefence(){
	if ( Z4_ItemsAndTimers[DEF_BOOSTED] && Z4_ItemsAndTimers[DEF_TIMER] < 1 ) { //If Link';s def is boosted and the timer has expired...
		Z4_ItemsAndTimers[DEF_BOOSTED] = 0; //Clear the flag that tells us that his defense was boosted...
		NerfRings(); //Run this function to reduce his defs back to normal.
		Z4_ItemsAndTimers[DEF_TIMER] = 0; //Ensure that the timer is exactly zero.
	}
}

//Runs from BoostDefence();
void BuffSwords(){
	float presentPower; //Make a variable so that we can write to it.
	for ( int q = 0; q <= 255; q++ ) { //Go through all Link's inventory (in one frame)...
		itemdata id = Game->LoadItemData(q); //Load each item, once per loop...
		if ( id->Family ==  IC_SWORD ) { //If an item is Itemclass SWORD
			presentPower = id->Power; //Set our variable to its present ->Power
			id->Power = presentPower * 2; //Write that value * 2 to its ->Power, doubling its attack strength.
		}
	}
	Game->PlaySound(SFX_POWER_BOOSTED); //Play a sound effect to indicate this happened.
	Z4_ItemsAndTimers[POWER_BOOSTED] = 1; //Set the flag that allows us to determine if Link's attack is boosted by a power-up.
}

//Runs from BoostDefence();
void BuffRings(){
	float presentPower; //Make a variable so that we can write to it.
	for ( int q = 0; q <= 255; q++ ) { //Go through all Link's inventory (in one frame)...
		itemdata id = Game->LoadItemData(q); //Load each item, once per loop...
		if ( id->Family ==  IC_RING ) { //If an item is Itemclass RING...
			presentPower = id->Power; //Set our variable to its present ->Power
			id->Power = presentPower * 2; //Write back that value * 2 to double the defense modifier.
		}
	}
	Game->PlaySound(SFX_GUARDIAN_DEF); //Play a sound so that the player knows it happened.
	Z4_ItemsAndTimers[DEF_BOOSTED] = 1; //Set the flag that allows us to determine if Link's defense is boosted by a power-up.
}

//Runs from BoostDefence();
void NerfSwords(){
	float presentPower;  //Make a variable so that we can write to it.
	for ( int q = 0; q <= 255; q++ ) { //Go through all Link's inventory (in one frame)...
		itemdata id = Game->LoadItemData(q);  //Load each item, once per loop...
		if ( id->Family ==  IC_SWORD ) { //If an item is Itemclass SWORD...
			presentPower = id->Power; //Set our variable to its present ->Power
			id->Power = presentPower * 0.5; //Write back that value * 0.5 to halve the defense modifier.
			//We use multiplication here, to avoid a division by zero error, however unlikely that may be.
		}
	}
	Game->PlaySound(SFX_NERF_POWER); //Play a sound to indicate that this happened.
	//Because this only runs if the timer is zero, and because the function NerfDefence() already sets the flag
	//that tells us that Link's attack is boosted back to '0', we dont need to have an instruction here to do that.
}

//Runs from BoostDefence();
void NerfRings(){
	float presentPower; //Make a variable so that we can write to it.
	for ( int q = 0; q <= 255; q++ ) { //Go through all Link's inventory (in one frame)...
		itemdata id = Game->LoadItemData(q); //Load each item, once per loop...
		if ( id->Family ==  IC_RING ) { //If an item is Itemclass RING...
			presentPower = id->Power; //Set our variable to its present ->Power
			id->Power = presentPower * 0.5;//Write back that value * 0.5 to halve the defense modifier.
			//We use multiplication here, to avoid a division by zero error, however unlikely that may be.
		}
	}
	Game->PlaySound(SFX_NERF_DEF); //Play a sound to indicate that this happened.
	//Because this only runs if the timer is zero, and because the function NerfDefence() already sets the flag
	//that tells us that Link's attack is boosted back to '0', we dont need to have an instruction here to do that.
}

//Awards full Piece of Power attack power-ups...
void EnemyPieceOfPower(){
	if ( Z4_ItemsAndTimers[AWARD_PIECE_OF_POWER] ) { //If we should award a Piece of Power power-up...
		while ( Link->Action == LA_HOLD1LAND ) { //If the Link->Action LA_HOLD1LAND is set, wait until its animation finished...
			//Failing to do this will cause the hold-up animation to fail.
			Waitframe(); //Wait...
		}
		Z4_ItemsAndTimers[AWARD_PIECE_OF_POWER] = 0; //Remove the flag to award a power-up.
		if ( ENEMY_POWERUPS_ARE_FULL ) { //If the setting ENEMY_POWERUPS_ARE_FULL is enabled...
			Z4_ItemsAndTimers[NUM_PIECES_POWER] = NEEDED_PIECES_OF_POWER; //Set Link to have the full power-up.
		}
		PieceOfPowerKills(); //Reset the number of kills needed for the next award.
	}
}

//Awards full Guardian Acorn defence power-ups...
void EnemyGuardianAcorn(){
	if ( Z4_ItemsAndTimers[AWARD_GUARDIAN_ACORN] ) { //If we should award a Guardian Acorn power-up...
		while ( Link->Action == LA_HOLD1LAND ) { //If the Link->Action LA_HOLD1LAND is set, wait until its animation finished...
			//Failing to do this will cause the hold-up animation to fail.
			Waitframe(); //Wait...
		}
		Z4_ItemsAndTimers[AWARD_GUARDIAN_ACORN] = 0; //Remove the flag to award a power-up.
		if ( ENEMY_POWERUPS_ARE_FULL ) { //If the setting ENEMY_POWERUPS_ARE_FULL is enabled...
			Z4_ItemsAndTimers[NUM_ACORNS] = NEEDED_ACORNS;  //Set Link to have the full power-up
		}
	}
}

/////////////////////////
/// Utility Functions ///
/////////////////////////

//Returns number of Secret Shells collected.
int NumShells(){
	return Z4_ItemsAndTimers[NUM_SHELLS]; //When calling NumShells() ZC will tell us how many Secret Shells the player has
						//by reading this value, and returning it.
}

//Awards a bonus Secret Shell
void BonusShell(){
	Z4_ItemsAndTimers[NUM_SHELLS]++; //Add one Secret Shell to out array counter.
}

//Returns true if the player has either an active Guardian Acorn Power-Up, or an active Piece of Power power-up.
bool HasPowerUp(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] || Z4_ItemsAndTimers[DEF_BOOSTED] ) { 
		//If either attack, or defence is boosted, return true.
		return true;
	}
	//If neither are boosted, return false.
	return false;
}

//Returns true if the player has a stone beak for the present level; and returns the number of beaks.
bool StoneBeak(){
	int lvl = Game->GetCurLevel(); //Store the current level to a variable.
	return StoneBeaks[lvl]; //Return the number of stone beaks the player has for this level. 
	//Remember, a value of '0' is treated as 'false', and '1' or more as 'true', so this allows us
	//either boolean, or integer control.
}

//Returns Link->Jump as an int. For whatever reason, this is recorded to allegro.log as a float, and some ZC versions
//have a bug involving this value, so we Floor it first.
int LinkJump(){
	int jmp = Floor(Link->Jump); //Floor Link->Jump to ensure that a value of 0.050 is '0'.
	return jmp; //Return the floored value.
}

//Automatically plays messages when the player has a Guardian Acorn power-up.
void AcornMessage(int msg){
	if ( ! Z4_ItemsAndTimers[MSG_GUARDIAN_PLAYED] && Z4_ItemsAndTimers[DEF_BOOSTED] ){ //If we haven't played the message, and Link's defence is boosted by an acorn...
		Z4_ItemsAndTimers[MSG_GUARDIAN_PLAYED] = 1; //Set the flag that tells us that ZC played the message...
		Screen->Message(msg); //Play the message input as arg 'msg', which is not the same as the cooking ingredient..
	}
}

//Automatically plays messages when the player has a Piece of Power power-up.
void PieceOfPowerMessage(int msg){
	if ( ! Z4_ItemsAndTimers[MSG_PIECE_POWER_PLAYED] && Z4_ItemsAndTimers[POWER_BOOSTED] ){ //If we haven't played the message, and Link's defence is boosted by a Piece of Power...
		Z4_ItemsAndTimers[MSG_PIECE_OF_POWER_PLAYED] = 1; //Set the flag that tells us that ZC played the message...
		Screen->Message(msg); //Play the message input as arg 'msg', which is not the same as the cooking ingredient..
	}
}

//////////////////////////////
/// Powerup MIDI Functions ///
//////////////////////////////

//Back up the original MIDIs so that we can later restore them.
void Backup_MIDIs(){
	for ( int q = 0; q <= 255; q++ ) { //A for loop with a size matching the size of Game->DMapMIDI[]
		PlayingPowerUp[q] = Game->DMapMIDI[q]; //Copy the first 256 elements of Game->DMapMIDI[] to PlayingPowerUp[].
		//This ensures that we can always restore them when we're done.
	}
}

//Copies all original MIDIs back to Game->DMapMIDI[]
void RestoreNonPowerUpMIDIs(){ 
	for ( int q = 0; q <= 255; q++ ) { //A for loop with a size matching the size of Game->DMapMIDI[]
		Game->DMapMIDI[q] = PlayingPowerUp[q]; //Copy the first 256 elements of  PlayingPowerUp[] to Game->DMapMIDI[].
	}
	//This restores the MIDIs set by the quest file, when we're done playing alternate MIDIs.
}

//An easy way to determine if we are playing a special MIDI for the power-ups.
bool _PlayingPowerUpMIDI(){
	return PlayingPowerUp[PLAYING_POWER_UP_MIDI]; 
}
//Above function replaced, with PlayingPowerUpMIDI() below.

//Change the value of this index, from 0 to 1, or 1 to 0, so that we can use it as a boolean flag to determine
//if we are playing a power-up MIDI.
void PlayingPowerUpMIDI(int setting){
	PlayingPowerUp[PLAYING_POWER_UP_MIDI] = setting;
}

//Copy the POWERUP_MIDI to DMapMIDI[] for this level, and hopefully auto-play it.
void PlayPowerUpMIDI(){
	int lvl = Game->GetCurLevel(); //Determine the present Level
	Game->DMapMIDI[lvl] = POWERUP_MIDI; //Change the value of the index of Game->DMapMIDI[] matching this level, to the MIDI of the Power-up MIDI
// This should, in theory, automatically play it, and it should not change if we leave the screen
// as it would with Game->PlayMIDI
// ZC should always play MIDIs with the new values for matching DMAPs.
}


//An easy way to determine if we are playing a special MIDI for the power-ups.
bool PlayingPowerUpMIDI(){
	int lvl = Game->GetCurLevel(); //Store the present level in a variable...
	if ( Game->DMapMIDI[lvl] == POWERUP_MIDI ){ //Check if the index lvl of Game->DMapMIDI[] is set to the special MIDI for power-ups.
		return true; //if so, return true.
	}
	return false; //Otherwise, return false.
}
	
//Plays the Power-Up MIDIs, by copying them into Game->DMapMIDI[]. Automates the routines for this...
void PowerUpMIDI(){
	if ( HasPowerUp() && !PlayingPowerUpMIDI() ) { //if Link has a power-up and we are not yet playing the special MIDI
		PlayingPowerUpMIDI(PLAY_POWERUP_MIDI); //Toggle this flag on.
		PlayPowerUpMIDI(); //Copy the special power-up MIDI to the index of Game->DMapMIDI[] for this level, and hopefully automatically play it.
		//Game->PlayMIDI(POWERUP_MIDI); //Removed in an old version, because this resets when leaving the screen.
	}
	if ( !HasPowerUp() && PlayingPowerUpMIDI() ) { //If Link does not have an active power-up, and we *are* still playing the power-up MIDI...
		RestoreNonPowerUpMIDIs(); //COpy the original MIDIs back to Game->DMapMIDIs[]
		PlayingPowerUpMIDI(NORMAL_DMAP_MIDI); //Toggle this flag back off.
	}
}

//Call in Global Script ~Init.
void InitZ4(){
	//InitScreenChanged(); //Set the intitial screen, and DMAP values, for checking if the screen changes.
	InitLinkHP(); //Store Link's HP initially, so that we know when he is hit. 
	PieceOfPowerKills(); //Establish how many enemies Link must kill for the first possible Piece of Power in the game.
}

	
//Runs from InitZ4 in Global script ~Init
//Call elsewhere to reset the value.
void PieceOfPowerKills(){
	int numKills = Rand(REQUIRE_KILLS_PIECE_OF_POWER_MIN,REQUIRE_KILLS_PIECE_OF_POWER_MAX); //Randomly generate the next number of required kills.
	Z4_ItemsAndTimers[POWERUP_PIECE_OF_POWER_NEEDED_KILLS] = numKills; //Set that to the value in the array.
}


//Store Link HP to check if he was hurt.
int StoreLinkHP(){
	Z4_ItemsAndTimers[POWERUP_PLAYER_HP] = Link->HP; //Store the present HP for Link this frame.
	if ( Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] > Z4_ItemsAndTimers[POWERUP_PLAYER_HP] ){ 
		//If this is lower than it was last frame (or at the atart of the game if this is the first frame of the game)
		//Link was hit.
		Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 1; //Set the flag that tells us that Link was hurt.
		Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] = Link->HP; //Store his new HP into the OLD_HP reference, so that
								     //we may use it next frame to repeat the check.
		//This value is set back to 0 by UpdateKilledEnemies(). 
	}
}

///Replacement function template for awarding kill bonuses:


//Run the routines to occur when killing enemies.
void KillRoutines(){
	 //Store Link's HP values, and determine if he was hurt this frame.
	CountEnemyKills(); //Store the number of enemies killed. 
}

void ResetConsecutiveKills(){
	if ( LinkHurt() ) { //otherwise...
		ResetLinkHurt(); //Set Link's hurt flag back to not hurt, so that we can mark this as the first consecutive kill...
		InitLinkHP(); //Re-store his HP values.
		Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] = 0; //Reset the consecutive kill counter to '1', as this is the new first kill.
		
	}
	if ( !LinkHurt() ) { //If Link was't hurt since the last clear of consecutive kills...
		
	}
}

//Count the number of enemy kills, this time, with a simpler method; more prone to slow-down. :/
void CountEnemyKills(){
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) { //Read every enemy on the screen...
		npc n = Screen->LoadNPC(q); //Assign each individually to an npc variable...
		if ( n->isValid() ) { //If that NPC is valid...
			if ( n->Type != NPCT_FAIRY ){ //and not a faerie...
				if ( n->HP <= 0 && n->HP > -9999 ) { //and alive....
					// ! Not being below -9998 is important, as this restricts the script
					// from infinitely awarding a kill bonus. Without this, the script
					// will go wild. 
					
					n->HP = -9999; //...set its HP to -9999 so that we don't give infinite awards.
					
					EnemiesExplodeOnDeath();
					
					Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS]++; //Increase his consecutive kill count.
					Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS]++; //and also increase the standard kill count.
					
				}
			}
		}
	}
}

//A utility function to easily determine if the flag for Link being hurt is enabled. 
int LinkHurt(){
	return Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED];
}


//A utility function to quickly reset the 'hurt' status of the player.
void ResetLinkHurt(){
	if ( LinkHurt() ) {
		Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 0; //Remove the 'hurt' flag.
	}
}

//Set up the values for Link's HP, and re-sync them when needed.
void InitLinkHP(){
	Z4_ItemsAndTimers[POWERUP_PLAYER_HP] = Link->HP; //Store Link's HP afresh.
	Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] = Link->HP;
}

//Award power-up items if the player has killed X-number enemies, or X-number consecutive enemies without being hurt.
void GivePowerUps(){
	bool awardedPoP = false; //Some boolean values to abuse.
	bool awardedGA = false;
	if ( Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] >= REQUIRE_CONSECUTIVE_KILLS && KILL_AWARDS ) {
		//If the player has killed a number of enemies set by constant REQUIRE_CONSECUTIVE_KILLS...
		//without being hurt...
		Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] = 0; //Reset the value of consecutive kills.
		Game->PlaySound(SFX_KILL_BONUS_POWERUP); //Play the power-up sound.
		item itm = Screen->CreateItem(I_ACORN); //Create an item, ID I_ACORN
		itm->X = Link->X; //Place it at Link's coordinates...
		itm->Y = Link->Y;
		itm->Z = Link->Z;
		Link->Action = LA_HOLD1LAND; //Cause Link to hold it up.
		Link->HeldItem = I_ACORN; //Set the item Link holds manually.
		awardedGA = true; //Set this value true. This later is used to toggle a global flag.
		
		
	}
	
	if ( Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] >= Z4_ItemsAndTimers[POWERUP_PIECE_OF_POWER_NEEDED_KILLS] && KILL_AWARDS ) {
		//If the player has killed the minimum number of enemies to earn a Piece of Power...
		Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] = 0;  //Reset the count.
		Game->PlaySound(SFX_KILL_BONUS_POWERUP); //Play the power-up sound.
		item itm = Screen->CreateItem(I_PIECE_POWER); //Create an item with the ID I_PIECE_POWER
		itm->X = Link->X; //Place it at Link's coordinates.
		itm->Y = Link->Y;
		itm->Z = Link->Z;
		Link->Action = LA_HOLD1LAND; //Cause Link to hold it up.
		Link->HeldItem = I_PIECE_POWER; //Set the item Link holds, manually. 
		
		awardedPoP = true;  //Set this value true. This later is used to toggle a global flag.
		
	}
	if ( awardedPoP ) Z4_ItemsAndTimers[AWARD_PIECE_OF_POWER] = 1; //If either of these conditions are true, set
	if ( awardedGA ) Z4_ItemsAndTimers[AWARD_GUARDIAN_ACORN] = 1;  //the corresponding global flag, that other functions
}								       //use to determine if they should give an item.


//Store Link HP to check if he was hurt.
int _StoreLinkHurt(){
	Z4_ItemsAndTimers[POWERUP_PLAYER_HP] = Link->HP; //Store the present HP for Link this frame.
	if ( Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] > Z4_ItemsAndTimers[POWERUP_PLAYER_HP] ){ 
		//If this is lower than it was last frame (or at the atart of the game if this is the first frame of the game)
		//Link was hit.
		Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 1; //Set the flag that tells us that Link was hurt.
		Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] = Link->HP; //Store his new HP into the OLD_HP reference, so that
								     //we may use it next frame to repeat the check.
		//This value is set back to 0 by UpdateKilledEnemies(). 
	}
}

void StoreLinkHurt(){
	if ( Link->Action == LA_GOTHURTLAND || Link->Action == LA_GOTHURTWATER || Link->Action == LA_DROWNING ) {
		Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 1; //Set the flag that tells us that Link was hurt.
	}
	else if ( Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] > Z4_ItemsAndTimers[POWERUP_PLAYER_HP] ){ 
		//If this is lower than it was last frame (or at the atart of the game if this is the first frame of the game)
		//Link was hit.
		Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 1; //Set the flag that tells us that Link was hurt.
		Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] = Link->HP; //Store his new HP into the OLD_HP reference, so that
								     //we may use it next frame to repeat the check.
		//This value is set back to 0 by UpdateKilledEnemies(). 
	}
}

//Cause enemies to have a death animation explosion with custom sprites.
//Run before Waitdraw() in the infinite ( while(true) ) loop of your global active script. 
//You need only call this one function to run the entirety of this code.
void EnemiesExplodeOnDeath(){
	if ( EXPLOSIONS_RUN_WITH_FFCS ) { //If this setting is enabled...
		EnemyExplosionFFC(); //Run this function.
	}
	else { //Otherwise...
		EnemyExplosion(); //Run this instead.
	}
}



////////////////////
/// Item Scripts ///
////////////////////

//Piece of Power item PICKUP script. 
item script PieceOfPower{
	void run(){
		Z4_ItemsAndTimers[NUM_PIECES_POWER]++; //When the player touches this item, add one to the array counter.
	}
}

//Acorn item PICKUP script. 
item script GuardianAcorn{
	void run(){
		Z4_ItemsAndTimers[NUM_ACORNS]++; //When the player touches this item, add one to the array counter.
	}
}

//Shell item PICKUP script. 
item script SecretShell{
	void run(){
		Z4_ItemsAndTimers[NUM_SHELLS]++; //When the player touches this item, add one to the array counter.
	}
}



//Attach as the Pick-Up script for the stone beak item.
item script StoneBeak_Pickup{
	void run(){
		int level = Game->GetCurLevel(); //Determine the present level, and store it in this variable.
		StoneBeaks[level]++; ////When the player touches this item, add one to the array counter for this level.
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
		int thisScreen = Game->GetCurScreen();
		if ( NumShells() % BONUS_SHELL_DIVISOR == 0 ) { //If the number of shells is an *exact multiple* of the value set by BONUS_SHELL_DIVISOR
			int shellsST = Game->GetScreenD(thisScreen,reg); //Store the present value of Screen->D register 'dat' in a variable, so that we can safely change the value of the register.
			if ( NumShells() > shellsST ) { //If the number of shells is higher than the value stored in Screen->D register 'dat' 
				Game->SetScreenD( thisScreen, reg, NumShells() ); //Set the register to the present number of shells, then...
				Game->PlaySound(SFX_BONUS_SHELL); //Play a special sound effect...
				BonusShell(); //...and award a bonus shell.
				//This replicates the bonus shell you may obtain at the Seashell manion in Z4 
				//by having exactly five shells, or multiples of 5 
				//on repeated visits. 
			}
		}
		if ( NumShells() >= REQUIRED_SECRET_SHELLS ) { //If we have enough shells to unlock a secret, as set by this constant
			Game->PlaySound(SFX_SECRET_SHELL); //Play a special sound to indicate that we unlocked a secret...
			if ( perm ) { //If arg D1 is '1' or higher...
				Screen->State[ST_SECRET] = true; //Set the secret state as permanent, then... 
			}
			Screen->TriggerSecrets(); //Trigger the secrets for this screen. 
						//This will be temporary if arg D1 is '0'.
		}
	}
}


/////////////////////////////
/// Sample Global Scripts ///
/////////////////////////////


global script LA_Active{ //An example global active script.
	void run(){
		TraceS(ST_Version);
		while(true){
			StoreLinkHurt();
			ResetConsecutiveKills();
			KillRoutines();
			GivePowerUps();
			EnemyPieceOfPower();
			EnemyGuardianAcorn();
			
			ReduceBuffTimers();
			LinksAwakeningItems();
			TestRoutines(); //This is used to store value sin counters for a visual reference when events occur. 
			
			Waitdraw();
			WalkSpeed();
			
			
			
			Waitframe();
		}
	}
}

global script LA_OnContinue{ //An example OnContinue script
	void run(){
		if ( RANDOMISE_PER_PLAY ) { //If this flag in settings is enabled, we will randomise the number of 
					    // enemies that Link must kill, each time he loads the game, so that 
					    // the number required when we saved is re-rolled. 
			PieceOfPowerKills(); //Randomise the value. 
		}
		InitLinkHP(); //Store Link's HP again, so that if we continue with more HP, the values aren;t out of sync.
		Z4_ItemsAndTimers[DEF_TIMER] = 0; //Reset timers for power-ups back to zero, so that they don;t carry over through F6
		Z4_ItemsAndTimers[POWER_TIMER] = 0; //or through saving.
		//Set timers back to 0, disabling the boost.
		if ( RESET_ENEMY_COUNT_ON_CONTINUE ) Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] = 0;
		if ( RESET_CONSECUTIVE_ENEMY_COUNT_ON_CONTINUE ) Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] = 0;
	}
}

global script LA_OnExit{
	void run(){
		Z4_ItemsAndTimers[DEF_TIMER] = 0;//Reset timers for power-ups back to zero, so that they don;t carry over through F6
		Z4_ItemsAndTimers[POWER_TIMER] = 0; //or through saving.
		//Set timers back to 0, disabling the boost.
	}
}

global script Init{
	void run(){
		InitZ4(); //Set up the initial values used by this script. 
	}
}

//void LinksAwakeningItems(int swords, int rings){
//}


//int TempBoostItems[6];
//int TempBoostTimers[2];


//int SwordItems[4]={1};
//int DefItems[4]={64};


//Drop one Guardian Acorn if the player kills 12 consecutive enemies without being hurt.


/// ! Check these functions to ensure they aren't broken !

//void Update_Powerup_HP(){
//	
//}

/// ! Check these functions to ensure they aren't broken !


//Example global script:

global script active_explosions{
	void run(){
		while(true){
			EnemiesExplodeOnDeath();
			Waitdraw();
			Waitframe();
		}
	}
}

//Routines

/// ! Check these functions to ensure they aren't broken !

//Death explosion animation function, for global use.
void EnemyExplosion(){
	int fX; //Set up variables to hold X/Y coordinates.
	int fY;
	bool isBoss;
	bool isMiniBoss;
	bool isFinalBoss;
	int numExplosions;
	int enemID;
	int explosionCount = numExplosions;
	eweapon explosion;
	int enemType;
	
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) { //Run a for loop to read every enemy on the screen...
		//Otherwise...
		npc n = Screen->LoadNPC(q); //Declare an npc variable, 
		if ( n->isValid() ) {
			
			if ( n->ID == FINAL_BOSS_ID ) {
				isFinalBoss = true;
				enemType = ENEM_TYPE_FINAL_BOSS;
			}
			
			for ( int e = 0; e < SizeOfArray(BossList); e++ ) {
				if ( isFinalBoss) break;
				enemID = BossList[e];
				if ( n->ID == enemID ) {
					isBoss = true;
					enemType = ENEM_TYPE_BOSS;
					break;
				}

			}
			
			for ( int e = 0; e < SizeOfArray(MiniBossList); e++ ) {
				if ( isBoss ) break;
				enemID = MiniBossList[e];
				if ( n->ID == enemID ) {
					isMiniBoss = true;
					enemType = ENEM_TYPE_MINIBOSS;
					break;
				}
			}
			
			
			if ( !ENEMIES_ALWAYS_EXPLODE && !isBoss && !isMiniBoss && !isFinalBoss && !Z4_ItemsAndTimers[POWER_BOOSTED] ){ //If these flags are all disabled, exit this function.
				break;
			}
			
			//Determine number of explosions by type of enemy...
			if ( isMiniBoss ) {
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_MINIBOSS_EXTRA;
			}
			else if ( isBoss ) {
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_BOSS_EXTRA;
			}
			else if ( isFinalBoss ) {
				if ( !FINAL_BOSS_EXPLOSIONS ) break;
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_FINALBOSS_EXTRA;
			}
			else numExplosions = FFC_NUM_OF_EXPLOSIONS;
			
			if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
				numExplosions += FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS; 
			}
			
			//and assign it to each valid NPC in the for loop.
			if ( n->HP <= 0 ) { //if the NPC is dead, or dying...
				fX = n->X; //Set the variables to the coordinates of that NPC.
				fY = n->Y;
				
				for ( int q = 0; q <= numExplosions; q++ ) {
					
					eweapon explosion; //Create a dummy eweapon to use for animations...
						
					//Run a for loop, to make a timed series of explosions...
					if ( numExplosions) { //Run only if there are explision to make.
						explosion = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
						Game->PlaySound(SFX_ENEMY_EXPLOSION);
						explosion->CollDetection = false; //...that doesn;t hurt anyone...
						
						if ( enemType == ENEM_TYPE_NORMAL ) {
							explosion->X = fX + Rand(-8,8); //at X coordinates fX plus a slightly randomised offset.
							explosion->Y = fY + Rand(-8,8); //at Y coordinates fX plus a slightly randomised offset.
							explosion->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
						
							}
						else if ( enemType == ENEM_TYPE_MINIBOSS ) {
							explosion->X = fX + Rand(-12,12); //at X coordinates fX plus a slightly randomised offset.
							explosion->Y = fY + Rand(-12,12); //at Y coordinates fX plus a slightly randomised offset.
							explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
						}
						else if ( enemType == ENEM_TYPE_BOSS ) {
							explosion->X = fX + Rand(-16,16); //at X coordinates fX plus a slightly randomised offset.
							explosion->Y = fY + Rand(-16,16); //at Y coordinates fX plus a slightly randomised offset.
							explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
						}
						else if ( enemType == ENEM_TYPE_FINAL_BOSS ) {
							explosion->X = fX + Rand(-24,24); //at X coordinates fX plus a slightly randomised offset.
							explosion->Y = fY + Rand(-24,24); //at Y coordinates fX plus a slightly randomised offset.
							explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
						}
						else {
							explosion->X = fX + Rand(-10,10); //at X coordinates fX plus a slightly randomised offset.
							explosion->Y = fY + Rand(-10,10); //at Y coordinates fX plus a slightly randomised offset.
							explosion->UseSprite(FFC_EXPLOSION_SPRITE); //...using this sprite
						}
						
						
						explosion->Extend = FFC_EXPLOSION_EXTEND; //...with extended size
						explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH; //...this many tiles wide
						explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT; ///...this many tiles high
						//Waitframe(); //..pause, then go back to the top of this loop, to repeat until the number of
							     // explosions is a total matching FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS
						explosion->DeadState = WDS_ARROW; //Kill the dummy eweapon
						
							
					}
				}
				explosion->DeadState = WDS_DEAD; //Kill the dummy eweapon
				Remove(explosion); //and remove it.
			}
		}
	}
}

void RunEnemyExplosionFFC(npc n, int numExplosions){
	int fX; //Set up variables to hold X/Y coordinates.
	int fY;
	
	if ( n->HP <= 0 ) { //if the NPC is dead, or dying...
		fX = n->X; //Assign its coordinates to the variables...
		fY = n->Y;
		
		int f_args[4]={fX,fY,numExplosions,0}; //...then make an array, and assign those variables as its indices.
		//if ( numExplosions ) 
		
		RunFFCScript(FFC_ENEMY_EXPLODE, f_args); //Launch the FFC script designated by FFC_ENEMY_EXPLODE
							 //using the values stored in the array f_args as the FFC 
							 //arguments D0 and D1.
	}
}

//Alternate to EnemyExplosion() that calls an FFC with its own Waitframe().
void EnemyExplosionFFC(){
	int fX; //Set up variables to hold X/Y coordinates.
	int fY;
	bool isBoss;
	bool isMiniBoss;
	bool isFinalBoss;
	int numExplosions;
	int enemID;
	
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) { //Run a for loop to read every enemy on the screen...
		npc n = Screen->LoadNPC(q); //Declare an npc variable, 
		int enemType;
		if ( n->isValid() ) { //and assign it to each valid NPC in the for loop.
			if ( n->ID == FINAL_BOSS_ID ) {
				isFinalBoss = true;
				enemType = ENEM_TYPE_FINAL_BOSS;
			}
			
			for ( int e = 0; e < SizeOfArray(BossList); e++ ) {
				if ( isFinalBoss ) break;
				enemID = BossList[e];
				if ( n->ID == enemID ) {
					isBoss = true;
					enemType = ENEM_TYPE_BOSS;
					break;
				}
			}
			for ( int e = 0; e < SizeOfArray(MiniBossList); e++ ) {
				if ( isBoss ) break;
				enemID = MiniBossList[e];
				if ( n->ID == enemID ) {
					isMiniBoss = true;
					enemType = ENEM_TYPE_MINIBOSS;
					break;
				}
			}
			
			
			
			if ( !ENEMIES_ALWAYS_EXPLODE && !isBoss && !isMiniBoss && !isFinalBoss && !Z4_ItemsAndTimers[POWER_BOOSTED] ){ //If these flags are both disabled, exit this function.
				break;
			}
			//Determine number of explosions by type of enemy...
			if ( isMiniBoss ) {
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_MINIBOSS_EXTRA;
			}
			else if ( isBoss ) {
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_BOSS_EXTRA;
			}
			else if ( isFinalBoss ) {
				if ( !FINAL_BOSS_EXPLOSIONS ) break;
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_FINALBOSS_EXTRA;
			}
			else numExplosions = FFC_NUM_OF_EXPLOSIONS;
			
			if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
				numExplosions += FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS; 
			}
			
			
			if ( n->HP <= 0 ) { //if the NPC is dead, or dying...
				fX = n->X; //Assign its coordinates to the variables...
				fY = n->Y;
				
				int f_args[4]={fX,fY,numExplosions,enemType}; //...then make an array, and assign those variables as its indices.
				//if ( numExplosions ) 
				
				RunFFCScript(FFC_ENEMY_EXPLODE, f_args); //Launch the FFC script designated by FFC_ENEMY_EXPLODE
									 //using the values stored in the array f_args as the FFC 
									 //arguments D0 and D1.
			}
		}
	}
}

//FFC Script: If you wish to use an FFC to generate this effect, assign this to a slot, update the constant above, then recompile. 

//FFC of death animation explosion, to use as alternative to global function.
//Do not call this directly, by assigning it to a screen FFC. This is designed to automatically run when needed.
//...unless you want something to look like it is perpetually exploding, but then, this will need modification to do that.
ffc script Explosion{
	void run (int fX, int fY, int numExplosions, int enemType){ //Inputs for coordinates. 

		//These args are to accept input by the instruction: RunFFCScript(FFC_ENEMY_EXPLODE, args[]) from other functions.
		eweapon explosion; //Create a dummy eweapon.
		eweapon explosion2;
		eweapon explosion3;
		eweapon explosion4;
		this->X = fX;
		this->Y = fY;
		int explosionCount = numExplosions;
		
		while ( explosionCount > 0 ) {
			for ( int q = 0; q <= numExplosions; q++ ) {
				//Run a for loop, to make a timed series of explosions...
				explosion = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				explosion2 = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				explosion3 = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				explosion4 = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				Game->PlaySound(SFX_ENEMY_EXPLOSION);
				explosion->CollDetection = false; //...that doesn;t hurt anyone...
				explosion2->CollDetection = false; //...that doesn;t hurt anyone...
				explosion3->CollDetection = false; //...that doesn;t hurt anyone...
				explosion4->CollDetection = false; //...that doesn;t hurt anyone...
				
				
				if ( enemType == ENEM_TYPE_NORMAL ) {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
					explosion2->X = this->X + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at X coordinates fX plus a slightly randomised offset.
					explosion2->Y = this->Y + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at Y coordinates fX plus a slightly randomised offset.
					explosion2->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
					explosion3->X = this->X + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at X coordinates fX plus a slightly randomised offset.
					explosion3->Y = this->Y + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at Y coordinates fX plus a slightly randomised offset.
					explosion3->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
					explosion4->X = this->X + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at X coordinates fX plus a slightly randomised offset.
					explosion4->Y = this->Y + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at Y coordinates fX plus a slightly randomised offset.
					explosion4->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_MINIBOSS ) {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion2->X = this->X + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion2->Y = this->Y + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion3->X = this->X + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion3->Y = this->Y + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion4->X = this->X + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion4->Y = this->Y + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
					explosion2->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
					explosion3->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
					explosion4->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_BOSS ) {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion2->X = this->X + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion2->Y = this->Y + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at Y coordinates fX plus a slightly randomised offset.
				
					explosion3->X = this->X + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion3->Y = this->Y + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at Y coordinates fX plus a slightly randomised offset.
				
					explosion4->X = this->X + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion4->Y = this->Y + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
					explosion2->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
					explosion3->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
					explosion4->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_FINAL_BOSS ) {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion2->X = this->X + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion2->Y = this->Y + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion3->X = this->X + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion3->Y = this->Y + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion4->X = this->X + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion4->Y = this->Y + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at Y coordinates fX plus a slightly randomised offset.
		
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
					explosion2->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
					explosion3->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
					explosion4->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
				}
				else {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_OTHER,EXPLOSION_DIST_OTHER); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_OTHER,EXPLOSION_DIST_OTHER); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE); //...using this sprite
				}
				
				explosion->Extend = FFC_EXPLOSION_EXTEND; //...with extended size
				explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH; //...this many tiles wide
				explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT; ///...this many tiles high
				
				
				for ( int w = 0; w <= FFC_EXPLOSION_DELAY; w++){
					Waitframe();
				}
				explosion->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion); //...and remove it.
				explosion2->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion2); //...and remove it.
				explosion3->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion3); //...and remove it.
				explosion4->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion4); //...and remove it.
				explosionCount--;
				
				Waitframe(); //..pause, then go back to the top of this loop, to repeat until the number of
					     // explosions is a total matching FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS
			}
			Waitframe();
		}
		explosion->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion); //...and remove it.
		explosion2->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion2); //...and remove it.
		explosion3->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion3); //...and remove it.
		explosion4->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion4); //...and remove it.
		this->X = -100;
		this->Y = -100;
		this->Data = 0; //...set the FFC script slot back to a usable state.
		Quit(); //...and exit. 
	}
}





//Routines to test code.
void TestRoutines(){
	TestEnemyCounters();
	//TestScreenChanged();
}

///This copies values held in the array into counters, to display them. 
//This makes it easier to check the functionality of the routines in play.
void TestEnemyCounters(){
	Game->Counter[CR_SCRIPT1] = Z4_ItemsAndTimers[POWERUP_PIECE_OF_POWER_NEEDED_KILLS];
	Game->Counter[CR_SCRIPT2] = Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES];
	Game->Counter[CR_SCRIPT3] = Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS];
	Game->Counter[CR_SCRIPT4] = Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS];
	Game->Counter[CR_SCRIPT5] = Z4_ItemsAndTimers[POWERUP_PLAYER_HP];
	Game->Counter[CR_SCRIPT6] = Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP];
	Game->Counter[CR_SCRIPT7] = Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED];
	Game->Counter[CR_SCRIPT8] = Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER_LAST];
	Game->Counter[CR_SCRIPT9] = Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER];
	Game->Counter[CR_SCRIPT10] = Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED];
}

//Plays a sound if the game believes the screen has changed based on flags. 
//Not used in this version.
void TestScreenChanged(){
	if ( Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] ) {
		Game->PlaySound(SFX_SCREEN_CHANGED);
	}
}

//The script version, and copyright.
int ST_Version[]="Link's Awakening Demi-Engine v0.6.4 - 26-JULY-2015 (c) 2015 TMGS, by ZoriaRPG";

//The following functions are deprecated, although they may return in a revamped form at some later point.
//None of these are called by anything in this version of the code. 

void Z4_EnemyKillRoutines(){ //This is a container function. Using these simplifies reading your global acript later, by reducing the number of direct calls.
	Z4ScreenChanged(); //Call these functions:
	CountEnemies();
	StoreLinkHP();
	KillPieceOfPower();
	KillAwards();
	
}

//Run before Waitdraw.
void Z4ScreenChanged(){ //Determines if the screen changed from scrolling, or warping. 
	PowerupStoreScreenChange();  //Store change values.
	PowerupScreenUpdateScrolling(); //and update them. 
}

//Runs from InitZ4 in Global script ~Init
void InitScreenChanged(){
	Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 1; //Set this flag to '1' so that the game isn't confused. 
}

//Runs from InitZ4 in Global script ~Init
void _InitLinkHP(){
	Z4_ItemsAndTimers[POWERUP_PLAYER_HP] = Link->HP; //Store the initial values of these, as a reference.
	Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP] = Link->HP;
}

	
//Runs before Waitdraw() from Z4ScreenChanged()
void PowerupStoreScreenChange(){
	int thisScreen = Game->GetCurScreen(); //Store the present screen ID in a variable.
	int thisDMap = Game->GetCurDMap(); //Store the present DMAP ID in a variable.
	if ( thisScreen != Z4_ItemsAndTimers[POWERUP_CURSCREEN] || thisDMap != Z4_ItemsAndTimers[POWERUP_CURDMAP] ){
			//If the present screen and DMAP are not the same as the ones stored, we know that tje screen has changed.
		Z4_ItemsAndTimers[POWERUP_CURSCREEN] = thisScreen; //Then we update the values for the screen...
		Z4_ItemsAndTimers[POWERUP_CURDMAP] = thisDMap; //...and the DMAP in the array
		Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 1; //and set this flag.
	}
	else {
		Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 0; //Otherwise, the screen HAS NOT changed, so we set this flag to '0'.
	}
}	

//Run in conjunction with PowerupStoreScreenChange(). Runs from Z4ScreenChanged()
void PowerupScreenUpdateScrolling(){
	if ( Link->Action == LA_SCROLLING ) { //If Link moves between screens with scrolling
		Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 1; //Set this flag so that we know that the screen has changed.
	}
}

//Utility function to determine if screen has changed.
int PowerUpScreenChanged(){
	if ( Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] ) { //If this value is '1' or higher...
		return 1; //The screen has changed, so this will return true.
	}
	return 0; //If it has a value of '0', the screen has not changed, so we don;t run routines that we want to run when the screen changes.
	//This is important when determining how many enemies we killed on this screen, before leaving it, so that we don't
	//set up a huge loop where the number infinitely increases.
}

//Count screen enemies and store the value.
void CountEnemies(){
	if ( PowerUpScreenChanged() ) { //If the screen has changed
		Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] = 0;
		if ( Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] > 0 ) { //If the number of enemies that are on the screen is not zero
			Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = 0; //Change it to zero...then...
		}
		Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = ( Screen->NumNPCs() - NumNPCsOf(NPCT_FAIRY) ); 
		//Check the number of enemies on the screen (other than faerie NPCs) and store the value.
		//This ensures that if we kill enemies, and leave the screen, the number that we use
		//as a reference to determine how many enemies we've killed, doesn't become desync'd. 
		
	}
}
	
//Check if any enemies have been killed.
void UpdateKilledEnemies(){
	int diff; //A variable for operations.
	int numEnem = ( Screen->NumNPCs() - NumNPCsOf(NPCT_FAIRY) ); //Count the (non-faerie) enemies on the screen, and store that value.
	if  ( numEnem < Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] ) { //If the number of enemies is fewer than the value we stored last frame...
		diff = ( Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] - numEnem ); //Calculate the difference.
		//if ( LinkHurt() ) {
		//	Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] = 0;
		//	ResetLinkHurt();
		//	InitLinkHP();
		//}
		Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] += diff; //This is how many enemies we killed this frame, so add that to our kill counter.
		Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES] = numEnem; //Change the array value of the number of on-screen enemies, so that we don't award extra kills.
		if ( Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] == 0 ) { //If Link was *NOT* hurt...
			Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] += diff; //also increase the value of consecutive kills by the same amoumt.
		}
		else if ( Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] == 1 ) { //but if Link was hurt this frame...we don;t award that...
			Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] = 0; //we set it back to zero instead.
			Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 0; //Then we reset the flag, to restart the count of consecutive kills w/o being hurt.
		}
	}
}

//End timer for a Piece of Power if the player was hurt a specified number of times.
void KillPieceOfPower(){
	if ( Z4_ItemsAndTimers[POWER_BOOSTED] && REMOVE_ATTACK_BOOST_WHEN_PLAYER_DAMAGED ) {
		if ( Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] ) {
			//this is set to either 0 or 1 each frame by UpdateKilledEnemies()
			Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] = 0;
			Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER]++; //Increase this counter if Link was hurt.
			//Because Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED] is set to either 0 or 1 before this runs, it 
			//should only increase once, unless Link is hurt multiple times in consecutive frames. 
		}
		
		if ( Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] >= NUM_HITS_TO_LOSE_POWER_BOOST ){
			//If Link was hurt more times than specified by constant NUM_HITS_TO_LOSE_POWER_BOOST
			Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER] = 0; //Reset hurt counters.
			Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER_LAST] = 0; //Reset hurt counters.
			Z4_ItemsAndTimers[POWER_TIMER] = 0; //Set POWER_TIMER to 0, ending the effect of a Piece of Power boost.
		}
	}
}
	
	

//If the flag KILL_AWARDS is set true, award buff items for killing enemies. 
void KillAwards(){
	if ( KILL_AWARDS ) { //If this setting is enabled..
		GiveAcorn(); //Run these functions.
		GivePieceOfPower();
	}
}

//Award a free Guardian Acorn for killing a number of monsters specified in settings, without being hit. 
void GiveAcorn(){
	if ( Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] >= REQUIRE_CONSECUTIVE_KILLS && KILL_AWARDS ){
		//If we consecutively kill a number of enemies equal to, or greater than the minimum
		//specified by the constant REQUIRE_CONSECUTIVE_KILLS:
		item itm = Screen->CreateItem(I_ACORN); //Create an item, ID I_ACORN
		itm->X = Link->X; //Place it at Link's coordinates...
		itm->Y = Link->Y;
		itm->Z = Link->Z;
		Link->Action = LA_HOLD1LAND; //Cause Link to hold it up.
		Link->HeldItem = I_ACORN; //Set the item Link holds manually.
		Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS] = 0; //Reset the consecutive kills counter. 
	}
}

//Drop one Piece of Power after killing a number of monsters specified by settings.
void GivePieceOfPower(){
	if ( Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] >= Z4_ItemsAndTimers[POWERUP_PIECE_OF_POWER_NEEDED_KILLS] && KILL_AWARDS ){
		//If we  kill a number of enemies equal to, or greater than the minimum
		//specified by the random value generated by PieceOfPowerKills(), that we've stored in 
		// array index Z4_ItemsAndTimers[POWERUP_PIECE_OF_POWER_NEEDED_KILLS] :
		
		item itm = Screen->CreateItem(I_PIECE_POWER); //Create an item with the ID I_PIECE_POWER
		itm->X = Link->X; //Place it at Link's coordinates.
		itm->Y = Link->Y;
		itm->Z = Link->Z;
		Link->Action = LA_HOLD1LAND; //Cause Link to hold it up.
		Link->HeldItem = I_PIECE_POWER; //Set the item Link holds, manually. 
		Z4_ItemsAndTimers[POWERUP_ENEMY_KILLS] = 0; //Reset the total kills counter.
		PieceOfPowerKills(); //Randomly generate the new number of kills needed, for the next Piece of Power 
				     //awarded this way.
	}
}


//Z4_ItemsAndTimers[POWER_WALK_TIMER]

///ffcscript.zh

// ffcscript.zh
// Version 1.1.0

// Combo to be used for generic script vehicle FFCs. This should be
// an invisible combo with no type or flag. It cannot be combo 0.
const int FFCS_INVISIBLE_COMBO = 735;

item script ffcScriptNEW{
	void run(){
	}
}

// Range of FFCs to use. Numbers must be between 1 and 32.
const int FFCS_MIN_FFC = 1;
const int FFCS_MAX_FFC = 32;


int RunFFCScript(int scriptNum, float args)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        return 0;
    
    ffc theFFC;
    
    // Find an FFC not already in use
    for(int i=FFCS_MIN_FFC; i<=FFCS_MAX_FFC; i++)
    {
        theFFC=Screen->LoadFFC(i);
        
        if(theFFC->Script!=0 ||
           (theFFC->Data!=0 && theFFC->Data!=FFCS_INVISIBLE_COMBO))
            continue;
        
        // Found an unused one; set it up
        theFFC->Data=FFCS_INVISIBLE_COMBO;
        theFFC->Script=scriptNum;
        
        if(args!=NULL)
        {
            for(int j=Min(SizeOfArray(args), 8)-1; j>=0; j--)
                theFFC->InitD[j]=args[j];
        }
        
        return i;
    }
    
    // No FFCs available
    return 0;
}

ffc RunFFCScriptOrQuit(int scriptNum, float args)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        Quit();
    
    int ffcID=RunFFCScript(scriptNum, args);
    if(ffcID==0)
        Quit();
    
    return Screen->LoadFFC(ffcID);
}

int FindFFCRunning(int scriptNum)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        return 0;
    
    ffc f;
    
    for(int i=1; i<=32; i++)
    {
        f=Screen->LoadFFC(i);
        if(f->Script==scriptNum)
            return i;
    }
    
    // No FFCs running it
    return 0;
}

int FindNthFFCRunning(int scriptNum, int n)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        return 0;
    
    ffc f;
    
    for(int i=1; i<=32; i++)
    {
        f=Screen->LoadFFC(i);
        if(f->Script==scriptNum)
        {
            n--;
            if(n==0)
                return i;
        }
    }
    
    // Not that many FFCs running it
    return 0;
}

int CountFFCsRunning(int scriptNum)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        return 0;
    
    ffc f;
    int numFFCs=0;
    
    for(int i=1; i<=32; i++)
    {
        f=Screen->LoadFFC(i);
        if(f->Script==scriptNum)
            numFFCs++;
    }
    
    return numFFCs;
}

bool FFCRunning(int ffcslot) {
	if ( FindFFCRunning(ffcslot) == 0 ){
		return false;
	}
	else {
		return true;
	}
}

///stdExtra.zh
//=============================================================================
// stdExtra.zh version 3.2
// Latest update:
//	* Added getFlip()
//=============================================================================

//Pre-requisites
//import "std.zh"
//import "ffcscript.zh"
//import "string.zh"

//==== * Quest-Specific Settings * ============================================

//Text colors
const int COLOR_WHITE		= 12;
const int COLOR_BLACK		= 8;

//Combos
const int CMB_BLANK 		= 0;	//Leave this be - combo 0 should always be invisible and no properties
const int CMB_FREEZEALL		= 712;	//Combo with "Freeze all (Except FFCs)" type
const int CMB_FREEZEFFC		= 713;	//Combo with "Freeze all (FFCs only)" type

//FFC Slots
const int FFC_FREEZEALL		= 31;
const int FFC_FREEZEFFC		= 32;

//Other Settings
const int MAX_ITEMS			= 255;	//Set to the highest item ID you use to make GetCurrentItem() more efficient
const int SS_MOVES_LIMIT	= 30;	//How many moves to attempt in equipItemX()

//=============================================================================

//Screen Dimensions
const int SCREEN_WIDTH			= 256;
const int SCREEN_HEIGHT			= 176;
const int SCREEN_VISIBLEHEIGHT	= 168; //The height of the screen you can see (bottom 8 pixels cut off)
const int SCREEN_SSTOP			= -64; //The top of the subscreen is at Y=-64

//Sprite Flips and rotations
const int FLIP_NO         = 0; //Not flipped
const int FLIP_H          = 1; //Horizontal
const int FLIP_V          = 2; //Vertical
const int FLIP_B          = 3; //Vertical & Horizontal
const int ROTATE_CW       = 4; //Clockwise
const int ROTATE_CCW      = 7; //Counter-clockwise
const int ROTATE_CW_FLIP  = 5;
const int ROTATE_CCW_FLIP = 6;

//NPC Misc Flags
const int NPCMF_DAMAGE       = 0x0001; //"Damaged by Power 0 weapons"
const int NPCMF_INVISIBLE    = 0x0002; //"Is invisible"
const int NPCMF_NOTRETURN    = 0x0004; //"Never returns after death"
const int NPCMF_NOTENEMY     = 0x0008; //"Doesn't count as beatable enemy"
const int NPCMF_SPAWNFLICKER = 0x0010; //Spawn animation = flicker (???)
const int NPCMF_LENSONLY     = 0x0020; //"Can only be seen with Lens of Truth"
const int NPCMF_FLASHING     = 0x0040;
const int NPCMF_FLICKERING   = 0x0080;
const int NPCMF_TRANSLUCENT  = 0x0100;
const int NPCMF_SHIELDFRONT  = 0x0200;
const int NPCMF_SHIELDLEFT   = 0x0400;
const int NPCMF_SHIELDRIGHT  = 0x0800;
const int NPCMF_SHIELDBACK   = 0x1000;
const int NPCMF_HAMMERBREAK  = 0x2000; //"Hammer can break shield"

//===============================================================================
//Reusable scripts
//===============================================================================

//Run an FFC script
//D0-D6: Arguments for the FFC Script
//D7: The script number to run
item script ffcItem{
    void run(int d0, int d1, int d2, int d3, int d4, int d5, int d6, int ffc_id){
        int d[7] = {d0,d1,d2,d3,d4,d5,d6};
        if(FindFFCRunning(ffc_id)<=0){
            RunFFCScriptOrQuit(ffc_id, d);
        }
    }
}

//===============================================================================
//Position and movement
//===============================================================================

//Prevents moving in any direction
void NoMovement(){
	Link->InputUp = false; Link->PressUp = false;
	Link->InputDown = false; Link->PressDown = false;
	Link->InputLeft = false; Link->PressLeft = false;
	Link->InputRight = false; Link->PressRight = false;
}

//Converts velocity into a direction.
int VelocityToDir(float x, float y){
	if(x == 0 && y == 0) return -1;
	return RadianAngleDir8(RadianAngle(0, x, 0, y));
}

int VelocityToDir4(float x, float y){
	if(x == 0 && y == 0) return -1;
	return RadianAngleDir4(RadianAngle(0, x, 0, y));
}

//Converts the x component of a velocity into a direction.
int XSpeedToDir(float x){
	return VelocityToDir(x, 0);
}

//Converts the y component of a velocity into a direction.
int YSpeedToDir(float y){
	return VelocityToDir(0, y);
}

//Takes a direction of movement and gets the xspeed.
float DirToXSpeed(int dir){
	if(dir<4)
		return Cond((dir*2)-5 < -1, 0, (dir*2)-5);
	else
		return Cond(dir<6, -1.5, 1.5);
}

//Takes a direction of movement and gets the yspeed.
float DirToYSpeed(int dir){
	if(dir > 7) dir = toggleBlock(dir);
	if(dir < 2) return 0;
	float ret = 1;
	if(dir >= 4) ret += .5;
	return Cond(IsEven(dir), -ret, ret);
}

//Returns the angle in radians of a direction; used for weapon angles
float dirToRad(int dir){
	if ( dir == DIR_UP )
		return 1.5 * PI;
	if ( dir == DIR_DOWN )
		return .5 * PI;
	if ( dir == DIR_LEFT )
		return PI;
	if ( dir == DIR_RIGHT )
		return 0;
}

int dirToDeg(int dir){
	if ( dir == DIR_UP )
		return 90;
	if ( dir == DIR_DOWN )
		return 270;
	if ( dir == DIR_LEFT )
		return 180;
	if ( dir == DIR_RIGHT )
		return 0;
}

//Returns value from 0 to 360 rather than -180 to 180
float AnglePos(int x1, int y1, int x2, int y2){
	float angle = ArcTan(x2-x1, y2-y1)*57.2958;
	if(angle < 0)
	angle += 360;
	return angle;
}

//Returns the distance between the given Coordinate and Link's Center.
float DistanceLink(float x, float y){
	return Distance(CenterLinkX(), CenterLinkY(), x, y);
}

//Returns the distance between Link's center and an object's center.
float DistanceLink(ffc f){
	return Distance(CenterLinkX(), CenterLinkY(), CenterX(f), CenterY(f));
}
float DistanceLink(npc n){
	return Distance(CenterLinkX(), CenterLinkY(), CenterX(n), CenterY(n));
}
float DistanceLink(lweapon l){
	return Distance(CenterLinkX(), CenterLinkY(), CenterX(l), CenterY(l));
}
float DistanceLink(eweapon e){
	return Distance(CenterLinkX(), CenterLinkY(), CenterX(e), CenterY(e));
}

//Converts 8-way direction to 4-way
int dir8ToDir4(int dir){
	if(dir != Clamp(dir, 0, 15)) return -1;
		dir &= 7;
	if((dir & 4) == 0)
		return dir;
	else
		return Cond(IsEven(dir), DIR_UP, DIR_DOWN);
}

//Returns the reverse of the given direction.
int reverseDir(int dir){
	if(dir != Clamp(dir, 0, 15)) return -1; //Invalid direction
	return Cond(dir<8, OppositeDir(dir), ((dir+4)%8)+8);
}

//Move the specified object a set distance in a set direction
//Walkable: Don't move onto a solid space
//PreventOffScreen: Don't move off screen
bool moveLink ( int dir, int dist, bool walkable, bool preventOffScreen ){
	//Can't move
	if ( walkable && !CanWalk(Link->X, Link->Y, dir, dist, false) )
		return false;
	
	//Otherwise, check direction
	if ( dir == DIR_UP && (!preventOffScreen || Link->Y - dist > 0) )
		Link->Y -= dist;
	else if ( dir == DIR_DOWN && (!preventOffScreen || Link->Y + dist < SCREEN_HEIGHT) )
		Link->Y += dist;
	else if ( dir == DIR_LEFT && (!preventOffScreen || Link->X - dist > 0))
		Link->X -= dist;
	else if ( dir == DIR_RIGHT && (!preventOffScreen || Link->X + dist < SCREEN_WIDTH) )
		Link->X += dist;
		
	return true;
}
bool move ( ffc this, int dir, int dist, bool walkable, bool preventOffScreen ){
	//Can't move
	if ( walkable && !CanWalk(this->X, this->Y, dir, dist, false) )
		return false;
	
	//Otherwise, check direction
	if ( dir == DIR_UP && (!preventOffScreen || this->Y - dist > 0) )
		this->Y -= dist;
	else if ( dir == DIR_DOWN && (!preventOffScreen || this->Y + dist < SCREEN_HEIGHT) )
		this->Y += dist;
	else if ( dir == DIR_LEFT && (!preventOffScreen || this->X - dist > 0))
		this->X -= dist;
	else if ( dir == DIR_RIGHT && (!preventOffScreen || this->X + dist < SCREEN_WIDTH) )
		this->X += dist;
	
	return true;
}
bool move ( npc enem, int dir, int dist, bool walkable, bool preventOffScreen ){
	//Can't move
	if ( walkable && !CanWalk(enem->X, enem->Y, dir, dist, false) )
		return false;
	
	//Otherwise, check direction
	if ( dir == DIR_UP && (!preventOffScreen || enem->Y - dist > 0) )
		enem->Y -= dist;
	else if ( dir == DIR_DOWN && (!preventOffScreen || enem->Y + dist < SCREEN_HEIGHT) )
		enem->Y += dist;
	else if ( dir == DIR_LEFT && (!preventOffScreen || enem->X - dist > 0))
		enem->X -= dist;
	else if ( dir == DIR_RIGHT && (!preventOffScreen || enem->X + dist < SCREEN_WIDTH) )
		enem->X += dist;
	
	return true;
}
bool move ( lweapon weap, int dir, int dist, bool walkable, bool preventOffScreen ){
	//Can't move
	if ( walkable && !CanWalk(weap->X, weap->Y, dir, dist, false) )
		return false;
	
	//Otherwise, check direction
	if ( dir == DIR_UP && (!preventOffScreen || weap->Y - dist > 0) )
		weap->Y -= dist;
	else if ( dir == DIR_DOWN && (!preventOffScreen || weap->Y + dist < SCREEN_HEIGHT) )
		weap->Y += dist;
	else if ( dir == DIR_LEFT && (!preventOffScreen || weap->X - dist > 0))
		weap->X -= dist;
	else if ( dir == DIR_RIGHT && (!preventOffScreen || weap->X + dist < SCREEN_WIDTH) )
		weap->X += dist;
	
	return true;
}
bool move ( eweapon weap, int dir, int dist, bool walkable, bool preventOffScreen ){
	//Can't move
	if ( walkable && !CanWalk(weap->X, weap->Y, dir, dist, false) )
		return false;
	
	//Otherwise, check direction
	if ( dir == DIR_UP && (!preventOffScreen || weap->Y - dist > 0) )
		weap->Y -= dist;
	else if ( dir == DIR_DOWN && (!preventOffScreen || weap->Y + dist < SCREEN_HEIGHT) )
		weap->Y += dist;
	else if ( dir == DIR_LEFT && (!preventOffScreen || weap->X - dist > 0))
		weap->X -= dist;
	else if ( dir == DIR_RIGHT && (!preventOffScreen || weap->X + dist < SCREEN_WIDTH) )
		weap->X += dist;
		
	return true;
}
bool move ( item theItem, int dir, int dist, bool walkable, bool preventOffScreen ){
	//Can't move
	if ( walkable && !CanWalk(theItem->X, theItem->Y, dir, dist, false) )
		return false;
	
	//Otherwise, check direction
	if ( dir == DIR_UP && (!preventOffScreen || theItem->Y - dist > 0) )
		theItem->Y -= dist;
	else if ( dir == DIR_DOWN && (!preventOffScreen || theItem->Y + dist < SCREEN_HEIGHT) )
		theItem->Y += dist;
	else if ( dir == DIR_LEFT && (!preventOffScreen || theItem->X - dist > 0))
		theItem->X -= dist;
	else if ( dir == DIR_RIGHT && (!preventOffScreen || theItem->X + dist < SCREEN_WIDTH) )
		theItem->X += dist;
		
	return true;
}

//===============================================================================
//Items and Equipment
//===============================================================================

//Returns true if Link is pressing the button for an item
bool pressingItem(int id){
	return ( (GetEquipmentA()==id && Link->PressA) 
		   ||(GetEquipmentB()==id && Link->PressB) );
}

//Returns the id of the highest level item of the given class that Link has acquired.
//Unlike GetHighestLevelItem(), only applies to items Link owns
int GetCurrentItem(int itemclass){
	itemdata id;
	int ret = -1;
	int curlevel = -1000;
	for(int i = 0; i < MAX_ITEMS; i++){
		if(!Link->Item[i])
			continue;
		id = Game->LoadItemData(i);
		if(id->Family != itemclass)
			continue;
		if(id->Level > curlevel){
			curlevel = id->Level;
			ret = i;
		}
	}
	return ret;
}

//Gives the specified item with hold up animation and optional fanfare
//keep: Whether to actually give the item
//twoHand: Use 1 or 2 hand animation
//sfx: Whether to play item fanfare
void holdUpItem(int id, bool keep, bool twoHand, bool sfx){
	if ( sfx )
		Game->PlaySound(SFX_PICKUP);
	if ( twoHand )
		Link->Action = LA_HOLD2LAND;
	else
		Link->Action = LA_HOLD1LAND;
	Link->HeldItem = id;
	
	//Give the item and its counter effects
	if(keep){
		Link->Item[id] = true;
		itemdata data = Game->LoadItemData(id);
		//Increase capacity
		if(data->MaxIncrement > 0 && data->Max > Game->MCounter[data->Counter]){
			Game->MCounter[data->Counter] = Min(Game->MCounter[data->Counter]+data->MaxIncrement, data->Max);
		}
		//Increase count
		if(data->Amount > 0)
			Game->Counter[data->Counter] = Min(Game->Counter[data->Counter]+data->Amount, Game->MCounter[data->Counter]);
	}
}

//Tries to equip an item to A/B
//Gives up instead of freezing game if not found
//Item must be reachable by only moving right
//Returns true if item was selected; false if not
bool equipItemA(int id){
	//Switch until you're equipping it
	int movesLeft = SS_MOVES_LIMIT; //Failsafe: Don't crash game if item not found
	while ( movesLeft-- > 0 && GetEquipmentA() != id )
		Link->SelectAWeapon(DIR_RIGHT);
	return(GetEquipmentA() == id);
}
bool equipItemB(int id){
	//Switch until you're equipping it
	int movesLeft = SS_MOVES_LIMIT; //Failsafe: Don't crash game if item not found
	while ( movesLeft-- > 0 && GetEquipmentB() != id )
		Link->SelectBWeapon(DIR_RIGHT);
	return(GetEquipmentB() == id);
}


//===============================================================================
//Screen Freezing
//===============================================================================

//WARNING: DO NOT USE IN AN FFC SCRIPT OR THE FFC WILL FREEZE ITSELF!
//Use in global scripts only.
void freezeScreen(){
	ffc freezeAll = Screen->LoadFFC(FFC_FREEZEALL);
	freezeAll->Data = CMB_FREEZEALL;
	ffc freezeFFC = Screen->LoadFFC(FFC_FREEZEFFC);
	freezeFFC->Data = CMB_FREEZEFFC;
}

void unfreezeScreen(){
	ffc freezeAll = Screen->LoadFFC(FFC_FREEZEALL);
	freezeAll->Data = CMB_BLANK;
	ffc freezeFFC = Screen->LoadFFC(FFC_FREEZEFFC);
	freezeFFC->Data = CMB_BLANK;
}

//===============================================================================
//Weapons
//===============================================================================

//Toggles weapon blockability by adjusting its direction
int toggleBlock (int dir){
	if(dir < 8) dir |= 8;
	else dir &= ~8;
	return dir;
}

//Get the correct flip for a 4-dir weapon based on its direction
int getFlip(int dir){
	if ( dir == DIR_UP )
		return FLIP_NO;
	if ( dir == DIR_DOWN )
		return FLIP_B;
	if ( dir == DIR_LEFT )
		return ROTATE_CCW;
	if ( dir == DIR_RIGHT )
		return ROTATE_CW;
	return -1;
}

//Sets the flip for a 4-dir weapon based on a single sprite
void setFlip ( lweapon weapon ){
	if ( weapon->Dir == DIR_DOWN )
		weapon->Flip = FLIP_B;
	else if ( weapon->Dir == DIR_LEFT )
		weapon->Flip = ROTATE_CCW;
	else if ( weapon->Dir == DIR_RIGHT )
		weapon->Flip = ROTATE_CW;
}
void setFlip ( eweapon weapon ){
	if ( weapon->Dir == DIR_DOWN )
		weapon->Flip = FLIP_B;
	else if ( weapon->Dir == DIR_LEFT )
		weapon->Flip = ROTATE_CCW;
	else if ( weapon->Dir == DIR_RIGHT )
		weapon->Flip = ROTATE_CW;
}

//Sets flip for a 4-dir sword based on two sprites (up and right)
void setFlipSword ( lweapon weapon ){
	if ( weapon->Dir >= DIR_LEFT )
		weapon->Tile++;
	if ( weapon->Dir == DIR_DOWN )
		weapon->Flip = FLIP_B;
	else if ( weapon->Dir == DIR_LEFT )
		weapon->Flip = FLIP_H;
}
void setFlipSword ( eweapon weapon ){
	if ( weapon->Dir >= DIR_LEFT )
		weapon->Tile++;
	if ( weapon->Dir == DIR_DOWN )
		weapon->Flip = FLIP_B;
	else if ( weapon->Dir == DIR_LEFT )
		weapon->Flip = FLIP_H;
}

//===============================================================================
//Other
//===============================================================================

void permaSecrets(){
	Screen->TriggerSecrets();
	Screen->State[ST_SECRET] = true;
}

void tempSecrets(){
	Screen->TriggerSecrets();
	Screen->State[ST_SECRET] = false;
}

//Makes secrets permanent if "Secrets are temporary" is not checked
void screenSecrets(){
	Screen->TriggerSecrets();
	if(!(Screen->Flags[SF_SECRETS]&2)){
		Screen->State[ST_SECRET] = true;
	}
}

bool WaitframeCheckScreenChange(){
    int old_dmap_screen = Game->GetCurDMapScreen();
    int old_dmap = Game->GetCurDMap();
    Waitframe();
    return (old_dmap!=Game->GetCurDMap() || old_dmap_screen!=Game->GetCurDMapScreen());
}

bool WaitframeCheckWarp(){
	return ( WaitframeCheckScreenChange() && !(Link->Action==LA_SCROLLING));
}

//Draw an inverted circle (fill whole screen except circle)
void InvertedCircle(int bitmapID, int layer, int x, int y, int radius, int scale, int fillcolor){
    Screen->SetRenderTarget(bitmapID);     //Set the render target to the bitmap.
    Screen->Rectangle(layer, 0, 0, 256, 176, fillcolor, 1, 0, 0, 0, true, 128); //Cover the screen
    Screen->Circle(layer, x, y, radius, 0, scale, 0, 0, 0, true, 128); //Draw a transparent circle.
    Screen->SetRenderTarget(RT_SCREEN); //Set the render target back to the screen.
    Screen->DrawBitmap(layer, bitmapID, 0, 0, 256, 176, 0, 56, 256, 176, 0, true); //Draw the bitmap
}

bool LinkOnComboType(int type){
	 if(Screen->ComboT[ComboAt(CenterLinkX(), CenterLinkY())] == type) return true;
	 return false;
}

bool LinkOnTallGrass(){
	return ( LinkOnComboType(CT_TALLGRASS)
	      || LinkOnComboType(CT_TALLGRASSC)
		  || LinkOnComboType(CT_TALLGRASSNEXT)
	);
}

void closingWipe(int wipetime){
	for(int i = wipetime; i > 0; i--){
		InvertedCircle(4, 6, CenterLinkX(), CenterLinkY(), Floor(300/wipetime)*i, 1, 15);
		WaitNoAction();
	}
}
void openingWipe(int wipetime){
	for(int i = 0; i < wipetime; i++){
		InvertedCircle(4, 6, CenterLinkX(), CenterLinkY(), Floor(300/wipetime)*i, 1, 15);
		WaitNoAction();
	}
}

//Get the color value given CSet and in-CSet color
int color(int cset, int csetColor){
	return (cset*16) + csetColor;
}

//Simulates a 2D array
//Returns the index of an array given row, column, and number of rows
int arr2D ( int row, int col, int numCols ){
	return (row * numCols) + col;
}

//Extracted this method from ffcscript.zh for common usage
//If force is true, takes over the last FFC even if it's used
ffc loadUnusedFFC(bool force){
	ffc theFFC;
	for(int i = FFCS_MIN_FFC; i <= FFCS_MAX_FFC; i++){
        theFFC=Screen->LoadFFC(i); //Check each FFC
        
        if ( ffcIsBlank(theFFC) )
            return theFFC; //Return it
		
		if ( force && i == FFCS_MAX_FFC ) //Force last FFC
			return theFFC;
	}
	
	//No FFC found; return an invalid one
	ffc invalidFFC;
	return invalidFFC;
}

//Tells whether an FFC is blank and unused
bool ffcIsBlank(ffc this){
	return ( this->Script == 0 && //If not running a script
		   ( this->Data == 0 || this->Data == FFCS_INVISIBLE_COMBO)); //And blank combo
}

//Taken from the Shop script by Joe123
bool SelectPressInput(int input){
	if(input == 0) return Link->PressA;
	else if(input == 1) return Link->PressB;
	else if(input == 2) return Link->PressL;
	else if(input == 3) return Link->PressR;
}
void SetInput(int input, bool state){
	if(input == 0) Link->InputA = state;
	else if(input == 1) Link->InputB = state;
	else if(input == 2) Link->InputL = state;
	else if(input == 3) Link->InputR = state;
}

//Draws the given time in frames as minutes and seconds
//Taken from "Hot Rooms" by Zecora
//void drawTime(int layer, int x, int y, int frames){
//	drawTime(layer, x, y, FONT_S, COLOR_WHITE, COLOR_BLACK, TF_NORMAL, frames);
//}

//void drawTime(int layer, int x, int y, int font, int color, int bgcolor, int format, int frames){
//	int seconds = Div(frames, 60); //Total seconds
//	int minutes = Div(seconds, 60); //Total minutes
//	seconds %= 60; //Remaining seconds (0 - 59)
	
//	int string[5]; //Create an array of characters.
//	itoa(string, 0, minutes); //Add the minutes to the array.
//	string[strlen(string)] = ':'; //Add the : after the minutes.
//	if(seconds < 10) //Single-digit seconds: add '0' before count
//		string[strlen(string)] = '0';
//	itoa(string, strlen(string), seconds);
//	Screen->DrawString(layer, x, y, font, color, bgcolor, format, string, 128);
//}

//===============================================================================
//Debug
//===============================================================================

//Shortcut for drawInteger for debug output
//Each debug item should have a unique "num" (match between value and label)
void debugValue ( int num, float value ){
	debugValue(num, value, 0);
}

void debugValue ( int num, float value, int places ){
	places = Clamp(places, 0, 4);
	Screen->DrawInteger(6, 100, 2+10*num, FONT_S, COLOR_WHITE, COLOR_BLACK, -1, -1, value, places, OP_OPAQUE);
}

void debugValue( int num, bool value){
	int trueString[] = "true";
	int falseString[] = "false";
	Screen->DrawString(6, 100, 2+10*num, FONT_S, COLOR_WHITE, COLOR_BLACK, TF_NORMAL, Cond(value, trueString, falseString), OP_OPAQUE);
}

void debugLabel ( int num, int string ){
	Screen->DrawString(6, 2, 2+10*num, FONT_S, COLOR_WHITE, COLOR_BLACK, TF_NORMAL, string, OP_OPAQUE);
}

//Both functions in one call, matching "num"
void debug ( int num, int string, float value ){
	debugLabel(num, string);
	debugValue(num, value, 0);
}
void debug ( int num, int string, float value, int places ){
	debugLabel(num, string);
	debugValue(num, value, places);
}
void debug ( int num, int string, bool value ){
	debugLabel(num, string);
	debugValue(num, value);
}
