//ZC Version Detecting
//v0.4

float Version[4]={250,0,0,0}; //Assume 2.50.0 first.
const int ZC_VERSION = 0; //Index 0, to hold the version.
const int DETECT_250_1_PASS1 = 1; //Holds 2.50.1 check passes. 
const int DETECT_250_1_PASS2 = 2; //...
const int DETECT_2_50_2 = 4; //Detect 2.50
const int DETECT2_50_2_SCREEN_HAS_SCROLLED = 3; //


const int DETECT_250_1_WEAPON_INDEX = 15; //The Misc[] index to check for the 2.50.1 validation. 
const int DETECT_250_1_WEAPON_ARB_VAL = 1023.9187; //A sufficiently arbitrary value to store in the index. 



//Check for 2.50.1

//Run before Waitdraw();
void Detect250_1_Phase1(){
	if ( !Version[DETECT_250_1_PASS1] ) {
		eweapon e; //Make an eweapon offscreen...
		e->X = -32;
		e->Y = -32;
		e->Misc[DETECT_250_1_WEAPON_INDEX] = DETECT_250_1_WEAPON_ARB_VAL; //Set an index so that we can look for it later.
		e->CollDetection = false; //Turn off its CollDetection.
		Version[DETECT_250_1_PASS1] = 1; //Mark that pass 1 is complete. 
		Waitframe(); //Wait one frame, to check if the pointer is removed. 
	}
}

//Run before Waitdraw(), before Detect250_2();
void Detect250_1_Phase2(){
	bool detected250;
	if ( Version[DETECT_250_1_PASS1] && !Version[DETECT_250_1_PASS2] ) { //Start pass 2.
		for ( int q = 1; q <= Screen->NumEWeapons(); q++ ) { //Look for that eweapon.
			eweapon e = Screen->LoadEWeapon(q);
			if ( e->Misc[DETECT_250_1_WEAPON_INDEX] == DETECT_250_1_WEAPON_ARB_VAL ) { //by finding its index with our arbitrary value...
				detected250 = true; //If it still exists after that one Waitframe, then it is 2.50.2, as it would have been removed. 
			}
		}
		Version[DETECT_250_1_PASS2] = 1; //Mark that we completed this pass, so that we never check again.
		if ( !detected250 ) Version[ZC_VERSION] = 250.1; //If the weapon was not there, we didn't detect 2.50, so we must be using 2.50.1, or 2.50.2 with thie rule to remove them enabled.
	}
}

//Then check for 2.50.2

//Run ONE INSTRUCTION before Waitdraw();
//Note that this will only work after the screen has scrolled, at least one time in a game.  
void Detect250_2(){
	if ( !Version[DETECT2_50_2_SCREEN_HAS_SCROLLED] ) {
		Version[DETECT2_50_2_SCREEN_HAS_SCROLLED] = 1;
		if ( Link->Action==LA_SCROLLING && Version[ZC_VERSION] < 250.2 ) Version[ZC_VERSION] = 250.2;
	}
}
	


//Draw an inverted circle (fill whole screen except circle)
void InvertedCircle(int bitmapID, int layer, int x, int y, int radius, int scale, int fillcolor){
	Screen->SetRenderTarget(bitmapID);     //Set the render target to the bitmap.
	Screen->Rectangle(layer, 0, 0, 256, 176, fillcolor, 1, 0, 0, 0, true, 128); //Cover the screen
	Screen->Circle(layer, x, y, radius, 0, scale, 0, 0, 0, true, 128); //Draw a transparent circle.
	Screen->SetRenderTarget(RT_SCREEN); //Set the render target back to the screen.
	if ( Version[ZC_VERSION] < 250.2 ) Screen->DrawBitmap(layer, bitmapID, 0, 0, 256, 176, 0, 56, 256, 176, 0, true); //Draw the bitmap for 2.50.0/1
	else Screen->DrawBitmap(layer, bitmapID, 0, 0, 256, 176, 0, 0, 256, 176, 0, true); //Draw the bitmap for 2.50.2
}

global script CheckVersion{
	void run(){
		while(true){
			Detect250_1_Phase1();
			Detect250_1_Phase2();
			Detect250_2();
			Waitdraw();
			if ( Link->PressEx2 ) {
				TraceNL();
				Trace(Version[ZC_VERSION]);
			}
			Waitframe();
		}
	}
}