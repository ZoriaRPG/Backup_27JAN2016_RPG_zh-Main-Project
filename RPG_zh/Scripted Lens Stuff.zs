int LensTimer;
if Lens is on A B and Link->Input A B
	LensTimer--;



void LensCost(){
	if ( LensTimer == 0 ) {
		LensTimer = LENS_TIMER;
		Link->MP -= LENS_COST;
	}
}
	

