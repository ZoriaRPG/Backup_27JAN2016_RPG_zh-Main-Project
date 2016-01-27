const int LADDER_PIT_PROXIMITY_SENS = 16; //The number of pixels (max distance) in X/Y proximity from a pit combo. 

int OwnsItems[256];

item script PickupLadder{
	void run(){
		OwnsItems[I_LADDER] = 1;
	}
}

void EnableDisableLadder(bool state) {
	if ( OwnsItems[I_LADDER] ) {
		if ( state && !Link->Item[I_LADDER] ) Link->Item[I_LADDER] = true;
		else {
			if ( Link->Item[I_LADDER] ) Link->Item[I_LADDER] = false;
		}
	}
}

void LadderOnlyWhenByPits(){
	bool prox;
	for ( int q = 0; q < 176; q++ ) {
		if ( Screen->ComboT[q] == CT_LADDERONLY ) {
			if ( CheckProximityX(q) <= LADDER_PIT_PROXIMITY_SENS && CheckProximityY(q) <= LADDER_PIT_PROXIMITY_SENS ) {
				prox = true;
				break;
			}
		}
	}
	if ( prox ) EnableDisableLadder(true);
	else EnableDisableLadder(false);
}

global script active{
	void run(){
		while(true){
			LadderOnlyWhenByPits();
			Waitdraw();
			Waitframe();
		}
	}
}

int CheckProximityX(int a) {
	int ax = ComboY(a);
	if ( ax > Link->X ) return ax - Link->X;
	else return Link->X - ax;
}

int CheckProximityY(int a) {
	int ay = ComboY(a);
	if ( ay > Link->Y ) return ay - Link->Y;
	else return Link->Y - ay;
}