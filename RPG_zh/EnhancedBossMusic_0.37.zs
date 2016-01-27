const int MIDI_DEFEATBOSS = 0; //Set to default midi to play for Victory Music.
				//ZC will use this if enhanced Victory music is not available.

//D0: MIDI number to default to for this boss, if no enhanced music is available.
//D1: Screen->D reg to set/check. 
//D2: Sets file type for both enhanced music tracks. Split argument, high and low at decimal point:
//	xxx##.xxxx -> Type for Boss Music file
//	xxxxx.xx## -> Type for Victory Music file
//D3: The file number, and track number, for Boss Music. Split arg, high and low at decimal point:
//	#####.xxxx -> The file number.
//	xxxxx.#### -> The track number to play.
//D4: The file number, and track number, for Victory Music. Split arg, high and low at decimal point:
//	#####.xxxx -> The file number.
//	xxxxx.#### -> The track number to play.
//D5: The point in the track to pause, then loop.
//	If set to 0, the track with loop only when it ends.
//	If set to greater than 0, the track will loop befor eit ends, as follows:
//	To loop by setting minutes, and seconds, set up minutes as the integer portion of the arg, and seconds as the decimal portion:
//		e.g. 00005.2600 is 5 mins, 26 seconds. 
//		This works to a fineness of 1/10 second, so 00010.1360 is 10 minutes, 13.6 seconds.
//	If you wish to specify the loop in frames, set the ten-thousands place to '1', and the rest of the value to the number of frames.
//	e.g. 10526.1023 = 5,261,023 frames. 
//	e.g. 10001.3591 = 13,591 frames. 

