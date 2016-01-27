import "std.zh"
import "ffcscript.zh"
import "string.zh"

//SwitchHook v0.2.1
//17-Nov-2015
//Modded by ywkls

const int CF_SWITCHHOOK = 98; //Script 1
const int SFX_SWITCHHOOK = 100; 

ffc script Switch_Hook{
	void run(){
		int solidity;
		int layer;
		while( Screen->NumLWeapons()>0){
			for ( int q = 0; q < 176; q++ ) {
				int cmb = Screen->ComboF[q];
				if ( cmb == CF_SWITCHHOOK ) {
					for ( int q = 0; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->ID == LW_HOOKSHOT && ComboFlagCollision(cmb,l) ) {
							//We need to check every layer...too...
							l->DeadState = WDS_DEAD;
							solidity = Screen->ComboS[cmb];
							Game->PlaySound(SFX_SWITCHHOOK);
							int cmbX = ComboX(cmb);
							int cmbY = ComboY(cmb);
							int lx = CenterLinkX();
							int ly = CenterLinkY();
							int cmbD = Screen->ComboD[q];
							int cmbLink = ComboAt(Link->X, Link->Y);
							Screen->ComboD[cmbLink] = cmbD;
							Screen->ComboS[cmbLink] = solidity;
							Link->X = cmbX;
							Link->Y = cmbY;
							Quit();
						}
						
					}
				}
			}
			Waitframe();
		}
	}
}


item script SwitchHook{
	void run(int ffc_slot) {
        int args[8];
		RunFFCScript(ffc_slot,args);
	}
}


// Returns INT if FFC collides with a combo which has specific placed flag
int ComboFlagCollision (int flag, lweapon l){
	for (int i = 0; i<176; i++){
		if (Screen->ComboF[i]==flag){
			if (ComboCollision(i, l->X,l->Y,l->X+16,l->Y+16)) return i;
		}
	}
	return -1;
}

// Returns TRUE if there is a collision between the combo and an arbitrary rectangle.
bool ComboCollision (int loc, int x1, int y1, int x2, int y2){
	return RectCollision( ComboX(loc), ComboY(loc), (ComboX(loc)+16), (ComboY(loc)+16), x1, y1, x2, y2);
}
