import "std.zh"
import "string.zh"
import "ffcscript.zh"

global script globalscript{
    void run(){
         StartGhostZH();
         while(true){
              UpdateGhostZH1();
              Waitdraw();
              UpdateGhostZH2();
			  JumpWithL();
              Waitframe();
         }
    }
}


const int JUMP_HEIGHT_NORMAL = 4; //This is the jump height when you don't have the high jump item. It uses feather jump height instead of script jump height for compatibility purposes.
const int JUMP_HEIGHT_HIGH = 8; //This is the jump height when you have the high jump item.
const int I_NORMALJUMP = 91;//Item Id for normal jump.
const int I_HIGHJUMP = 123; //This is the item used for the high jump boots. Just having the item will make you jump higher with the script. Uses Roc's Feather by default.
const int I_SPACE_JUMP = 51;//Item id for Space Jump.
const int SPACE_JUMP_LOWER_BOUND = 20; // How many frames Link has to fall before Space Jump can be used.
const int SPACE_JUMP_UPPER_BOUND = 50; // How many frames Link can fall before Space Jump use is barred.
const int SF_NOJUMP = 0000100b; //This is the Misc screen flag used by the script to find screens where jumping is disabled. It uses General Use 1 (Scripts) by default.
const int I_SCREWATTACK = 35;//Item Id for Screw Attack.
const int LW_SCREWATTACK = 31; //Script1
const int SCREWATTACK_DAMAGE = 8;//How much damage Screw Attack does to enemies.
const int I_GRAVITY_SUIT = 18;//Item Id for Gravity Suit.
const int I_VARIA_SUIT = 55;//Item id for Varia Suit.

int StoredY;
int SpaceJumpFalling;

//This is the jump function. Put this in the while loop of your global script.
void JumpWithL(){
    int JumpHeight = JUMP_HEIGHT_NORMAL;
    if(Link->Item[I_HIGHJUMP])
		 JumpHeight = JUMP_HEIGHT_HIGH;
    if(IsSideview()){ //For sideview screens
        if(Link->PressEx1&&OnSidePlatform(Link->X, Link->Y, Link->HitXOffset, Link->HitYOffset, Link->HitHeight)&&Link->Action<=2&&!(Screen->Flags[SF_MISC]&SF_NOJUMP)){
            Link->Jump = (JumpHeight+2)*0.8;
            Game->PlaySound(SFX_JUMP);
        }
		else if (Link->PressEx1&&Link->Item[I_SPACE_JUMP]&&SpaceJumpFalling>=SPACE_JUMP_LOWER_BOUND&&SpaceJumpFalling<SPACE_JUMP_UPPER_BOUND&&Link->Action<=2&&!(Screen->Flags[SF_MISC]&SF_NOJUMP)){
			Link->Jump = (JumpHeight+2)*0.8;
            Game->PlaySound(SFX_JUMP);
		}
		if (Link->Y > StoredY){
			SpaceJumpFalling++;
		}
		else{
			SpaceJumpFalling = 0;
		}
		
		StoredY = Link->Y;
    }
    else{ //For top-down screens
        if(Link->PressEx1&&Link->Z==0&&Link->Action<=2&&!(Screen->Flags[SF_MISC]&SF_NOJUMP)){
            Link->Jump = (JumpHeight+2)*0.8;
            Game->PlaySound(SFX_JUMP);
        }
    }
    Link->InputEx1 = false;
}

//Shell Top- 3 X 6
//Shell Bottom- 3 x 6
//Core- 2 x 3
//First segment - 3 x 3
//Other segments- 2 x 2

const int SHELL_TOP = 213;//Enemy ID for top shell
const int SHELL_BOTTOM = 214;//Enemy ID for bottom shell
const int MAIN_SEGMENT = 215;//Enemy ID for first segment.
const int VINE_SEGMENT = 216;//Enemy ID for vine segments.
const int SPORE_SPRITE = 93;//Sprite for spores
const int SPORE_SFX = 63;//Sound for spores

