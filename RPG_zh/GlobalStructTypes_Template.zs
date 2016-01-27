int CurPos[255];
global script pointers{
	void run(){
		while(true){
			if ( CurPos[0] != Game->GetCurDMap() && CurPos[1] != Game->GetCurScreen() ) {
				CurPos[0] = Game->GetCurDMap();
				CurPos[1] = Game->GetCurScreen();
				lweapon lw[255];
				eweapon ew[255]
				npc np[255];
				item itm[255];
				itemdata id[255];
			}
			Waitdraw();
			Waitframe();
		}
	}
}

global script Init{
	void run(){
		for ( int q = 0; q < 2; q++ ) CurPos[q] = -1;
	}
}

global script OnExit{
	void run(){
		for ( int q = 0; q < 2; q++ ) CurPos[q] = -1;
	}
}

global script OnContinue{
	void run(){
		for ( int q = 0; q < 2; q++ ) CurPos[q] = -1;
	}
}