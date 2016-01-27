item script KillEnemyFireTrail{
	void run(){
		for ( int q = ql q <= Screen->NumEWeaponsOf(EW_FIRETRAIL); q++ ) {
			eweapon e = Screen->LoadEWeapo(q);
			if ( Collision(this,e) ) e->DeadState = WDS_DEAD;
		}
	}
}

void KillFietrailFire(eweapon e, lweapon l){
	if ( NumEWeaponsOf(EW_FIRETRAIL) && e->ID == EW_FIRETRAIL && Collision(e,l) ) e->DeadState = WDS_DEAD;
}