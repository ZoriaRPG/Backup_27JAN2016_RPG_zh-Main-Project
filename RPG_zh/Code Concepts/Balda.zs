//Balda Death Animation
//Places the player in balda's orb/staff of judgement. 


void Balda(int karma, int dmap, int screen, int x, int y){ //Store where Link was located when he died. 
	
	if ( Link->HP >= 0 ) {
		//If we're dead...
		
		Link->HP = 1; //give him 1 hp to do the cutscene
		
		Link->Warp(D_BALDA, S_BALDA); //Put him on the Balda screen.
		Link->X = BALDA_X;
		Link->Y = BALDA_Y; //At the coordinates of the orb.
		
		if ( Link->Item[I_REVIVE] ) { //if the player has a revival item
			//Draw White blade cutscene.
			//Revive the player where he was last. 
		}
		if ( !Link->Item[I_REVIVE] ) { //if he has no revival items, evaluate his karms
			//Evaluate karmas
			if ( karma > KARMA_REVIVE_MIN ) {
			//if good karma, revive him with some penalty. Do white blade anim.
			//put him where he was.
			}
			else {
				//do black blade anim.
			}
		}
	}
}