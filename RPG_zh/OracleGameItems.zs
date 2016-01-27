item script SwitchHook{
	void run(){
		for ( int q = 0; q < 176; q++ ) {
			int cmb = Screen->ComboF[q];
			if ( cmb == CF_SWITCHSHOT ) {
				for ( int q = 0; q <= Screen->NumLWeapons(); q++ ) {
					lweapon l = Screen->LoadLWeapon(q);
					if ( l->Type == LW_HOOKSHOT ) {
						l->DeadState = WDS_DEAD;
					}
					int cmbX = ComboX(cmb);
					int cmbY = ComboY(cmb);
					int lx = CenterX(Link->X);
					int ly = CenterY(Link->Y);
					cmbD = Screen->ComboD[q];
					int cmbLink = ComboAt(Link->X, Link->Y);
					Screen->ComboD[cmbLink] = cmbD;
					Link->X = cmbX;
					Link->Y = cmbY;
				}
			}
		}
	}
}

const int CF_SWITCHHOOK = CF_SCRIPT1;

ffc script SwitchHook{
	void run(){
		
	}
}

item script MagneticGLoves{
	void run(){
	}
}

//Move Link towards magnet, igoring pits.
//Set Link->Z to 1.
ffc script MagnetTarget{
	
	void run(){
	
	}
}

ffc script MagneticObject{
	void run(){
	
	}
}

item script Ring{
	void run(){
	}
}

item script RingBox{
	void run(){
	}
}