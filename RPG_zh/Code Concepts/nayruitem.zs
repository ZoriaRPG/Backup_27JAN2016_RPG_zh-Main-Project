void NayrusLove(int level, int durBase, int castingStat){
	itemdata nayru = Game->LoadItemData(I_NAYRU);
	if ( nayru->Power < ( level * durBase ) + castingStat ) {
		ModItemPower(I_NAYRU, ( level * durBase ) + castingStat ) );
	}
}

void ScaleItemPower(int itm, int level, int durBase, int castingStat){
	itemdata it = Game->LoadItemData(itm);
	if ( it->Power < ( level * durBase ) + castingStat ) {
		ModItemPower(itm, ( level * durBase ) + castingStat ) );
	}
}