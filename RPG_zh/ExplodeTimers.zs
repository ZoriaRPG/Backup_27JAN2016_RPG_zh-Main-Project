int ExplodeTimers[2];

const int EXPLODE_COUNTDOWN = 0;
const int NUM_EXPLOSIONS = 1;

const int EXPLODE_X = 2;
const int EXPLODE_Y = 3;

const int EXPLODE_DUR_BETWEEN_BLASTS = 80;

if ( ExplodeTimers[NUM_EXPLOSIONS] > 0 ) {
	if ExplodeTimers[EXPLODE_COUNTDOWN] > 0 ) {
		ExplodeTimers[EXPLODE_COUNTDOWN]--;
	} 
	else if ( ExplodeTimers[EXPLODE_COUNTDOWN] == 0 ) {
		