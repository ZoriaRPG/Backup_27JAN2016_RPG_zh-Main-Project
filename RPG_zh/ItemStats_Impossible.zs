
void ItemStats(int itm){
	itemdata it = Game->LoadItemData(itm);
	for ( int q = 0; q <= 16; 1++ ){
		ItemStats[q] = it->Misc[q];
	}
}

const int SET = 0;
const int LOAD = 1;

void ItemStats(int itm, bool set){
	itemdata it = Game->LoadItemData(itm);
	for ( int q = 0; q <= 16; 1++ ){
		if ( set ) {
			it->Misc[q] = ItemStats[q];
		}
		else {
			ItemStats[q] = it->Misc[q];
		}
	}
}

void ItemStats(int itm, int action){
	itemdata it = Game->LoadItemData(itm);
	for ( int q = 0; q <= 16; 1++ ){
		if ( action == 0 ) {
			it->Misc[q] = ItemStats[q]; //Set to item.
		}
		else if ( action == 1 ) { //Load to array.
			ItemStats[q] = it->Misc[q];
		}
	}
}

int ItemStats(int itm, int stat, bool array){
	itemdata it = Game->LoadItemData(itm);
	if ( array ) { //Return a stored value from ItemStats[]
		return ItemStats[stat];
	}
	return it->Misc[stat];
}

void ItemStats(int itm, int stat, int value){
	itemdata it = Game->LoadItemData(itm);
	it->Misc[stat] = value;
}

void ItemStats(int itm, int stat, int value, int action){
	itemdata it = Game->LoadItemData(itm);
	for ( int q = 0; q <= 16; 1++ ){
		if ( action == 0 ) {
			it->Misc[q] = ItemStats[q]; //Set to item.
		}
		else if ( action == 1 ) { //Load to array.
			ItemStats[q] = it->Misc[q];
		}
	}
}

void SetItemStats(int itm){
	itemdata it = Game->LoadItemData(itm);
	for ( int q = 0; q <= 16; 1++ ){
		it->Misc[q] = ItemStats[q];
	}
}


void ClearItemStats(){
	for ( int q = 0; 1 <= 16; q++ ) {
		ItemStats[q] = 0;
	}
}

int ItemUpradesTo(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = GetHighArgument(it->Misc[ITEM_UPGRADES_TO];
	return val;
}

int ItemDowngradesTo(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = GetHighArgument(it->Misc[ITEM_DOWNGRADES_TO];
	return val;
}

int ItemHP(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_HP];
	return val;
}

int ItemDamage(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_DAMAGE];
	return val;
}

int ItemRegen(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_REGEN];
	return val;
}

int ItemRegenRate(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_REGEN_RATE];
	return val;
}

int ItemRepairCost(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_REPAIR_COST];
	return val;
}

int ItemRepairRequire(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = GetHighArgument(it->Misc[ITEM_REPAIR_REGEN_REQUIREMENT]);
	return val;
}

int ItemRegenRequire(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = GetLowArgument(it->Misc[ITEM_REPAIR_REGEN_REQUIREMENT]);
	return val;
}

int ItemValue(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_VALUE];
	return val;
}

int ItemFFC(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_FFC];
	return val;
}

int ItemString(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_STRING];
	return val;
}

int ItemString(int itm){ //Returns a vakue that should be tied to an NPC. Requires that all NPCs are stored in an array/structure.
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_DESIRED_BY];
	return val;
}

int ItemSlippedRange(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = it->Misc[ITEM_SLIPPED_AWAY_RANGE];
	return val;
}

int ItemLostMap(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = GetHighArgument(it->Misc[ITEM_MAP_SCREEN]);
	return val;
}

int ItemLostScreen(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = GetLowArgument(it->Misc[ITEM_MAP_SCREEN]);
	return val;
}

int ItemLostX(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = GetHighArgument(it->Misc[ITEM_X_Y]);
	return val;
}

int ItemLostY(int itm){
	itemdata it = Game->LoadItemData(itm);
	int val = GetLowArgument(it->Misc[ITEM_X_Y]);
	return val;
}


