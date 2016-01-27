const int SFX_SCREEN_CHANGED = 100;

//Testing routines.
void TestEnemyCounters(){
	Game->Counter[CR_SCRIPT1] = Z4_ItemsAndTimers[POWERUP_NUM_ENEMIES];
	Game->Counter[CR_SCRIPT2] = Z4_ItemsAndTimers[POWERUP_CONSECUTIVE_ENEMY_KILLS];
	Game->Counter[CR_SCRIPT3] = Z4_ItemsAndTimers[POWERUP_LINK_DAMAGED];
	Game->Counter[CR_SCRIPT4] = Z4_ItemsAndTimers[POWERUP_PIECE_OF_POWER_NEEDED_KILLS];
	Game->Counter[CR_SCRIPT5] = Z4_ItemsAndTimers[POWERUP_PLAYER_HP];
	Game->Counter[CR_SCRIPT6] = Z4_ItemsAndTimers[POWERUP_PLAYER_OLD_HP];
	Game->Counter[CR_SCRIPT7] = Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER_LAST];
	Game->Counter[CR_SCRIPT8] = Z4_ItemsAndTimers[POWERUP_LINK_HURT_COUNTER];
}

void TestScreenChanged(){
	if ( Z4_ItemsAndTimers[POWERUP_SCREEN_HAS_CHANGED] ) {
		Game->PlaySound(SFX_SCREEN_CHANGED);
	}
}

MSG_PIECE_OF_POWER
MSG_PIECE_OF_POWER_PLAYED

for ( int q = 0; q <= numExplosions; q++ ) {
				if ( explodeTimer == 70 ) {
					//Run a for loop, to make a timed series of explosions...
					explosion = Screen->CreateEWeapon(EW_BOMBBLAST); //Make an explosion..
					Game->PlaySound(SFX_ENEMY_EXPLOSION);
					explosion->CollDetection = false; //...that doesn;t hurt anyone...
					explosion->X = this->X + Rand(1,16)-8; //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(1,16)-8; //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE); //...using this sprite
					explosion->Extend = FFC_EXPLOSION_EXTEND; //...with extended size
					explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH; //...this many tiles wide
					explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT; ///...this many tiles high
					TraceS(str);
					Trace(fX);
					Trace(fY);
					Trace(explosionCount);
					
					explodeTimer--;
					if ( explodeTimer < 70 ) {
						continue;
					}
					if ( explodeTimer <= 0 ) {
						explodeTimer = 70;
					}
					explosionCount--;
				}
				Waitframe(); //..pause, then go back to the top of this loop, to repeat until the number of
					     // explosions is a total matching FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS
			}
void StartExplosion

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
			
			for ( int e = 0; e <= SizeOfArray(BossList); e++ ) {
				if ( isFinalBoss) break;
				enemID = BossList[e];
				if ( n->ID == enemID ) {
					isBoss = true;
					enemType = ENEM_TYPE_BOSS;
					break;
				}

			}
			
			for ( int e = 0; e <= SizeOfArray(MiniBossList); e++ ) {
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
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_FINALBOSS_EXTRA;
			}
			else numExplosions = FFC_NUM_OF_EXPLOSIONS;
			
			if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
				numExplosions += FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS; 
			}
			
			int Timer = FindFreeExplosionSlot();
			
			
			//and assign it to each valid NPC in the for loop.
			if ( n->HP <= 0 ) { //if the NPC is dead, or dying...
				fX = n->X; //Set the variables to the coordinates of that NPC.
				fY = n->Y;
				eweapon explosion; //Create a dummy eweapon to use for animations...
				for ( int q = 0; q <= numExplosions; q++ ) {
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
						Waitframe(); //..pause, then go back to the top of this loop, to repeat until the number of
							     // explosions is a total matching FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS
					}
				}
				explosion->DeadState = WDS_DEAD; //Kill the dummy eweapon
				Remove(explosion); //and remove it.
			}
		}
	}
}

ffc script Explosion{
	void run (int fX, int fY, int numExplosions, int enemType){ //Inputs for coordinates. 

		//These args are to accept input by the instruction: RunFFCScript(FFC_ENEMY_EXPLODE, args[]) from other functions.
		eweapon explosion; //Create a dummy eweapon.
		this->X = fX;
		this->Y = fY;
		int explosionCount = numExplosions;
		
		while ( explosionCount > 0 ) {
			for ( int q = 0; q <= numExplosions; q++ ) {
				//Run a for loop, to make a timed series of explosions...
				explosion = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				Game->PlaySound(SFX_ENEMY_EXPLOSION);
				explosion->CollDetection = false; //...that doesn;t hurt anyone...
				
				if ( enemType == ENEM_TYPE_NORMAL ) {
					explosion->X = this->X + Rand(-8,8); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-8,8); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_MINIBOSS ) {
					explosion->X = this->X + Rand(-12,12); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-12,12); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_BOSS ) {
					explosion->X = this->X + Rand(-16,16); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-16,16); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_FINAL_BOSS ) {
					explosion->X = this->X + Rand(-24,24); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-24,24); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
				}
				else {
					explosion->X = this->X + Rand(-10,10); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-10,10); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE); //...using this sprite
				}
				
				explosion->Extend = FFC_EXPLOSION_EXTEND; //...with extended size
				explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH; //...this many tiles wide
				explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT; ///...this many tiles high
				
				
				for ( int w = 0; w <= EXPLOSION_DELAY; w++){
					Waitframe();
				}
				explosion->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion); //...and remove it.
				explosionCount--;
				
				Waitframe(); //..pause, then go back to the top of this loop, to repeat until the number of
					     // explosions is a total matching FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS
			}
			Waitframe();
		}
		explosion->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion); //...and remove it.
		this->X = -100;
		this->Y = -100;
		this->Data = 0; //...set the FFC script slot back to a usable state.
		Quit(); //...and exit. 
	}
}

