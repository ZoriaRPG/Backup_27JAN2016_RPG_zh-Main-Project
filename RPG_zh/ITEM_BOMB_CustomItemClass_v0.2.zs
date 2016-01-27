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

item script BombDrop_CustomItemclass{
	void run(int sound, int counter, int errorSFX, int super, int maxOnscreen, int allowLinkZ){
		int numBombs;
		int numSBombs;
		if ( Floor(Link->Z) !=0 && !allowLinkZ ) Quit();
		if ( !super ) {
			if ( counter ) {
				if ( Game->Counter[counter] && !maxOnscreen ){
					Game->Counter[counter]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon bomb = Screen->CreateLWeapon(LW_BOMB);
					bomb->X = Link->X;
					bomb->Y = Link->Y;
					bomb->X = Link->Z;
					itemdata normalBomb = Game->LoadItemData(I_BOMB);
					this->UseSprite = normalBomb->UseSprite;
					this->Power = normalBomb->Power;
					this->Level = normalBomb->Level;
					this->Counter = normalBomb->Counter;
					this->MaxIncrement = normalBomb->MaxIncrement;
					this->Keep = normalBomb->Keep;
					this->Max = normalBomb->Max;
					this->Amount = normalBomb->Amount;
				}
				else if ( Game->Counter[counter] && maxOnscreen ){
					for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->Type == LW_BOMB ) numBombs++;
					}
					if ( numBombs < maxOnscreen ) {
						Game->Counter[counter]--;
						if ( sound ) Game->PlaySound(sound);
						lweapon bomb = Screen->CreateLWeapon(LW_BOMB);
						bomb->X = Link->X;
						bomb->Y = Link->Y;
						bomb->X = Link->Z;
						itemdata normalBomb = Game->LoadItemData(I_BOMB);
						this->UseSprite = normalBomb->UseSprite;
						this->Power = normalBomb->Power;
						this->Level = normalBomb->Level;
						this->Counter = normalBomb->Counter;
						this->MaxIncrement = normalBomb->MaxIncrement;
						this->Keep = normalBomb->Keep;
						this->Max = normalBomb->Max;
						this->Amount = normalBomb->Amount;
					}
					else Game->PlaySound(errorSFX);
				}
				if ( !Game->Counter[counter] ) Game->PlaySound(errorSFX);
			}
			if ( !counter ) {
				if ( Game->Counter[CR_BOMBS] && !maxOnscreen ){
					Game->Counter[CR_BOMBS]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon bomb = Screen->CreateLWeapon(LW_BOMB);
					bomb->X = Link->X;
					bomb->Y = Link->Y;
					bomb->X = Link->Z;
					itemdata normalBomb = Game->LoadItemData(I_BOMB);
					this->UseSprite = normalBomb->UseSprite;
					this->Power = normalBomb->Power;
					this->Level = normalBomb->Level;
					this->Counter = normalBomb->Counter;
					this->MaxIncrement = normalBomb->MaxIncrement;
					this->Keep = normalBomb->Keep;
					this->Max = normalBomb->Max;
					this->Amount = normalBomb->Amount;
				}
				
				if ( Game->Counter[CR_BOMBS] && maxOnscreen ){
					for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->Type == LW_BOMB ) numBombs++;
					}
					if ( numBombs < maxOnscreen ) {
						Game->Counter[CR_BOMBS]--;
						if ( sound ) Game->PlaySound(sound);
						lweapon bomb = Screen->CreateLWeapon(LW_BOMB);
						bomb->X = Link->X;
						bomb->Y = Link->Y;
						bomb->X = Link->Z;
						itemdata normalBomb = Game->LoadItemData(I_BOMB);
						this->UseSprite = normalBomb->UseSprite;
						this->Power = normalBomb->Power;
						this->Level = normalBomb->Level;
						this->Counter = normalBomb->Counter;
						this->MaxIncrement = normalBomb->MaxIncrement;
						this->Keep = normalBomb->Keep;
						this->Max = normalBomb->Max;
						this->Amount = normalBomb->Amount;
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
					lweapon bomb = Screen->CreateLWeapon(LW_SBOMB);
					bomb->X = Link->X;
					bomb->Y = Link->Y;
					bomb->X = Link->Z;
					itemdata normalBomb = Game->LoadItemData(I_SBOMB);
					this->UseSprite = normalBomb->UseSprite;
					this->Power = normalBomb->Power;
					this->Level = normalBomb->Level;
					this->Counter = normalBomb->Counter;
					this->MaxIncrement = normalBomb->MaxIncrement;
					this->Keep = normalBomb->Keep;
					this->Max = normalBomb->Max;
					this->Amount = normalBomb->Amount;
				}
				
				else if ( Game->Counter[counter] && maxOnscreen ){
					for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->Type == LW_SBOMB ) numSBombs++;
					}
					if ( numSBombs < maxOnscreen ) {
						Game->Counter[counter]--;
						if ( sound ) Game->PlaySound(sound);
						lweapon bomb = Screen->CreateLWeapon(LW_SBOMB);
						bomb->X = Link->X;
						bomb->Y = Link->Y;
						bomb->X = Link->Z;
						itemdata normalBomb = Game->LoadItemData(I_SBOMB);
						this->UseSprite = normalBomb->UseSprite;
						this->Power = normalBomb->Power;
						this->Level = normalBomb->Level;
						this->Counter = normalBomb->Counter;
						this->MaxIncrement = normalBomb->MaxIncrement;
						this->Keep = normalBomb->Keep;
						this->Max = normalBomb->Max;
						this->Amount = normalBomb->Amount;
					}
					else Game->PlaySound(errorSFX);
				}
				
				if ( !Game->Counter[counter] ) Game->PlaySound(errorSFX);
			}
			if ( !counter ) {
				if ( Game->Counter[CR_SBOMBS] ){
					Game->Counter[CR_SBOMBS]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon bomb = Screen->CreateLWeapon(LW_SBOMB);
					bomb->X = Link->X;
					bomb->Y = Link->Y;
					bomb->X = Link->Z;
					itemdata normalBomb = Game->LoadItemData(I_SBOMB);
					this->UseSprite = normalBomb->UseSprite;
					this->Power = normalBomb->Power;
					this->Level = normalBomb->Level;
					this->Counter = normalBomb->Counter;
					this->MaxIncrement = normalBomb->MaxIncrement;
					this->Keep = normalBomb->Keep;
					this->Max = normalBomb->Max;
					this->Amount = normalBomb->Amount;
				}
				
				else if ( Game->Counter[CR_SBOMBS] && maxOnscreen ){
					for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->Type == LW_SBOMB ) numSBombs++;
					}
					if ( numSBombs < maxOnscreen ) {
						Game->Counter[CR_SBOMBS]--;
						if ( sound ) Game->PlaySound(sound);
						lweapon bomb = Screen->CreateLWeapon(LW_SBOMB);
						bomb->X = Link->X;
						bomb->Y = Link->Y;
						bomb->X = Link->Z;
						itemdata normalBomb = Game->LoadItemData(I_SBOMB);
						this->UseSprite = normalBomb->UseSprite;
						this->Power = normalBomb->Power;
						this->Level = normalBomb->Level;
						this->Counter = normalBomb->Counter;
						this->MaxIncrement = normalBomb->MaxIncrement;
						this->Keep = normalBomb->Keep;
						this->Max = normalBomb->Max;
						this->Amount = normalBomb->Amount;
					}
					else Game->PlaySound(errorSFX);
				}
				
				if ( !Game->Counter[CR_BOMBS] ) Game->PlaySound(errorSFX);
			}
		}
	}
}

				