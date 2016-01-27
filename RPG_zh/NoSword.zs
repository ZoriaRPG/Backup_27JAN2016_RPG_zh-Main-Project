void NoSword(int minMP){
	int itemA = GetEquipmentA();
	int itemB = GetEquipmentB();
	itemdata slotA = Game->LoadItemData(itemA);
	itemdata slotB = Game->LoadItemDats(itemB);
	bool swordA;
	bool swordB;
	
	if ( slotA->Class == IC_SWORD ) swordA = true;
	if ( slotB->Class == IC_SWORD ) swordB = true;
	
	if ( Link->MP < minMP ) {
		if ( Link->PressA && swordA ) {
			Link->PressA = false;
			if ( Link->Action == LA_ATTACKING ) Link->Action = LA_NONE; 
			for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
				lweapon l = Screen->LoadLWeapon(q);
				if ( l->Type == LW_SWORD ) remove l;
				if ( l->Type == LW_BEAM ) remove l;
			}
		}
		if ( Link->PressB && swordB ) {
			Link->PressB = false;
			if ( Link->Action == LA_ATTACKING ) Link->Action = LA_NONE; 
			for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
				lweapon l = Screen->LoadLWeapon(q);
				if ( l->Type == LW_SWORD ) remove l;
				if ( l->Type == LW_BEAM ) remove l;
			}
		}
	}
}