int Explosions[2048];

SLOT, TIMER, X, Y, ENEMTYPE

const int EXPLOSION_TIMERS = 256;
const int EXPLOSION_X = 512;
const int EXPLOSION_Y = 768;
const int EXPLOSION_ENEMY_TYPE = 1024;
const int EXPLOSION_COUNT = 1280;

int FindFreeExplosionSlot(){
	for ( int q = 0; q <= (SizeOfArray(Explosions) / 8); q++ ) {
		if ( Explosions[q] == 0 ) {
			return q;
		}
	}
	return -1;
}


void RunExplosions(){
	for ( int q = 0; q <= (SizeOfArray(Explosions) / 8); q++ ) {
		if ( Explosions[q] ) //If there is an explosion...
			int fX = Explosions[q+EXPLOSION_X]; //Set up variables to hold X/Y coordinates.
			int fY = Explosions[q+EXPLOSION_Y];
			int enemType = Explosions[q+EXPLOSION_ENEM_TYPE]; 
			bool isBoss;
			bool isMiniBoss;
			bool isFinalBoss;
		
			if ( enemType == ENEM_TYPE_FINAL_BOSS ) {
				isFinalBoss = true;
			}
			if ( enemtype == ENEM_TYPE_BOSS ) {
				isBoss = true;
			}
			if ( enemType == ENEM_TYPE_MIDBOSS ) {
				isMiniBoss = true;
			}
			int numExplosions = Explosions[q+EXPLOSION_COUNT]; 
			//int enemID;
			//int explosionCount = numExplosions;
			eweapon explosion;
			
		
void ClearExplosions(){
	if ( ScreenChanged() ) {
		for ( int q = 0; q <= (SizeOfArray(Explosions); q++ ) {
			Explosions[q] = 0;
		}
	}
}