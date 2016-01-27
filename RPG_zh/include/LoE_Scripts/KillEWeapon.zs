const int RANGERSWORD = 1; //Set to item number of Ranger Sword.
int RangerDeflectIDs[3]={EW_ARROW,EW_ROCK,EW_BRANG};

void CancelAnyEW(int cancelitem){
	for (int i = 1; i <= Screen->NumEWeapons(); i++) {
		eweapon ew = Screen->LoadEWeapon(i);
		for (int j = 1; j <= Screen->NumLWeapons(); j++) {
			lweapon lw = Screen->LoadLWeapon(j);
			if ( Collision(ew,lw) ) {
				ew->DeadState = WDS_DEAD;
			}
		}
	}
}

void CancelWeapons(int weaponL, int arrayImport){
	if ( Screen->NumEWeapons() > 0 ) {
		for (int i = 1; i <= Screen->NumEWeapons(); i++) {
			eweapon ew = Screen->LoadEWeapon(i);
			for (int j = 1; j <= Screen->NumLWeapons(); j++) {
				lweapon lw = Screen->LoadLWeapon(j);
				for ( int k = 0; k < SizeOfArray(arrayImport); k++){
					if ( ew->ID == arrayImport[k] &&  lw->ID == LW_SWORD && Collision(lw,ew) ) {
						ew->DeadState = WDS_DEAD;
						Game->PlaySound(6);
					}
				}
			}
		}
	}
}

global script active{
	void run(){
		while(true){
			CancelWeapons(RANGERSWORD,RangerDeflectIDs);
			Waitdraw();

			CancelWeapons(RANGERSWORD,RangerDeflectIDs);
			
			Waitframe();
		}
	}
}

			//