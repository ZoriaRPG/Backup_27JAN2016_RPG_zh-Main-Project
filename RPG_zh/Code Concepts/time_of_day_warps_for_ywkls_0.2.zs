 //Array to hold DMap sets
 TS_DMaps[13] = {	0, 
			4,32,71,75,
			79, 83,87,91,
			95,101,105,109};
     
//onstsnts for DMap set IDs.
const int MAPSET_1 = 0;
const int MAPSET_2 = 4;
const int MAPSET_3 = 32;
const int MAPSET_4 = 71;
const int MAPSET_5 = 75;
const int MAPSET_6 = 79;
const int MAPSET_7 = 83;
const int MAPSET_8 = 87;
const int MAPSET_9 = 91;
const int MAPSET_10 = 95;
const int MAPSET_11 = 101;
const int MAPSET_12 = 105;
const int MAPSET_13 = 109;
			


//Warps link to the proper dmap. Call as DoWarp(Link->Dir)
void DoWarp(int linkdir){
	int mapset;
	int warpMaps[]={	0,1,2,3,
				4,5,6,7,
				32,33,34,35,
				71,72,73,74,
				75,76,77,78,
				79,80,81,82,
				83,84,85,86,
				87,88,89,90,
				91,92,93,94,
				95,96,97,98,
				101,102,103,104,
				105,106,107,108,
				109,110,11,112 };
				
		int curmap = Game->GetCurDMap();
				
		if ( curmap >=0 && curmap <= 3 ) mapset = MAPSET_1;
		if ( curmap >=4 && curmap <= 7 ) mapset = MAPSET_2;
		if ( curmap >=32 && curmap <= 35 ) mapset = MAPSET_3;
		if ( curmap >=71 && curmap <= 74 ) mapset = MAPSET_4;
		if ( curmap >=75 && curmap <= 78 ) mapset = MAPSET_5;
		if ( curmap >=79 && curmap <= 82 ) mapset = MAPSET_6;
		if ( curmap >=83 && curmap <= 86 ) mapset = MAPSET_7;
		if ( curmap >=87 && curmap <= 90 ) mapset = MAPSET_8;
		if ( curmap >=91 && curmap <= 94 ) mapset = MAPSET_9;
		if ( curmap >=95 && curmap <= 98 ) mapset = MAPSET_10;
		if ( curmap >=101 && curmap <= 104 ) mapset = MAPSET_11;
		if ( curmap >=105 && curmap <= 108 ) mapset = MAPSET_12;
		if ( curmap >=109 && curmap <= 112 ) mapset = MAPSET_13;
				
		Link->PitWarp(warpMaps[mapset+linkdir]), Game->GetCurScreen());
}
	
//Harp of Ages script.
item script HarpOfAges{
	vour run(int sfx){
		Game->PlaySound(sfx);
		DoWarp(Link->Dir);
	}
}