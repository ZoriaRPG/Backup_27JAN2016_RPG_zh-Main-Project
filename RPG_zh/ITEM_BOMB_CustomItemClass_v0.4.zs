//Custom Bomb item
//v0.4
//27th November, 2015

//Assign to an item, with the item class 'Custom itemclass', or one of the 'zz###' item classes
//as the 'Action; script.

//Arguments:
// D0: The sound to play for dropping the bomb. 
// D1: The count er to use. If set to '0', it will default to CR_BOMBS for a normal bomb, 
// and CR_SBOMBS for a super bomb. This argument allows you to specify a custom counter.
// D2: The sound effect to play for an error, including too many bombs on screen, or out of bombs in the counter.
// D3: Set to '1' or higher, to make the item srop super bombs. Otherwise, leave at '0'/
// D4: The maximum number of bombs that the player may have on-screen at any one time. 
// --> You want to set this argument, as not setting it, will allow the player to drop up to 255 bombs, providing 
// --> that they have sufficient ammunition. Normal values are between '1' and '4'. 
// D5: Set to a value of '1' to allow Link to drop bombs while jumping. 
// D6: The sprite of the bomb when placed.
// D7: The distance from Link to place it. 

item script BombDrop_CustomItemclass{
	void run(int sound, int counter, int errorSFX, int super, int maxOnscreen, int allowLinkZ, int sprite, int dist){
		int numBombs;
		int numSBombs;
		if ( Floor(Link->Z) !=0 && !allowLinkZ ) Quit();
		if ( !super ) {
			if ( counter ) {
				if ( Game->Counter[counter] && !maxOnscreen ){
					Game->Counter[counter]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon bomb = NextToLink(LW_BOMB, dist);
					itemdata normalBomb = Game->LoadItemData(I_BOMB);
					//int sprite = normalBomb->UseSprite;
					bomb->UseSprite(sprite);
					this->Power = normalBomb->Power;
					//bomb->Level = normalBomb->Level;
					//bomb->Counter = normalBomb->Counter;
					//bomb->MaxIncrement = normalBomb->MaxIncrement;
					//bomb->Keep = normalBomb->Keep;
					//bomb->Max = normalBomb->Max;
					//bomb->Amount = normalBomb->Amount;
					//bomb->UseSound = normalBomb->UseSound;
				}
				else if ( Game->Counter[counter] && maxOnscreen ){
					for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->ID == LW_BOMB ) numBombs++;
					}
					if ( numBombs < maxOnscreen ) {
						Game->Counter[counter]--;
						if ( sound ) Game->PlaySound(sound);
						lweapon bomb = NextToLink(LW_BOMB, dist);
						itemdata normalBomb = Game->LoadItemData(I_BOMB);
						//int sprite = normalBomb->UseSprite;
						bomb->UseSprite(sprite);
						this->Power = normalBomb->Power;
					}
					else Game->PlaySound(errorSFX);
				}
				if ( !Game->Counter[counter] ) Game->PlaySound(errorSFX);
			}
			if ( !counter ) {
				if ( Game->Counter[CR_BOMBS] && !maxOnscreen ){
					Game->Counter[CR_BOMBS]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon bomb = NextToLink(LW_BOMB, dist);
					itemdata normalBomb = Game->LoadItemData(I_BOMB);
					//int sprite = normalBomb->UseSprite;
					bomb->UseSprite(sprite);
					this->Power = normalBomb->Power;
				}
				
				if ( Game->Counter[CR_BOMBS] && maxOnscreen ){
					for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->ID == LW_BOMB ) numBombs++;
					}
					if ( numBombs < maxOnscreen ) {
						Game->Counter[CR_BOMBS]--;
						if ( sound ) Game->PlaySound(sound);
						lweapon bomb = NextToLink(LW_BOMB, dist);
						itemdata normalBomb = Game->LoadItemData(I_BOMB);
						//int sprite = normalBomb->UseSprite;
						bomb->UseSprite(sprite);
						this->Power = normalBomb->Power;
					}
					else Game->PlaySound(errorSFX);
				}
				
				if ( !Game->Counter[CR_BOMBS] ) Game->PlaySound(errorSFX);
			}
		}
		if ( super ) {
			if ( counter ) {
				if ( Game->Counter[counter] && !maxOnscreen ){
					Game->Counter[counter]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon bomb = NextToLink(LW_SBOMB, dist);
					itemdata normalBomb = Game->LoadItemData(I_SBOMB);
					//int sprite = normalBomb->UseSprite;
					bomb->UseSprite(sprite);
					this->Power = normalBomb->Power;
				}
				
				else if ( Game->Counter[counter] && maxOnscreen ){
					for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->ID == LW_SBOMB ) numSBombs++;
					}
					if ( numSBombs < maxOnscreen ) {
						Game->Counter[counter]--;
						if ( sound ) Game->PlaySound(sound);
						lweapon bomb = NextToLink(LW_SBOMB, dist);
						itemdata normalBomb = Game->LoadItemData(I_SBOMB);
						//int sprite = normalBomb->UseSprite;
						bomb->UseSprite(sprite);
						this->Power = normalBomb->Power;
					}
					else Game->PlaySound(errorSFX);
				}
				
				if ( !Game->Counter[counter] ) Game->PlaySound(errorSFX);
			}
			if ( !counter ) {
				if ( Game->Counter[CR_SBOMBS] ){
					Game->Counter[CR_SBOMBS]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon bomb = NextToLink(LW_SBOMB, dist);
					itemdata normalBomb = Game->LoadItemData(I_SBOMB);
					//int sprite = normalBomb->UseSprite;
					bomb->UseSprite(sprite);
					this->Power = normalBomb->Power;
				}
				
				else if ( Game->Counter[CR_SBOMBS] && maxOnscreen ){
					for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->ID == LW_SBOMB ) numSBombs++;
					}
					if ( numSBombs < maxOnscreen ) {
						Game->Counter[CR_SBOMBS]--;
						if ( sound ) Game->PlaySound(sound);
						lweapon bomb = NextToLink(LW_SBOMB, dist);
						itemdata normalBomb = Game->LoadItemData(I_SBOMB);
						//int sprite = normalBomb->UseSprite;
						bomb->UseSprite(sprite);
						this->Power = normalBomb->Power;
					}
					else Game->PlaySound(errorSFX);
				}
				
				if ( !Game->Counter[CR_BOMBS] ) Game->PlaySound(errorSFX);
			}
		}
	}
}

				