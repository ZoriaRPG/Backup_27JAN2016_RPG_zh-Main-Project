
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

