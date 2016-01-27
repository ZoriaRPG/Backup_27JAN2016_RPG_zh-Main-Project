//Block Stairs Fix
//Timed Undercombo for a Push block.
//v0.2

//Args:
//D0: Duration of delay timer.
//D1: The Combo ID of the block to move.
//D2: The layer on which the block moves. Must be '1' or '2'.
//D3: The combo to place under the block, after it moves. 
//D4: The sound effect file to play when triggered. Set to '0' for 'None'.
//D5: Set to '1' to enable verbose reporting. 

//! Block to push should be on layer 1, or layer 2.
ffc script FixBlockStairs{
	void run(int dur, int sourceBlockComboD, int blockLayer, int underCombo, int secretSFX, int debugOn){
		//If there is a movable block on the screen with a combo ID
		//as specified, on the specified layer (must be 1 or higher)
		
		int blockLoc; //Location of block.
		int cmb;
		bool changed;

		
		int debug[]="Debug Report for FixBlockStairs FFC Script. There was no combo matching the value of D2 on screen: ";
		int debug2[]="...on map: ";
		int debug3[]="...on DMap: ";
		
		for ( int q = 0; q < 176; q++ ) {
			cmb = GetLayerComboD(layer,q);
			if ( cmb == sourceBlockComboD ) blockLoc = q;	//If it's there, store its location
		}
		
		//If there is no combo on the screen that matches this data...
		if ( ! cmb ) {
			//if verbose debugging is enabled
			if ( debugOn ) {
				//Trace information to allegro.log, so that it's easier to fix the problem.
				TraceNL();	TraceS(debug);	Trace( Game->GetCurScreen() );
				TraceNL();	TraceS(debug2);	Trace( Game->GetCurMap() );
				TraceNL();	TraceS(debug2);	Trace( Game->GetCurDMap() );	TraceNL();
			}
			
			this->Data = 0; //Kill the FFC. 
			this->Script = 0;
			Quit();
		}
		
		
		
		
		//if we haven't finished replacing the block...
		while(!changed){
	
			//Read / check for that block every frame
			for ( int q = 0; q < 176; q++ ) {
				int cmb = GetLayerComboD(layer,q);
				
				//if the block changes location from its original value...
				if ( cmb == sourceBlockComboD && cmb != blockLoc ) {
			
					//if the secret sound is a positive number, play it now...
					if ( secretSFX > 0 ) Game->PlaySound(secretSFX);
					
					//run a timed loop for dur
					for ( int q = 0; q < dur; q++ ) Waitframe();
					//!Sure, we could probably use combo cycling for this, but it's more fun this way. 
					
					//Then change the combo where it was, one layer under it, to undercombo
					
					changing = true;	//Mark that we've changed the combo in advance.
					
					//If the secret sound is a NEGATIVE value, wait for the
					//transformation, to play it. 
					if ( secretSFX < 0 ) Game->PlaySound(secretSFX);

					//Execute the combo change. 
					SetLayerComboD( (layer-1), blockLoc, underCombo);
				}
			}
			Waitframe();
			
		}
		this->Data = 0;
		this->Script = 0;
		Quit();

	}
}
			
			