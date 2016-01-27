ffc script FlashEnemy{
	void run(){
		for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
		
180 3 seconds
			1 second = 60
			30 per flash
			flash at 180 & 180 = 0
			150 
			120
			90
			60
			30
			
			const int ENEM_FLASH_1 = 180;
const int ENEM_FLASH_2 = 150;
const int ENEM_FLASH_3 = 120;
const int ENEM_FLASH_4 = 90; 
const int ENEM_FLASH_5 = 60; 
const int ENEM_FLASH_6 = 30; 

void FlashEnemyWhenHit(npc n) {
	if ( ENEMIES_FLASH_WHEN_HIT && n->Misc[ENEM_INV_FRAMES] > 0 ) {
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_1 ) {
			if ( n->CSet == 14 ) n->BossPal = ENEM_BPAL_FLASH;
			else n->CSet = ENEM_CSET_FLASH;
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_2 ) {
			if ( n->CSet == 14 ) n->BossPal = n->Misc[ENEM_ORIG_PAL];
			else n->CSet = n->Misc[ENEM_ORIG_PAL];
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_3 ) {
			if ( n->CSet == 14 ) n->BossPal = ENEM_BPAL_FLASH;
			else n->CSet = ENEM_CSET_FLASH;
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_4 ) {
			if ( n->CSet == 14 ) n->BossPal = n->Misc[ENEM_ORIG_PAL];
			else n->CSet = n->Misc[ENEM_ORIG_PAL];
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_5 ) {
			if ( n->CSet == 14 ) n->BossPal = ENEM_BPAL_FLASH;
			else n->CSet = ENEM_CSET_FLASH;
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_6 ) {
			if ( n->CSet == 14 ) n->BossPal = n->Misc[ENEM_ORIG_PAL];
			else n->CSet = n->Misc[ENEM_ORIG_PAL];
		}
	}
	if ( ENEMIES_FLICKER_WHEN_HIT && n->Misc[ENEM_INV_FRAMES] > 0 ) {
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_1 ) {
			n->OriginalTile = ENEM_BLANK_TILE;
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_2 ) {
			n->OriginalTIle = n->Misc[ENEM_ORIG_PAL];
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_3 ) {
			n->OriginalTile = ENEM_BLANK_TILE;
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_4 ) {
			n->OriginalTIle = n->Misc[ENEM_ORIG_PAL];
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_5 ) {
			n->OriginalTile = ENEM_BLANK_TILE;
		}
		if ( n->Misc[ENEM_INV_FRAMES] == ENEM_FLASH_6 ) {
			n->OriginalTIle = n->Misc[ENEM_ORIG_PAL];
		}
	}
}

			
			
void FlashEnemy(npc n) {
	if ( ENEMIES_FLASH_WHEN_HIT ) {
	if ( Floor(n->Misc[ENEM_INV_FRAMES]) % 20 !=0 && GetLowValue(n->Misc[ENEM_INV_FRAMES]) != 0 ) {
		n->Misc[ENEM_INV_FRAMES] + .0030;
		if ( n->CSet == 14 ) n->BossPal = ENEM_BPAL_FLASH;
		else n->CSet = ENEM_CSET_FLASH;
	}
	
	if ( 