//SwitchHook v0.3
//20-Nov-2015
import "std.zh"
const int CF_SWITCHHOOK = 98; //Script 1
const int SFX_SWITCHHOOK = 100; 
const int FFC_SWITCHSHOT_QUIT_COUNTER = 360; 	//The number of frames a switchshot ffc will continue
						//to run, if there are no hookshot weapons on the screen.

const int SWITCHHOOK_ENEMIES_REQUIRE_SPECIAL_DEFS = 1; 	//Set this to '1' to ensure that only enemies with a specific defence 
							//setting for NPCD_HOOKSHOT will be affected by the switchshot...
							//
							//Setting this to '0' will cause all enemies to be affected by the 
							//switchshot's ability to move objects!
							
const int NPCDT_SWITCHHOOK = 12; 	//If no value is assigned to the item arg D3, we use this value to set the special defence flag
					//needed for the enemy to be affected by the switchshot. Default: NPCDT_IGNORE1 (Ignore if < 1)
					//This allows us to tailor enemies so that they are affected as normal by a hookshot, or are swapped 
					//with Link, or to create switchshot-specific enemies. 
					
//Settings for Combos on Layers
const int SWITCHHOOK_USE_LAYER_0 = 1; //Enable to allow combos on Layer 0.
const int SWITCHHOOK_USE_LAYER_1 = 1; //Enable to allow combos on Layer 1.
const int SWITCHHOOK_USE_LAYER_2 = 1; //Enable to allow combos on Layer 2.

