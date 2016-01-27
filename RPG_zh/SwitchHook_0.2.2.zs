//SwitchHook v0.2.2
//18-Nov-2015

const int CF_SWITCHHOOK = 98; //Script 1
const int SFX_SWITCHHOOK = 100; 


ffc script SwitchHook{
	void run(int comboF, int affectEnemies){
		int solidity;
		int layer;
		if ( comboF == 0 ) comboF = CF_SWITCHHOOK;
		while( Screen->NumLWeaponsOf(LW_HOOKSHOT) ) {
			for ( int q = 0; q < 176; q++ ) {
				int cmb = Screen->ComboF[q];
				if ( cmb == comboF ) {
					for ( int q = 0; q <= Screen->NumLWeapons(); q++ ) {
						lweapon l = Screen->LoadLWeapon(q);
						if ( l->Type == LW_HOOKSHOT && ComboFlagCollision(l,cmb) ) {
							//We need to check every layer...too...
							//..for combos on layers higher than 0. (?)
							l->DeadState = WDS_DEAD;
							solidity = Screen->ComboS[cmb];
							Game->PlaySound(SFX_SWITCHHOOK);
							int cmbX = ComboX(cmb);
							int cmbY = ComboY(cmb);
							int lx = CenterX(Link->X);
							int ly = CenterY(Link->Y);
							cmbD = Screen->ComboD[q];
							int cmbLink = ComboAt(Link->X, Link->Y);
							Screen->ComboD[cmbLink] = cmbD;
							Screen->ComboS[cmbLink] = solidity;
							Link->X = cmbX;
							Link->Y = cmbY;
							Quit();
						}
						if ( affectEnemies && Screen->NumNPCs() ) {
							for ( int q = 0; q <= Screen->NumNPCs(); q++ ) {
								npc n = Screen->LoadNPC(q);
								if ( l->Type == LW_HOOKSHOT && Collision(l,n) ) {
									Game->PlaySound(SFX_SWITCHHOOK);
									int npcX = n->X;
									int npxY = n->Y;
									int lx = Link->X;
									int ly = Link->Y;
									n->X = -1; 
									n->Y = -1;
									Link->X = npcX;
									Link->Y = npcY;
									n->X = lx; 
									n->Y = ly;
									Quit();
								}
							}
						}
						
					}
				}
			}
			Waitframe();
		}
	}
}


item script SwitchHook{
	void run(int ffc_slot, int comboF, int affectEnemies) {
		int args[2]={comboF,affectEnemies};
		RunFFCScript(ffc_slot, args);
	}
}


// Returns INT if FFC collides with a combo which has specific placed flag
int ComboFlagCollision (int flag, lweapon l){
	for (int i = 0; i<176; i++){
		if (Screen->ComboF[i]==flag){
			if (ComboCollision(i, l)) return i;
		}
	}
	return -1;
}

// Returns TRUE if there is a collision between the combo and an arbitrary rectangle.
bool ComboCollision (int loc, int x1, int y1, int x2, int y2){
	return RectCollision( ComboX(loc), ComboY(loc), (ComboX(loc)+16), (ComboY(loc)+16), x1, y1, x2, y2);
}