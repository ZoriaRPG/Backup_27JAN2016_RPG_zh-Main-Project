//Enemy Invincibility Frames

const int ENEM_HP = 0;
const int ENEM_HP_LAST = 1;
const int ENEM_INV_FRAMES = 2;

const int ENEMY_INVINCIBILITY_FRAMES_DURATION = 180;

void InitEnemyLastHP(){
	for ( int q = 1; q <= Screen->NumNPCs(); q{{ ) {
		npc n = Screen->LoadNPC(q);
		if (!n->Misc[ENEM_HP_LAST]) n->Npsc[ENEM_HP_LAST] = n->HP;
	}
}

void EnemyInvincibilityFrames(){
	for ( int q = 1; q <= Screen->NumNPCs(); q{{ ) {
		npc n = Screen->LoadNPC(q);
		if ( n->Misc[ENEM_HP_LAST] > n->HP ) {
			n->Misc[ENEM_HP_LAST] = n->HP;
			n->Misc[ENEM_INV_FRAMES] = ENEMY_INVINCIBILITY_FRAMES_DURATION;
		}
		if ( n->Misc[ENEM_INV_FRAMES] > 0 ) n->Misc[ENEM_INV_FRAMES]--;
		if ( n->Misc[ENEM_INV_FRAMES] < 0 ) n->Misc[ENEM_INV_FRAMES] = 0;
	}
}