//////////////////////////////////
/// Enemy Invincibility Frames ///
//////////////////////////////////

//Settings for Enemy Invincibility Frames
const int ENEMY_INVINCIBILITY_FRAMES_DURATION = 180;
const int INVINCIBLE_ENEMIES_PHANTOM = 1; //Setting to enable or disable phantoming injured enemies.
const int STORE_ORIGINAL_ENEMY_PALETTE = 1; //Setting to enable storing original enemy palette or cset. 

//You may enable *ONE* of these two rules, to match your quest rule settings. 
//! If one is enabled, the other MUST be disabled. 
const int ENEMIES_FLICKER_WHEN_HIT = 0; //Use the OriginalSprite, and store it instead of CSet or BPal
const int ENEMIES_FLASH_WHEN_HIT = 0; //Use the CSet or BPal to make an enemy flash, when hit. 

//Values For Enemy Invincibility Frames

//n->Misc Indices
const int ENEM_HP_LAST = 1; //n->Mics[] holds last enemy HP. Adjusted when damaged. 
const int ENEM_INV_FRAMES = 2; //n->Misc[] holds the present nth frame of invincibility as a countdown timer. 
const int ENEM_ORIG_PAL = 3; //original CSet or Palette, or OriginalSprite

const int ENEM_BLANK_TILE = 65260; //Set to a tile at the head of a FULL PAGE of BLANK tiles. 
//const int ENEM_FLASH_TIMER = 4;

//Framecount for each enemy flash or flicker.
const int ENEM_FLASH_1 = 180; //Will change on frame 180
const int ENEM_FLASH_2 = 150; //...frame 150
const int ENEM_FLASH_3 = 120;
const int ENEM_FLASH_4 = 90; 
const int ENEM_FLASH_5 = 60; 
const int ENEM_FLASH_6 = 30; //...frame 30

//Cset or BPal to use when flashing
const int ENEM_BPAL_FLASH = 6;
const int ENEM_CSET_FLASH = 6;


//Run before Waitdraw, and before EnemyInvincibilityFrames()
void InitEnemyLastHP(){
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
		npc n = Screen->LoadNPC(q);
		if (!n->Misc[ENEM_HP_LAST] && n->HP > 0) {
			n->Misc[ENEM_HP_LAST] = n->HP;
			if ( STORE_ORIGINAL_ENEMY_PALETTE && !n->Misc[ENEM_ORIG_PAL] ) {
				if ( n->CSet == 14 ) n->Misc[ENEM_ORIG_PAL] = n->BossPal;
				else n->Misc[ENEM_ORIG_PAL] = n->CSet;
			}
			if ( ENEMIES_FLICKER_WHEN_HIT && !n->Misc[ENEM_ORIG_PAL] ) {
				n->Misc[ENEM_ORIG_PAL] = n->OriginalTile;
			}
		}
	}
}

void _InitEnemyLastHP(){
    for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
        npc n = Screen->LoadNPC(q);
        if (!n->Misc[ENEM_HP_LAST] && n->HP > 0) n->Misc[ENEM_HP_LAST] = n->HP;
    }
}

//Run before Waitdraw and before any collision/damage functions that need to read these values. 
void _EnemyInvincibilityFrames(){
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
		npc n = Screen->LoadNPC(q);
		if ( n->Misc[ENEM_HP_LAST] > n->HP ) {
			n->Misc[ENEM_HP_LAST] = n->HP;
			n->Misc[ENEM_INV_FRAMES] = ENEMY_INVINCIBILITY_FRAMES_DURATION;
		}
		if ( n->Misc[ENEM_INV_FRAMES] > 0 ) n->Misc[ENEM_INV_FRAMES]--;
		if ( n->Misc[ENEM_INV_FRAMES] < 0 ) n->Misc[ENEM_INV_FRAMES] = 0;
	}
}

//Run after InitEnemyLastHP, before Waitdraw and before any collision/damage functions that need to read these values. 
void EnemyInvincibilityFrames(){
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
		npc n = Screen->LoadNPC(q);
		if ( n->Misc[ENEM_HP_LAST] > n->HP ) {
			n->Misc[ENEM_HP_LAST] = n->HP;
			n->Misc[ENEM_INV_FRAMES] = ENEMY_INVINCIBILITY_FRAMES_DURATION;
		}
		if ( n->Misc[ENEM_INV_FRAMES] > 0 ) n->Misc[ENEM_INV_FRAMES]--;
		if ( n->Misc[ENEM_INV_FRAMES] < 0 ) n->Misc[ENEM_INV_FRAMES] = 0;
		
		if ( INVINCIBLE_ENEMIES_PHANTOM ) {
			if ( EnemyInvincible(n) && n->DrawStyle != DS_PHANTOM ) n->DrawStyle = DS_PHANTOM;
			if ( !EnemyInvincible(n) && n->DrawStyle == DS_PHANTOM 
				&& !GetNPCMiscFlag(n,NPCM_TRANSLUCENT) && !GetNPCMiscFlag(n,NPCM_FLICKERING) 
				&& !GetNPCMiscFlag(n,NPCM_FLASHING) ) n->DrawStyle = DS_NORMAL;

		}
	}
}



//Run IMMEDIATELY AFTER EnemyInvincibilityFrames() if you have flashing, or flickering settings enabled. 
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

//Returns if an enemy is invincible.
int EnemyInvincible(npc n){
	return n->Misc[ENEM_INV_FRAMES];
}

//Immediately sets, or resets enemy invincibility to on.
void SetEnemyInvincible(npc n) {
	n->Misc[ENEM_INV_FRAMES] = ENEMY_INVINCIBILITY_FRAMES_DURATION;
}

//Immediately disables mock enemy invincibility. 
void SetEnemyNotInvincible(npc n) {
	n->Misc[ENEM_INV_FRAMES] = 0;
}