ffc script SwitchHook{
	void run(int comboF, int affectEnemies, int sfx, int npcdt){
		
		//Initial script variables.
		
		int quitCounter; //A countwer to use to end the script prematurely. 
		int layer; //We'll need this to do collision on layers other than 0.
		
		//if ( comboF == 0 ) comboF = CF_SWITCHHOOK; //We no longer need this, but we'll retain it (commented out) for the present. 
		
		//Switchchot combo at the start of the script. 
		int cmbX; //X position.
		int cmbY; //Y position.
		int cmbD; //Combo Data
		int cmbS; //Combo Solidity
		
		//Combo where Link is standing at the start of the script.
		int cmbLX; //X position.
		int cmbLY; //Y position
		int cmbLD; //Data
		int cmbLS; //Solidity
		int cmbL; //Screen index (of 176)
		
		//Layer 1 Combos
		//int cmb1X;
		//int cmb1Y;
		//int cmb1D;
		//int cmb1S;
		//int cmb1LX; //X position.
		//int cmb1LY; //Y position
		//int cmb1LD; //Data
		//int cmb1LS; //Solidity
		//int cmb1L; //Screen index (of 176)
		
		//Layer 2 Combos
		//int cmb2X;
		//int cmb2Y;
		//int cmb2D;
		//int cmb2S;
		//int cmb2LX; //X position.
		//int cmb2LY; //Y position
		//int cmb2LD; //Data
		//int cmb2LS; //Solidity
		//int cmb2L; //Screen index (of 176)
		
		//Link positions.
		int lx;
		int ly;
		
		bool switching; //Enabled if there is a matching combo.
		
		while( true ) {
			
			if ( Screen->NumLWeapons() ) { //If there are no weapons on the screen, ignore the pass. 
				//if ( NumLWeaponsOf(LW_HOOKSHOT) ) TraceS(str);
				
				for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) { 	//Pass through the lweapons on the screen...
					lweapon l = Screen->LoadLWeapon(q); 		//...loading each one and...
					if ( l->ID == LW_HOOKSHOT ){			//if a hookshot lweapon is present...
				
											//Check for switchshot combos...
						
						for ( int q = 0; q < 176; q++ ) { 	//Pass through the screen combos to find a match...
							int cmb = Screen->ComboI[q]; 	//loading them along the way...
							
							int cmb1 = GetLayerComboI(1,q); 
							int cmb2 = GetLayerComboI(2,q);
							
								//If D0 is assigned a value above 0, check to see if it matches
								//that combo inherent flag, otherwise check if it matches the one
								//assigned to the constant CF_SWITCHSHOT.
							
							if ( 
									( SWITCHHOOK_USE_LAYER_0 && comboF && cmb == comboF ) 		//Layer 0
								|| 	( SWITCHHOOK_USE_LAYER_0 !comboF && cmb == CF_SWITCHHOOK ) 	//Layer 0
							) {
								switching = true; 	//We will be switching...
								layer = 0;		//...on layer 0...
							}
								
							if (
									( SWITCHHOOK_USE_LAYER_1 && comboF && cmb1 == comboF ) 		//Layer 1
								|| 	( SWITCHHOOK_USE_LAYER_1 !comboF && cmb1 == CF_SWITCHHOOK ) 	//Layer 1
							) {
								switching = true;	//We will be switching...
								layer = 1;		//...on layer 1...
							}
							
							if (
									( SWITCHHOOK_USE_LAYER_2 && comboF && cmb2 == comboF ) //Layer 2
								|| 	( SWITCHHOOK_USE_LAYER_2 !comboF && cmb2 == CF_SWITCHHOOK ) //Layer 2
							
							) { 	
								switching = true;	//We will be switching...
								layer = 2;		//...on layer 2...
							}
								
								//If it does match, work based on the layer....							
							if ( switching && layer == 0 ) {
								
								if ( ComboCollision(q,l) ) {	//and there is collision between that combo and the hookshot...
									
								//!We need to check every layer...too..for combos on layers higher than 0. (?)
									l->DeadState = WDS_DEAD;	//Kill the hookshot.
									
									if ( sfx ) Game->PlaySound(sfx); //Play the sound defined in the item script,
									if ( !sfx && SFX_SWITCHHOOK ) Game->PlaySound(SFX_SWITCHHOOK);  //or the constant if the item editor arg isn't set.
										
									//Store Link's starting position.
									lx = CenterLinkX();
									ly = CenterLinkY();
										
									//Store the switchshot combo to move.
									cmbX = ComboX(q);	//The combo number for the for loop pass...
									cmbY = ComboY(q);	//... X and Y
									cmbD = Screen->ComboD[q]; //The original data of the switchhook combo.
									cmbS = Screen->ComboS[q]; //The original solidity of the switchshot combo. 
									
									//Store the combo datum for the cumbo that Link is on. 
									
									cmbLD = Screen->ComboD[ComboAt(Link->X, Link->Y)]; //The combo under Link.
									cmbLS = Screen->ComboS[ComboAt(Link->X, Link->Y)]; //The solidity of the combo under Link.
									cmbLX = GridX(lx); //The X position
									cmbLY = GridY(ly); //The Y position
									cmbL = ComboAt(cmbLX,cmbLY); //The screen index for that combo (Nth of 176).
										
										
									//Change the combo where Link WAS, to the switchshot combo.
									Screen->ComboD[cmbL] = cmbD; //Set its data
									Screen->ComboS[cmbL] = cmbS; //and solidity.
									
									//Move Link to where the old switchshot combo that we moved, WAS.
									Link->X = cmbX;
									Link->Y = cmbY;
									
										
									//Move the switchshot combo to where LINK was before he moved...
									Screen->ComboD[q] = cmbLD; //Set the combo data
									Screen->ComboS[q] = cmbLS; //and the solidity.
									
									this->Script = 0; //Free the FFC for later use.
									this->Data = 0;
									Quit();
								}
							}
							
							if ( switching && layer > 0 ) {
								
								if ( ComboCollision(q,l) ) {	//and there is collision between that combo and the hookshot...
									
								//!We need to check every layer...too..for combos on layers higher than 0. (?)
									l->DeadState = WDS_DEAD;	//Kill the hookshot.
									
									if ( sfx ) Game->PlaySound(sfx); //Play the sound defined in the item script,
									if ( !sfx && SFX_SWITCHHOOK ) Game->PlaySound(SFX_SWITCHHOOK);  //or the constant if the item editor arg isn't set.
										
									//Store Link's starting position.
									lx = CenterLinkX();
									ly = CenterLinkY();
										
									//Store the switchshot combo to move.
									cmbX = ComboX(q);	//The combo number for the for loop pass...
									cmbY = ComboY(q);	//... X and Y
									cmbD = GetLayerComboD(layer,q); //The original data of the switchhook combo.
									cmbS = GetLayerComboS(layer,q); //The original solidity of the switchshot combo. 
									
									//Store the combo datum for the combo that Link is on. 
									
									cmbLD = GetLayerComboD(layer,ComboAt(Link->X, Link->Y));//The combo under Link.
									cmbLS = GetLayerComboS(layer,ComboAt(Link->X, Link->Y)); //The solidity of the combo under Link.
									cmbLX = GridX(lx); //The X position
									cmbLY = GridY(ly); //The Y position
									cmbL = ComboAt(cmbLX,cmbLY); //The screen index for that combo (Nth of 176).
										
										
									//Change the combo where Link WAS, to the switchshot combo.
									SetLayerComboD(layer,cmbL,cmbD); //Set its data
									SetLayerComboS(layer,cmbL,cmbS); //and solidity.
									
									//Move Link to where the old switchshot combo that we moved, WAS.
									Link->X = cmbX;
									Link->Y = cmbY;
									
										
									//Move the switchshot combo to where LINK was before he moved...
									SetLayerComboD(layer,cmbL,cmbLD); //Set the combo data
									SetLayerComboS(layer,cmbL,cmbLS); //and the solidity.
									
									this->Script = 0; //Free the FFC for later use.
									this->Data = 0;
									Quit();
								}
							}
						}
						
						//If we also switch enemies, check for those now.
			
						if ( affectEnemies && Screen->NumNPCs() ) {
							for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
								npc n = Screen->LoadNPC(q);
								if ( l->ID == LW_HOOKSHOT && Collision(l,n) ) {
									
									if ( 
										( SWITCHHOOK_ENEMIES_REQUIRE_SPECIAL_DEFS && !npcdt && n->Defense[NPCD_HOOKSHOT] == NPCDT_SWITCHHOOK ) 
										||
										( SWITCHHOOK_ENEMIES_REQUIRE_SPECIAL_DEFS && npcdt && n->Defense[NPCD_HOOKSHOT] == npcdt ) 
										||
										( !SWITCHHOOK_ENEMIES_REQUIRE_SPECIAL_DEFS ) 
									) {
											//If enemies require a special NPC Defs flag, and either we're assigning one to the item via arg D3
											//or if we are using the constant NPCDT_SWITCHHOOK...
											//...or if enemies DO NOT require a special defs flag to be affected...
										Game->PlaySound(SFX_SWITCHHOOK);
										int npcX = n->X;
										int npcY = n->Y;
										int lx = Link->X;
										int ly = Link->Y;
										n->X = -1; 
										n->Y = -1;
										Link->X = npcX;
										Link->Y = npcY;
										n->X = lx; 
										n->Y = ly;
										this->Script = 0;
										this->Data = 0;
										Quit();
									}
								}
							}
						}
						
					}
				}
			}
			if ( !NumLWeaponsOf(LW_HOOKSHOT) ) quitCounter++; //If there hasn;t been a hookshot on the screen this frame, bump the counter.
			if ( quitCounter >= FFC_SWITCHSHOT_QUIT_COUNTER ) break;	//and if it reaches 600, break the loop to exit the script, and free the ffc slot. 
			Waitframe();
			
			
		}
		this->Script = 0;
		this->Data = 0;
		Quit();
	}
}