ffc script SporeSpawn{
	void run(int enemyid){
		npc ghost = Ghost_InitAutoGhost(this, enemyid);
		Ghost_SetFlag(GHF_IGNORE_ALL_TERRAIN);
		Ghost_SetFlag(GHF_IGNORE_NO_ENEMY);
		Ghost_SetFlag(GHF_NO_FALL);
		Ghost_SetFlag(GHF_FAKE_Z);
		int HVS = ghost->Attributes[0];//Type of hover. 0=Float, 1=Horizontal movement, 2=Vertical  movement, 3 = Parametric movement
		int Misc1 = ghost->Attributes[1];//Half width of horizontal movement
		int Misc2 = ghost->Attributes[2];//X speed
		int Misc3 = ghost->Attributes[3];//Half Height of vertical movement
		int Misc4 = ghost->Attributes[4];//Y speed
		Ghost_X = 140;
		Ghost_Y = 0;
		bool Closed = true;//Tracks whether it is defending or not.
		//These four variables handle the parametric movement.
		int StartX;
		int StartY;
		int T1 = 0;
		int T2 = 0;
		//Tile width and height.
		int Width = Ghost_GetAttribute(ghost,5,1);
		int Height = Ghost_GetAttribute(ghost,6,1);
		Ghost_SetSize(this,ghost,Width,Height);
		//Initiate enemies for all the parts and position them.
		npc ShellTop = Screen->CreateNPC(SHELL_TOP);
		npc ShellBottom = Screen->CreateNPC(SHELL_BOTTOM);
		npc FirstSegment = Screen->CreateNPC(MAIN_SEGMENT);
		npc TailSegments[6];
		ShellTop->X = Ghost_X-32;
		ShellTop->Y = Ghost_Y-16;
		ShellBottom->X = ShellTop->X;
		ShellBottom->Y = Ghost_Y+16;;
		FirstSegment->X =Ghost_X-8;
		FirstSegment->Y =ShellTop->Y-16;
		ShellTop->Extend = 3;
		ShellTop->TileHeight = 3;
		ShellTop->TileWidth = 6;
		ShellBottom->Extend = 3;
		ShellBottom->TileWidth = 6;
		ShellBottom->TileHeight = 3;
		FirstSegment->Extend = 3;
		FirstSegment->TileHeight = 3;
		FirstSegment->TileWidth = 3;
		for(int i = 0;i<=5;i++){
			TailSegments[i] = Screen->CreateNPC(VINE_SEGMENT);
			TailSegments[i]->X = FirstSegment->X;
			TailSegments[i]->Y = FirstSegment->Y;
			TailSegments[i]->Extend = 3;
			TailSegments[i]->TileHeight = 2;
			TailSegments[i]->TileWidth = 2;
		}
		int Mode = 0;//Tracks what mode it is in.
		int OpenTimer;//How long to stay open or closed.
		int SporeTimer;//How long between spore attacks.
		int IntroTimer = 85;//Handles initial lowering into position.
		eweapon Spores[4];
		int Calc;//Used to calculate average position for vertical placement of segments.
		int StoreY[6];//Stores Y location of segments at end of lowering phase.
		while(true){
			
			//Do enemy explosions for these segemnts, if they have 0 HP. 
			//You should set all their HP to 0, the instant that the boss has <=0 HP... 
			
			if ( ghost->HP <= 0 ) {
				ShellTop->HP = 0;
				ShellBottom->HP = 0;
				FirstSegment->HP = 0;
				TailSegments[0]->HP = 0;
				TailSegments[1]->HP = 0;
				TailSegments[2]->HP =0;
				TailSegments[3]->HP = 0;
				TailSegments[4]->HP = 0;
				TailSegments[5]->HP = 0;
				TailSegments[6]->HP =0;
			
			}
			
			RunEnemyExplosionFFC(ShellTop, FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(ShellBottom, FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(FirstSegment, FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[0], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[1], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[2], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[3], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[4], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[5], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[6], FFC_NUM_OF_EXPLOSIONS);
			
			//Lower into position. This part works in sideview.
			while(IntroTimer>0){
				Ghost_Y++;
				ShellTop->X = Ghost_X-32;
				ShellTop->Y = Ghost_Y-16;
				ShellBottom->X = ShellTop->X;
				ShellBottom->Y = Ghost_Y+16;;
				FirstSegment->X =Ghost_X-8;
				FirstSegment->Y =ShellTop->Y-16;
				for(int i = 0;i<=5;i++){
					TailSegments[i]->X = FirstSegment->X+12;
				}
				Calc = FirstSegment->Y/5;
				TailSegments[0]->Y = FirstSegment->Y-Calc;
				TailSegments[1]->Y = FirstSegment->Y-(Calc*2);
				TailSegments[2]->Y = FirstSegment->Y-(Calc*3);
				TailSegments[3]->Y = FirstSegment->Y-(Calc*4);
				TailSegments[4]->Y = FirstSegment->Y-(Calc*5);
				TailSegments[5]->Y = 0;
				IntroTimer--;
				if(IntroTimer==1){
					for(int i = 0;i<=5;i++){
						StoreY[i] = TailSegments[i]->Y;
					}
					StartX = Ghost_X;
					StartY = Ghost_Y;
				}
				Spore_Waitframe(this,ghost,ShellTop,ShellBottom,FirstSegment,TailSegments);
			}
			//If closed, in mode zero and open timer is less than or equal to zero.
			if(Mode == 0 && Closed && OpenTimer<=0){
				Mode = 1;//Change modes.
				Closed = false;//Turn defenses off.
				ghost->Defense[NPCD_ARROW] =NPCDT_NONE;
				//Move top shell away from core.
				while(ShellTop->Y>Ghost_Y-44){
					ShellTop->Y--;
					FirstSegment->Y =ShellTop->Y-16;
					Calc = FirstSegment->Y/5;
					TailSegments[0]->Y = FirstSegment->Y-Calc;
					TailSegments[1]->Y = FirstSegment->Y-(Calc*2);
					TailSegments[2]->Y = FirstSegment->Y-(Calc*3);
					TailSegments[3]->Y = FirstSegment->Y-(Calc*4);
					TailSegments[4]->Y = FirstSegment->Y-(Calc*5);
					TailSegments[5]->Y = 0;
					Spore_Waitframe(this,ghost,ShellTop,ShellBottom,FirstSegment,TailSegments);
				}
				//Move bottom shell away from core.
				while(ShellBottom->Y<Ghost_Y+36){
					ShellBottom->Y++;
					FirstSegment->Y =ShellTop->Y-16;
					Calc = FirstSegment->Y/5;
					TailSegments[0]->Y = FirstSegment->Y-Calc;
					TailSegments[1]->Y = FirstSegment->Y-(Calc*2);
					TailSegments[2]->Y = FirstSegment->Y-(Calc*3);
					TailSegments[3]->Y = FirstSegment->Y-(Calc*4);
					TailSegments[4]->Y = FirstSegment->Y-(Calc*5);
					TailSegments[5]->Y = 0;
					Spore_Waitframe(this,ghost,ShellTop,ShellBottom,FirstSegment,TailSegments);
				}
				//Set timer for how long to stay open.
				OpenTimer = 240;
			}
			//In mode one and open timer exists.
			while(OpenTimer>0 && Mode ==1){
				//Drop spores every two seconds.
				SporeTimer = (SporeTimer + 1)%120;
				if(SporeTimer == 0){
					for(int i = 0;i<4;i++){
						Spores[i] = FireAimedEWeapon(ghost->Weapon, Rand(32,224), 32, DegtoRad(0), 100, ghost->WeaponDamage, SPORE_SPRITE,SPORE_SFX, 0);
						SetEWeaponLifespan(Spores[i],EWL_TIMER, 240);
						SetEWeaponMovement(Spores[i], EWM_SINE_WAVE, 16, 6);
						SetEWeaponDeathEffect(Spores[i],EWD_VANISH, 0);
					}
				}
				//Handle movement.
				T1+=Misc2;
				WrapDegrees(T1);
				T2+=Misc4;
				WrapDegrees(T2);
				if(HVS==1){
					Ghost_X = StartX + Misc1*Sin(T1);
				}
				else if(HVS==2){
					Ghost_Y = StartY + Misc1*Sin(T1);
				}
				else if(HVS==3){
					Ghost_X = StartX+Misc1*Cos(T1);
					Ghost_Y = StartY+Misc3*Sin(2*T2);
				}
				//Align parts with core.
				ShellTop->X = Ghost_X-32;
				ShellTop->Y = Ghost_Y-44;
				ShellBottom->X = ShellTop->X;
				ShellBottom->Y = Ghost_Y+36;;
				FirstSegment->X =Ghost_X-8;
				FirstSegment->Y =ShellTop->Y-16;
				for(int i = 0;i<=5;i++){
					TailSegments[i]->X = FirstSegment->X+12;
				}
				Calc = FirstSegment->Y/5;
				TailSegments[0]->Y = FirstSegment->Y-Calc;
				TailSegments[1]->Y = FirstSegment->Y-(Calc*2);
				TailSegments[2]->Y = FirstSegment->Y-(Calc*3);
				TailSegments[3]->Y = FirstSegment->Y-(Calc*4);
				TailSegments[4]->Y = FirstSegment->Y-(Calc*5);
				TailSegments[5]->Y = 0;
				OpenTimer--;
				Spore_Waitframe(this,ghost,ShellTop,ShellBottom,FirstSegment,TailSegments);
			}
			//In mode one, open and open time is less than or equal to zero.
			if(Mode == 1 && !Closed && OpenTimer<=0){
				Mode = 0;//Go to mode zero.
				Closed = true;//Restore defenses.
				ghost->Defense[NPCD_ARROW] =NPCDT_IGNORE;
				//Move top shell over core.
				while(ShellTop->Y<Ghost_Y-16){
					ShellTop->Y++;
					FirstSegment->Y =ShellTop->Y-16;
					Calc = FirstSegment->Y/5;
					TailSegments[0]->Y = FirstSegment->Y-Calc;
					TailSegments[1]->Y = FirstSegment->Y-(Calc*2);
					TailSegments[2]->Y = FirstSegment->Y-(Calc*3);
					TailSegments[3]->Y = FirstSegment->Y-(Calc*4);
					TailSegments[4]->Y = FirstSegment->Y-(Calc*5);
					TailSegments[5]->Y = 0;
					Spore_Waitframe(this,ghost,ShellTop,ShellBottom,FirstSegment,TailSegments);
				}
				//Move bottom shell over core.
				while(ShellBottom->Y>Ghost_Y+16){
					ShellBottom->Y--;
					FirstSegment->Y =ShellTop->Y-16;
					Calc = FirstSegment->Y/5;
					TailSegments[0]->Y = FirstSegment->Y-Calc;
					TailSegments[1]->Y = FirstSegment->Y-(Calc*2);
					TailSegments[2]->Y = FirstSegment->Y-(Calc*3);
					TailSegments[3]->Y = FirstSegment->Y-(Calc*4);
					TailSegments[4]->Y = FirstSegment->Y-(Calc*5);
					TailSegments[5]->Y = 0;
					Spore_Waitframe(this,ghost,ShellTop,ShellBottom,FirstSegment,TailSegments);
				}
				//Set closed timer.
				OpenTimer = 240;
			}
			//In mode zero and open timer exists.
			while(OpenTimer>0 && Mode ==0){
				//Create spores every two seconds.
				SporeTimer = (SporeTimer + 1)%120;
				if(SporeTimer == 0){
					for(int i = 0;i<4;i++){
						Spores[i] = FireAimedEWeapon(ghost->Weapon, Rand(32,224), 0, DegtoRad(90), 50, ghost->WeaponDamage, SPORE_SPRITE,SPORE_SFX, 0);
						SetEWeaponLifespan(Spores[i],EWL_TIMER, 240);
						SetEWeaponMovement(Spores[i], EWM_SINE_WAVE, 16, 6);
						SetEWeaponDeathEffect(Spores[i],EWD_VANISH, 0);
					}
				}
				//Handle movement.
				T1+=Misc2;
				WrapDegrees(T1);
				T2+=Misc4;
				WrapDegrees(T2);
				if(HVS==1){
					Ghost_X = StartX + Misc1*Sin(T1);
				}
				else if(HVS==2){
					Ghost_Y = StartY + Misc1*Sin(T1);
				}
				else if(HVS==3){
					Ghost_X = StartX+Misc1*Cos(T1);
					Ghost_Y = StartY+Misc3*Sin(2*T2);
				}
				//Align parts with core.
				ShellTop->X = Ghost_X-32;
				ShellTop->Y = Ghost_Y-16;
				ShellBottom->X = ShellTop->X;
				ShellBottom->Y = Ghost_Y+16;;
				FirstSegment->X =Ghost_X-8;
				FirstSegment->Y =ShellTop->Y-16;
				for(int i = 0;i<=5;i++){
					TailSegments[i]->X = FirstSegment->X+12;
				}
				Calc = FirstSegment->Y/5;
				TailSegments[0]->Y = FirstSegment->Y-Calc;
				TailSegments[1]->Y = FirstSegment->Y-(Calc*2);
				TailSegments[2]->Y = FirstSegment->Y-(Calc*3);
				TailSegments[3]->Y = FirstSegment->Y-(Calc*4);
				TailSegments[4]->Y = FirstSegment->Y-(Calc*5);
				TailSegments[5]->Y = 0;
				OpenTimer--;
				Spore_Waitframe(this,ghost,ShellTop,ShellBottom,FirstSegment,TailSegments);
			}
			Spore_Waitframe(this,ghost,ShellTop,ShellBottom,FirstSegment,TailSegments);
		}
	}
	//Custom waitframe.
	void Spore_Waitframe(ffc f, npc n, npc top, npc bottom, npc first, npc tail){
		n->Jump = 0;
		top->Jump = 0;
		bottom->Jump = 0;
		first->Jump = 0;
		for(int i = 0;i<=5;i++){
			tail[i]->Jump = 0;
		}
		if(!Ghost_Waitframe(f, n, false, false)){
			if ( ghost->HP <= 0 ) {
				ShellTop->HP = 0;
				ShellBottom->HP = 0;
				FirstSegment->HP = 0;
				TailSegments[0]->HP = 0;
				TailSegments[1]->HP = 0;
				TailSegments[2]->HP =0;
				TailSegments[3]->HP = 0;
				TailSegments[4]->HP = 0;
				TailSegments[5]->HP = 0;
				TailSegments[6]->HP =0;
			
			}
			
			RunEnemyExplosionFFC(ShellTop, FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(ShellBottom, FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(FirstSegment, FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[0], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[1], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[2], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[3], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[4], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[5], FFC_NUM_OF_EXPLOSIONS);
			RunEnemyExplosionFFC(TailSegments[6], FFC_NUM_OF_EXPLOSIONS);
			
			n->Jump = 0;
			top->Jump = 0;
			bottom->Jump = 0;
			first->Jump = 0;
			for(int i = 0;i<=5;i++){
				tail[i]->Jump = 0;
			}
			for(int i = 0;i<Screen->NumNPCs();i++){
				npc e = Screen->LoadNPC(i);
				int Args[8]= {i,FFC_EXPLOSIONS_BOSS_EXTRA,FFC_EXPLOSION_SPRITE_ENEM_BOSS};
				RunFFCScript(FFC_ENEMY_EXPLODE, Args);
			}
			//Kill the tails first.
			 for(int i = 0;i<=5;i++){
				tail[i]->HP = 0;
			 }
			 first->HP = 0;
			 bottom->HP = 0;
			 top->HP = 0;
			 n->HP = 0;
			 Quit();
		}
	}
}

// Section 30. ghost.zh
// ghost.zh
// Version 2.8.0

// See ghost.txt for documentation.

// Standard settings -----------------------------------------------------------

// Small (1x1) shadow settings
const int GH_SHADOW_TILE = 27425;
const int GH_SHADOW_CSET = 7;
const int GH_SHADOW_FRAMES = 4;
const int GH_SHADOW_ANIM_SPEED = 8;
const int GH_SHADOW_TRANSLUCENT = 1; // 0 = No, 1 = Yes
const int GH_SHADOW_FLICKER = 0; // 0 = No, 1 = Yes

// Large (2x2) shadow settings
// If GH_LARGE_SHADOW_TILE is 0, large shadows will be disabled
const int GH_LARGE_SHADOW_TILE = 27425; // Top-left corner
const int GH_LARGE_SHADOW_CSET = 7;
const int GH_LARGE_SHADOW_FRAMES = 4;
const int GH_LARGE_SHADOW_ANIM_SPEED = 8;
const int GH_LARGE_SHADOW_MIN_WIDTH = 3;  // Enemies must be at least this wide
const int GH_LARGE_SHADOW_MIN_HEIGHT = 3; // and this high to use large shadows

// AutoGhost settings
const int AUTOGHOST_MIN_FFC = 1; // Min: 1, Max: 32
const int AUTOGHOST_MAX_FFC = 32; // Min: 1, Max: 32
const int AUTOGHOST_MIN_ENEMY_ID = 20; // Min: 20, Max: 511
const int AUTOGHOST_MAX_ENEMY_ID = 511; // Min: 20, Max: 511

// Other settings
const int GH_DRAW_OVER_THRESHOLD = 32;
const float GH_GRAVITY = 0.16;
const float GH_TERMINAL_VELOCITY = 3.2;
const int GH_SPAWN_SPRITE = 22; // Min: 0, Max: 255, Default: 22
const int GH_FAKE_Z = 1; // 0 = No, 1 = Yes
const int __GH_FAKE_EWEAPON_Z = 0; // 0 = No, 1 = Yes
const int GH_ENEMIES_FLICKER = 0; // 0 = No, 1 = Yes
const int GH_PREFER_GHOST_ZH_SHADOWS = 0; // 0 = No, 1 = Yes

// Top-left corner of a 4x4 block of blank tiles
const int GH_BLANK_TILE = 65456; // Min: 0, Max: 65456

// Invisible combo with no properties set
const int GH_INVISIBLE_COMBO = 164; // Min: 1, Max: 65279

// Always read script name and combo from the enemy's name,
// freeing up attributes 11 and 12
const int __GH_ALWAYS_USE_NAME = 0;

// End standard settings -------------------------------------------------------



// Advanced settings -----------------------------------------------------------

// AutoGhost will read a script name from the enemy's name if attribute 12
// is set to this. Must be a negative number.
const int AUTOGHOST_READ_NAME = -1;

// When reading a script from the enemy name, this character marks the
// beginning of the script name.
// Default: 64 ( @ )
const int AUTOGHOST_DELIMITER = 64;

// Misc. attribute 11 can be set to this instead of GH_INVISIBLE_COMBO.
// Must be a negative number.
const int __GH_INVISIBLE_ALT = -1;

// This will use the invisible combo, but also set npc->Extend to 3 or 4,
// hiding the initial spawn puff. Must be a negative number.
const int __GH_INVISIBLE_EXTEND = -2;

// If enabled, the FFC will be invisible, and Screen->DrawCombo will be used
// to display enemies.
const int __GH_USE_DRAWCOMBO = 1;

// Enemies flash or flicker for this many frames when hit. This does not
// affect enemies that use the invisible combo.
// Default: 32
const int __GH_FLASH_TIME = 32;

// Enemies will be knocked back for this many frames when hit.
// Default: 16
// Max: 4095
const int __GH_KNOCKBACK_TIME = 16;

// The speed at which enemies are knocked back, in pixels per frame.
// Default: 4
const int __GH_KNOCKBACK_STEP = 4;

// The imprecision setting used when a movement function is called internally
// (except for walking functions).
const int __GH_DEFAULT_IMPRECISION = 2;

// npc->Misc[] index
// Set this so it doesn't conflict with other scripts. Legal values are 0-15.
const int __GHI_NPC_DATA = 15;

// eweapon->Misc[] indices
// These must be unique numbers between 0 and 15.
const int __EWI_FLAGS          = 15; // Every index but this one can be used by non-ghost.zh EWeapons
const int __EWI_ID             = 3;
const int __EWI_XPOS           = 4;
const int __EWI_YPOS           = 5;
const int __EWI_WORK           = 6;
const int __EWI_WORK_2         = 7; // Only used by a few movement types
const int __EWI_MOVEMENT       = 8;
const int __EWI_MOVEMENT_ARG   = 9;
const int __EWI_MOVEMENT_ARG_2 = 10;
const int __EWI_LIFESPAN       = 11;
const int __EWI_LIFESPAN_ARG   = 12;
const int __EWI_ON_DEATH       = 13;
const int __EWI_ON_DEATH_ARG   = 14;

// These are only used by dummy EWeapons;
// they can use the same values as __EWI_XPOS and __EWI_YPOS
const int __EWI_DUMMY_SOUND    = 2;
const int __EWI_DUMMY_STEP     = 4;
const int __EWI_DUMMY_SPRITE   = 5;

// Returns true if the given combo should be considered a pit.
bool __IsPit(int combo)
{
    return IsPit(combo); // std.zh implementation by default
}

// Returns true if enemies are visible on screens with the
// "All Enemies Are Invisible" flag enabled
bool __HaveAmulet()
{
    return Link->Item[I_AMULET1] || Link->Item[I_AMULET2];
}

// End advanced settings -------------------------------------------------------


import "ghost_zh/2.8/common.zh"
import "ghost_zh/2.8/deprecated.zh"
import "ghost_zh/2.8/drawing.zh"
import "ghost_zh/2.8/eweapon.zh"
import "ghost_zh/2.8/eweaponDeath.zh"
import "ghost_zh/2.8/eweaponMovement.zh"
import "ghost_zh/2.8/flags.zh"
import "ghost_zh/2.8/global.zh"
import "ghost_zh/2.8/init.zh"
import "ghost_zh/2.8/modification.zh"
import "ghost_zh/2.8/movement.zh"
import "ghost_zh/2.8/other.zh"
import "ghost_zh/2.8/update.zh"

import "ghost_zh/2.8/scripts.z"



void RunEnemyExplosionFFC(npc n, int numExplosions){
	int fX; //Set up variables to hold X/Y coordinates.
	int fY;
	
	if ( n->HP <= 0 ) { //if the NPC is dead, or dying...
		fX = n->X; //Assign its coordinates to the variables...
		fY = n->Y;
		
		int f_args[4]={fX,fY,numExplosions,0}; //...then make an array, and assign those variables as its indices.
		//if ( numExplosions ) 
		
		RunFFCScript(FFC_ENEMY_EXPLODE, f_args); //Launch the FFC script designated by FFC_ENEMY_EXPLODE
							 //using the values stored in the array f_args as the FFC 
							 //arguments D0 and D1.
	}
}


//Enemy Type Constants / Flags
const int ENEM_TYPE_BOSS = 0; 
const int ENEM_TYPE_NORMAL = 1;
const int ENEM_TYPE_MINIBOSS = 2;
const int ENEM_TYPE_FINAL_BOSS = 4;

//Enemy Explosion Constants
const int FFC_ENEMY_EXPLODE = 1; //Set to FFC script slot for death explosion FFC animation.
const int FFC_NUM_OF_EXPLOSIONS = 4; //Base number of explosions when killing an enemy.
const int FFC_EXPLOSION_SPRITE = 0; //Sprite for the explosion.
const int FFC_EXPLOSION_EXTEND = 3; //Size of explosion eweapon.
const int FFC_EXPLOSION_TILEWIDTH = 1; //Width of explosion, in tiles.
const int FFC_EXPLOSION_TILEHEIGHT = 1; //Height of explosion, in tiles.

const int FFC_EXPLOSIONS_MINIBOSS_EXTRA = 4; //Add this many explosions if the enemy is a miniboss.
const int FFC_EXPLOSIONS_BOSS_EXTRA = 12; //Add this many explosions if the enemy is a full boss.
const int FFC_EXPLOSIONS_FINALBOSS_EXTRA = 16; //Add this many explosions if the enemy is the FINAL boss.

const int FFC_EXPLOSION_SPRITE_NORMAL_ENEM = 87; //Sprite to use for ordinary enemy explosions.
const int FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS = 9; //Sprite for explosions if the enemy is a mini-boss.
const int FFC_EXPLOSION_SPRITE_ENEM_BOSS = 17; //Sprite for explosions if the enemy is a Boss.
const int FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS = 81; //Sprite for explosions if the enemy if the FINAL BOSS in the game.

const int FFC_EXPLOSION_DELAY = 4; //The delay in frames between explosions.

const int FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS = 2; //Number of extra explosions if player has Piece of Power
							 //power-up (attack) boost.
							 
const int EXPLODE_INVIS_COMBO = 735; //A general use invisible combo, that we never actually use. This is here as a reference only.

const int EXPLOSION_TWO_DIST = 2; //The distance modifier (in PIXELS) for the second explolsion effect (layered explosions).
const int EXPLOSION_THREE_DIST = 3; //The distance modifier (in PIXELS) for the third explolsion effect (layered explosions).
const int EXPLOSION_FOUR_DIST = 4; //The distance modifier (in PIXELS) for the fourth explolsion effect (layered explosions).

const int EXPLOSION_DIST_NORMAL = 8; 	//The -N and +N values to Randomise for distance of explosion 
					//FFC for normal enemies.
const int EXPLOSION_DIST_MINIBOSS = 12; //The -N and +N values to Randomise for distance of explosion 
				        //FFC for Mini-Boss enemies.
const int EXPLOSION_DIST_BOSS = 16; 	//The -N and +N values to Randomise for distance of explosion
					//FFC for Boss enemies.
const int EXPLOSION_DIST_FINAL_BOSS = 24; //The -N and +N values to Randomise for distance of explosion 
				          //FFC for your FINAL BOSS enemy.
const int EXPLOSION_DIST_OTHER = 10;  //The -N and +N values to Randomise for distance of explosion FFC 
				      //as a CATCH_ALL for enemies not included elsewhere.



//FFC Script: If you wish to use an FFC to generate this effect, assign this to a slot, update the constant above, then recompile. 

//FFC of death animation explosion, to use as alternative to global function.
//Do not call this directly, by assigning it to a screen FFC. This is designed to automatically run when needed.
//...unless you want something to look like it is perpetually exploding, but then, this will need modification to do that.

//NPC pointer, number of explosions, enemy type/flag
ffc script Explosion{
	void run (int nx, int ny, int numExplosions, int enemType){ //Inputs for coordinates. 

		//These args are to accept input by the instruction: RunFFCScript(FFC_ENEMY_EXPLODE, args[]) from other functions.
		eweapon explosion; //Create a dummy eweapon.
		eweapon explosion2;
		eweapon explosion3;
		eweapon explosion4;
		this->X = nx;
		this->Y = ny;
		int explosionCount = numExplosions;
		
		while ( explosionCount > 0 ) {
			for ( int q = 0; q <= numExplosions; q++ ) {

				//Run a for loop, to make a timed series of explosions...
				explosion = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				explosion2 = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				explosion3 = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				explosion4 = Screen->CreateEWeapon(EW_SCRIPT1); //Make an explosion..
				Game->PlaySound(SFX_ENEMY_EXPLOSION);
				explosion->CollDetection = false; //...that doesn;t hurt anyone...
				explosion2->CollDetection = false; //...that doesn;t hurt anyone...
				explosion3->CollDetection = false; //...that doesn;t hurt anyone...
				explosion4->CollDetection = false; //...that doesn;t hurt anyone...
				
				
				if ( enemType == ENEM_TYPE_NORMAL ) {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
					explosion2->X = this->X + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at X coordinates fX plus a slightly randomised offset.
					explosion2->Y = this->Y + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at Y coordinates fX plus a slightly randomised offset.
					explosion2->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
					explosion3->X = this->X + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at X coordinates fX plus a slightly randomised offset.
					explosion3->Y = this->Y + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at Y coordinates fX plus a slightly randomised offset.
					explosion3->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
					explosion4->X = this->X + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at X coordinates fX plus a slightly randomised offset.
					explosion4->Y = this->Y + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_NORMAL,EXPLOSION_DIST_NORMAL); //at Y coordinates fX plus a slightly randomised offset.
					explosion4->UseSprite(FFC_EXPLOSION_SPRITE_NORMAL_ENEM); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_MINIBOSS ) {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion2->X = this->X + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion2->Y = this->Y + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion3->X = this->X + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion3->Y = this->Y + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion4->X = this->X + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion4->Y = this->Y + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_MINIBOSS,EXPLOSION_DIST_MINIBOSS); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
					explosion2->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
					explosion3->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
					explosion4->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_MINIBOSS); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_BOSS ) {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion2->X = this->X + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion2->Y = this->Y + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at Y coordinates fX plus a slightly randomised offset.
				
					explosion3->X = this->X + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion3->Y = this->Y + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at Y coordinates fX plus a slightly randomised offset.
				
					explosion4->X = this->X + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion4->Y = this->Y + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_BOSS,EXPLOSION_DIST_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
					explosion2->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
					explosion3->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
					explosion4->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_BOSS); //...using this sprite
				}
				else if ( enemType == ENEM_TYPE_FINAL_BOSS ) {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion2->X = this->X + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion2->Y = this->Y + EXPLOSION_TWO_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion3->X = this->X + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion3->Y = this->Y + EXPLOSION_THREE_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at Y coordinates fX plus a slightly randomised offset.
					
					explosion4->X = this->X + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at X coordinates fX plus a slightly randomised offset.
					explosion4->Y = this->Y + EXPLOSION_FOUR_DIST + Rand(-EXPLOSION_DIST_FINAL_BOSS,EXPLOSION_DIST_FINAL_BOSS); //at Y coordinates fX plus a slightly randomised offset.
		
					explosion->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
					explosion2->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
					explosion3->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
					explosion4->UseSprite(FFC_EXPLOSION_SPRITE_ENEM_FINAL_BOSS); //...using this sprite
				}
				else {
					explosion->X = this->X + Rand(-EXPLOSION_DIST_OTHER,EXPLOSION_DIST_OTHER); //at X coordinates fX plus a slightly randomised offset.
					explosion->Y = this->Y + Rand(-EXPLOSION_DIST_OTHER,EXPLOSION_DIST_OTHER); //at Y coordinates fX plus a slightly randomised offset.
					explosion->UseSprite(FFC_EXPLOSION_SPRITE); //...using this sprite
				}
				
				explosion->Extend = FFC_EXPLOSION_EXTEND; //...with extended size
				explosion->TileWidth = FFC_EXPLOSION_TILEWIDTH; //...this many tiles wide
				explosion->TileHeight = FFC_EXPLOSION_TILEHEIGHT; ///...this many tiles high
				
				
				for ( int w = 0; w <= FFC_EXPLOSION_DELAY; w++){
					Waitframe();
				}
				explosion->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion); //...and remove it.
				explosion2->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion2); //...and remove it.
				explosion3->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion3); //...and remove it.
				explosion4->DeadState = WDS_DEAD; //Kill the eweapon
				Remove(explosion4); //...and remove it.
				explosionCount--;
				
				Waitframe(); //..pause, then go back to the top of this loop, to repeat until the number of
					     // explosions is a total matching FFC_NUM_OF_EXPLOSIONS + FFC_EXPLOSION_PIECE_OF_POWER_EXTRA_BLASTS
			}
			Waitframe();
		}
		explosion->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion); //...and remove it.
		explosion2->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion2); //...and remove it.
		explosion3->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion3); //...and remove it.
		explosion4->DeadState = WDS_DEAD; //Kill the eweapon
		Remove(explosion4); //...and remove it.
		this->X = -100;
		this->Y = -100;
		this->Data = 0; //...set the FFC script slot back to a usable state.
		this->Script = 0;
		Quit(); //...and exit. 
	}
}

