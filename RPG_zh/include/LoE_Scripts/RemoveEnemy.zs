ffc script RemoveEnemy{
	void run(int enemID){
		for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
			npc n = Screen->LoadNPC(q);
			if ( n->ID == enemID ) Remove(n);
		}
	}
}