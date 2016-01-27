//Ten Script Defences for a Ghosted Enemy
//v0.2.1

ffc script ScriptDefsGhost{
	void run(){
		int Defs[18];
		//Store normal ghost defs here.
		int ScriptDefs[10];
		//store script defs here. 
		
		
	while(true){
		Waitframe();
	}
	
	void SetScriptDefs(ffc f, npc n int ScriptDefs){
		int def;
		for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
			lweapon l = Screen->LoadLWeapon(q);
			if ( l->ID >= 31 && l->ID <= 40 ) {
				if ( Collision(f,l) || Collision (n,l) ) {
					def = ScriptDefs[l->ID - 31];
					n->Defense[17] = def;
				}
			}
		}
	}
	

	void _SetGhostScriptDef(npc n, ffc f, int script_id, int ScriptDefs){
		for ( int q = 1; q <= Screen->NumLWeaponsOf(script_id) ) {
			lweapon l = Screen->LoadLWeapon(q);
				if ( Collision(f,l) || Collision(n,l) ) n->Defense[17] = ScriptDefs[script_id - 31];
		}
	}
	
	void SetGhostScriptDef(ffc f, npc n, int script_id, int def_type){
		for ( int q = 1; q <= Screen->NumLWeaponsOf(script_id) ) {
			lweapon l = Screen->LoadLWeapon(q);
				if ( Collision(f,l) || Collision(n,l) ) n->Defense[17] = def_type;
		}
	}

	void CleanUpScriptDefs(ffc f, npc n, int Defs){
		n->Defense[17] = Defs[17];
		//f->Something if we want to use a ghost property here. 
		//or call a ghost function
	}
}