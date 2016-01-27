//Enemy Hurt by Friendly Fire

void FriendlyFire(){
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ){
		npc n = Screen->LoadNPC(q);
		if ( ! n->isValid ) {
			break;
		}
		for ( int w = 1; w <= Screen->NumEWeapons(); w++ ) {
			eweapon ew = Screen->LoadEWeapon(w);
			if ( ! n->isValid() ) {
				break;
			}
			if ( Collision (n,ew){
				int ffwtype = ew->Type;
				friendlyfire = Screen->CreateLWeapon(ffwtype);
				friendlyfire->X = ew->X;
				friendlyfire->Y = ew->Y;
				friendlyfire->Z = ew->Z;
			}
		}
	}
}