//D0: The FFC SLot ID
//D1: The Combo Inherent Flag for the Switchshot combos. Defaults to CF_SWITCHSHOT if set to '0'.
//D2: The sound to play when switching. Defaults to SFX_SWITCHSHOT if set to '0'.
//D3: The NPCDT used to define switchshot specific enemies, or enemies affected by the switchshot's moving power. Default value: 12.
//	Note: This is only used if SWITCHHOOK_ENEMIES_REQUIRE_SPECIAL_DEFS is enabled. 
item script SwitchHookItem{
	void run(int ffc_slot, int comboF, int affectEnemies, int sfx, int npcdt) {
		int args[4]={comboF,affectEnemies,sfx,npcdt};
		RunFFCScript(ffc_slot, args);
	}
}


// Returns INT if FFC collides with a combo which has specific placed flag
int ComboFlagCollision (int flag, lweapon l){
	for (int i = 0; i<176; i++){
		if (Screen->ComboF[i]==flag){
			if (ComboCollision(i, l)) return i;
		}
	}
	return -1;
}

// Returns TRUE if there is a collision between the combo and an arbitrary rectangle.
bool ComboCollision (int loc, int x1, int y1, int x2, int y2){
	return RectCollision( ComboX(loc), ComboY(loc), (ComboX(loc)+16), (ComboY(loc)+16), x1, y1, x2, y2);
}


// Returns TRUE if there is a collision between Lweapon and the combo on screen.
bool ComboCollision (int loc, lweapon f){
	if (!(f->CollDetection)) return false;
	int ax = (f->X)+f->HitXOffset;
	int ay = (f->Y)+f->HitYOffset;
	int bx = ax+f->HitWidth;
	int by = ay+f->HitHeight;
	int cx = ComboX(loc);
	int cy = ComboY(loc);
	int dx = ComboX(loc)+16;
	int dy = ComboY(loc)+16;
	return RectCollision( cx, cy, dx, dy, ax, ay, bx, by);
}


