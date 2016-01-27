const int SDC_SENSITIVITY = 12; //How many frames of safety the damage combos have

ffc script SolidDamageCombo{
	bool CheckDC(int x, int y, int dir, int step, bool full_tile, int ct) {
		int c=8;
		int xx = x+15;
		int yy = y+15;
		if(full_tile) c=0;
		if(dir==0) return (Screen->ComboT[ComboAt(x,y+c-step)]==ct||Screen->ComboT[ComboAt(x+8,y+c-step)]==ct||Screen->ComboT[ComboAt(xx,y+c-step)]==ct);
		else if(dir==1) return (Screen->ComboT[ComboAt(x,yy+step)]==ct||Screen->ComboT[ComboAt(x+8,yy+step)]==ct||Screen->ComboT[ComboAt(xx,yy+step)]==ct);
		else if(dir==2) return (Screen->ComboT[ComboAt(x-step,y+c)]==ct||Screen->ComboT[ComboAt(x-step,y+c+7)]==ct||Screen->ComboT[ComboAt(x-step,yy)]==ct);
		else if(dir==3) return (Screen->ComboT[ComboAt(xx+step,y+c)]==ct||Screen->ComboT[ComboAt(xx+step,y+c+7)]==ct||Screen->ComboT[ComboAt(xx+step,yy)]==ct);
		return false; //invalid direction
	}
	int HitBramble(int ComboType){
		if(Link->InputUp&&!CanWalk(Link->X, Link->Y, DIR_UP, 3, false)){
			if(CheckDC(Link->X, Link->Y, DIR_UP, 3, false, ComboType))
				return DIR_UP;
		}
		if(Link->InputDown&&!CanWalk(Link->X, Link->Y, DIR_DOWN, 3, false)){
			if(CheckDC(Link->X, Link->Y, DIR_DOWN, 3, false, ComboType))
				return DIR_DOWN;
		}
		if(Link->InputLeft&&!CanWalk(Link->X, Link->Y, DIR_LEFT, 3, false)){
			if(CheckDC(Link->X, Link->Y, DIR_LEFT, 3, false, ComboType))
				return DIR_LEFT;
		}
		if(Link->InputRight&&!CanWalk(Link->X, Link->Y, DIR_RIGHT, 3, false)){
			if(CheckDC(Link->X, Link->Y, DIR_RIGHT, 3, false, ComboType))
				return DIR_RIGHT;
		}
		return -1;
	}
	int ConveyorBramble(int ComboType){
		int Combo = Screen->ComboT[ComboAt(Link->X+8, Link->Y+12)];
		if(Combo==CT_CVUP&&!CanWalk(Link->X, Link->Y, DIR_UP, 1, false)){
			if(CheckDC(Link->X, Link->Y, DIR_UP, 1, false, ComboType))
				return DIR_UP;
		}
		else if(Combo==CT_CVDOWN&&!CanWalk(Link->X, Link->Y, DIR_DOWN, 1, false)){
			if(CheckDC(Link->X, Link->Y, DIR_DOWN, 1, false, ComboType))
				return DIR_DOWN;
		}
		else if(Combo==CT_CVLEFT&&!CanWalk(Link->X, Link->Y, DIR_LEFT, 1, false)){
			if(CheckDC(Link->X, Link->Y, DIR_LEFT, 1, false, ComboType))
				return DIR_LEFT;
		}
		else if(Combo==CT_CVRIGHT&&!CanWalk(Link->X, Link->Y, DIR_RIGHT, 1, false)){
			if(CheckDC(Link->X, Link->Y, DIR_RIGHT, 1, false, ComboType))
				return DIR_RIGHT;
		}
		return -1;
	}
	void run(int ComboType, int Damage){
		int SafetyCounter;
		while(true){
			if(ConveyorBramble(ComboType)>-1){
				SafetyCounter++;
				if(SafetyCounter>=SDC_SENSITIVITY){
					int Dir = ConveyorBramble(ComboType);
					eweapon e = FireEWeapon(EW_SCRIPT10, Link->X+InFrontX(Dir, 10), Link->Y+InFrontY(Dir, 10), 0, 0, Damage, -1, -1, EWF_UNBLOCKABLE);
					e->DrawYOffset = -1000;
					if(Link->Item[I_RING2])
						e->Damage = e->Damage*4;
					else if(Link->Item[I_RING1])
						e->Damage = e->Damage*2;
					SetEWeaponLifespan(e, EWL_TIMER, 1);
					SetEWeaponDeathEffect(e, EWD_VANISH, 0);
					SafetyCounter = 0;
				}
			}
			else if(HitBramble(ComboType)>-1){
				SafetyCounter++;
				if(SafetyCounter>=SDC_SENSITIVITY){
					int Dir = HitBramble(ComboType);
					eweapon e = FireEWeapon(EW_SCRIPT10, Link->X+InFrontX(Dir, 10), Link->Y+InFrontY(Dir, 10), 0, 0, Damage, -1, -1, EWF_UNBLOCKABLE);
					e->DrawYOffset = -1000;
					if(Link->Item[I_RING2])
						e->Damage = e->Damage*4;
					else if(Link->Item[I_RING1])
						e->Damage = e->Damage*2;
					SetEWeaponLifespan(e, EWL_TIMER, 1);
					SetEWeaponDeathEffect(e, EWD_VANISH, 0);
					SafetyCounter = 0;
				}
			}
			else
				SafetyCounter = 0;
			Waitframe();
		}
	}
}