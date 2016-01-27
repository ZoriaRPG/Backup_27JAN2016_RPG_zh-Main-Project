ffc script NewClock{
	void run(int timer){ //Timer is set in seconds.
		int clock = timer;
		int bigClock = clock * 60;
		int linkHP = Link->HP;
		int enemyX[255];
		int enemyY[255]
		int enemyZ[255];
		int enemyStep[255];
		int IgnoreEnemyTypes[]={NPCT_GUY, NPCT_FAIRY, NPCT_NONE};
		if ( clock < 0 ) clock = -999;
		for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
			npc n = Screen->LoadNPC(q);
			enemyX[q] = n->X;
			enemyY[q] = n->Y;
			enemyZ[q] = n->Z;
			enemyStep[q] = n->Step;
		}
		while( clock > 0 || clock != -999 ){
			bigClock--;
			if ( bigClock % 60 == 0 && clock != 0 ) clock--;
			if ( clock == 0 ) { 
				clock = timer;
				bigClock = clock * 60;
			if ( Link->HP < linkHP ) Link->HP = linkHP;
			if ( Link->Action == LA_GOTHURTLAND || Link->Action == LA_HOTHURTEATER ) Link->HitDir = -1;
			for ( int q = 1; 1 <= Screen->NumNPCs; q ++ ) {
				if ( n->isValid() && !_IgnoreNPCs(IgnoreEnemyTypes,n) {
					npc n = Screen->LoadNPC(q); 
					n->X = enemyX[q];
					n->Y = enemyY[q];
					n->Z = enemyZ[q];
					n->Step = 0;
				}
			}
			Waitframe();
		}
		for ( int q = 1; 1 <= Screen->NumNPCs; q ++ ) {
			if ( n->isValid() && !_IgnoreNPCs(IgnoreEnemyTypes,n) {
				npc n = Screen->LoadNPC(q); 
				n->Step = enemyStep[q];
			}
		}
	}
			
	bool _IgnoreNPCs(int list, npc enem){
		bool match;
		for ( int q = 0; q < SizeOfArray(list); q++ ) {
			if ( enem->ID == list[q] ) match = true;
		}
		return match;
	}
}

//Place on an item using a 'Custom Itemclass', or a 'zz###' item class as a pick-up script.
//The 'Power' attribute in the item editor, is the clock time, in seconds,.
//Arg D0 is the slot of the FFC Script holding 'NewClockFFC'.

item script NewClock{
	void run(int ffc_script){
		int seconds = this->Power;
		RunFFCScript(ffc_script,seconds);
	}
}
			
			