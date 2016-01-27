//Puts an artifical limit of ( limit ) for on-screen enemies. 
//Any enemy spawned (other than Fairy NPCs) will be removed, if it exceeds the limit imposed. 
void LimitEnemies(int limit){
	if ( Screen->NumNPCs() >= limit ) {
		for ( int q = Screen->NumNPCs(); q > limit; q-- ){
			npc n = Screen->LoadNPC(q);
			if ( n->Type != NPCT_FAIRY ) {
				Remove(n);
			}
		}
	}
}