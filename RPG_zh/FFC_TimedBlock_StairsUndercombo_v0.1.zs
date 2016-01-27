//Block Stairs Fix
//TImed Undercombo for a Push block.

ffc script FixBlockStairs{
	void run(int dur, int sourceBlockComboD, int blockLayer, int underCombo, int secretSFX){
		//If there is a movable block on the screen with a combo ID
		//as specified, on the specified layer (must be 1 or higher)
		
		int blockLoc; //Location of block.
		
		for ( int q = 0; q < 176; q++ ) {
			int cmb = GetLayerComboD(layer,q);
			if ( cmb == sourceBlockComboD ) blockLoc = q;
		}
		
		bool changed;
		
		//store its location
		
		while(true){
		
			//if we haven;t finished replacing the block...
			if ( !changed ) {
				
				//Read for that block every frame
				
				for ( int q = 0; q < 176; q++ ) {
					int cmb = GetLayerComboD(layer,q);
					
					//if the block changes location.
					if ( cmb == sourceBlockComboD && cmb != blockLoc ) {
				
						//if the secret sound is a positive number, play it now...
						if ( secretSFX > 0 ) Game->PlaySound(secretSFX);
						
						//run a timed loop for dur
						for ( int q = 0; q < dur; q++ ) Waitframe();
						//!Sure, we could probably use combo cycling for this, but it's more fun this way. 
						
						//Then change the combo where it was, one layer under it, to undercombo
						changing = true;
						
						//Otherwise, if the secret sound is a NEGATIVE value, wait for the
						//transformation, to play it. 
						if ( secretSFX < 0 ) Game->PlaySound(secretSFX);
						SetLayerComboD(layer-1, q, underCombo);
					}
				}
				Waitframe();
			}
			if ( changed ) {
				this->Data = 0;
				this->Script = 0;
				Quit();
			}
		}
	}
}
			
			