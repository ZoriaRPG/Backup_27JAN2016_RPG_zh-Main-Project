//Wind removes enemies

void WindRemovesEnemies(){
	if ( NumEWeaponsOf(EW_WIND) {
		for ( int q = 1; q <= Screen->NumEWeapons(); q++ ) {
			eweapon e = Screen->LoadEweapon(q);
			for ( int w = 1; w <= Screen->NumNPCs(); q++ ) {
				npc n = Screen->LoadNPC(w);
				if ( Collision(e,n) ) remove(e);
			}
		}
	}
}

void WindRemovesEnemies(int list){
	mool batch;
	if ( NumEWeaponsOf(EW_WIND) {
		for ( int q = 1; q <= Screen->NumEWeapons(); q++ ) {
			eweapon e = Screen->LoadEweapon(q);
			for ( int w = 1; w <= Screen->NumNPCs(); q++ ) {
				npc n = Screen->LoadNPC(w);
				for ( int r = 0; r < SizeOfArray(list); r++ ) {
					(if n->ID == list[r] ) match = true;
				}
				if ( Collision(e,n) && match ) remove(e);
			}
		}
	}
}

void WindSendsEnemyToStart(int list){
	bool batch;
	if ( NumEWeaponsOf(EW_WIND) {
		for ( int q = 1; q <= Screen->NumEWeapons(); q++ ) {
			eweapon e = Screen->LoadEweapon(q);
			for ( int w = 1; w <= Screen->NumNPCs(); q++ ) {
				npc n = Screen->LoadNPC(w);
				for ( int r = 0; r < SizeOfArray(list); r++ ) {
					(if n->ID == list[r] ) match = true;
				}
				if ( Collision(e,n) && match ) {
					//find an empty slot in the array and store the enemy:
					for ( int t = 0; t < 254; t++ ) {
						if ( !EnemiesSentToStart[t] ) EnemiesSentToStart[t] = n->ID;
					}
					remove(e);
				}
			}
		}
	}
}

void WindSendsEnemyToStart(){
	bool batch;
	int EnemiesImmuneToWind[]={0}; //List all the enemy IDs *NOT* to affect by this. 
	if ( NumEWeaponsOf(EW_WIND) {
		for ( int q = 1; q <= Screen->NumEWeapons(); q++ ) {
			eweapon e = Screen->LoadEweapon(q);
			for ( int w = 1; w <= Screen->NumNPCs(); q++ ) {
				npc n = Screen->LoadNPC(w);
				for ( int r = 0; r < SizeOfArray(EnemiesImmuneToWind); r++ ) {
					(if n->ID == EnemiesImmuneToWind[r] ) match = true;
				}
				if ( Collision(e,n) && !match ) {
					//find an empty slot in the array and store the enemy:
					for ( int t = 0; t < 254; t++ ) {
						if ( !EnemiesSentToStart[t] ) EnemiesSentToStart[t] = n->ID;
					}
					remove(e);
				}
			}
		}
	}
}

void WindSendsEnemyToStart(lweapon l){
	bool batch;
	int EnemiesImmuneToWind[]={0}; //List all the enemy IDs *NOT* to affect by this. 
	for ( int w = 1; w <= Screen->NumNPCs(); q++ ) {
		npc n = Screen->LoadNPC(w);
		for ( int r = 0; r < SizeOfArray(EnemiesImmuneToWind); r++ ) {
			(if n->ID == EnemiesImmuneToWind[r] ) match = true;
		}
		if ( Collision(l,n) && !match ) {
			//find an empty slot in the array and store the enemy:
			for ( int t = 0; t < 254; t++ ) {
				if ( !EnemiesSentToStart[t] ) EnemiesSentToStart[t] = n->ID;
			}
			remove(e);
		}
	}
}

void WindSendsEnemyToStart(eweapon l){
	bool batch;
	int EnemiesImmuneToWind[]={0}; //List all the enemy IDs *NOT* to affect by this. 
	for ( int w = 1; w <= Screen->NumNPCs(); q++ ) {
		npc n = Screen->LoadNPC(w);
		for ( int r = 0; r < SizeOfArray(EnemiesImmuneToWind); r++ ) {
			(if n->ID == EnemiesImmuneToWind[r] ) match = true;
		}
		if ( Collision(l,n) && !match ) {
			//find an empty slot in the array and store the enemy:
			for ( int t = 0; t < 254; t++ ) {
				if ( !EnemiesSentToStart[t] ) EnemiesSentToStart[t] = n->ID;
			}
			remove(e);
		}
	}
}

void WindSendsEnemyToStart(ffc l){
	bool batch;
	int EnemiesImmuneToWind[]={0}; //List all the enemy IDs *NOT* to affect by this. 
	for ( int w = 1; w <= Screen->NumNPCs(); q++ ) {
		npc n = Screen->LoadNPC(w);
		for ( int r = 0; r < SizeOfArray(EnemiesImmuneToWind); r++ ) {
			(if n->ID == EnemiesImmuneToWind[r] ) match = true;
		}
		if ( Collision(l,n) && !match ) {
			//find an empty slot in the array and store the enemy:
			for ( int t = 0; t < 254; t++ ) {
				if ( !EnemiesSentToStart[t] ) EnemiesSentToStart[t] = n->ID;
			}
			remove(e);
		}
	}
}

ffc script EnemiesWindedToStart{
	void run(minX, int maxX, int minY, int maxY){
		int enemX;
		int enemY;
		//bool done = false;
		Waitframes(5);
		//while ( !done ) {
		for ( int q = 0; q < 254; q++ ) {
			if ( EnemiesSentToStart[q] ) {
				do {
					enemX = Rand(minX, maxX);
					enemY = Rand(minY, maxY);
				} while ( ( ComboSolid(enemX) || ComboWater(enemX) ) && ComboSolid(enemX) || ComboWater(enemY) ) );
				npn n = ScreenCreateNPC(EnemiesSentToStart[q]);
				n->X = enemX;
				n->Y = enemY;
			}
			if ( !EnemiesSentToStart[q] ) break; //if we reach an empty slot, return.
		}
	}
}

int EnemiesSentToStart[255]; //Holds the enemies sent back to the start by wind. 