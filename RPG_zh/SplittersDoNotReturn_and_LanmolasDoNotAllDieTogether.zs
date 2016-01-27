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
		int laninit[]="Number of lanmolas in Screen->D[lanmolasReg] before entering loop.";
		TraceS(laninit);
		TraceNL();
		Trace(Screen->D[lanmolasReg]);
		TraceNL();
		Waitframes(5);
		bool firstRun = true;
		int segments;
		
		if ( lanmolaID ) { 
			for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
				npc a = Screen->LoadNPC(q);
				if ( a->ID == lanmolaID ) {
					segments = a->Attributes[0] + 1;
					int segs[]="Lanmola Attribute 0 is:";
					TraceNL();
					TraceS(segs);
					Trace(a->Attributes[0] + 1);
					TraceNL();
					break;
				}
			}
		}
		
		float segs = segments / 10;
		
		Screen->D[lanmolasReg] += segs;
		int lanmolasValid = Floor(Screen->D[lanmolasReg]);
		float deciSegs = ( Screen->D[lanmolasReg] - Floor(Screen->D[lanmolasReg]) ) * 10 ;
		
		int segm[]="Var segments = ";
		TraceNL();
		TraceS(segm);
		TraceNL();
		Trace(segments);
		TraceNL();
		
		while(true){
			segments = deciSegs;
			lanmolasValid = Floor(Screen->D[lanmolasReg]);
			int lanwait[]="Number of lanmolas in Screen->D[lanmolasReg] instantly after entering loop.";
			TraceS(lanwait);
			TraceNL();
			Trace(Screen->D[lanmolasReg]);
			TraceNL();
			if ( presentMax == 0 && Screen->D[regInit] == 0 ) {
				Screen->D[regInit] = 1;
				Screen->D[reg] = startNum;
				Trace(Screen->D[reg]);
				TraceNL();
			}
			
			if ( lanmolasValid && NumNPCsOf(lanmolaID) == 0 && firstRun ) {
				for ( int q = ( Floor(Screen->D[lanmolasReg]) / segments ); q > 0; q-- ) {
					Screen->CreateNPC(lanmolaID);
				}
				firstRun = false;
			}
			
			
			
			curNum = NumNPCsOf(enemID);
			presentMax = Screen->D[reg];
			int presmax[]="Tracing presentMax";
			TraceS(presmax);
			TraceNL();
			Trace(presentMax);
			TraceNL();
			if ( presentMax == 0 && Screen->D[regInit] > 0 ) {
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					
					npc n = Screen->LoadNPC(q);
					if ( n->ID == enemID ) Remove(n);
				}
			}
			curNum = NumNPCsOf(enemID);
			children = NumNPCsOf(splitsInto);
			if ( Screen->D[reg] > curNum+children ) Screen->D[reg] = curNum;
			int currentNum[]="Tracing curNum";
			TraceS(currentNum);
			TraceNL();
			Trace(curNum);
			TraceNL();
			int dreg[]="Tracing Screen->D[reg] line 30";
			TraceS(dreg);
			TraceNL();
			Trace(Screen->D[reg]);
			TraceNL();
			
			if ( curNum > Screen->D[reg] ) {
				int diff = curNum - Screen->D[reg];
				int removed;
				for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
					if ( removed == diff ) break;
					npc n = Screen->LoadNPC(q);
					if ( enemID != lanmolaID ) {
						if ( n->ID == enemID ) {
							//if ( n->ID == lanmolaID || n->ID == 75 && curNum == 6  ) n->HP == -9999;
							//else 
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
			int lanreg[]="Number of stored Lanmolas";
			TraceS(lanreg);
			TraceNL();
			Trace(Screen->D[lanmolasReg]);
			TraceNL();
			
			if ( !NumNPCsOf(lanmolaID) ) {
				Screen->D[lanmolasReg] = 0;
				int allkilled[]="All lanmolas are dead.";
				TraceS(allkilled);
				TraceNL();
			}
			
			
			
			//if ( Screen->NumNPCs() ) 
			//	for ( int q = 0; q <= 14; q++ ) Screen->State[q] = 0;
			
			Waitframe();
		}
	}
}

global script active{
	void run(){
		while(true){
			int numLanmolas = 0;
			for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
				npc n = Screen->LoadNPC(q);
				//if ( n->ID == lanmolaID && n->HP <= 0 ) {
				//	n->HP = 9999;
				//	//n->CollDetection = false;
				//	n->Rate = 0;
				//	n->X = -32768;
					
					
				//}
				//Waitframe();
				
			}
			
				
			
			Waitdraw();
			Waitframe();
		}
	}
}