const int FFC_WEATHER = 0; //Set this to FFC slot of your weather FFC.
bool isRaining = false;

global script active {
	void run(){
		while(true){
			if ( isRaining && !RainEffects ){
				RunFFCScript(FFC_WEATHER); //We want this before waitdraw.
			}
			
			///Pre-Waitdraw commands.
			
			Waitdraw();
			
			///Post-Waitdraw() commands.
			
			Waitframe();
		}
	}
}

bool RainEffects(){
	return FFCRunning(FFC_WEATHER);
}


bool FFCRunning(int ffcslot) {
	if ( FindFFCRunning(ffcslot) == 0 ){
		return false;
	}
	else {
		return true;
	}
}
		