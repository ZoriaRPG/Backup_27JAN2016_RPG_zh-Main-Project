int ScreenEnemies[256];
const int ENEMY_NOT_PRESENT = -1;

void StoreScreenEnemies(){
	//int maxEnemies; 
	if ( Screen->NumNPCs() ) {
		
		for ( int q = 0; q <= 255; q++ ) {
			if ( q <= Screen->NumNPCs() ) { 
				//Make the list for the number of enemies on the screen.
				//Store all the enemies on the screen to an array by ID.
				npc n = Screen->LoadNPC(q);
				if (
					n->Type != NPCT_GUY && n->Type != NPCT_ROCK && n->Type != NPCT_TRAP &&
					n->Type != NPCT_PROJECTILE && n->Type != NPCT_NONE && n->ID != NPC_FAIRY 
					//Ignore enemy types that we don't care about. 
				) {
					ScreenEnemies[q] = n ->ID;  //Store them. 
					//maxEnemies++;
				}
				
				else {
					ScreenEnemies[1] = ENEMY_NOT_PRESENT;
					//maxEnemies++;
				}
			}
		
			//We've reached the end of the list.
			
			if ( q > Screen->NumNPCs() ) {
				//Populate the rest of the indixes with a special value so that we know there 
				//are no enemies for those indices.
				ScreenEnemies[q] = ENEMY_NOT_PRESENT;
			}
		}
	}
	else { //There are no enemies, so wipe the array.
		for ( q = 0; q <= SizeOfArray(ScreenEnemies); q++ ) ScreenEnemies[q] = ENEMY_NOT_PRESENT;
	}
}
			
			
			