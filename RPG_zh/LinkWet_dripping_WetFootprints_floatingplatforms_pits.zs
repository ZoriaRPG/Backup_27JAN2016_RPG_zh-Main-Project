const int DRIPTIMER = 2400;
const int MAX_DRIPTIMER = 420; //7 SECONDS

void WetFootprints(){
	if ( Is(SWIMMING) && Val(DRIPTIMER) != MAX_DRIPTIMER ) {
		Val(DRIPTIMER,MAX_DRIPTIMER);
	}
	if ( !Is(SWIMMING) && Val(DRIPTIMER) > 0 ) {
		Val(DRIPTIMER,KICK);
		//Draw wet footprints
	}
}


void isOnPit(){
	int linkz = Floor(Link->Z);
	int linkfall = Floor(Link->Jump);
	if ( linkz > 0 || linkfall > 0 ) {\
		