//D0: The ID of the enemy to remove.
//D1: The enemi ID that the D0 splits into. 
//D2: the starting number of enemies on this screen (the number of times it is in the enemy list)
//D3: The register to use to store enemy counts. 
//D4: the register to check for intialisation. 
//D5: Total number of lanmola enemies on the screen.
//D6: Lanmola enemy ID.
//D7: Register for tracking lanmolas. 

ffc script RemoveKilledSpliiters{
	void run(int enemID, int splitsInto, int startNum, int reg, int regInit, int totalLanmolas, int lanmolaID, int lanmolasReg){
		int curNum = NumNPCsOf(enemID);
		int presentMax = Screen->D[reg];
		int children;
		int numLanmolas;
		Waitframes(5);
		bool firstRun = true;
		int segments;
		if ( lanmolaID ) { 
			for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
				npc a = Screen->LoadNPC(q);
				if ( a->ID == lanmolaID ) {
					segments = a->Attributes[0] + 1;
					break;
				}
			}
		}
		
		float segs = segments / 10;
		Screen->D[lanmolasReg] += segs;
		int lanmolasValid = Floor(Screen->D[lanmolasReg]);
		float deciSegs = ( Screen->D[lanmolasReg] - Floor(Screen->D[lanmolasReg]) ) * 10 ;
		
		while(true){
			segments = deciSegs;
			lanmolasValid = Floor(Screen->D[lanmolasReg]);
			
			if ( presentMax == 0 && Screen->D[regInit] == 0 ) {
				Screen->D[regInit] = 1;
				Screen->D[reg] = startNum;
				Trace(Screen->D[reg]);
				TraceNL();
			}
			
			if ( lanmolasValid && NumNPCsOf(lanmolaID) == 0 && firstRun ) {
				Unsecret = true;
				for ( int q = ( Floor(Screen->D[lanmolasReg]) / segments ); q > 0; q-- ) {
					Screen->CreateNPC(lanmolaID);
				}
				firstRun = false;
			}
			
			
			
			
			curNum = NumNPCsOf(enemID);
			presentMax = Screen->D[reg];
			if ( presentMax == 0 && Screen->D[regInit] > 0 ) {
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					
					npc n = Screen->LoadNPC(q);
					if ( n->ID == enemID ) Remove(n);
				}
			}
			curNum = NumNPCsOf(enemID);
			children = NumNPCsOf(splitsInto);
			if ( Screen->D[reg] > curNum+children ) Screen->D[reg] = curNum;
			
			if ( curNum > Screen->D[reg] ) {
				int diff = curNum - Screen->D[reg];
				int removed;
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					if ( removed == diff ) break;
					npc n = Screen->LoadNPC(q);
					if ( enemID != lanmolaID ) {
						if ( n->ID == enemID ) {
							Remove(n);
							removed++;
						}
					}
				}
			}
			int lanmolasOffscreen;
			
			if ( curNum == totalLanmolas ) {
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					npc n = Screen->LoadNPC(q);
					if ( n->ID == lanmolaID && n->X == -32768 ) lanmolasOffscreen++;
				}
			}
			
			if ( lanmolasOffscreen == totalLanmolas ) {
				for ( ; lanmolasOffscreen < 0; lanmolasOffscreen -- ){
					npc n = Screen->LoadNPC(lanmolasOffscreen);
					n->HP = -9999;
				}
			}
			
			lanmolasOffscreen = 0;
			
			Screen->D[lanmolasReg] = NumNPCsOf(lanmolaID) + ( segments / 10 );
			
			if ( !NumNPCsOf(lanmolaID) ) {
				Screen->D[lanmolasReg] = 0;
				//! Add secret triggers. 
			}
			
			Waitframe();
		}
	}
}

bool Unsecret;

global script active{
	void run(){
		while(true){
			if ( Unsecret ) {
				Screen->State[ST_SECRET] = false;
				Unsecret = false;
				
			}
			Waitdraw();
			Waitframe();
		}
	}
}
			