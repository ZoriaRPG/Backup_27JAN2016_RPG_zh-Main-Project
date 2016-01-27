const int MIDI_DEFEATBOSS = 0;

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
		int ogg[]=".ogg";
		int s3m[]=".s3m";
		int mod[]=".mod";
		int spc[]=".spc";
		int gym[]=".gym";
		int gbs[]=".gbs";
		int it_format[]=".it";
		int xm[]=".xm";
		
		int boss_buffer[7]=""; //two-digit number, plus four-digit extension, plus NULL.
		int victory_buffer[7]=""; //Buffer for Victory Music Filename.
		int strBoss[2]=""; //The two digit value of musicBoss arg.
		int strVictory[2]=""; //The two digit value of musicVictory is stored here.
		//int bossMusic[]=" "; //Must read value from enhBoss, append .mp3 to it, and 
		
		
		///Set up Boss Music Filename String
		itoa(int strBoss, musicBoss); //Copy the value of arg musicBoss into string strBoss.	
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
		itoa(int strVictory, musicVitory); //Copy the value of arg musicVictory into string strVictory.
		strncpy(victory_buffer, strVictory, 2); //Copy filename (two-digit number) to buffer.
		if ( musicType == 0 ) strcat(victory_buffer, mp3); //Append datatype to buffer.
		else if ( musicType == 1 ) strcat(victory_buffer, vgm); //Append datatype to buffer.
		else if ( musicType == 2 ) strcat(victory_buffer, nsf); //Append datatype to buffer.
		///Other formats.
		
		
		if ( dat == 0 ) {
			
			PlayEnhancedMusic(int boss_buffer, int trkBoss);
			if ( ! PlayEnhancedMusic(int boss_buffer, int trkBoss) ) {
				Game->PlayMIDI(midiNumber); //Play MIDI if enhanced music is not available. 
			}
		}
		
		while(true){
			dat = Game->GetScreenD(curScreen,reg);
			if ( dat > 0 ) {
				if ( dur > 0 ) {
					PlayEnhancedMusic(int victory_buffer, int trkVictory);
					if ( ! PlayEnhancedMusic(int victory_buffer, int trkVictory) ) Game->PlayMIDI(MIDI_DEFEATBOSS);
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
