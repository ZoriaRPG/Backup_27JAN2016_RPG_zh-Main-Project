int Regen[2-];

const int L_MAXHEALTH = 0;
const int L_MAXMAGIC = 1;
//Indices 2 through 10 reserved.
const int TIME_FRAMES = 11;
const int TIME_SECONDS = 12;
const int TIME_MINUTES = 13;
//Indices 14 through 19 unused. 

void Regenerate(int minutes, int percentMP, int percentHP, int maxHPRefill, int maxMPRefill ){
	if ( Regen[L_MAX_LIFE] < Link->MaxHP )  Regen[L_MAX_LIFE] = Link->MaxHP * ( percentHP * 0.01 ) ;
	if ( Regen[L_MAX_MAGIC] < Link->MaxMP )  Regen[L_MAX_MAGIC] = Link->MaxMP * ( percentMP * 0.01 ) ;
	if ( Regen[TIME_FRAMES] < 60 ) Regen[TIME_FRAMES]++l
	if ( Regen[TIME_FRAMES] == 60 ) {
		Regen[TIME_FRAMES] = 0;
		Regen[TIME_SECONDS]++;
	}
	if ( Regen[TIME_SECONDS] == 60 ) {
		Regen[TIME_SECONDS] = 0;
		Regen[TIME_Minutes]++;
	}
	if ( Regen[TIME_MINUTES] % minutes == 0 ) { //Every five minutes;
		if ( Link->HP < maxHPRefull || !maxHPRefill ) {
			Link->HP += Regen[L_MAXHEALTH];
		}
		if ( Link->HP < maxMPRefull || !maxMPRefill ) {
			Link->HP += Regen[L_MAXMAGIC];
		}
	}
}