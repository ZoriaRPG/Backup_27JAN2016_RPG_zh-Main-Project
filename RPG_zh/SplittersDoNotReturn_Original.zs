//Spliiting enemies do not return, after death. 

//D0: The ID of the enemy to remove.
//D1: The enemi ID that the D0 splits into. 
//D2: the starting number of enemies on this screen (the number of times it is in the enemy list)
//D3: The register to use to store enemy counts. 
//D4: the register to check for intialisation. 

ffc script RemoveKilledSpliiters{
	void run(int enemID, int splitsInto, int startNum, int reg, int regInit){
		int curNum = NumNPCsOf(enemID);
		int presentMax = Screen->D[reg];
		int children;
		
		while(true){
			
			Waitframes(5);
			if ( presentMax == 0 && Screen->D[regInit] == 0 ) {
				Screen->D[regInit] = 1;
				Screen->D[reg] = startNum;
				Trace(Screen->D[reg]);
				TraceNL();
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
					if ( n->ID == enemID ) {
						Remove(n);
						removed++;
					}
				}
			}
			Waitframe();
		}
	}
}