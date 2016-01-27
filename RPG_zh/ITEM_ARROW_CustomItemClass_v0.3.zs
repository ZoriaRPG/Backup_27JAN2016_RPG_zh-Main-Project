//Custom Bomb item
//v0.4
//27th November, 2015

//Assign to an item, with the item class 'Custom itemclass', or one of the 'zz###' item classes
//as the 'Action; script.

//Arguments:
//Arguments:
// D0: The sound to play for firing an arrow.. 
// D1: The counter to use. If set to '0', it will default to CR_ARROWS.
// D2: The sound effect to play for an error, including too many arrows on screen, or out of arrows in the counter.
// D3: The maximum number of arrows that the player may have on-screen at any one time. 
// --> You want to set this argument, as not setting it, will allow the player to fire up to 255 arrows, providing 
// --> that they have sufficient ammunition. Normal values are between '1' and '4'. 
// D4: Set to a value of '1' to allow Link to fire arrows while jumping. 
// D5: The ID of the arrow type to generate.
// D6: The sprite of the arrow when fired.
// D7: The distance from Link to place it. 

item script Arrow_CustomItemclass{
	void run(int sound, int counter, int errorSFX, int maxOnscreen, int allowLinkZ, int arrowID, int sprite, int dist){
		int numArrows;
		if ( Floor(Link->Z) !=0 && !allowLinkZ ) Quit();
		if ( counter ) {
			if ( Game->Counter[counter] && !maxOnscreen ){
				Game->Counter[counter]--;
				if ( sound ) Game->PlaySound(sound);
				lweapon arrow = NextToLink(LW_ARROW, dist);
				itemdata normalArrow = Game->LoadItemData(arrowID);
				//int sprite = normalArrow->UseSprite;
				arrow->UseSprite(sprite);
				this->Power = normalArrow->Power;
				//bomb->Level = normalArrow->Level;
				//bomb->Counter = normalArrow->Counter;
				//bomb->MaxIncrement = normalArrow->MaxIncrement;
				//bomb->Keep = normalArrow->Keep;
				//bomb->Max = normalArrow->Max;
				//bomb->Amount = normalArrow->Amount;
				//bomb->UseSound = normalArrow->UseSound;
			}
			else if ( Game->Counter[counter] && maxOnscreen ){
				for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
					lweapon l = Screen->LoadLWeapon(q);
					if ( l->ID == LW_ARROW ) numArrows++;
				}
				if ( numArrows < maxOnscreen ) {
					Game->Counter[counter]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon arrow = NextToLink(LW_ARROW, dist);
					itemdata normalArrow = Game->LoadItemData(arrowOD);
					//int sprite = normalArrow->UseSprite;
					arrow->UseSprite(sprite);
					this->Power = normalArrow->Power;
				}
				else Game->PlaySound(errorSFX);
			}
			if ( !Game->Counter[counter] ) Game->PlaySound(errorSFX);
		}
		if ( !counter ) {
			if ( Game->Counter[CR_ARROWS] && !maxOnscreen ){
				Game->Counter[CR_ARROWS]--;
				if ( sound ) Game->PlaySound(sound);
				lweapon arrow = NextToLink(LW_ARROW, dist);
				itemdata normalArrow = Game->LoadItemData(arrowID);
				//int sprite = normalArrow->UseSprite;
				arrow->UseSprite(sprite);
				this->Power = normalArrow->Power;
			}
			
			if ( Game->Counter[CR_ARROWS] && maxOnscreen ){
				for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
					lweapon l = Screen->LoadLWeapon(q);
					if ( l->ID == LW_ARROW ) numArrows++;
				}
				if ( numArrows < maxOnscreen ) {
					Game->Counter[CR_ARROWS]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon arrow = NextToLink(LW_ARROW, dist);
					itemdata normalArrow = Game->LoadItemData(arrowID);
					//int sprite = normalArrow->UseSprite;
					arrow->UseSprite(sprite);
					this->Power = normalArrow->Power;
				}
				else Game->PlaySound(errorSFX);
			}
			
			if ( !Game->Counter[CR_ARROWS] ) Game->PlaySound(errorSFX);
		}
	}
}

				