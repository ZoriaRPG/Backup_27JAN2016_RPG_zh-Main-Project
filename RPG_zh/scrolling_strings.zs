void ScrollingStrings(){
		
	int string1[] = "'Episode ( 2.23606 ^ 2 ): Revenge of The Crows'";
	int string2[] = "A long time, or maybe five years ago, in a game far away...";
	int string3[]="The great Hyrulian Empire was at war. People suffer through strife, ";
	int string4[]="in a vain attempt at gouging out their own eyes to win even a slight ";
	int string5[]="hope of victory. The wise king defeated a plan by a band of seven wicked ";
	int string6[]="maidens, and an evil wizard, to take control of his great land, of ";
	int string7[]="perplexing geographical anomalies. ";
	int string8[]="                                                  ";	
	int string9[]="Despite this, one daring rebel, TeamUDF climbed the Parallel Tower, not once, ";
	int string10[]="not twice, but at least 2+1 times.";
	int string11[]="                                                 ";	
	int string12[]="On his first climb, armed only with a green tunic that looks more like a dress";
	int string13[]="than menswear, he managed to reach the top floor, bypassing a not-so-hard";
	int string14[]="optional puzzle; and engages in epic battles, only to be defeated by a door";
	int string15[]="that opened one way. The mirror here, he did find, but the Kokiri Emerald,"; 
	int string16[]="'not here' it was...";
	int string17[]="                                                  ";	
	int string18[]="Forsaking the Maaaaster Swoooord, the hero raced through dungeons, labyrinths,";
	int string19[]="and teleporter mazes. He plumbed the depths of Nabooru's Holes, cheated his";
	int string20[]="own Impa's Ways through a game-ending glitch, and fought some 'very mean crows'...";
	int string21[]="                                                  ";
	int string22[]="But unbeknownst to this valiant hero, the crows have *their own* secret plan!"; 
	int string23[]="                                                  ";
	int string24[]="Far atop Mount Doom, err, Death Mountain, in fiery lavafalls, they plant their";
	int string25[]="feathers to lure unwary travelers who wish to jump like pogo sticks, to a fiery";
	int string26[]="death; but this, eeeeven this, is no match for the strength of the Maaaster Swooord;";
	int string27[]="that we totally never needed; or the bow, that would be nice to have about now";
	int string28[]="(to not get a piece of heart from that thieving, swindling archery game).";
	int string29[]="                                                  ";
	int string30[]="Thus, to carry out their vile plan of revenge, the crows have secretly stolen";
	int string31[]="something great, something powerful. They have taken...";

	//10 second pause to black, then:

	int string32[]"That's right, they took *that*! Mmmm, hmm. You all saw it.";
	int string33[]="                                                  ";
	int string34[]="Now, it's up to our hero to hunt them down, and keep score of the headcount, as";
	int string35[]="those crows are back, and meaner than ever before!";

	int stringsOne[] = {string1, string2, string3, string4, string5, string6, string7, string8, string9, string10,
				string11, string12, string13, string14. string15. string16. string17, string18, string19, string20, 
				string21, string22, string23, string24, string25, string26, string27, string28, string29, string30, string31};
	int stringsTwo[] = {string32, string33, string34, string35};
				
				
	for(int y = SCREEN_HEIGHT; y > -16; y--){
	    for(int i = 0; i <= 31; i++){
		    for ( int size = 20; size > 0; size --) { //Size shoulkd decrease as Y decreases. 
		Screen->DrawString(x, y+(i*16), stringsOne[i], ...);
	    }
	    for ( int q = 600; q >=0; q-- ){
		    Waitframe();
	    }
	    for ( int r = 0; r <= 3; r++ ) {
		    Screen->DrawString(x, y+(i*16), stringsTwo[i], ...);
	    }
	}
	
	void DrawString( int layer, int x, int y, int font,int color, int background_color,int format, int[] ptr, int opacity );
