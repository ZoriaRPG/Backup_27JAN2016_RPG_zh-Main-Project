//Reduces the number of NPCs on the screen to the amount defined as 'limit', 
//ignoring guys, faeries, and other types.

//Run before Waitdraw. Note that in 2.50.0, using Remove() on some segemented enemies
//(e.g. lanmolas) will cause ZC to crash. This is fixed in 2.50.1


void ReduceNPCs(int limit) { 
	if ( Screen->NumNPCs > limit ){
		int diff = Screen->NumNPCs = limit;
		for ( int q = 1; q <= limit; q++ ) {
			npc n = Screen->LoadNPC(q);
			if ( n->Type != NPCT_GUY && n->Type != NPCT_FAIRY && n->Type != NPCT_TRAP 
				&& n->Type != NPCT_ROCK && n->Type != NPCT_PROJECTILE ) Remove(n);
		}
	}
}
		