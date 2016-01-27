



int PickupWeapons[]={LW_SWORD, LW_BRANG, LW_HOOKSHOT, LW_WAND, LW_CANEOFBYRNA, LW_SCRIPT10}; //Populate with LTypes that can pick up items by touching them.
//We also need one by specific weapon item number.



int ItemsToPockup[]={	I_ARROWAMMO1, I_ARROWAMMO5, I_ARROWAMMO10, I_ARROWAMMO30,  //Stock arrow ammo.
			I_BOMBAMMO1, I_BOMBAMMO4, I_BOMBAMMO8, I_BOMBAMMO30, //Stock bomb ammo.
			I_FAIRY, I_FAIRYSTILL, I_HEART, I_MAGICJAR1, I_MAGICJAR2, //Stock refills.
			I_CLOCK, //Stock clock item.
			I_RUPEE1, I_RUPEE5, I_RUPEE10, I_RUPEE20, I_RUPEE50, I_RUPEE100, I_RUPEE200, //Stock Rupee Items
			I_KEY, I_LEVELKEY,  //Stock keys.
			I_COMPASS, //Stock Dungeon Compass
			I_MAP, //Stock dungeon map.
			I_BOSSKEY, //Stock dungeon/level master key.
			I_DUSTPILE, //Stock dust pile, because I can.
			I_BRACELET1, //L1 'Glove' bracelet.
			//Standard ZC items end here.
	
			I_KILLALL, //Special, kill all enemies item.
	
			//RPG.zh Items
			I_DSARI1, I_DSARI5, I_DSARI10, I_DSARI20, I_DSARI50, I_DSARI100, I_DSARI250, I_DSARI750, I_DSARI1000, I_DSARI5000, //RPG Money
			I_CRYDISC_BLUE, I_CRYDISC_RED, I_CRYDISC_BLUE_LARGE, I_CRYDISC_RED_LARGE, I_CRYDISC, //RPG Money
			I_CRYSHEET25, I_CRYSHEET50, I_CRYSHEET100, I_CRYSHEET250, I_CRYSHEET500, I_CRYSHEET1000, I_GEM, //RPG Money
			I_LIFE_REFILL_MEDIUM, I_MAGIC_REFILL_MEDIUM, I_CIGAR, //RPG Health and Magic
			
			I_SCROLL_HEALING, I_SCROLL_TALYXIUX, I_SCROLL_MAGIC, I_SCROLL_TIMESTOP, //RPG Scrolls
			I_BULLET, I_BULLET_BOX, I_ENERGY_CANISTER, //RPG Ammo
			I_BOMBAMMO10}; //Expanded bomb ammo.

//Make a full index, plus items in 100-slot fields, so that index size can be used with a parameter modifier, to hold multiple lists as one array.

//This function collects items of types stored in array itemList, with any weapon that has an LType specified in the array pickUpWith.
void ItemRetrieval(int itemList, int pickUpWith, bool instantaneous, bool holdUpItem, bool killWeapon, bool includingBounceLWs ){
	for ( int q = 0; q <= Screen->NumLWeapons(); q++ ){
		lweapon w = Screen->LoadLWeapon(q);
		for ( int it = 0; it <= SizeOfArray(pickUpWith); i++ ){
			if ( w->ID == pickUpWith[it] ) {
				for ( int e = 0; e <= Screen->NumItems(); e ++ ) {
					item a = Screen->LoadItem(e);
					for ( int s = 0; s <= SizeOfArray(itemList); s ++ ) {
						if ( a->ID == itemList[s] ) {
							if ( Collision (w,a) ) {
								
								if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ){
									w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
									//Bouncing must precede item movement. 
								}
							
								if ( a->isValid() ) {
									
									if ( instantaneous ) {
										if ( a->Z != Link->Z ) {
											a->Z = Link->Z;
										}
										a->X = Link->X;
										a->Y = Link->Y; //Give the item directly to Link
										
										if ( killWeapon ) {
											if ( w->ID != LW_BRANG ||  w->ID != LW_HOOKSHOT || includingBounceLWs ){
												w->DeadState = WDS_DEAD;
											}
										}
										
										if ( holdUpItem && LinkCollision(a) ) {
											Link->Action = LA_HOLD1LAND; //Hold item over head.
											Game->PlaySound(SFX_HOLDTOHAND);
											Link->HeldItem = a->ID;
										}
									}
									else {
										if ( a->Z != 0 ) {
											a->Z = 0;
										}
										a->X = w->X;
										a->Y = w->Y; //Drag the item back to Link.

										if ( holdUpItem && LinkCollision(a) ) {
											Link->Action = LA_HOLD1LAND; //Hold item over head, when it reaches Link.
											Game->PlaySound(SFX_HOLDTOHAND);
											Link->HeldItem = a->ID;
										}							
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