const int EXPLOSION_DELAY = 8;
const int FFC_EXPLOSION_SPRITE_NORMAL_ENEM = 87;
const int FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS = 9;
const int FFC_EXPLOSION_SPRITE_ENEM_BOSS = 17;
const int FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS = 81;
	
	
//Enemy Explosion Settings

const int ENEMIES_ALWAYS_EXPLODE = 1; //Set to '0' if enemies only explode when a player has a Piece of Power power-up.
const int EXPLOSIONS_RUN_WITH_FFCS = 0; //If set to 1, enemy explosions on death will run from FFCs
					//rather than from the global active infinite loop.
					
//Enemy Explosion Constants
const int FFC_ENEMY_EXPLODE = 0; //Set to FFC script slot for death explosion FFC animation.
const int FFC_NUM_OF_EXPLOSIONS = 4; //Base number of explosions when killing an enemy.
const int FFC_EXPLOSION_SPRITE = 0; //Sprite for the explosion.
const int FFC_EXPLOSION_EXTEND = 4; //Size of explosion eweapon.
const int FFC_EXPLOSION_TILEWIDTH = 2; //Width of explosion, in tiles.
const int FFC_EXPLOSION_TILEHEIGHT = 2; //Height of explosion, in tiles.
const int FFC_EXPLOSIONS_BOSS_EXTRA = 8;

//Arrays

int BossList[]={

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
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) { //Run a for loop to read every enemy on the screen...
		if ( !ENEMIES_ALWAYS_EXPLODE && !Z4_ItemsAndTimers[POWER_BOOSTED] ){ //If these flags are both disabled, exit this function.
			break;
		}
		//Otherwise...
		npc n = Screen->LoadNPC(q); //Declare an npc variable, 
		if ( n->isValid() ) {
			//and assign it to each valid NPC in the for loop.
			if ( q->HP <= 0 ) { //if the NPC is dead, or dying...
				fX = q->X; //Set the variables to the coordinates of that NPC.
				fY = q->Y;
				eweapon explosion; //Create a dummy eweapon to use for animations...
				for ( int q = 0; q <= FFC_NUM_OF_EXPLOSIONS; q++ ) {
					//Run a for loop, to make a timed series of explosions...
					explosion = Screen->CreateEWeapon(EW_BOMBBLAST); //Make an explosion..
					explosion->CollDetection = false; //...that doesn;t hurt anyone...
					explosion->X = fX + Rand(1,16)-8; //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = fY + Rand(1,16)-8; //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE); //...using this sprite
					explosion->Extend = FFC_EXPLOSION_EXTEND; //...with extended size
					explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH; //...this many tiles wide
					explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT; ///...this many tiles high
					Waitframe(); //..pause, then go back to the top of this loop, to repeat until the number of
						     // explosions is a total matching FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS
				}
				explosion->DeadState = WDS_DEAD; //Kill the dummy eweapon
				Remove(explosion); //and remove it.
			}
		}
	}
}

