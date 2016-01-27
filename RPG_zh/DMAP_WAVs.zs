//v0.2

int CurrentDMAP;
bool PlayingDMAP_WAV;
int DMAP_WAV_Runtime[512]; //Set runtime in frames.

int WAV_Timer;

float WAV_Vars[10]; //Array to hold WAV-related things.


const int CURRENT_DMAP = 0;
const int PLAYING_DMAP_WAV = 1;
const int WAV_TIMER = 2;

int DMAP_WAVs[512]={70};

void SetDMAP(){
	int curDMAP = Game->GetCurDMap();
	CurrentDMAP = curDMAP;
}

void UpdateDMAP(){
	int curDMAP = Game->GetCurDMap();
	if ( CurrentDMAP != curDMAP ) {
		PlayingDMAP_WAV = false;
		CurrentDMAP = curDMAP;
	}
}

void PlayWAV(int WAVsArray, int WAV_TimersArray){
	if ( !PlayingDMAP_WAV ) {
		if ( Wav_Timer == 0 ) {
			WAV_Timer = WAV_TimersArray[CurrentDMAP];
			Game->PlaySound(WAVsArray[CurrentDMAP];
		}
		PlayingDMAP_WAV = true;
	}
	if ( WAV_Timer > 0 ) {
		WAV_Timer--;
	}
	else if ( WAV_TIMER <=0 ) {
		WAV_Timer = WAV_TimersArray[CurrentDMAP];
	}
}

//Run before Waitdraw();
void DMAP_WAVs(int WAVsArray, int WAV_TimersArray){
	UpdateDMAP();
	PlayWAV(WAVsArray,WAV_TimersArray);
}

void MapMusic(int list){
	
}

const int SFX_ENEMY_HURT = 0;
const int SFX_ENEMY_DIES = 0;

void FixHitOrDieSOund(){
	for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
		npc n = Game->LoadNPC(q);
		for ( int w = 1; w <= Screen->NumLWeapons(); w++ ) {
			lweapon l = Screen->LoadLweapon(w);
			if ( Collision(l,n) {
				if ( n->NP <=0 ) {
					Game->PlaySound(SFX_ENEMY_HURT);
				}
				//Load enemy defs. 
				//If enemy blocked, ignored, or otherwise deflected attack
				//do nothing.
				else {
					Game->PlaySound(SFX_ENEMY_HURT);
				}
			}
		}
	}
}