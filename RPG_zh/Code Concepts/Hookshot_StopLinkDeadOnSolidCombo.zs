ffc script DeadStopHookshot{
	void run(){
		int lx;
		int ly;
		int lOffsetX;
		int lOffsetY;

		while(NumLWeaponsOf(LW_HOOKSHOT)){
			lx = Link->X;
			ly = Link->Y;
			int cmb = ComboAt(Link->X, Link->Y);
			if ( Link->Dir == DIR_UP ) {
				lOffsetY = 0;
				lOffsetX = -16;
			}
			if ( Link->Dir == DIR_DOWN )  {
				lOffsetY = 0;
				lOffsetX = 16;
			}
			if ( Link->Dir == DIR_LEFT )  {
				lOffsetY = 16;
				lOffsetX = 0;
			}
			if ( Link->Dir == DIR_RIGHT )  {
				lOffsetY = -16;
				lOffsetX = 0;
			}
	
			if ( ComboS[cmb] !=0 && ComboT[cmb] != CT_HOOKSHOTONLY ) {
				for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
					lweapon l = Screen->LoadLWeapon(q);
					if ( l->ID == LW_HOOKSHOT ) l->DeadState = WDS_DEAD;
				}
				Link->X = lx + lOffsetX;
				Link->Y = ly + lOffsetY;
			}
			Waitframe();
		}
	}
}