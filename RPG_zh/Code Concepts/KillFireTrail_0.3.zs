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

const int SPRITE_FIRETRAIL_SMOKE = 0;
const int SPRITE_FIRETRAIL_DIE = 0;

item script KillEnemyFireTrail{
	void run(int sprite){
		for ( int q = ql q <= Screen->NumEWeaponsOf(EW_FIRETRAIL); q++ ) {
			eweapon e = Screen->LoadEWeapo(q);
			if ( Collision(this,e) ) {
				e->UseSprite(sprite);
				e->DeadState = WDS_DEAD;
		}
	}
}

void KillFietrailFire(eweapon e, lweapon l, int sprite){
	if ( NumEWeaponsOf(EW_FIRETRAIL) && e->ID == EW_FIRETRAIL && Collision(e,l) ) {
		e->UseSprite(sprite);
		e->DeadState = WDS_DEAD;
	}
}
