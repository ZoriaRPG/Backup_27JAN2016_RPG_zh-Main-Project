//Five screens away
//Sets a screen register, if Link is more than five screens away, on all screens for a given DMAP.

//	        [ ]
//	      [][ ][]
//	    [][][ ][][]
//	  [][][][ ][][][]
//	[][][][][s][][][][]
//	  [][][][ ][][][]
//	    [][][ ][][]
//	      [][ ][]
//	        [ ]

//Probably better...

//	        [ ]
//	      [][ ][] 
//	    [][][ ][][]
//	  [][][][s][][][]
//	    [][][ ][][]
//	      [][ ][] 
//	        [ ]
		
//		s = 0x34
//		BASE
//		+0x01
//		+0x02
//		+0x03
//		-0x01
//		-0x02
//		-0x03
//		+0x08
//		-0x08
//		+0x09
//		-0x09
//		-0x10
//		+0x10
//		+0x11
//		-0x11
//		+0x12
//		-0x12
//		+0x19
//		-0x19
//		+0x20
//		-0x20
//		+0x21
//		-0x21
//		+0x30
//		-0x30
		
//int ScreenPlot[25];
//int ScreenPlotMods[25]={0x00, 0x01, 0x02, 0x03, -0x01, -0x02, -0x03, 0x08, -0x08, 0x09, -0x09, 0x10, -0x10, 0x11, -0x11,
//			0x12, -0x12, 0x19, -0x19, 0x20, -0x20, 0x21, -0x21, 0x30, -0x30};

//Combine the two above arrays, into one, and use a oonstant, to shift groups (rows). 
FiveScreensAway[50]={	0,    0,    0,    0,     0,     0,     0,    0,     0,    0,     0,    0,     0,    0,     0,    0,     0,    0,     0,    0,     0,    0,     0,    0,     0,
			0x00, 0x01, 0x02, 0x03, -0x01, -0x02, -0x03, 0x08, -0x08, 0x09, -0x09, 0x10, -0x10, 0x11, -0x11, 0x12, -0x12, 0x19, -0x19, 0x20, -0x20, 0x21, -0x21, 0x30, -0x30};

	
const int PLOT_MODS = 25; //The starting index of the screen plot hex modifiers.
	
//Run every frame before Waitdraw()
//Uses ScreenPlotMods[] to map out the excluded screens into ScreenPlot, every frame. 
void SetScreenPlot(int curScreen){
	for ( int q = 0; q < 25; q++ ) {
		FiveScreensAway[q] += FiveScreensAway[q+PLOT_MODS];
	}
}

//Run every frame before Waitdraw(), after SetScreenPlot()
//Clears the state of a register (reg) to value (val) if the screen isn't part of the exclusion-map.
SetDmapFiveScreens(int reg, float val){
	int exclude;
	int scr;
	bool excluded;
	for ( int q = 0; q < 128; q++ ) {
		scr = q;
		for ( int w = 0; w < 25; q++ ) {
			exclude = FiveScreensAway[w];
			if ( scr == exclude ) excluded = true;
		}
		if ( !excluded && scr >= 0 ) SetScreenD(q,reg,val);
	}
}

//Run before Waitdraw, after SetDmapFiveScreens()
//Clears the state of a register (reg) to value (val)  for an entire DMAP. 
void SetWarpFiveScreens(int reg, int val){
	if ( CurDMAP != LastDMAP ) {
		for ( int q = 0; q < 128; q++ ) SetScreenD(q,reg,val);
	}
}
		



