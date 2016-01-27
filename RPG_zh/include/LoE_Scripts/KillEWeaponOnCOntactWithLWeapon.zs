const int RANGERSWORD = 100; //Set to item number of Ranger Sword.
int ANGER_DEFLECT_IDs[3]={EW_ARROW,EW_ROCK,EW_BRANG];

void CancelWeapons(int weqaponL, int weaponE, int arrayImport){
	for (int i = 1; i <= Screen->NumeWeapons(); i++) {
                eweapon ew = Screen->LoadLWeapon(i);
		for (int j = 1; j <= Screen->NumLWeapons(); j++) {
			lweapon lw = Screen->LoadLWeapon(j);
			for ( k = 0; k < SizeOfArray(arrayImport); k++){
				if ( ew->ID = arrayImport[k] && IsFromItem(lw, RANGERSWORD) ) {
					continue;
				}
				else {
					break;
				}
				if ( Collision(lw,ew) ) {
					ew->Deadstate = 0;
				}
			}
		}
	}
}

			