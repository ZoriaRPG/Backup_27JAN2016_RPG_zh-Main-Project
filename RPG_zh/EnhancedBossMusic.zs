/**
	* Play the specified enhanced music if it's available. If the music
	* cannot be played, the current music will continue. The music will
	* revert to normal upon leaving the screen.
	* Returns true if the music file was loaded successfully.
	* The filename cannot be more than 255 characters. If the music format
	* does not support multiple tracks, the track argument will be ignored.
	*/
	bool PlayEnhancedMusic(int filename[], int track);
	
	/**
	* Load the filename of the given DMap's enhanced music into buf.
	* buf should be at least 256 elements in size.
	*/
	void GetDMapMusicFilename(int dmap, int buf[]);
	
	/**
	* Returns the given DMap's enhanced music track. This is valid but
	* meaningless if the music format doesn't support multiple tracks.
	*/
	int GetDMapMusicTrack(int dmap);


ffc script BossMusic{
	void run(int midiNumber, int reg, int dur, int musicType, int musicBoss, int trkBoss, int musicVictory, int trkVictory){
		int curScreen = Game->GetCurScreen();
		int curDMAP = Game->GetCurDMap();
		int curDmap = Game->GetCurDMap();
		int dat = Game->GetScreenD(curScreen,reg);
		int stdMIDI = DMapMIDI[curDMAP];
		
		int dmapMusicBuffer[512]="";
		Game->GetDMapMusicFilename(curDMAP, dmapMusicBuffer);
		
		int dmapTrack = GetDMapMusicTrack(curDMAP);
		int mp3[]=".mp3";
		int vgm[]=".vgm";
		int nsf[]=".nsf";
		int music_buffer[7]=""; //two-digit number, plus four-digit extension, plus NULL.
		
		
		int strBoss[2]=""; //The two digit value of musicBoss arg.
		int strVictory[2]=""; //The two digit value of musicVictory is stored here.
		itoa(int strBoss, musicBoss); //Copy the value of arg musicBoss into string strBoss.	
		strncpy(music_buffer, strBoss, 2); //Copy filename (two-digit number) to buffer.
		if ( musicType == 0 ) strcat(music_buffer, mp3); //Append datatype to buffer.
		else if ( musicType == 1 ) strcat(music_buffer, vgm); //Append datatype to buffer.
		else if ( musicType == 2 ) strcat(music_buffer, nsf); //Append datatype to buffer.
		///Other formats.
		
		
		int bossMusic[]=" "; //Must read value from enhBoss, append .mp3 to it, and 
		if ( dat == 0 ) {
			
			PlayEnhancedMusic(int music_buffer, int trkBoss);
			if ( ! PlayEnhancedMusic(int music_buffer, int trkBoss) ) {
				Game->PlayMIDI(midiNumber); //Play MIDI if enhanced music is not available. 
			}
		}
		
		while(true){
			dat = Game->GetScreenD(curScreen,reg);
			if ( dat > 0 ) {
				if ( dur > 0 ) {
					
					itoa(int strVictory, musicVitory); //Copy the value of arg musicVictory into string strVictory.
					strncpy(music_buffer, strVictory, 2); //Copy filename (two-digit number) to buffer.
					if ( musicType == 0 ) strcat(music_buffer, mp3); //Append datatype to buffer.
					else if ( musicType == 1 ) strcat(music_buffer, vgm); //Append datatype to buffer.
					else if ( musicType == 2 ) strcat(music_buffer, nsf); //Append datatype to buffer.
					///Other formats.
					PlayEnhancedMusic(int music_buffer, int trkVictory);
					if ( ! PlayEnhancedMusic(int music_buffer, int trkVictory) ) Game->PlayMIDI(MIDI_DEFEATBOSS);
					for ( int q = 0; q <= dur, q++ ) {
						Waitframe(); //Pause for duration of victory music. 
					}
				}
				
				
				
				PlayEnhancedMusic(music_buffer, dmapTrack);
				if ( ! PlayEnhancedMusic(music_buffer, dmapTrack) ) {
					Game->PlayMIDI(stdMIDI);
				}
			}
			Waitframe();
		}
	}
}
