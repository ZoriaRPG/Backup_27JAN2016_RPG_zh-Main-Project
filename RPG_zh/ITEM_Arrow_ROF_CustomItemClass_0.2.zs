//Assign to an item, with the item class 'Custom itemclass', or one of the 'zz###' item classes
//as the 'Action; script.

//Arguments:
// D0: The sound to play for firing an arrow.. 
// D1: The counter to use. If set to '0', it will default to CR_ARROWS.
// D2: The sound effect to play for an error, including too many arrows on screen, or out of arrows in the counter.
// D3: The maximum number of arrows that the player may have on-screen at any one time. 
// --> You want to set this argument, as not setting it, will allow the player to fire up to 255 arrows, providing 
// --> that they have sufficient ammunition. Normal values are between '1' and '4'. 
// D4: Set to a value of '1' to allow Link to fire arrows while jumping. 
// D5: The ID of the arrow type to generate.

item script Arrow_CustomItemclass{
	void run(int sound, int counter, int errorSFX, int maxOnscreen, int allowLinkZ, int arrowID){
		int numArrows;
		
		if ( Floor(Link->Z) !=0 && !allowLinkZ ) Quit();
		
		if ( counter ) {
			if ( Game->Counter[counter] && !maxOnscreen ){
				Game->Counter[counter]--;
				if ( sound ) Game->PlaySound(sound);
				lweapon arrow = NextToLink(LW_ARROW, 8);
				
				
				itemdata normalArrow = Game->LoadItemData(arrowID);
				this->UseSprite = normalArrow->UseSprite;
				this->Step = normalArrow->Step;
				this->Power = normalArrow->Power;
				this->Level = normalArrow->Level;
				this->Counter = normalArrow->Counter;
				this->MaxIncrement = normalArrow->MaxIncrement;
				this->Keep = normalArrow->Keep;
				this->Max = normalArrow->Max;
				this->Amount = normalArrow->Amount;
				
				if ( Link->Dir == DIR_DOWN ) this->Flip = 3;

				else if ( Link->Dir == DIR_LEFT ){
					this->Tile++;
					this->Flip = 1;
				}
				else if ( Link->Dir == DIR_RIGHT ) this->Tile++;
			}
			else if ( Game->Counter[counter] && maxOnscreen ){
				for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
					lweapon l = Screen->LoadLWeapon(q);
					if ( l->Type == LW_ARROCR ) numArrows++;
				}
				if ( numArrows < maxOnscreen ) {
					Game->Counter[counter]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon arrow = Screen->CreateLWeapon(LW_ARROW);
					itemdata normalArrow = Game->LoadItemData(arrowID);
					this->UseSprite = normalArrow->UseSprite;
					this->Step = normalArrow->Step;
					this->Power = normalArrow->Power;
					this->Level = normalArrow->Level;
					this->Counter = normalArrow->Counter;
					this->MaxIncrement = normalArrow->MaxIncrement;
					this->Keep = normalArrow->Keep;
					this->Max = normalArrow->Max;
					this->Amount = normalArrow->Amount;
					
					if ( Link->Dir == DIR_DOWN ) this->Flip = 3;

					else if ( Link->Dir == DIR_LEFT ){
						this->Tile++;
						this->Flip = 1;
					}
					else if ( Link->Dir == DIR_RIGHT ) this->Tile++;
				}
				else Game->PlaySound(errorSFX);
			}
			if ( !Game->Counter[counter] ) Game->PlaySound(errorSFX);
		}
		if ( !counter ) {
			if ( Game->Counter[CR_ARROWS] && !maxOnscreen ){
				Game->Counter[CR_ARROWS]--;
				if ( sound ) Game->PlaySound(sound);
				lweapon arrow = Screen->CreateLWeapon(LW_ARROW);
				itemdata normalArrow = Game->LoadItemData(arrowID);
				this->UseSprite = normalArrow->UseSprite;
				this->Step = normalArrow->Step;
				this->Power = normalArrow->Power;
				this->Level = normalArrow->Level;
				this->Counter = normalArrow->Counter;
				this->MaxIncrement = normalArrow->MaxIncrement;
				this->Keep = normalArrow->Keep;
				this->Max = normalArrow->Max;
				this->Amount = normalArrow->Amount;
				
				if ( Link->Dir == DIR_DOWN ) this->Flip = 3;

				else if ( Link->Dir == DIR_LEFT ){
					this->Tile++;
					this->Flip = 1;
				}
				else if ( Link->Dir == DIR_RIGHT ) this->Tile++;
			}
			
			if ( Game->Counter[CR_ARROWS] && maxOnscreen ){
				for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
					lweapon l = Screen->LoadLWeapon(q);
					if ( l->Type == LW_ARROW ) numArrows++;
				}
				if ( numArrows < maxOnscreen ) {
					Game->Counter[CR_ARROWS]--;
					if ( sound ) Game->PlaySound(sound);
					lweapon arrow = Screen->CreateLWeapon(LW_ARROW);
					itemdata normalArrow = Game->LoadItemData(arrowID);
					this->UseSprite = normalArrow->UseSprite;
					this->Step = normalArrow->Step;
					this->Power = normalArrow->Power;
					this->Level = normalArrow->Level;
					this->Counter = normalArrow->Counter;
					this->MaxIncrement = normalArrow->MaxIncrement;
					this->Keep = normalArrow->Keep;
					this->Max = normalArrow->Max;
					this->Amount = normalArrow->Amount;
					
					if ( Link->Dir == DIR_DOWN ) this->Flip = 3;

					else if ( Link->Dir == DIR_LEFT ){
						this->Tile++;
						this->Flip = 1;
					}
					else if ( Link->Dir == DIR_RIGHT ) this->Tile++;
				}
				else Game->PlaySound(errorSFX);
			}
			
			if ( !Game->Counter[CR_ARROWS] ) Game->PlaySound(errorSFX);
		}
		
		
	}
}

				