//Lens of Truch v 0.2

//Define offscreen bitmap not to interfere with Tango areas

//
//
//
//


int LensTimer;
if Lens is on A B and Link->Input A B
	LensTimer--;



void LensCost(){
	if ( LensTimer == 0 ) {
		LensTimer = LENS_TIMER;
		Link->MP -= LENS_COST;
	}
}

bool UsingLens;

const int WEAPON_SPECIAL_PROPERTY = 8;
const int PROPERTY_LENS_OF_TRUTH = 2;

item script LensOfTruth{
	void run(int ffc_ID){
		int args[8];
		if ( ! UsingLens ) UsingLens = true;
		else UsingLens = false; 
		RunFFCScript(ffc_ID,args);
	}
}

ffc script LensOfTruth{
	void run(	int lensTile, int soundDuration, int lensSFX, int d, 
			int e, int f, int g, int h ) {
		int sfxTimer = soundDuration * 60;
				
				
				//Store the actual combos seen by the player
				///and those on lower layers so that we can
				//temporarily copy those combos into the drawing area of the lens
				//from layer 0 to 2 or 2 to display them as custom secret markers
				int ScreenCombos[176];
				int ScreenCombosLayer0[176];
				int ScreenCombosLayer1[176];
				int ScreenCombosLayer2[176];
				int TemporaryCombosLayer0[176];
				int TemporaryCombosLayer1[176];
				int TemporaryCombosLayer2[176];
				
				//! We also need to store their flags, inherent flags, and types in these arrays, 
				//! so each array needs to be a size of 176*4
				
				//COpy any comboD that matches a type, flag, or inherent flag combination onto
				//the offscreen bitmap, so that we can draw them over the screen when the lens is active. 
				
				//Save all the combos in an array.
				for ( int q = 0; q < 176; q++ ) {
					ScreenCombos[q] = Screen->ComboD[q];
					ScreenCombosLayer0 = GetLayerComboD(0,q);
					ScreenCombosLayer1 = GetLayerComboD(1,q);
					ScreenCombosLayer2 = GetLayerComboD(2,q);
				}
				
				//Make the temporary combos image. 
				
		while ( UsingLens ) {
			lweapon lens = Screen->CreateLWeapon(LW_SCRIPT10);
			lens->Extend = 8;
			lens->TileHeight = 8;
			lens->TileWidth = 8;
			lens->OriginalTile = lensTile;
			if ( sfxTimer % 60 == 0 ) Game->PlaySound(lensSFX);
			lens->Misc[WEAPON_SPECIAL_PROPERTY] = PROPERTY_LENS_OF_TRUTH;
			//DrawToLayer(lens,6);
			
			//Use as:
			//if ( collision(l,cmb) && l->Misc[WEAPON_SPECIAL_PROPERTY] == PROPERTY_LENS_OF_TRUTH ) {
			//	RevealSecrets();
			
			//OR
			
			//if ( Collision(this,cmb) && cmb->ID == LENS_SECRET ) 
			Waitframe();
		}
	}
}