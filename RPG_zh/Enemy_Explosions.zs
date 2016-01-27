// Generalised Enemy Explosions, from LinksAwakening_v0.50.zs
// Sub-version 0.2.1
// 2nd July, 2015

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
const int FFC_EXPLOSIONS_MINIBOSS_EXTRA = 4; //Add this many explosions if the enemy is a miniboss.
const int FFC_EXPLOSIONS_BOSS_EXTRA = 12; //Add this many explosions if the enemy is a full boss.
const int FFC_EXPLOSIONS_FINALBOSS_EXTRA = 16; //Add this many explosions if the enemy is the FINAL boss.

const int FINAL_BOSS_ID = 78; //Enemy ID of the FINAL boss. Ganon, by default. 

//Arrays

// A list of Boss enemies, by Enemy ID
// Add, or remove values from this list, to increase, or decrease the enemies treated 
// as Bosses for determining the number of explosions.
int BossList[]={	58,	61,	62,	63, 
			64, 	65, 	71, 	72, 
			73, 	76, 	77, 	93, 	
			94, 	103, 	104, 	105, 	
			109, 	110, 	111, 	112, 	
			114, 	121, 	122};
	
// A list of Mini-boss enemies by Enemy ID
// Add, or remove values from this list, to increase, or decrease the enemies treated 
// as Mini-bosses for determining the number of explosions.
int MiniBossList[]={	59, 	66,	67,	68,	
			69, 	70,	71,	74,	
			75};

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
	bool isBoss;
	bool isMiniBoss;
	bool isFinalBoss;
	int numExplosions;
	int enemID;
	
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) { //Run a for loop to read every enemy on the screen...
		//Otherwise...
		npc n = Screen->LoadNPC(q); //Declare an npc variable, 
		if ( n->isValid() ) {
			
			if n->ID == FINAL_BOSS_ID {
				isFinalBoss = true;
			}
			
			for ( int e = 0; 0 <= SizeOfArray(BossList); e++ ) {
				if ( isFinalBoss) break;
				enemID = BossList[e];
				if ( n->ID == enemID )
					isBoss = true;
					break;
				}
			}
			
			for ( int e = 0; 0 <= SizeOfArray(MiniBossList); e++ ) {
				if ( isBoss ) break;
				enemID = MiniBossList[e];
				if ( n->ID == enemID )
					isMiniBoss = true;
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
			else ( numExplosions = FFC_NUM_OF_EXPLOSIONS );
			
			if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
				numExplosions += FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS; 
			}
			
			//and assign it to each valid NPC in the for loop.
			if ( q->HP <= 0 ) { //if the NPC is dead, or dying...
				fX = q->X; //Set the variables to the coordinates of that NPC.
				fY = q->Y;
				eweapon explosion; //Create a dummy eweapon to use for animations...
				for ( int q = 0; q <= numExplosions; q++ ) {
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
	bool isBoss;
	bool isMiniBoss;
	bool isFinalBoss;
	int numExplosions;
	int enemID;
	
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) { //Run a for loop to read every enemy on the screen...
		npc n = Screen->LoadNPC(q); //Declare an npc variable, 
		if ( n->isvalid() ) { //and assign it to each valid NPC in the for loop.
			if n->ID == FINAL_BOSS_ID {
				isFinalBoss = true;
			}
			
			for ( int e = 0; 0 <= SizeOfArray(BossList); e++ ) {
				if ( isFinalBoss ) break;
				enemID = BossList[e];
				if ( n->ID == enemID )
					isBoss = true;
					break;
				}
			}
			for ( int e = 0; 0 <= SizeOfArray(MiniBossList); e++ ) {
				if ( isBoss ) break;
				enemID = MiniBossList[e];
				if ( n->ID == enemID )
					isMiniBoss = true;
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
				numExplosions = FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSIONS_FINALBOSS_EXTRA;
			}
			else ( numExplosions = FFC_NUM_OF_EXPLOSIONS );
			
			if ( Z4_ItemsAndTimers[POWER_BOOSTED] ) {
				numExplosions += FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS; 
			}
			
			if ( q->HP <= 0 ) { //if the NPC is dead, or dying...
				fX = q->X; //Assign its coordinates to the variables...
				fY = q->Y;
				int f_args[2]={fX,fY,numExplosions}; //...then make an array, and assign those variables as its indices.
				
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
	void run (int fX, int fY, int numExplosions){ //Inputs for coordinates. 
		//These args are to accept input by the instruction: RunFFCScript(FFC_ENEMY_EXPLODE, args[]) from other functions.
		eweapon explosion; //Create a dummy eweapon.
		for ( int q = 0; q <= numExplosions; q++ ) {
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

