//import RPG_zh/RPG_MagicCosts.zib

//Included directly:

const int SFX_MP_ERROR = 63;

//All functions, scripts, or other commands that reduce MP, should process through these commands. 

const int USE_DOUBLED_MP_COSTS = 1;

//Disable to use exact MP amounts. 

const int CHECK_REDUCE = 1;
const int CHECK_REDUCE_RET_DIFF = 2;
const int CHECK = 3;
const int CHECK_INCREASE = 4;


int MagicCost(int action, int amount){
	int val;
	int LinkMP_Usable;
	if ( USE_DOUBLED_MP_COSTS ) val = amount * Game->Generic[GEN_MAGICDRAINRATE];
	else val = amount;
	//if ( USE_DOUBLED_MP_COSTS ) {
	//	if ( Game->Generic[GEN_MAGICDRAINRATE] ) LinkMP_Usable = Link->MP / Game->Generic[GEN_MAGICDRAINRATE];
	//	else LinkMP_Usable = 99999;
	//}
	//else 
	LinkMP_Usable = Link->MP;
	if (!action)	return (val);
	else if ( action == 1 ) { 
		if ( LinkMP_Usable >= val ) {
			Link->MP -= ( val );
			return 1;
		}
		else if ( LinkMP_Usable < val ) return 0;
	}
	else if ( action == 2 ) { 
		if ( LinkMP_Usable >= val ) {
			Link->MP -= ( val );
			return 1;
		}
		else if ( LinkMP_Usable < val ) 
			return LinkMP_Usable - val;
	}
	else if ( action == 3 ) {
		if ( LinkMP_Usable >= val ) return 1;
		else return 0;
	}
	//Expand as needed.
}

int SwordMP_Table[8]={	5, 6, 7, 36
			2, 4, 8, 16	};
			
			

const int SWORD_MP_COST = 4;

void NoSword(int minMP_Table){
	int itemA = GetEquipmentA();
	int itemB = GetEquipmentB();
	itemdata slotA = Game->LoadItemData(itemA);
	itemdata slotB = Game->LoadItemDats(itemB);
	bool swordA;
	bool swordB;
	int minMP_A;
	int minMP_B;
	int itemID_A;
	int itemID_B;
	
	
	if ( slotA->Class == IC_SWORD ) swordA = true;
	if ( slotB->Class == IC_SWORD ) swordB = true;
	
	if ( Link->PressA && swordA ) {
		itemID_A = slotA->ID;
		int curItem_A;
		int cost_A;
		for ( int q = 0; q <= SizeOfArray(minMP_Table) * 0.5; q++ ){
			curItem_A = minMP_Table[q];
			if ( curItem_A == itemID ) {
				cost_A = minMP_Table[q+SWORD_MP_COST];
				break;
			}
		minMP_A = cost_A;
		if ( !MagicCost(CHECK,cost_A) ) {
			Link->PressA = false;
			if ( Link->Action == LA_ATTACKING ) Link->Action = LA_NONE; 
			
			for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
				lweapon l = Screen->LoadLWeapon(q);
				if ( l->Type == LW_SWORD ) remove l;
				if ( l->Type == LW_BEAM ) remove l;
			}
		}
		else {
			MagicCost(CHECK_REDUCE,cost_A);
		}
	if ( Link->PressB && swordB ) {
		itemID_B = slotB->ID;
		int curItem_B;
		int cost_B;
		for ( int q = 0; q <= SizeOfArray(minMP_Table) * 0.5; q++ ){
			curItem_A = minMP_Table[q];
			if ( curItem_B == itemID ) {
				cost_B = minMP_Table[q+SWORD_MP_COST];
				break;
			}
		minMP_B = cost_B;
		if ( !MagicCost(CHECK,cost_B) ) {
			Link->PressA = false;
			if ( Link->Action == LA_ATTACKING ) Link->Action = LA_NONE; 
			
			for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
				lweapon l = Screen->LoadLWeapon(q);
				if ( l->Type == LW_SWORD ) remove l;
				if ( l->Type == LW_BEAM ) remove l;
			}
		}
		else {
			MagicCost(CHECK_REDUCE,cost_A);
		}
	}
}