const int SOLID_NONE = 0;
const int SOLID_UPLEFT = 
const int SOLID UPRIGHT = 
const int SOLID_TOP = 
const int SOLID LEFT = 
const int SOLID DOWNLEFT = 
const int SOLID DOWN = 
const int SOLID_DOWNRIGHT = 
const int SOLID_RIGHT = 

int SnapLinkToGridOffSwitchShotBlock()
	//We also need this for NPCs
	int bestlinkXY; //ComboAt for best Link X and Y
	int cmbLink0; //ComboAtLink layer 0
		int cmbLink1; //ComboAtLink layer 1
			int cmbLink2; //ComboAtLink layer 2
	
	//Check combos on layers 0, 1, and 2. If Link's coordinates put him at a position of a Switchshot combo, 
	//snap him to the grid away from it on the best nonsolid combo one tile away before switching.
	
	if ( Link->Dir == DIR_DOWN ) //Try snapping up first
	if ( Link->Dir == DIR_UP ) //Try Snapping down first
	if ( Link->Dir == DIR_LEFT) //Try snapping right first
	if ( Link->Dir == DIR_RIGHT ) //Try snapping left first
	
	//if cardinal directions won;t suffice, check at a diagonal. 
	
	return bestlinkXY;
}


void SnapLinkToNearestWalkableCombo(){
	//! Note: Original SnapToGrid() by blackbishop/Mero/Tamamo. 
	
	int x = Link->X;
	int y = Link->Y + Cond(BIG_LINK==0, 8, 0);
	int comboLoc = ComboAt(lx, ly);
	
	
	//X Axis
	if(Screen->ComboS[comboLoc] == SOLID_NONE && Cond(x % 16 == 0, true, Screen->ComboS[comboLoc+1] != SOLID_NONE))
		Link->X = ComboX(comboLoc);
	else if(Screen->ComboS[comboLoc+1] == SOLID_NONE && Cond(x % 16 == 0, true, Screen->ComboS[comboLoc] != SOLID_NONE))
		Link->X = ComboX(comboLoc+1);
	if(Cond(y % 16 == 0, false, Screen->ComboS[comboLoc+16] == SOLID_NONE) && Cond(x % 16 == 0, true, Screen->ComboS[comboLoc+17] != SOLID_NONE))
		Link->X = ComboX(comboLoc+16);
	else if(Cond(y % 16 == 0, false, Screen->ComboS[comboLoc+17] == SOLID_NONE) && Cond(x % 16 == 0, true, Screen->ComboS[comboLoc+16] != SOLID_NONE))
		Link->X = ComboX(comboLoc+17);
 
	//Y Axis
	if(Screen->ComboS[comboLoc] == SOLID_NONE && Cond(y % 16 == 0, true, Screen->ComboS[comboLoc+16] != SOLID_NONE))
		Link->Y = ComboY(comboLoc);
	else if(Screen->ComboS[comboLoc+16] == SOLID_NONE && Cond(y % 16 == 0, true, Screen->ComboS[comboLoc] != SOLID_NONE))
		Link->Y = ComboY(comboLoc+16);
	if(Cond(x % 16 == 0, false, Screen->ComboS[comboLoc+1] == SOLID_NONE) && Cond(y % 16 == 0, true, Screen->ComboS[comboLoc+17] != SOLID_NONE))
		Link->Y = ComboY(comboLoc+1);
	else if(Cond(x % 16 == 0, false, Screen->ComboS[comboLoc+17] == CT_HOLELAVA) && Cond(y % 16 == 0, true, Screen->ComboS[comboLoc+1] != SOLID_NONE))
		Link->Y = ComboY(comboLoc+17);
	
	if ( Link->Dir == DIR_DOWN ) //Try snapping up first
	if ( Link->Dir == DIR_UP ) //Try Snapping down first
	if ( Link->Dir == DIR_LEFT) //Try snapping right first
	if ( Link->Dir == DIR_RIGHT ) //Try snapping left first
	
	//if diagonal dirs? Do we need these?
	
	
	
	
	
}

//Snaps Link to the combo so he appears completely over pit and lava combos. (Function by Tamamo.)
void SnaptoGrid()
{
	int x = Link->X;
	int y = Link->Y + Cond(BIG_LINK==0, 8, 0);
	int comboLoc = ComboAt(x, y);
 
	//X Axis
	if(Screen->ComboT[comboLoc] == CT_HOLELAVA && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+1] != CT_HOLELAVA))
		Link->X = ComboX(comboLoc);
	else if(Screen->ComboT[comboLoc+1] == CT_HOLELAVA && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc] != CT_HOLELAVA))
		Link->X = ComboX(comboLoc+1);
	if(Cond(y % 16 == 0, false, Screen->ComboT[comboLoc+16] == CT_HOLELAVA) && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+17] != CT_HOLELAVA))
		Link->X = ComboX(comboLoc+16);
	else if(Cond(y % 16 == 0, false, Screen->ComboT[comboLoc+17] == CT_HOLELAVA) && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+16] != CT_HOLELAVA))
		Link->X = ComboX(comboLoc+17);
 
	//Y Axis
	if(Screen->ComboT[comboLoc] == CT_HOLELAVA && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+16] != CT_HOLELAVA))
		Link->Y = ComboY(comboLoc);
	else if(Screen->ComboT[comboLoc+16] == CT_HOLELAVA && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc] != CT_HOLELAVA))
		Link->Y = ComboY(comboLoc+16);
	if(Cond(x % 16 == 0, false, Screen->ComboT[comboLoc+1] == CT_HOLELAVA) && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+17] != CT_HOLELAVA))
		Link->Y = ComboY(comboLoc+1);
	else if(Cond(x % 16 == 0, false, Screen->ComboT[comboLoc+17] == CT_HOLELAVA) && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+1] != CT_HOLELAVA))
		Link->Y = ComboY(comboLoc+17);
}