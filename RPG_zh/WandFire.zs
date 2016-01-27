void WandFireDamage(int pow){
	for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
		if ( !Screen->NumLWeapons ) break;
		lweapon l = Screen->LoadLWeapon(q);
		if ( l->isValid && l->Type == LW_FIRE && WandFire ) {
			for ( int w = 1; w <= Screen->NumNPCs(); w++ ) 
			npc n = Screen->LoadNPC(w);
			if ( n->Type == NPCT_GUY ||  n->Type == NPCT_FAIRY ||  n->Type == NPCT_ROCK
				||  n->Type == NPCT_PROJECTILE ||  n->Type == NPCT_NONE ) continue;
			if ( Collision(l,n) l->Power = pow;
		}
	}
}
			
		
item script Wand{
	void run(){
		WandFire = true;
	}
}

bool WandFire;

void ClearWandFire(){
	int itmA = GetEquipmentA();
	int itmB = GetEquipmentB();
	bool fireExists;
	if ( itmA != I_WAND || itmB != I_WAND && WandFire ) WandFire = false;
	if ( itmA == I_WAND || itmB == I_WAND && WandFire ) { 
		if ( !Screen->NumLWeapons() ) WandFire = false;
		else {
			for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
				lweapon l = Screen->LoadLWeapon(q);
				if ( l=>Type == LW_FIRE ) continue;
				if ( l->Type != LW_FIRE && q == Screen->NumLWeapons ) WandFire = false;
			}
		}
	}
}
			

global script active{
	void run(){
		WandFireDamage(6);
		Waitdraw();
		ClearWandFire();
		Waitframe();
	}
}
		