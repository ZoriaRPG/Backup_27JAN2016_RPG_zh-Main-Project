item script KillEnemyFireTrail{
	void run(){
		
	}
}

void KillFietrailFire(eweapon e, lweapon l){
	if ( NumEWeaponsOf(EW_FIRETRAIL) && e->ID == EW_FIRETRAIL && Collision(e,l) ) e->DeadState = WDS_DEAD;
}