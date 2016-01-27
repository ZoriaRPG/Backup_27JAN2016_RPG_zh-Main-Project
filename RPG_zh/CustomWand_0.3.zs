
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

//int book_attributes[]={book_dmg, ffc_lType, book_sprite, book_sfx, book_speed, book_sfx, book_layer, dir};

ffc script WandMagicBook{
	void run(float dmg, float ffc_lType, float flameSprite, float flameSFX, float flameLifespan, float flameSpeed, float flameLayer, float dir){
		bool flame;
		int flameX;
		int flameY;
		int IgnoreEnemyTypes[]={NPCT_GUY, NPCT_FAIRY, NPCT_ROCK, NPCT_PROJECTILE, NPCT_NONE};
		int ltype = Floor(ffc_lType);
		int flameLtype = ( ffc_lType - Floor(ffc_lType) ) * 10000;
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
	void createFlame(float x, float y, float layer, float ltype, float damage, float sprite, float sfx, float speed, int dir){
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
			
		if ( speed >= 0 ) {
			spd = Floor(speed);
			velocity = spd;
		}
		
		//if ( speed - Floor(speed) != 0 ) velocity = 
		
		Game->PlaySound(sfx);
		lweapon flame; 
		flame->Type = ltype;
		flame->X = x;
		flame->Y = y;
		//if ( dir ) flame->Dir = dir;
		flame->Dir = Floor(dir);
		flame->Power = damage;
		if ( velocity != 0 ) flame->Step = velocity;
		flame->UseSprite = sprite;
		if ( useDeadState ) flame->DeadState = deadState;
		
		if ( layer > 0 ) DrawToLayer(flame, layer, 128); //If layer is a positive value, draw to that layer, and make the sprite opaque. 
		if ( layer < 0 ) DrawToLayer(flame, (layer * -1), 128); //If layer is a negative value, draw to that layer, and make the sprite transparent.
	}
		
	void create8WayFlame(float x, float y, float layer, float ltype, float damage, float sprite, float sfx, float speed){
		//Iteration 1:
		bool useDeadState;
		int deadState;
		float velocity;
		//int spd;
		int fragment_speed;
		
		if ( speed < 0 ) { //If speed is a negative number, we use its integer half for a DeadState, and its decimal portion for Step.
			useDeadState = true;
			float spd = ( speed + Floor(speed) ) * 10; //This is the actuial Step.
			deadState = speed * -1;
			velocity = spd * -1;
		}
			
		if ( speed >= 0 ) {
			spd = Floor(speed);
			velocity = spd;
			fragment_speed = velocity * 1.5;
		}
		if ( !Floor(fragment_speed) ) fragment_speed = 100;
		
		//if ( speed - Floor(speed) != 0 ) velocity = 
		
		Game->PlaySound(sfx);
		lweapon flame; 
		flame->Type = ltype;
		flame->X = x;
		flame->Y = y;
		flame->Dir = Floor(Dir);
		flame->Power = damage;
		if ( velocity != 0 ) flame->Step = velocity;
		flame->UseSprite = sprite;
		if ( useDeadState ) flame->DeadState = deadState;
		
		if ( layer > 0 ) DrawToLayer(flame, layer, 128); //If layer is a positive value, draw to that layer, and make the sprite opaque. 
		if ( layer < 0 ) DrawToLayer(flame, (layer * -1), 128); //If layer is a negative value, draw to that layer, and make the sprite transparent.
		
		//Explode in eight directions.
		
		for ( int q = 0; q < 4; q++ ) {
\
			Duplicate(flame, CenterX(a)-8, CenterY(a)-8, q, fragment_speed); //Duplicate in all eight directions.
			//Do we need to set a special speed, or distance factor?
		}
		for ( int w = 0; w < 8; w++ ) {
			Duplicate(flame, CenterX(a)-8, CenterY(a)-8, q, fragment_speed * .71);
		} //Replicated ghost.zh method.
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
		int dir = this->Dir;
		
		float ffc_lType = ltype + ( book_lType * 0.0001 );
		int book_attributes[]={book_dmg, ffc_lType, book_sprite, book_sfx, book_speed, book_sfx, book_layer, dir};
		
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

lweapon Duplicate(lweapon a, int dir) {
  lweapon b = Screen->CreateLWeapon(a->ID);
  b->X = a->X;
  b->Y = a->Y;
  b->Z = a->Z;
  b->Jump = a->Jump;
  b->Extend = a->Extend;
  b->TileWidth = a->TileWidth;
  b->TileHeight = a->TileHeight;
  b->HitWidth = a->HitWidth;
  b->HitHeight = a->HitHeight;
  b->HitZHeight = a->HitZHeight;
  b->HitXOffset = a->HitXOffset;
  b->HitYOffset = a->HitYOffset;
  b->DrawXOffset = a->DrawXOffset;
  b->DrawYOffset = a->DrawYOffset;
  b->DrawZOffset = a->DrawZOffset;
  b->Tile = a->Tile;
  b->CSet = a->CSet;
  b->DrawStyle = a->DrawStyle;
  b->Dir = dir;
  b->OriginalTile = a->OriginalTile;
  b->OriginalCSet = a->OriginalCSet;
  b->FlashCSet = a->FlashCSet;
  b->NumFrames = a->NumFrames;
  b->Frame = a->Frame;
  b->ASpeed = a->ASpeed;
  b->Damage = a->Damage;
  b->Step = a->Step;
  b->Angle = a->Angle;
  b->Angular = a->Angular;
  b->CollDetection = a->CollDetection;
  b->DeadState = a->DeadState;
  b->Flash = a->Flash;
  b->Flip = a->Flip;
  for (int i = 0; i < 16; i++)
    b->Misc[i] = a->Misc[i];
  return b;
}

lweapon Duplicate(lweapon a, int dir, int speed) {
  lweapon b = Screen->CreateLWeapon(a->ID);
  b->X = a->X;
  b->Y = a->Y;
  b->Z = a->Z;
  b->Jump = a->Jump;
  b->Extend = a->Extend;
  b->TileWidth = a->TileWidth;
  b->TileHeight = a->TileHeight;
  b->HitWidth = a->HitWidth;
  b->HitHeight = a->HitHeight;
  b->HitZHeight = a->HitZHeight;
  b->HitXOffset = a->HitXOffset;
  b->HitYOffset = a->HitYOffset;
  b->DrawXOffset = a->DrawXOffset;
  b->DrawYOffset = a->DrawYOffset;
  b->DrawZOffset = a->DrawZOffset;
  b->Tile = a->Tile;
  b->CSet = a->CSet;
  b->DrawStyle = a->DrawStyle;
  b->Dir = dir;
  b->OriginalTile = a->OriginalTile;
  b->OriginalCSet = a->OriginalCSet;
  b->FlashCSet = a->FlashCSet;
  b->NumFrames = a->NumFrames;
  b->Frame = a->Frame;
  b->ASpeed = a->ASpeed;
  b->Damage = a->Damage;
  b->Step = speed;
  b->Angle = a->Angle;
  b->Angular = a->Angular;
  b->CollDetection = a->CollDetection;
  b->DeadState = a->DeadState;
  b->Flash = a->Flash;
  b->Flip = a->Flip;
  for (int i = 0; i < 16; i++)
    b->Misc[i] = a->Misc[i];
  return b;
}

lweapon Duplicate(lweapon a, int dir, int speed, bool random, int pixelsMin, pixelsMax) {//Randomly adjust X/Y by 'pixelsMin' and pixelsMax. 
  int xpos = Rand(pixelsMin,pixelsMax);
  int ypos = Rand(pixelsMin,pixelsMax);
  lweapon b = Screen->CreateLWeapon(a->ID);

  b->X = a->X + xpos;
  b->Y = a->Y + ypos;
  b->Z = a->Z;
  b->Jump = a->Jump;
  b->Extend = a->Extend;
  b->TileWidth = a->TileWidth;
  b->TileHeight = a->TileHeight;
  b->HitWidth = a->HitWidth;
  b->HitHeight = a->HitHeight;
  b->HitZHeight = a->HitZHeight;
  b->HitXOffset = a->HitXOffset;
  b->HitYOffset = a->HitYOffset;
  b->DrawXOffset = a->DrawXOffset;
  b->DrawYOffset = a->DrawYOffset;
  b->DrawZOffset = a->DrawZOffset;
  b->Tile = a->Tile;
  b->CSet = a->CSet;
  b->DrawStyle = a->DrawStyle;
  b->Dir = dir;
  b->OriginalTile = a->OriginalTile;
  b->OriginalCSet = a->OriginalCSet;
  b->FlashCSet = a->FlashCSet;
  b->NumFrames = a->NumFrames;
  b->Frame = a->Frame;
  b->ASpeed = a->ASpeed;
  b->Damage = a->Damage;
  b->Step = speed;
  b->Angle = a->Angle;
  b->Angular = a->Angular;
  b->CollDetection = a->CollDetection;
  b->DeadState = a->DeadState;
  b->Flash = a->Flash;
  b->Flip = a->Flip;
  for (int i = 0; i < 16; i++)
    b->Misc[i] = a->Misc[i];
  return b;
}

lweapon Duplicate (lweapon a, int x, int y, int dir, int step){
	
	//CenterX(wpn)-8
	//CenterY(wpn)-8,
	
  lweapon b = Screen->CreateLWeapon(a->ID);

  b->X = x
  b->Y = y
  b->Z = a->Z;
  b->Jump = a->Jump;
  b->Extend = a->Extend;
  b->TileWidth = a->TileWidth;
  b->TileHeight = a->TileHeight;
  b->HitWidth = a->HitWidth;
  b->HitHeight = a->HitHeight;
  b->HitZHeight = a->HitZHeight;
  b->HitXOffset = a->HitXOffset;
  b->HitYOffset = a->HitYOffset;
  b->DrawXOffset = a->DrawXOffset;
  b->DrawYOffset = a->DrawYOffset;
  b->DrawZOffset = a->DrawZOffset;
  b->Tile = a->Tile;
  b->CSet = a->CSet;
  b->DrawStyle = a->DrawStyle;
  b->Dir = dir;
  b->OriginalTile = a->OriginalTile;
  b->OriginalCSet = a->OriginalCSet;
  b->FlashCSet = a->FlashCSet;
  b->NumFrames = a->NumFrames;
  b->Frame = a->Frame;
  b->ASpeed = a->ASpeed;
  b->Damage = a->Damage;
  b->Step = step;
  b->Angle = a->Angle;
  b->Angular = a->Angular;
  b->CollDetection = a->CollDetection;
  b->DeadState = a->DeadState;
  b->Flash = a->Flash;
  b->Flip = a->Flip;
  for (int i = 0; i < 16; i++)
    b->Misc[i] = a->Misc[i];
  return b;
}

global script Phantom{
	void run(){
		//Automate item ffc lauching using item level.
		//We can do this with itemdata, but what is the best way to know if an item is used, oter than manually adding an item script  to it?
	}
}