ffc script BossMusicEnhanced{
	void run(int midiNumber, int reg, int dur, float musicType_musicTypeVictory, float musicBoss_trkBoss, float musicVictory_trkVictory, float loopBossMusic){
		int curScreen = Game->GetCurScreen();
		int curDMAP = Game->GetCurDMap();
		int curDmap = Game->GetCurDMap();
		int dat = Game->GetScreenD(curScreen,reg);
		int stdMIDI = Game->DMapMIDI[curDMAP];
		
		int dmapMusicBuffer[512]=" ";
		Game->GetDMapMusicFilename(curDMAP, dmapMusicBuffer);
		
		int musicType = _GetHighArgument(musicType_musicTypeVictory); //xxx##.xxxx
		int musicType_Victory = _GetLowArgument(musicType_musicTypeVictory); //xxxxx.xx##
		
		int musicBoss = _GetHighArgument(musicBoss_trkBoss); //#####.xxxx
		int trkBoss = _GetLowArgument(musicBoss_trkBoss); //xxxxx.####
		
		int musicVictory = _GetHighArgument(musicVictory_trkVictory);
		int trkVictory = _GetLowArgument(musicVictory_trkVictory); //xxxxx.####
		
		int dmapTrack = Game->GetDMapMusicTrack(curDMAP);
		int mp3[]=".mp3";
		int vgm[]=".vgm";
		int nsf[]=".nsf";
		int ogg[]=".ogg";
		int s3m[]=".s3m";
		int mod[]=".mod";
		int spc[]=".spc";
		int gym[]=".gym";
		int gbs[]=".gbs";
		int it_format[]=".it";
		int xm[]=".xm";
		
		int boss_buffer[7]=" "; //two-digit number, plus four-digit extension, plus NULL.
		int victory_buffer[7]=" "; //Buffer for Victory Music Filename.
		int strBoss[2]=" "; //The two digit value of musicBoss arg.
		int strVictory[2]=" "; //The two digit value of musicVictory is stored here.
		//int bossMusic[]=" "; //Must read value from enhBoss, append .mp3 to it, and 
		
		
		///Set up Boss Music Filename String
		itoa(strBoss, musicBoss); //Copy the value of arg musicBoss into string strBoss.	
		strncpy(boss_buffer, strBoss, 2); //Copy filename (two-digit number) to buffer.
		if ( musicType == 0 ) strcat(boss_buffer, mp3); //Append datatype to buffer (MP3)
		else if ( musicType == 1 ) strcat(boss_buffer, vgm); //Append datatype to buffer ( Video Game Music format)
		else if ( musicType == 2 ) strcat(boss_buffer, nsf); //Append datatype to buffer ( NES Sound File ) 
		else if ( musicType == 3 ) strcat(boss_buffer, ogg); //Append datatype to buffer ( The Xiph.org open music format )
		else if ( musicType == 4 ) strcat(boss_buffer, s3m); //Append datatype to buffer ( ScreamTracker 3 module file )
		else if ( musicType == 5 ) strcat(boss_buffer, mod); //Append datatype to buffer ( Tracker Module file ) 
		else if ( musicType == 6 ) strcat(boss_buffer, spc); //Append datatype to buffer ( Super NES / SuFami soound file )
		else if ( musicType == 7 ) strcat(boss_buffer, gym); //Append datatype to buffer ( Genesis / Megadrive sound file )
		else if ( musicType == 8 ) strcat(boss_buffer, gbs); //Append datatype to buffer ( Gameboy sound file )
		else if ( musicType == 9 ) strcat(boss_buffer, it_format); //Append datatype to buffer ( Impulse Tracker audio file )
		else if ( musicType == 10 ) strcat(boss_buffer, xm); //Append datatype to buffer ( Triton FastTracker 2 'Extended Module' format }
		///Other formats.
		
		//Set up Victory Music Filename String
		itoa(strVictory, musicVictory); //Copy the value of arg musicVictory into string strVictory.
		strncpy(victory_buffer, strVictory, 2); //Copy filename (two-digit number) to buffer.
		if ( musicType_Victory == 0 ) strcat(boss_buffer, mp3); //Append datatype to buffer (MP3)
		else if ( musicType_Victory == 1 ) strcat(boss_buffer, vgm); //Append datatype to buffer ( Video Game Music format)
		else if ( musicType_Victory == 2 ) strcat(boss_buffer, nsf); //Append datatype to buffer ( NES Sound File ) 
		else if ( musicType_Victory == 3 ) strcat(boss_buffer, ogg); //Append datatype to buffer ( The Xiph.org open music format )
		else if ( musicType_Victory == 4 ) strcat(boss_buffer, s3m); //Append datatype to buffer ( ScreamTracker 3 module file )
		else if ( musicType_Victory == 5 ) strcat(boss_buffer, mod); //Append datatype to buffer ( Tracker Module file ) 
		else if ( musicType_Victory == 6 ) strcat(boss_buffer, spc); //Append datatype to buffer ( Super NES / SuFami soound file )
		else if ( musicType_Victory == 7 ) strcat(boss_buffer, gym); //Append datatype to buffer ( Genesis / Megadrive sound file )
		else if ( musicType_Victory == 8 ) strcat(boss_buffer, gbs); //Append datatype to buffer ( Gameboy sound file )
		else if ( musicType_Victory == 9 ) strcat(boss_buffer, it_format); //Append datatype to buffer ( Impulse Tracker audio file )
		else if ( musicType_Victory == 10 ) strcat(boss_buffer, xm); //Append datatype to buffer ( Triton FastTracker 2 'Extended Module' format }
		///Other formats.
		
		bool playingMusic;
		
		int LoopClockMethod = GetDigit(loopBossMusic, 4);
		//Convert mins and seconds.
		
		
		int BossMusicDuration;
		if ( LoopClockMethod == 0 ) {
			BossMusicDuration = MusicFrames(loopBossMusic); //Convert loopBossMusic into time. 
		}
		if ( LoopClockMethod > 0 ) {
			BossMusicDuration = _GetPartialArg(loopBossMusic,3,8); //Use the full value of loopBossMusic as frame in int.
		}
		
		if ( dat == 0 && loopBossMusic == 0 ) {
			
			Game->PlayEnhancedMusic(boss_buffer, trkBoss);
			
			if ( ! Game->PlayEnhancedMusic(boss_buffer, trkBoss) ) {
				Game->PlayMIDI(midiNumber); //Play MIDI if enhanced music is not available. 
			}
		}
		
		while(true){
			
			if ( dat == 0 && loopBossMusic > 0 ){

				//set up music loop
				for ( int q = BossMusicDuration; q >=0; q-- ){
					if ( q == BossMusicDuration && dat == 0 ) {
						Game->PlayEnhancedMusic(boss_buffer, trkBoss);
					}
					if ( dat > 0 ) break;
					Waitframe();
				
				}
				//playingMusic = false;
			}
				
			
			
			dat = Game->GetScreenD(curScreen,reg);
			if ( dat > 0 ) {
				if ( dur > 0 ) {
					Game->PlayEnhancedMusic(victory_buffer, trkVictory);
					if ( ! Game->PlayEnhancedMusic(victory_buffer, trkVictory) ) Game->PlayMIDI(MIDI_DEFEATBOSS);
					for ( int q = 0; q <= dur; q++ ) {
						Waitframe(); //Pause for duration of victory music. 
					}
				}
				Game->PlayEnhancedMusic(dmapMusicBuffer, dmapTrack);
				if ( ! Game->PlayEnhancedMusic(dmapMusicBuffer, dmapTrack) ) {
					Game->PlayMIDI(stdMIDI);
				}
			}
			Waitframe();
		}
		
	}
	
	int MusicSeconds(float seconds){
			int music_seconds = _GetLowArgument(seconds);
			return music_seconds * 60;
	}
		
	int MusicMinutes(float mins){
			int music_minutes = _GetHighArgument(mins);
			return music_minutes * 360;
	}
			
	int MusicFrames(float val){
		int mins = MusicMinutes(val);
		int seconds = MusicSeconds(val);
		return mins+seconds;
	}
	
	int _GetRemainderAsInt(int v) {
	    int r = (v - (v << 0)) * 10000;
	    return r;
	}

	// This function breaks up the value of an argument into individual digits. It is combined with the function GetDigit below.


	int _GetDigit(int n, int place){ //GetDigit and related functions by Gleeok
		place = Clamp(place, -4, 4);
		if(place < 0){
			n = _GetRemainderAsInt(n);
			place += 4;
		}

		int r = ((n / Pow(10, place)) % 10) << 0;
		return r;
	}

	int _GetHighArgument(int arg) {
	    return arg >> 0;
	}

	int _GetLowArgument(int arg) {
	    return (arg - (arg >> 0)) * 10000;
	}

	int _GetPartialArg(int arg, int place, int num){
		place = Clamp(place, -4, 4);
		int r;
		int adj = 1;
		for(int i = num-1; i > -1; i--){
			if(place - i < -4) continue;
			r += _GetDigit(arg, place - i) * adj;
			adj *= 10;
		}
		return r;
	}
}