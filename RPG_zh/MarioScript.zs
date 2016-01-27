//Mario Games Functions (Preliminary)


const int MARIO_HEAD_Y = -17; //Position of Big Mario's head (top pixel)
const int MARIO_FEET_Y = 16; //Position of Mario's feet.

//From what point are X/Y determined when using a 2x1 sprite for Link?

void JumpAtBlocks(int cmb)
	//If Link is Jumping, and the combo over him is a block, and he is within sixteen
	//pizels undder that combo...
	if ( Link->Jump > 0  && ComboOverLink(CMB_BLOCK) && DistanceComboOverLink(CMB_BLOCK,16) && BigMario() ) {
		MarioStats[POINTS} += 50;
		BreakBlock(cmb)
	}
	if ( Link->Jump > 0  && ComboOverLink(CMB_Q_BLOCK) && DistanceComboOverLink(CMB_Q_BLOCK,16) ) {
		HitQuestionBlock(cmb);
	}
}
	
bool BigMario(){
	if ( Vor(MarioPowerUp[MUSHROOM],MarioPowerUp[FLOWER] ) return true;
	return false;
}

void BreakBlock(int cmb, int layer){
	int comboX = ComboX(cmb);
	int comboY = ComboY(cmb);
	
	///!IsUnderWater() 
	//We don;t want normal blocks to break, under water; but '?' blocks should activate, 
	//as should other blocks with items/rewards.
	
	
	if ( GetComboI(layer,cmb) == CF_10COIN ) {
		//How should we check to determine if the block is out of coins
	}
	
	else {
	
		//Animate the block breaking, and jiggle it.
		//! This needs to be AFTER a check for 10-coin blocks.
		
		
		
		

		if ( GetComboI(layer,cmb) == CF_POWERUP ) {
			//Make a powerup.
			if ( GetComboD(layer,cmb) == CMB_Q_BLOCK_COIN ) MakeCoin(cmb);
			if ( GetComboD(layer,cmb) == CMB_Q_BLOCK_MUSHROOM ) MakeMushroom(cmb);
			if ( GetComboD(layer,cmb) == CMB_Q_BLOCK__POISONMUSHROOM ) MakePoisonMushroom(cmb);
			if ( GetComboD(layer,cmb) == CMB_Q_BLOCK_NEXTPOWERUP ) MakePowerUp(cmb,MarioStats[CURRENT_POWERUP]);
			if ( GetComboD(layer,cmb) == CMB_Q_BLOCK_STAR ) MakeStar(cmb);
			then make the block solid-used.
			SetLayerComboD(layer,cmb,CMB_USED_BLOCK); //Set it to a used state. 
			SetLayerComboI(layer,cmb,CF_NONE); //...and kill its flag.
		}
		else { 
			MarioStats[POINTS] += 50; //Give Mario points
			//then remove the block...
			SetComboD(layer,cmb,0); //Set it to Combo 0.
		}
	}
}
	

ffc script PowerUp{
	void run(int type, int speed){
		//Powerups that have a speed, move along platforms if a positive value, 
		//or fly / bounce if a negative value (stars)
		//On contact, they invisibly grant a power-up, penalty (poison mushroom), or coins/lives.
		bool touched;
		while(!touched){
			//powerup movement by type.
			
			if ( LinkCollision(this) {
				touched = true;
				if ( type == __ ) {
					this->Data = 0; //Clear the combo, as it's been collected. 
				}
			}
			Waitframe();
		}
		this->Script = 0;
		Quit();
	}
}


//Water and Swimming

void MarioFloat(){}
	
void MarioSwim(){}
	
/////////////////////////
///  Jumping Scripts  ///
///        and        ///
///     Functions     ///
////////////////////////////////////////////////
/// ZoriaRPG, Release 1, on  3rd June, 2014. ///
/// Alpha, v1.0                              ///
////////////////////////////////////////////////

import "std.zh"
import "ffcscript.zh"
import "stdExtra.zh"

//Note: These are variables, so that you can change their values with items. 
//You can change them to constants, if not using more than one jump item or jump type.

//ARRAY

//                HEIGHT  MPCOST  RUP_COST   USR_COST     USR_COUNTER JUMP_SFX ERROR_SFX REQ_STATE    ITEM TIME   WIDTH
//NORMAL_JUMP
//Z_JUMP

//const int ARRAY_ROW = 
//const int ARRAY COLUMN =\ 

//make zjumpa function, not an ffc.


/////////////
/// COSTS ///
///////////// 

///Standard

int jumpMP = 0; //Set the MP cost for jumping. Multiples of 8, 16, 24, or 32 would be the most logical. 
                //There are 32 MP in one magic block, if using a normal metre. 
                
int jumpCostRupees = 0; // Sets the cost in rupees to jump.

int jumpCostUserDefined = 0; //Sets a user defined Jump cost, tied to a user-defined counter.

///Overhead

int birdseyeJumpMP = 0; //Set the MP cost for jumping. Multiples of 8, 16, 24, or 32 would be the most logical. 
                //There are 32 MP in one magic block, if using a normal metre. 
                
int birdseyeJumpCostRupees = 0; // Sets the cost in rupees to jump.

int birdseyeJumpCostUserDefined = 0; //Sets a user defined Jumo cost, tied to a user-defined counter.

///Custom Counter

const int CR_JUMPCOST = 7;  //Counter Script 1 is '7'. Change this to your desired value for a custom counter, 
                            //if you're using one.
                            //Reference std_constants.zh to determine the counter value that you want to use.

/////////////////////
/// Sound Effects ///
/////////////////////

int SFX_JUMP = 62; //Sets jump sound, from Quest->Audio->SFX Data.
int jumpError = 64; //Sets the SFX error for jumping / items.
int OVERHEAD_SFX_JUMP = 62; //Sets overhead jump sound, from Quest->Audio->SFX Data.
int overheadJumpError = 64; //Sets the SFX error for overhead jumping / items.
const int CHANGE_JUMP_SETTINGS = 65;
const int CHANGE_JUMP_SETTINGS_OVERHEAD = 66;


///////////////
/// METRICS ///
///////////////

int JUMP_HEIGHT = 4; //Sets the height of the jump.
bool requireOnGround = true; //Set to false for overhead jumping.
int overheadTime = 240; //Sets duration of overhead view jumps at 60FPS.
int overheadHeight = 4; //Sets Z axis height for overhead jumping.
int overheadDistance = 4; //Sets automatic distance of overhead jumps.
bool inAir = false;

/////////////////////////
/// ITEM REQUIREMENTS ///
/////////////////////////

int JUMP_ITEM = 91; //Sets the item required for jumping. 
bool requireJumpItem = true; //Set to false, if player can always jump.
bool requireOverheadJumpItem = false; 
int OVERHEAD_JUMP_ITEM = 92; //Sets the item neded for overhead jumping.

////////////////////
/// FFC SETTINGS ///
////////////////////

int jumpBirdseye = 0;
int birdseyeHeight = 4;
int birdseyeDistance = 2;
const int jumpZ_FFC = 1; //Set this to the slot of 'ffc script overheadJump'.

/////////////////////
/// GLOBAL SCRIPT ///
/////////////////////

global script active{ //Slot 2
    void run() {
    inAir = false;
        while(true){
            jumpButton();
            jumpButtonOverhead();
            Waitdraw();
            Waitframe();
        }
    }
}

////////////////////
/// ITEM SCRIPTS ///
////////////////////

//////////////////////////
/// Jump Settings Item ///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// This script should be set to the 'active' (use) script of an item. The item should be a custom item class ///
/// or a zz### item class, and should be set as an equipment item. Set up the arguments, and when the player  ///
/// uses this item, it will change the jump settings in the game.                                             ///
/// This allows you to have multiple types of jump effects, with different costs, etc..                       ///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// D0: Set this to the height of the jump.                                                                   ///
/// D1: Set this to the Jump SFX (from: Quest->Audio->SFX Data)                                               ///
/// D2: Set this to the error sound, if applicable (from : Quest->Audio->SFX Data)                            ///
/// D3: Require that the player is on the ground or has an item?                                              ///
///-----------------------------------------------------------------------------------------------------------///
///                     SETTINGS (FLAGS)                                                                      ///
///                         0 = None                                                                          ///
///                     1 = Item Needed                                                                       ///
///                    2 = Ground Needed                                                                      ///
///              3 = Both Ground, and Item Needed                                                             ///
///-----------------------------------------------------------------------------------------------------------///
/// D4: Set this to the item number (from the Item Editor) needed to jump, is applicable.                     ///
/// D5: Set an MP cost to jump, here.                                                                         ///
/// D6: Set a Rupee cost to jump, here.                                                                       ///
/// D7: Set a user defined cost (applied to the counter set by CR_JUMPCOST) here.                             ///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

item script jumpSettings {
    void run (int heightOfJump, int jumpSFX, int error_SFX, int requireGroundorItem, int itemNumberNeeded, int costMagic, int costRupees, int costUserDefined ) {
        Game->PlaySound(CHANGE_JUMP_SETTINGS);
        JUMP_HEIGHT = heightOfJump;
        jumpMP = costMagic; //Sets the cost of jumping (MP)
        SFX_JUMP = jumpSFX; //Sets jump sound, from Quest->Audio->SFX Data.
        jumpError = error_SFX; //Sets the SFX error for jump items.
        JUMP_ITEM = itemNumberNeeded; //Sets, or changes the item required to jump.
        jumpCostRupees = costRupees; 
        jumpCostUserDefined = costUserDefined; 
        
        if ( requireGroundorItem == 0 ) {
            requireOnGround = false;
            requireJumpItem = false;
        }
        else if ( requireGroundorItem == 1 ) {
            requireOnGround = false;
            requireJumpItem = true;
        }
        else if ( requireGroundorItem == 2 ) {
            requireOnGround = true;
            requireJumpItem = false;
        }
        else if ( requireGroundorItem == 3 ) {
            requireOnGround = true;
            requireJumpItem = true;
        }

        
    }
}

////////////////////////////////
/// SET OVERHEAD JUMP (ITEM) ///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// This is similar to the above script, but sets variables for overhead jumping, to isolate these from normal         ///
/// jumping, again, to allow you to have multiple types, using different items.                                        ///
/// Args:                                                                                                              ///
/// D0: The time that Link will be in th air, at 60 FPS.                                                               ///
/// D1: The Z-axis height of the jump.                                                                                 ///
/// D2: The Distance link will move (in tiles) in the direction he is facing, when jumping.                            ///
/// D3: Set to 0, if you want to require a special item to use this, or set to 0 if you don't want to require an item. ///
/// D4: if requiring an item, fill this field with the item number (from the Item Editor) to require.                  ///
/// D5: The Sound Effect to play when jumping in Birds' Eye Mode; can be different to the present sideview sound.      ///
/// D6: The MP cost (if any) for overhead jumping. This value is separate from the present sideview cost.              ///
/// D7: This is split into two values, before, and after the decimal point.                                            ///
///     D7 (High) #####.xxxx : Set the cost (if any) of Rupees to spend when doing an overhead jump.                   ///
///     D7 (Low)  xxxxx.#### : Set the amount (if any) to reduce the counter defined as CR_JUMPCOST.                   ///
///     These values are all separate from the present sideview settings.                                              ///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


item script setBirdseyeJumpOptions {
    void run(int time, int height, int distance, int allowType, int requireOverheadItem, int overheadSFX, int costMP, int costRupees_Custom) {
        Game->PlaySound(CHANGE_JUMP_SETTINGS_OVERHEAD);
        overheadTime = time;
        overheadHeight = height;
        overheadDistance = distance; //Sets automatic distance of overhead jumps.
        OVERHEAD_JUMP_ITEM = requireOverheadItem;
        OVERHEAD_SFX_JUMP = GetHighPortion(overheadSFX);
        overheadJumpError = GetLowPortion(overheadSFX);
        birdseyeJumpMP = costMP; 
        birdseyeJumpCostRupees = GetHighPortion(costRupees_Custom); 
        birdseyeJumpCostUserDefined = GetLowPortion(costRupees_Custom); 
        
        if ( allowType == 0 ) {
            requireOverheadJumpItem = false;
        }
        else if ( allowType > 0 ) {
            requireOverheadJumpItem = true;
        }
    }
}

///////////////////
/// FFC SCRIPTS ///
///////////////////////////////////////////
/// Birds' Eye Jumping ////////////////////
/// by: ZoriaRPG       ////////////////////
/// Alpha v1.0         ////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// The premise of this script is that it moves Link on the Z axis, and if the user opts, it automatically ///
/// moves the player a number of tiles, in a direction that he is facing.                                  ///
/// This is an alpha version, and not tested at this time (3rd June, 2014). I am not certain what moving   ///
/// Link on the z-Axis does, if done directly, but I presume that it *should* work.                        ///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// The FFC keeps Link at a specific height (on the Z axis) using a for loop, that acts as a timer. It may ///
/// be better to handle this in distinct segments, moving the player up slowly for a few frames, until the ///
/// player reaches the crescendo limit, and then fall down again, but in practical terms, moving a player  ///
/// above a Z of 0 (zero) is potentially gane-breaking at the best of times.                               ///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// It may also be possible to use butmaps to scale the player sprite when doing this, or at least, to     ///
/// draw a shadow that changes in size, as the player rises, or falls in a jump action, in overhead view.  ///
/// Neither of these are in the script at present, as I still need to test the bloddy thing, before making ///
/// it fancier.                                                                                            ///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// The bool inAir is intended to prevent the player from jumping again, until he lands. It could probably ///
/// use a for loop, to count down a specific amount of 'rest' time, until the player can again jump, even  ///
/// after landing.                                                                                         ///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

ffc script overheadJump {
    void run(){
    
        //while(true){
            for (int i=1; i<=overheadTime; i++){ 
                Link->Z = overheadHeight;
                inAir = true;
                Waitframe();

            }
            
            if ( overheadDistance > 0 ) {
                if(Link->Dir == DIR_DOWN) {
                    Link->X += overheadDistance;
                }
                if(Link->Dir == DIR_UP) {
                    Link->X -= overheadDistance;
                }
                if(Link->Dir == DIR_LEFT) {
                    Link->Y -= overheadDistance;
                }
                if(Link->Dir == DIR_RIGHT) {
                    Link->Y += overheadDistance;
                }
                inAir = false;
            }
        //}
    }
}




        

/////////////////
/// FUNCTIONS ///
/////////////////

void jumpButton() {
    if ( requireOnGround == true ) {
        if ( requireJumpItem == true ) {
            if ( Link->Item[JUMP_ITEM] && onGround() ) {
                    if ( Link->PressEx1 && Link->MP >= jumpMP || Link->PressEx1 && jumpMP == 0 ){
                        if ( Game->Counter[CR_RUPEES] >= jumpCostRupees || jumpCostRupees == 0) {
                            if ( Game->Counter[CR_JUMPCOST] >= jumpCostUserDefined || jumpCostUserDefined == 0 ) {  
                                Link->Jump = JUMP_HEIGHT; //Sets height of jump.
                                Game->Counter[CR_MAGIC] -= jumpMP;
                                Game->Counter[CR_RUPEES] -= jumpCostRupees;
                                Game->Counter[CR_JUMPCOST] -= jumpCostUserDefined;
                                if ( SFX_JUMP > 0 ) {
                                    Game->PlaySound(SFX_JUMP);  //Play sound set as SFX_JUMP. //Play sound set as jumpError. 
                                    //A sound value of '0' will not produce a sound. 
                                }
                            }
                        }
                    }
                    else if ( Link->PressEx1 && Link->MP < jumpMP ||
                            Link->PressEx1 && Game->Counter[CR_RUPEES] < jumpCostRupees ||
                            Link->PressEx1 && Game->Counter[CR_JUMPCOST] < jumpCostUserDefined )
                    {
                        if ( jumpError > 0 ) {
                            Game->PlaySound(jumpError); //Play sound set as jumpError. 
                        }
                        //A sound value of '0' will not produce a sound. 
                    }
            }
        }
        else if ( requireJumpItem == false ) {
            if ( onGround() ) {
                if ( Link->PressEx1 && Link->MP >= jumpMP || Link->PressEx1 && jumpMP == 0 ){
                        if ( Game->Counter[CR_RUPEES] >= jumpCostRupees || jumpCostRupees == 0) {
                            if ( Game->Counter[CR_JUMPCOST] >= jumpCostUserDefined || jumpCostUserDefined == 0 ) {  
                                Link->Jump = JUMP_HEIGHT; //Sets height of jump.
                                Game->Counter[CR_MAGIC] -= jumpMP;
                                Game->Counter[CR_RUPEES] -= jumpCostRupees;
                                Game->Counter[CR_JUMPCOST] -= jumpCostUserDefined;
                                if ( SFX_JUMP > 0 ) {
                                    Game->PlaySound(SFX_JUMP);  //Play sound set as SFX_JUMP. //Play sound set as jumpError. 
                                    //A sound value of '0' will not produce a sound. 
                                }
                            }
                        }
                    }
                else if ( Link->PressEx1 && Link->MP < jumpMP ||
                            Link->PressEx1 && Game->Counter[CR_RUPEES] < jumpCostRupees ||
                            Link->PressEx1 && Game->Counter[CR_JUMPCOST] < jumpCostUserDefined )
                {
                    Game->PlaySound(jumpError); //Play sound set as jumpError. 
                    //A sound value of '0' will not produce a sound. 
                }
            }
        }
        
    }

    
    else if ( requireOnGround == false ) {
        if ( requireJumpItem == true ) {
            if ( Link->Item[JUMP_ITEM] ) {
                    if ( Link->PressEx1 && Link->MP >= jumpMP || Link->PressEx1 && jumpMP == 0 ){
                        if ( Game->Counter[CR_RUPEES] >= jumpCostRupees || jumpCostRupees == 0) {
                            if ( Game->Counter[CR_JUMPCOST] >= jumpCostUserDefined || jumpCostUserDefined == 0 ) {  
                                Link->Jump = JUMP_HEIGHT; //Sets height of jump.
                                Game->Counter[CR_MAGIC] -= jumpMP;
                                Game->Counter[CR_RUPEES] -= jumpCostRupees;
                                Game->Counter[CR_JUMPCOST] -= jumpCostUserDefined;
                                if ( SFX_JUMP > 0 ) {
                                    Game->PlaySound(SFX_JUMP);  //Play sound set as SFX_JUMP. //Play sound set as jumpError. 
                                    //A sound value of '0' will not produce a sound. 
                                }
                            }
                        }
                    }
                    else {
                        if ( SFX_JUMP > 0 ) {
                            Game->PlaySound(jumpError); //Play sound set as jumpError. 
                        }
                        //A sound value of '0' will not produce a sound. 
                    }
            }
        }
        else if ( requireJumpItem == false ){
            if ( Link->PressEx1 && Link->MP >= jumpMP || Link->PressEx1 && jumpMP == 0 ){
                if ( Game->Counter[CR_RUPEES] >= jumpCostRupees || jumpCostRupees == 0) {
                    if ( Game->Counter[CR_JUMPCOST] >= jumpCostUserDefined || jumpCostUserDefined == 0 ) {  
                        Link->Jump = JUMP_HEIGHT; //Sets height of jump.
                        Game->Counter[CR_MAGIC] -= jumpMP;
                        Game->Counter[CR_RUPEES] -= jumpCostRupees;
                        Game->Counter[CR_JUMPCOST] -= jumpCostUserDefined;
                        if ( SFX_JUMP > 0 ) {
                            Game->PlaySound(SFX_JUMP);  //Play sound set as SFX_JUMP. //Play sound set as jumpError. 
                            //A sound value of '0' will not produce a sound. 
                        }
                    }
                }
            }
            else {
                Game->PlaySound(jumpError); //Play sound set as jumpError. 
                //A sound value of '0' will not produce a sound. 
            }
        }
    }
}

void jumpButtonOverhead() {
    int overheadTimer = 0;
    if ( requireOverheadJumpItem == true ) {
        if ( Link->Item[JUMP_ITEM] && inAir == false ) {
            if ( Link->PressEx2 && Link->MP >= birdseyeJumpMP || Link->PressEx2 && birdseyeJumpMP == 0) {
                if ( Game->Counter[CR_RUPEES] >= birdseyeJumpCostRupees || birdseyeJumpCostRupees == 0) {
                    if ( Game->Counter[CR_JUMPCOST] >= birdseyeJumpCostUserDefined || birdseyeJumpCostUserDefined == 0 ) {
                        Game->Counter[CR_MAGIC] -= birdseyeJumpMP;
                        Game->Counter[CR_RUPEES] -= birdseyeJumpCostRupees;
                        Game->Counter[CR_JUMPCOST] -= birdseyeJumpCostUserDefined;
                        if ( OVERHEAD_SFX_JUMP > 0 ) {
                            Game->PlaySound(OVERHEAD_SFX_JUMP);  //Play sound set as OVERHEAD_SFX_JUMP. //Play sound set as overheadJumpError. 
                            //A sound value of '0' will not produce a sound. 
                        }
                        for (int i=1; i<=overheadTime; i++){ 
                            Link->Z = overheadHeight;
                            inAir = true;
                            //Waitframe();

                        }
            
                        if ( overheadDistance > 0 ) {
                            if(Link->Dir == DIR_DOWN) {
                                Link->X += overheadDistance;
                            }
                            if(Link->Dir == DIR_UP) {
                                Link->X -= overheadDistance;
                            }
                            if(Link->Dir == DIR_LEFT) {
                                Link->Y -= overheadDistance;
                            }
                            if(Link->Dir == DIR_RIGHT) {
                                Link->Y += overheadDistance;
                            }
                            inAir = false;
                        }
                    }
                }
            }
        }
    
        else if ( Link->PressEx2 && 
                Link->MP < birdseyeJumpMP ||
                Link->PressEx2 && 
                Game->Counter[CR_RUPEES] < birdseyeJumpCostRupees ||
                Link->PressEx2 && 
                Game->Counter[CR_JUMPCOST] < birdseyeJumpCostUserDefined ) {
                if ( overheadJumpError > 0 ) {
                    Game->PlaySound(overheadJumpError); //Play sound set as overheadJumpError.
                }
                //A sound value of '0' will not produce a sound. 
        }
    }
    
    else if ( requireOverheadJumpItem == false ) {
        //if ( inAir == false ) {
        if ( !IsSideview() ) {
            if ( Link->PressEx2 && Link->MP >= birdseyeJumpMP || Link->PressEx2 && birdseyeJumpMP == 0) {
                if ( Game->Counter[CR_RUPEES] >= birdseyeJumpCostRupees || birdseyeJumpCostRupees == 0) {
                    if ( Game->Counter[CR_JUMPCOST] >= birdseyeJumpCostUserDefined || birdseyeJumpCostUserDefined == 0 ) {
                        Game->Counter[CR_MAGIC] -= birdseyeJumpMP;
                        Game->Counter[CR_RUPEES] -= birdseyeJumpCostRupees;
                        Game->Counter[CR_JUMPCOST] -= birdseyeJumpCostUserDefined;
                        if ( OVERHEAD_SFX_JUMP > 0 ) {
                            Game->PlaySound(OVERHEAD_SFX_JUMP);  //Play sound set as OVERHEAD_SFX_JUMP. //Play sound set as overheadJumpError. 
                            //A sound value of '0' will not produce a sound. 
                        }
                        //int overheadTimer = 1;
                            do{
                                overheadTimer++;
                                Link->Z = overheadHeight;
                                inAir = true;
                                }
                            while(overheadTimer < overheadTime );
                            
                            
                        
                            
                            
                            Link->Z = 8;
                            inAir = false;
                            //Waitframe();

                        
            
                        //if ( overheadDistance > 0 ) {
                            if(Link->Dir == DIR_RIGHT) {
                                Link->X += overheadDistance;
                            }
                            if(Link->Dir == DIR_LEFT) {
                                Link->X -= overheadDistance;
                            }
                            if(Link->Dir == DIR_UP) {
                                Link->Y -= overheadDistance;
                            }
                            if(Link->Dir == DIR_DOWN) {
                                Link->Y += overheadDistance;
                            }
                            inAir = false;
                        //}
                    }
                }
            }
        //}
        }
    }
        
        //else if ( Link->PressEx2 && 
        //        Link->MP < birdseyeJumpMP ||
        //        Link->PressEx2 && 
        //        Game->Counter[CR_RUPEES] < birdseyeJumpCostRupees ||
        //        Link->PressEx2 && 
        //        Game->Counter[CR_JUMPCOST] < birdseyeJumpCostUserDefined )
        //
        //{
        //    if ( overheadJumpError > 0 ) {
        //            Game->PlaySound(overheadJumpError); //Play sound set as overheadJumpError.
        //    }                        
        //        //A sound value of '0' will not produce a sound. 
        //}
}
//}
        
    
//bool onGround(){
//    if(!IsSideview()) 
//        return Link->Z == 0;
//    return
//        OnSidePlatform(Link->X, Link->Y);
//}

bool onGround(){
    if(!IsSideview()) 
        return Link->Z == 0;
    return
        OnSidePlatform(Link->X, Link->Y, Link->HitXOffset, Link->HitYOffset, Link->HitHeight);
}





bool IsSideviewLinkOnGround() {
  return
    // If this is a sideview screen.
    IsSideview() &&
    // and Link is standing on a solid tile.
    (Screen->isSolid(Link->X + 04, Link->Y + 16) ||
     Screen->isSolid(Link->X + 12, Link->Y + 16));
     }

int GetHighPortion(int arg) {return arg >> 0;}
int GetLowPortion(int arg) {return (arg - (arg >> 0)) * 10000;}