
const int SFX_MP_ERROR = 63;
const int USE_DOUBLED_MP_COSTS = 1;
const int CHECK_REDUCE = 1;
const int CHECK_REDUCE_RET_DIFF = 2;
const int CHECK = 3;
const int CHECK_INCREASE = 4;
const int SFX_WAND_MAGIC = 0;
const int SFX_WAND_MAGIC_UPGRADED = 0;
const int I_WAND_UPGRADE = 32;
const int FFC_MAGIC_BOOK = 1;
	
ffc script MagicBookEightFlames{
	
}


ffc script WandMagicBook{
	void run(int dmg, int ltype,  int flameLType, int flameSprite, int flameSFX, int flameLifespan, int flameSpeed, int flameLayer){
		bool flame;
		int flameX;
		int flameY;
		int IgnoreEnemyTypes[]={NPCT_GUY, NPCT_FAIRY, NPCT_ROCK, NPCT_PROJECTILE, NPCT_NONE};
		while(true){
			if ( Screen->NumLWeapons() ) {
				for ( int q = 1; q <= Screen->NumLWeapons; q++ ) {
					lweapon l = Screen->LoadLWeapon(q);
					if ( ltype && l->Type != ltype ) continue;
					if (( ltype && l->Type == ltype ) || ( !ltype && l->Type == LW_MAGIC ) ) {
						if ( l->isValid && Screen->NumNPCs() ) {
							for ( int w = 1; w <= Screen->NumNPCs()l w++ ) {
								if 
							}
						}
						if ( l->X <= 1 || l->X >= 248 || l->Y <= 1 || l->Y >= 160 ) {
							flameX = l->X;
							flameY = l->Y;
							CreateFlame(flameX, flameY, 1, flameLtype,dmg,flameSprite,flameSFX,flameSpeed,deadstate);
						}
					}
				}
			}
			Waitframe();
		}
	}
	void createFlame(int x, int y, int layer, int ltype, int damage, int sprite, int sfx, float speed){
		bool useDeadState;
		int deadState;
		int velocity;
		int spd;
		
		if ( speed < 0 ) { //If speed is a negative number, we use its integer half for a DeadState, and its decimal portion for Step.
			useDeadState = true;
			float spd = ( speed + Floor(speed) ) * 10; //This is the actuial Step.
			deadState = speed * -1;
			velocity = spd * -1;
		}
			
		if ( speed >= 0 ) velocity = spd;
		
		//if ( speed - Floor(speed) != 0 ) velocity = 
		
		Game->PlaySound(sfx);
		lweapon flame; 
		flame->Type = ltype;
		flame->X = x;
		flame->Y = y;
		flame->Power = damage;
		if ( velocity != 0 ) flame->Step = velocity;
		flame->UseSprite = sprite;
		if ( useDeadState ) flame->DeadState = deadState;
		
		if ( layer > 0 ) DrawToLayer(flame, layer, 128); //If layer is a positive value, draw to that layer, and make the sprite opaque. 
		if ( layer < 0 ) DrawToLayer(flame, (layer * -1), 128); //If layer is a negative value, draw to that layer, and make the sprite transparent.
	}
		
	void create8WayFlame(int x, int y, int layer, int ltype, int damage, int sprite, int sfx, float speed){
		//Iteration 1:
		bool useDeadState;
		int deadState;
		int velocity;
		int spd;
		
		if ( speed < 0 ) { //If speed is a negative number, we use its integer half for a DeadState, and its decimal portion for Step.
			useDeadState = true;
			float spd = ( speed + Floor(speed) ) * 10; //This is the actuial Step.
			deadState = speed * -1;
			velocity = spd * -1;
		}
			
		if ( speed >= 0 ) velocity = spd;
		
		//if ( speed - Floor(speed) != 0 ) velocity = 
		
		Game->PlaySound(sfx);
		lweapon flame; 
		flame->Type = ltype;
		flame->X = x;
		flame->Y = y;
		flame->Power = damage;
		if ( velocity != 0 ) flame->Step = velocity;
		flame->UseSprite = sprite;
		if ( useDeadState ) flame->DeadState = deadState;
		
		if ( layer > 0 ) DrawToLayer(flame, layer, 128); //If layer is a positive value, draw to that layer, and make the sprite opaque. 
		if ( layer < 0 ) DrawToLayer(flame, (layer * -1), 128); //If layer is a negative value, draw to that layer, and make the sprite transparent.
	}
		
	//void createFlame(int x, int y, int layer, int ltype, int damage, int sprite, int sfx, int speed, int deadstate){
	//void createFlame(int x, int y, int layer, int ltype, int damage, int sprite, int sfx, int speed, int flameFFC){
	
	//Accepts an array list of enemy types to ignore, and compares them to an enemy input as e argument 'enem'. 
	//Returns true if enem matches any NPCT on array 'list'.
	bool _IgnoreNPCs(int list, npc enem){
		bool match;
		for ( int q = 0; q < SizeOfArray(list); q++ ) {
			if ( enem->ID == list[q] ) match = true;
		}
		return match;
	}
}

//Do not change the wand item, or attach this to it. Instead, attach this to a custom item class, and leave the asset for the wand alone. 
//This script will use item attributes from the Wand item, to set up its values!
//? Can we do that?