////------------------------------------------------------------------------
// ffcscript.zh
// Version 1.1.0

// Combo to be used for generic script vehicle FFCs. This should be
// an invisible combo with no type or flag. It cannot be combo 0.
const int FFCS_INVISIBLE_COMBO = 1698;

item script ffcScriptNEW{
	void run(){
	}
}

// Range of FFCs to use. Numbers must be between 1 and 32.
const int FFCS_MIN_FFC = 1;
const int FFCS_MAX_FFC = 32;


int RunFFCScript(int scriptNum, float args)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        return 0;
    
    ffc theFFC;
    
    // Find an FFC not already in use
    for(int i=FFCS_MIN_FFC; i<=FFCS_MAX_FFC; i++)
    {
        theFFC=Screen->LoadFFC(i);
        
        if(theFFC->Script!=0 ||
           (theFFC->Data!=0 && theFFC->Data!=FFCS_INVISIBLE_COMBO))
            continue;
        
        // Found an unused one; set it up
        theFFC->Data=FFCS_INVISIBLE_COMBO;
        theFFC->Script=scriptNum;
        
        if(args!=NULL)
        {
            for(int j=Min(SizeOfArray(args), 8)-1; j>=0; j--)
                theFFC->InitD[j]=args[j];
        }
        
        return i;
    }
    
    // No FFCs available
    return 0;
}

ffc RunFFCScriptOrQuit(int scriptNum, float args)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        Quit();
    
    int ffcID=RunFFCScript(scriptNum, args);
    if(ffcID==0)
        Quit();
    
    return Screen->LoadFFC(ffcID);
}

int FindFFCRunning(int scriptNum)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        return 0;
    
    ffc f;
    
    for(int i=1; i<=32; i++)
    {
        f=Screen->LoadFFC(i);
        if(f->Script==scriptNum)
            return i;
    }
    
    // No FFCs running it
    return 0;
}

int FindNthFFCRunning(int scriptNum, int n)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        return 0;
    
    ffc f;
    
    for(int i=1; i<=32; i++)
    {
        f=Screen->LoadFFC(i);
        if(f->Script==scriptNum)
        {
            n--;
            if(n==0)
                return i;
        }
    }
    
    // Not that many FFCs running it
    return 0;
}

int CountFFCsRunning(int scriptNum)
{
    // Invalid script
    if(scriptNum<0 || scriptNum>511)
        return 0;
    
    ffc f;
    int numFFCs=0;
    
    for(int i=1; i<=32; i++)
    {
        f=Screen->LoadFFC(i);
        if(f->Script==scriptNum)
            numFFCs++;
    }
    
    return numFFCs;
}

bool FFCRunning(int ffcslot) {
	if ( FindFFCRunning(ffcslot) == 0 ){
		return false;
	}
	else {
		return true;
	}
}


//global script active{
//	void run(){
//		while(true){
//			if ( Screen->NumLWeapons() ) {
				//if ( NumLWeaponsOf(LW_HOOKSHOT) ) TraceS(str);
				
//				for ( int q = 1; q <= Screen->NumLWeapons(); q++ ) {
//					lweapon l = Screen->LoadLWeapon(q);
//					if ( l->ID == LW_HOOKSHOT ){
//						TraceS(str);	TraceNL();
//						for ( int q = 0; q < 176; q++ ) {
//							int cmb = Screen->ComboI[q];
//							if ( cmb == CF_SWITCHHOOK ) {
//								TraceS(shc);	TraceNL();
//								if ( ComboCollision(q,l) ) {
//									TraceS(col);	TraceNL();
//									//We need to check every layer...too...
//									//..for combos on layers higher than 0. (?)
//									l->DeadState = WDS_DEAD;
//									solidity = Screen->ComboS[cmb];
//									Game->PlaySound(SFX_SWITCHHOOK);
//									int cmbX = ComboX(cmb);
//									int cmbY = ComboY(cmb);
//									int lx = CenterLinkX();
//									int ly = CenterLinkY();
//									int cmbD = Screen->ComboD[q];
//									int cmbLink = ComboAt(Link->X, Link->Y);
//									Screen->ComboD[cmbLink] = cmbD;
//									Screen->ComboS[cmbLink] = solidity;
//									Link->X = cmbX;
//									Link->Y = cmbY;
//								}
//							}
//						}
//					}
//				}
//			}
//		Waitdraw();
//		Waitframe();
//		}
//	}
//}