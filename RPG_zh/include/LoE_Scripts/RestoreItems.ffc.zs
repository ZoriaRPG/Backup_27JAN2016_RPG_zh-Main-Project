// D0: the counter to use. See std_constants.zh.
// D1: The number of items to restore. Use '0' for MAX.
// D2: The ID of the sound effect to play. If set to '0', no sound will play.
// D3: Restore only if the current value of Game->Counter[counterRef] is less than this value.
//	Set to '0' for no minimum. 
// D4: Set to '1' if this script should quit after restoring; or '0' if you want the FFC to work 
//	more than one time. 
//	If set above a valaue of '1', the player can refill a number of times, equal to this value.
ffc script RestoreItems{
     void run(int counterRef, int restoreNumber, int sfx, int onlyUnder, int onlyOnce){
	     bool restore;
	     int restoreCount;
	     int restoredTimes = onlyOnce;
          while(true){
              if(Collision(this) {
		      if ( onlyUnder && Game->Counter[counterRef] < onlyUnder ) restore = true;
		      if ( !onlyUnder ) restore = true;
		      if ( Game->Counter[counterRef] == Game->MaxCounter[counterRef] ) restore = false;
		      
		      if ( restoreNumber == 0 ) restoreCount = Game->MCounter[counterRef];
		      else restoreCount = restoreNumber;
		      
		      if ( restore ) {
			      if ( sfx ) Game->PlaySound(sfx);
			      Game->Counter[counterRef] += restoreCount;
			      if ( onlyOnce ) {
					restoredTimes--;
					if ( restoredTimes == 0 ) {
					      this->Script = 0;
					      this->Data = 0;
					      Quit();
					}
			      }
		      }
		      
              Waitframe(); 
           } 
      } 
}