//! No; so DO use he Wand item to run it.
//item script CustomWand(int mainSFX_upgradedSFX, int damage_bookDamage, int lType_bookLtype, int sprite_bookSprite, int speed_bookSpeed, int requireBook, int bookFFC){
item script CustomWand{
	void run(int ltype, int speed, int sprite, int deadState, int upgradeItemID, int flameFFC){
		//Check Magic -- We can do that with the item editor. 
		//If enough, make magic projectile, using properties of Wand item.
		//itemdata wand = Game->LoadItemData(this);
		
		
		
		int power = this->Power;
		//int cost = this->
		
		
		int sfx = this->UseSound;
		
		//We can't use counter refs like this on the primary item, unless we sacrifice a counter.
		//int lType = this->Amount; //(Item Editor->Pickup: Increase Amount)
		//int sprite = this->MaxIncrement; //(Item Editor->Pickup: Increase Counter Max)
		//int speed = this->Max; //(Item Editor->Pickup: But Not ABove)
		//int layer = book->Counter; //The selectionhere is extremely limited, 0 to 31. 
		
		//Using the level of a primary item has very limited potential. 
		//int flameFFC= this->Level; //(Item Editor->Data: Level)
		

		
		
		// We can;t use ->Family on the primary item.
		
		//itemclass->Counter appears to be a thing, but it's for increaaing a counter, not the magic cost.
		
		
		//! Custom Itemclasses have the following attributes:
		//! Level, Power, Magic Cost, Sound, 
		itemdata book = Game->LoadItemData(upgradeItemID);
		
		int book_dmg = book->Power;
		int book_ltype = book->Amount; //(Item Editor->Pickup: Increase Amount)
		int book_sprite = book->MaxIncrement; //(Item Editor->Pickup: Increase Counter Max)
		int book_speed = book->Max; //(Item Editor->Pickup: But Not ABove)
		int book_useFFC = book->Level; //(Item Editor->Data: Level)
		int book_sfx = book->UseSound; //(Item Editor->Action: Sound)
		

		int book_layer = book->Counter; //The selectionhere is extremely limited, 0 to 31. 
		
		int book_deadState = book->Family; //The range here is 0 to 254. Use IC_ constants for values 0 to 88. 
					//Values 89 through 254 are equivalent to the zz### item class number.
		//We can use counter refs that are set at zero, as arguments, because the book item is never directly used.
		//Silently add the book to Link->Items, with an indirect pickup, so that the counter refs are never utilised. 
		
		//void run(int dmg, int ltype,  int flameLType, int flameSprite, int flameSFX, int flameLifespan, int flameSpeed. int flameFFC){
		
		int book_attributes[]={book_dmg, book_ltype, book_sprite, book_sfx, book_deadState, book_speed, book_sfx, book_layer};
		
		
		
		//If we can check the item attributes of another item, we can use those fot the 'Upgrade item'.
		//calling itemdate should do this. 
		
		
		if ( !Link->Item[I_WAND_UPGRADE) Game->PlaySound(SFX_WAND_MAGIC);
		if ( Link->Item[I_WAND_UPGRADE) Game->PlaySound(SFX_WAND_MAGIC_UPGRADED);
		lweapon wand;
		
		wand = NextToLink(ltype, 8);      
		wand->UseSprite(sprite);
		wand->Damage = this->Power;                                    
		wand->Step = speed;                              
		if ( Link->Dir == DIR_DOWN ){
		    wand->Flip = 3;
		}
		else if ( Link->Dir == DIR_LEFT ){
		    wand->Tile++;
		    wand->Flip = 1;
		}
		else if ( Link->Dir == DIR_RIGHT ){
		    wand->Tile++;
		}
		
		RunFFCScript(FFC_MAGIC_BOOK, book_attributes);
	}
}
	
	

//All functions, scripts, or other commands that reduce MP, should process through these commands. 



//Disable to use exact MP amounts. 

//Locsl functions for this item.
void MagicCost(int amount){
	int avail = Link->MP;
	int val = amount * Game->Generic[GEN_MAGICDRAINRATE];
	if ( USE_DOUBLED_MP_COSTS ){
		if ( avail >= val ) Link->MP -= val;
		else Game->PlaySound(SFX_MP_ERROR);
	}
	else {
		if ( avail >= amount ) Link->MP -= amount;
		else Game->PlaySound(SFX_MP_ERROR);
	}
}




int _MagicCost(int action, int amount){
	int val;
	int LinkMP_Usable;
	if ( USE_DOUBLED_MP_COSTS ) val = amount * Game->Generic[GEN_MAGICDRAINRATE];
	else val = amount;
	//if ( USE_DOUBLED_MP_COSTS ) {
	//	if ( Game->Generic[GEN_MAGICDRAINRATE] ) LinkMP_Usable = Link->MP / Game->Generic[GEN_MAGICDRAINRATE];
	//	else LinkMP_Usable = 99999;
	//}
	//else 
	LinkMP_Usable = Link->MP;
	if (!action)	return (val);
	else if ( action == 1 ) { 
		if ( LinkMP_Usable >= val ) {
			Link->MP -= ( val );
			return 1;
		}
		else if ( LinkMP_Usable < val ) return 0;
	}
	else if ( action == 2 ) { 
		if ( LinkMP_Usable >= val ) {
			Link->MP -= ( val );
			return 1;
		}
		else if ( LinkMP_Usable < val ) 
			return LinkMP_Usable - val;
	}
	else if ( action == 3 ) {
		if ( LinkMP_Usable >= val ) return 1;
		else return 0;
	}
	//Expand as needed.
}
