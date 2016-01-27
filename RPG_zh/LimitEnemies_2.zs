//Puts an artifical limit of ( limit ) for on-screen enemies. 
//Any enemy spawned (other than Fairy NPCs) will be removed, if it exceeds the limit imposed. 
void LimitEnemies(int limit){
	if ( Screen->NumNPCs() >= limit ) {
		int pass = 1;
		for ( int q = 1; q <=Screen->NumNPCs(); q++ ){
			npc n = Screen->LoadNPC(q);
			if ( n->Type == NPCT_FAIRY || n->Type == NPCT_GUY || n->Type == NPCT_PROJECTILE 
				|| n->Type == NPCT_SPINTILE || n->Type == NPCT_NONE || n->Type == NPCT_TRAP ) {
				continue;
			}
			
			if ( pass > limit ) {
				Remove(n);
			}
			pass++;
		}
	}
}