//Alternate to EnemyExplosion() that calls an FFC with its own Waitframe().
void EnemyExplosionFFC(){
	int fX; //Set up variables to hold X/Y coordinates.
	int fY;
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) { //Run a for loop to read every enemy on the screen...
		if ( !ENEMIES_ALWAYS_EXPLODE && !Z4_ItemsAndTimers[POWER_BOOSTED] ){
			break; //If these flags are both disabled, exit this function.
		}
		npc n = Screen->LoadNPC(q); //Declare an npc variable, 
		if ( n->isvalid() ) { //and assign it to each valid NPC in the for loop.
			if ( q->HP <= 0 ) { //if the NPC is dead, or dying...
				fX = q->X; //Assign its coordinates to the variables...
				fY = q->Y;
				int f_args[2]={fX,fY}; //...then make an array, and assign those variables as its indices.
				
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
	void run (int fX, int fY){ //Inputs for coordinates. 
		//These args are to accept input by the instruction: RunFFCScript(FFC_ENEMY_EXPLODE, args[]) from other functions.
		eweapon explosion; //Create a dummy eweapon.
		for ( int q = 0; q <= FFC_NUM_OF_EXPLOSIONS; q++ ) {
			//Run a for loop, to make a timed series of explosions...
			explosion = Screen->CreateEWeapon(EW_BOMBBLAST); //Make an explosion..
			explosion->CollDetection = false; //...that doesn;t hurt anyone...
			explosion->X = fX + Rand(1,16)-8; //at X coordinates fX plus a slightly randomised offset.
			explosion->Y = fY + Rand(1,16)-8; //at Y coordinates fX plus a slightly randomised offset.
			explosion->UseSprite(FFC_EXPLOSION_SPRITE); //...using this sprite
			explosion->Extend = FFC_EXPLOSION_EXTEND; //...with extended size
			explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH; //...this many tiles wide
			explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT; ///...this many tiles high
			Waitframe(); //..pause, then go back to the top of this loop, to repeat until the number of
				     // explosions is a total matching FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS
		}
		explosion->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion); //...and remove it.
		this->Data = 0; //...set the FFC script slot back to a usable state.
		return; //...and exit. 
	}
}

bool LinkSlow = false;
const int ADJUST_LINK_SPEED_SLOW = 2;

if ( Link->Action == LA_NONE && !LinkJump() && Link->Z == 0 && LinkSLow ) { //If he isnt attacking, swimming, hurt, or casting, and h
	if ( Link->PressDown ) {
		Link->X -= ADJUST_LINK_SPEED_SLOW;
	}
	if ( Link->PressUp ) {
		Link->X += ADJUST_LINK_SPEED_SLOW;
	}
	if ( Link->PressLeft ) {
		Link->Y -= ADJUST_LINK_SPEED_SLOW;
	}
	if ( Link->PressRight ) {
		Link->Y += ADJUST_LINK_SPEED_SLOW;
	}
}
	
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
			
			for ( int e = 0; e <= SizeOfArray(BossList); e++ ) {
				if ( isFinalBoss) break;
				enemID = BossList[e];
				if ( n->ID == enemID ) {
					isBoss = true;
					enemType = ENEM_TYPE_BOSS;
					break;
				}

			}
			
			for ( int e = 0; e <= SizeOfArray(MiniBossList); e++ ) {
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
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_FINALBOSS_EXTRA;
			}
			else numExplosions = FFC_NUM_OF_EXPLOSIONS;
			
			if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
				numExplosions += FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS; 
			}
			
			int explodeTimer = 60;
			
			
			//and assign it to each valid NPC in the for loop.
			if ( n->HP <= 0 ) { //if the NPC is dead, or dying...
				fX = n->X; //Set the variables to the coordinates of that NPC.
				fY = n->Y;
				
				for ( int q = 0; q <= numExplosions; q++ ) {
					eweapon explosion; //Create a dummy eweapon to use for animations...
					if ( explodeTimer == 60 ) {
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
							explosion->DeadState = WDS_DEAD; //Kill the dummy eweapon
							Remove(explosion); //and remove it.
							Trace(explodeTimer);
							explodeTimer--;
						}
					}
					else if ( explodeTimer < 60 && explodeTimer > 0 ) {
						Trace(explodeTimer);
						explodeTimer--;
						explosion->DeadState = WDS_DEAD; //Kill the dummy eweapon
						Remove(explosion); //and remove it.
					}
					else if ( explodeTimer == 0 ) {
						explodeTimer = 60;
					}
				}
				
			}
		}
	}
}

if (presentCombo < DIG_COMBO_START || presentCombo > DIG_COMBO_END || 
	( presentCombo > DIG_COMBO_END && presentCombo < DIG_SPECIAL_START )  || ( presentCombo > DIG_COMBO_END && presentCombo > DIG_SPECIAL_END || presentComboLayerDug == DUG_COMBO_NORMAL || presentComboLayerDug == DUG_COMBO_SPECIAL ){
	
NUM_ACORNS = NEEDED_ACORNS
NUM_PIECES_POWER= NEEDED_PIECES_OF_POWER

cKills
POWERUP_CONSECUTIVE_ENEMY_KILLS

kills
POWERUP_ENEMY_KILLS

linkHP
POWERUP_PLAYER_HP

linkOldHP
POWERUP_PLAYER_OLD_HP


if ( ENEMY_POWERUPS_ARE_FULL )
	
Z4_ItemsAndTimers

linkHurt
POWERUP_LINK_DAMAGED


if ( awardedPoP ) {
		if ( ENEMY_POWERUPS_ARE_FULL ) {
			Z4_ItemsAndTimers[NUM_PIECES_POWER] = NEEDED_PIECES_OF_POWER;
		}
		PieceOfPowerKills();
	}
	
AWARD_PIECE_OF_POWER
	
	
	EnemyGuardianAcorn(){
		
		
		AWARD_GUARDIAN_ACORN