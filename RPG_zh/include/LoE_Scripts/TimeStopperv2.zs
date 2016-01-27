const int SFX_TIMESTOP_ON = 47; //"Stopwatch ON" sound
const int SFX_TIMESTOP_OFF = 46; //"Stopwatch OFF" sound
const int SFX_TIMETICK = 22; //Sound to play every 60 frames when Stopwatch is active
const int I_GHOSTZH_CLOCK = 154; // Used to time-stop ghosted enemies. 
const int NPC_DUMMY=200; // Dummy enemy ID.
const int TIMESTOP_FFC_SCRIPT = 33; //When this script is compiled and assigned to FFC script slot, 
//change this constant to slot number of this script and re-compile.

//DO: Duretion of time-stop effect, in frames.
//D1: Currently unused.
ffc script Stopwatch{
	void run(int duration, int sprite){
		if (CountFFCsRunning(TIMESTOP_FFC_SCRIPT)>1) Quit(); //Check if time is already stopped 
		//if (!AmmoManager(CR_RUPEES, 5, 0)) Quit(); //Check if Link has enough hearts to fuel Stopwatch
		int timer=0; // Initialize timer
		npc STOPPED[50]; //Declare arrays needed to record enemy data.
		int ENEMY_ID[48];
		int ENEMY_TYPE[48];
		int ENEMY_X[48];
		int ENEMY_Y[48];
		int ENEMY_TILE[48];
		int ENEMY_CSET[48];
		int ENEMY_ORIGTILE[48];
		int ENEMY_HP[48];
		int ENEMY_EXTEND[48];
		int ENEMY_DAMAGE[48];
		int ENEMY_HITXOFFSET[48];
		int ENEMY_HITYOFFSET[48];
		int ENEMY_DRAWXOFFSET[48];
		int ENEMY_DRAWYOFFSET[48];
		int ENEMY_HITWIDTH[48];
		int ENEMY_HITHEIGHT[48];
		int ENEMY_TILEWIDTH[48];
		int ENEMY_TILEHEIGHT[48];
		int ENEMY_DROPSET[48];
		int ENEMY_MISCFLAGS[48];
		int ENEMY_BRANG_DEFENSE[48];
		int ENEMY_BOMB_DEFENSE[48];
		int ENEMY_SBOMB_DEFENSE[48];
		int ENEMY_ARROW_DEFENSE[48];
		int ENEMY_FIRE_DEFENSE[48];
		int ENEMY_WAND_DEFENSE[48];
		int ENEMY_MAGIC_DEFENSE[48];
		int ENEMY_HOOKSHOT_DEFENSE[48];
		int ENEMY_HAMMER_DEFENSE[48];
		int ENEMY_SWORD_DEFENSE[48];
		int ENEMY_SWORDBEAM_DEFENSE[48];
		int ENEMY_REFBEAM_DEFENSE[48];
		int ENEMY_REFMAGIC_DEFENSE[48];
		int ENEMY_REFFIREBALL_DEFENSE[48];
		int ENEMY_REFROCK_DEFENSE[48];
		int ENEMY_STOMP_DEFENSE[48];
		int ENEMY_BYRNA_DEFENSE[48];
		int ENEMY_SCRIPT_DEFENSE[48];
		//Initialize eweapon data.
		eweapon EWSTOP[1024];
		int EWSTOP_ID[1024];
		int EWSTOP_X[1024];
		int EWSTOP_Y[1024];
		int EWSTOP_Z[1024];
		int EWSTOP_DAMAGE[1024];
		int EWSTOP_SPEED[1024];
		int EWSTOP_ASPEED[1024];
		int EWSTOP_CSET[1024];
		int EWSTOP_ORIGCSET[1024];
		int EWSTOP_DIR[1024];
		int EWSTOP_TILE[1024];
		int EWSTOP_ORIGTILE[1024];
		int EWSTOP_FLASH_CSET[1024];
		bool EWSTOP_FLASH[1024];
		int EWSTOP_NUMFRAMES[1024];
		int EWSTOP_FRAME[1024];
		bool EWSTOP_ANGULAR[1024];
		float EWSTOP_ANGLE[1024];
		int EWSTOP_FLIP[1024];
		int EWSTOP_DEADSTATE[1024];
		int EWSTOP_DRAWXOFFSET[1024];
		int EWSTOP_DRAWYOFFSET[1024];
		int EWSTOP_DRAWZOFFSET[1024];
		int EWSTOP_HITXOFFSET[1024];
		int EWSTOP_HITYOFFSET[1024];
		int EWSTOP_HITZHEIGHT[1024];
		int EWSTOP_HITWIDTH[1024];
		int EWSTOP_HITHEIGHT[1024];
		int EWSTOP_EXTEND[1024];
		int EWSTOP_TILEWIDTH[1024];
		int EWSTOP_TILEHEIGHT[1024];// Not finished...
		int EWSTOP_MISC0[1024];
		int EWSTOP_MISC1[1024];
		int EWSTOP_MISC2[1024];
		int EWSTOP_MISC3[1024];
		int EWSTOP_MISC4[1024];
		int EWSTOP_MISC5[1024];
		int EWSTOP_MISC6[1024];
		int EWSTOP_MISC7[1024];
		int EWSTOP_MISC8[1024];
		int EWSTOP_MISC9[1024];
		int EWSTOP_MISC10[1024];
		int EWSTOP_MISC11[1024];
		int EWSTOP_MISC12[1024];
		int EWSTOP_MISC13[1024];
		int EWSTOP_MISC14[1024];
		int EWSTOP_MISC15[1024];
		
		for (int i=1; i<= Screen->NumNPCs(); i++){
			STOPPED[i] = Screen->LoadNPC(i); //Record needed enemy data
			if (STOPPED[i]->isValid()){
			ENEMY_ID[i] = STOPPED[i]->ID;
			ENEMY_TYPE[i] = STOPPED[i]->Type;
			ENEMY_EXTEND[i] = STOPPED[i]->Extend;
			ENEMY_X[i] = STOPPED[i]->X;
			ENEMY_Y[i] = STOPPED[i]->Y;
			ENEMY_TILE[i] = STOPPED[i]->Tile;
			ENEMY_ORIGTILE[i] = STOPPED[i]->OriginalTile;
			ENEMY_CSET[i] = STOPPED[i]->CSet;
			ENEMY_HP[i] = STOPPED[i]->HP;
			ENEMY_DAMAGE[i] = STOPPED[i]->Damage;
			ENEMY_HITXOFFSET[i] = STOPPED[i]->HitXOffset;
			ENEMY_HITYOFFSET[i] = STOPPED[i]->HitYOffset;
			ENEMY_DRAWXOFFSET[i] = STOPPED[i]->DrawXOffset;
			ENEMY_DRAWYOFFSET[i] = STOPPED[i]->DrawYOffset;
			ENEMY_HITWIDTH[i] = STOPPED[i]->HitWidth;
			ENEMY_HITHEIGHT[i] = STOPPED[i]->HitHeight;
			ENEMY_TILEWIDTH[i] = STOPPED[i]->TileWidth;
			ENEMY_TILEHEIGHT[i] = STOPPED[i]->TileHeight;
			ENEMY_DROPSET[i] = STOPPED[i]->ItemSet;
			ENEMY_MISCFLAGS[i] = STOPPED[i]->MiscFlags;
			
			ENEMY_BRANG_DEFENSE[i] = STOPPED[i]->Defense[0];
			ENEMY_BOMB_DEFENSE[i] = STOPPED[i]->Defense[1];
			ENEMY_SBOMB_DEFENSE[i] = STOPPED[i]->Defense[2];
			ENEMY_ARROW_DEFENSE[i] = STOPPED[i]->Defense[3];
			ENEMY_FIRE_DEFENSE[i] = STOPPED[i]->Defense[4];
			ENEMY_WAND_DEFENSE[i] = STOPPED[i]->Defense[5];
			ENEMY_MAGIC_DEFENSE[i] = STOPPED[i]->Defense[6];
			ENEMY_HOOKSHOT_DEFENSE[i] = STOPPED[i]->Defense[7];
			ENEMY_HAMMER_DEFENSE[i] = STOPPED[i]->Defense[8];
			ENEMY_SWORD_DEFENSE[i] = STOPPED[i]->Defense[9];
			ENEMY_SWORDBEAM_DEFENSE[i] = STOPPED[i]->Defense[10];
			ENEMY_REFBEAM_DEFENSE[i] = STOPPED[i]->Defense[11];
			ENEMY_REFMAGIC_DEFENSE[i] = STOPPED[i]->Defense[12];
			ENEMY_REFFIREBALL_DEFENSE[i] = STOPPED[i]->Defense[13];
			ENEMY_REFROCK_DEFENSE[i] = STOPPED[i]->Defense[14];
			ENEMY_STOMP_DEFENSE[i] = STOPPED[i]->Defense[15];
			ENEMY_BYRNA_DEFENSE[i] = STOPPED[i]->Defense[16];
			ENEMY_SCRIPT_DEFENSE[i] = STOPPED[i]->Defense[17];
			}
		}
		
		for (int ew = 1; ew<= Screen->NumEWeapons(); ew++){
			EWSTOP[ew] = Screen->LoadEWeapon(ew);
			if (EWSTOP[ew]->isValid()){
			EWSTOP_ID[ew] = EWSTOP[ew]->ID;
			EWSTOP_X[ew] = EWSTOP[ew]->X;
			EWSTOP_Y[ew] = EWSTOP[ew]->Y;
			EWSTOP_Z[ew] = EWSTOP[ew]->Z;
			EWSTOP_DAMAGE[ew] = EWSTOP[ew]->Damage;
			EWSTOP_SPEED[ew] = EWSTOP[ew]->Step;
			EWSTOP_ASPEED[ew] = EWSTOP[ew]->ASpeed;
			EWSTOP_CSET[ew] = EWSTOP[ew]->CSet;
			EWSTOP_ORIGCSET[ew] = EWSTOP[ew]->OriginalCSet;
			EWSTOP_DIR[ew] = EWSTOP[ew]->Dir;
			EWSTOP_TILE[ew] = EWSTOP[ew]->Tile;
			EWSTOP_ORIGTILE[ew] = EWSTOP[ew]->OriginalTile;
			EWSTOP_FLASH_CSET[ew] = EWSTOP[ew]->FlashCSet;
			EWSTOP_FLASH[ew] = EWSTOP[ew]->Flash;
			EWSTOP_NUMFRAMES[ew] = EWSTOP[ew]->NumFrames;
			EWSTOP_FRAME[ew] = EWSTOP[ew]->Frame;
			EWSTOP_ANGULAR[ew] = EWSTOP[ew]->Angular;
			EWSTOP_ANGLE[ew] = EWSTOP[ew]->Angle;
			EWSTOP_FLIP[ew] = EWSTOP[ew]->Flip;
			EWSTOP_DEADSTATE[ew] = EWSTOP[ew]->DeadState;
			EWSTOP_DRAWXOFFSET[ew] = EWSTOP[ew]->DrawXOffset;
			EWSTOP_DRAWYOFFSET[ew] = EWSTOP[ew]->DrawYOffset;
			EWSTOP_DRAWZOFFSET[ew] = EWSTOP[ew]->DrawZOffset;
			EWSTOP_HITXOFFSET[ew] = EWSTOP[ew]->HitXOffset;
			EWSTOP_HITYOFFSET[ew] = EWSTOP[ew]->HitYOffset;
			EWSTOP_HITZHEIGHT[ew] = EWSTOP[ew]->HitZHeight;
			EWSTOP_HITWIDTH[ew] = EWSTOP[ew]->HitWidth;
			EWSTOP_HITHEIGHT[ew] = EWSTOP[ew]->HitHeight;
			EWSTOP_EXTEND[ew] = EWSTOP[ew]->Extend;
			EWSTOP_TILEWIDTH[ew] = EWSTOP[ew]->TileWidth;
			EWSTOP_TILEHEIGHT[ew] = EWSTOP[ew]->TileHeight;
			EWSTOP_MISC0[ew] = EWSTOP[ew]->Misc[0];
			EWSTOP_MISC1[ew] = EWSTOP[ew]->Misc[1];
			EWSTOP_MISC2[ew] = EWSTOP[ew]->Misc[2];
			EWSTOP_MISC3[ew] = EWSTOP[ew]->Misc[3];
			EWSTOP_MISC4[ew] = EWSTOP[ew]->Misc[4];
			EWSTOP_MISC5[ew] = EWSTOP[ew]->Misc[5];
			EWSTOP_MISC6[ew] = EWSTOP[ew]->Misc[6];
			EWSTOP_MISC7[ew] = EWSTOP[ew]->Misc[7];
			EWSTOP_MISC8[ew] = EWSTOP[ew]->Misc[8];
			EWSTOP_MISC9[ew] = EWSTOP[ew]->Misc[9];
			EWSTOP_MISC10[ew] = EWSTOP[ew]->Misc[10];
			EWSTOP_MISC11[ew] = EWSTOP[ew]->Misc[11];
			EWSTOP_MISC12[ew] = EWSTOP[ew]->Misc[12];
			EWSTOP_MISC13[ew] = EWSTOP[ew]->Misc[13];
			EWSTOP_MISC14[ew] = EWSTOP[ew]->Misc[14];
			EWSTOP_MISC15[ew] = EWSTOP[ew]->Misc[15];
			}
		}
		
		Game->PlaySound(SFX_TIMESTOP_ON); //Play stopwatch activation sound
		if (((Screen->EFlags[1])&8)==0){ // Stopwatch does not work against bosses.
		for (int i=1; i<=Screen->NumNPCs(); i++){ //Replace enemies with dummies
			if (STOPPED[i]->isValid()){
			if ((STOPPED[i]->Attributes[11])==0) {//Ghosted enemies should have special treatment.			
			STOPPED[i]->ItemSet=0;
			Remove(STOPPED[i]);
			STOPPED[i] = Screen->CreateNPC(NPC_DUMMY);
			if (ENEMY_TYPE[i] != NPCT_WALLMASTER)STOPPED[i]->OriginalTile = ENEMY_TILE[i];
			else STOPPED[i]->CollDetection = false;
			STOPPED[i]->X=ENEMY_X[i];
			STOPPED[i]->Y=ENEMY_Y[i];
			STOPPED[i]->CSet = ENEMY_CSET[i];
			STOPPED[i]->HP = ENEMY_HP[i];
			STOPPED[i]->Extend = ENEMY_EXTEND[i];
			STOPPED[i]->Damage = ENEMY_DAMAGE[i];
			STOPPED[i]->ItemSet = ENEMY_DROPSET[i];
			STOPPED[i]->MiscFlags = ENEMY_MISCFLAGS[i];
			STOPPED[i]->HitXOffset = ENEMY_HITXOFFSET[i];
			STOPPED[i]->HitYOffset = ENEMY_HITYOFFSET[i];
			STOPPED[i]->DrawXOffset = ENEMY_DRAWXOFFSET[i];
			STOPPED[i]->DrawYOffset = ENEMY_DRAWYOFFSET[i];
			STOPPED[i]->HitWidth = ENEMY_HITWIDTH[i];
			STOPPED[i]->HitHeight = ENEMY_HITHEIGHT[i];
			STOPPED[i]->TileWidth= ENEMY_TILEWIDTH[i];
			STOPPED[i]->TileHeight = ENEMY_TILEHEIGHT[i];
			STOPPED[i]->Defense[0] = ENEMY_BRANG_DEFENSE[i];
			STOPPED[i]->Defense[1] = ENEMY_BOMB_DEFENSE[i];
			STOPPED[i]->Defense[2] = ENEMY_SBOMB_DEFENSE[i];
			STOPPED[i]->Defense[3] = ENEMY_ARROW_DEFENSE[i];
			STOPPED[i]->Defense[4] = ENEMY_FIRE_DEFENSE[i];
			STOPPED[i]->Defense[5] = ENEMY_WAND_DEFENSE[i];
			STOPPED[i]->Defense[6] = ENEMY_MAGIC_DEFENSE[i];
			STOPPED[i]->Defense[7] = ENEMY_HOOKSHOT_DEFENSE[i];
			STOPPED[i]->Defense[8] = ENEMY_HAMMER_DEFENSE[i];
			STOPPED[i]->Defense[9] = ENEMY_SWORD_DEFENSE[i];
			STOPPED[i]->Defense[10] = ENEMY_SWORDBEAM_DEFENSE[i];
			STOPPED[i]->Defense[11] = ENEMY_REFBEAM_DEFENSE[i];
			STOPPED[i]->Defense[12] = ENEMY_REFMAGIC_DEFENSE[i];
			STOPPED[i]->Defense[13] = ENEMY_REFFIREBALL_DEFENSE[i];
			STOPPED[i]->Defense[14] = ENEMY_REFROCK_DEFENSE[i];
			STOPPED[i]->Defense[15] = ENEMY_STOMP_DEFENSE[i];
			STOPPED[i]->Defense[16] = ENEMY_BYRNA_DEFENSE[i];
			STOPPED[i]->Defense[17] = ENEMY_SCRIPT_DEFENSE[i];
			}
			}			
		}
		if(I_GHOSTZH_CLOCK>0){
			item ghoststopper = Screen->CreateItem(I_GHOSTZH_CLOCK);
			ghoststopper->X = Link->X;
			ghoststopper->Y = Link->Y;
		}
		for (int ew = 1; ew <= 1023; ew++){
			if (EWSTOP[ew]->isValid()){
				Remove(EWSTOP[ew]);
				EWSTOP[ew] = Screen->CreateEWeapon(EWSTOP_ID[ew]);
				EWSTOP[ew]->X = EWSTOP_X[ew];
				EWSTOP[ew]->Y = EWSTOP_Y[ew];
				EWSTOP[ew]->Z = EWSTOP_Z[ew];
				EWSTOP[ew]->Dir = EWSTOP_DIR[ew];
				EWSTOP[ew]->Damage = EWSTOP_DAMAGE[ew];
				EWSTOP[ew]->CSet = EWSTOP_CSET[ew];
				EWSTOP[ew]->Step = 0;
				EWSTOP[ew]->ASpeed = 10000;
				EWSTOP[ew]->OriginalTile = EWSTOP_TILE[ew];
				FlipEweapon (EWSTOP[ew]);
				EWSTOP[ew]->OriginalCSet = EWSTOP_ORIGCSET[ew];
				EWSTOP[ew]->Flash = false;
				//EWSTOP[ew]->FlashCSet = EWSTOP_FLASH_CSET[ew];
				//EWSTOP[ew]->NumFrames = EWSTOP_NUMFRAMES[ew];
				//EWSTOP[ew]->Frame = EWSTOP_FRAME[ew];
				if (EWSTOP[ew]->ID == EW_WIND) EWSTOP[ew]->CollDetection = false;
				//EWSTOP[ew]->Flip = EWSTOP_FLIP[ew];
				EWSTOP[ew]->DeadState = -1;
				EWSTOP[ew]->DrawXOffset = EWSTOP_DRAWXOFFSET[ew];
				EWSTOP[ew]->DrawYOffset = EWSTOP_DRAWYOFFSET[ew];
				EWSTOP[ew]->DrawZOffset = EWSTOP_DRAWZOFFSET[ew];
				EWSTOP[ew]->HitXOffset = EWSTOP_HITXOFFSET[ew];
				EWSTOP[ew]->HitYOffset = EWSTOP_HITYOFFSET[ew];
				EWSTOP[ew]->HitZHeight = EWSTOP_HITZHEIGHT[ew];
				EWSTOP[ew]->HitWidth = EWSTOP_HITWIDTH[ew];
				EWSTOP[ew]->HitHeight = EWSTOP_HITHEIGHT[ew];
				EWSTOP[ew]->Extend = EWSTOP_EXTEND[ew];
				EWSTOP[ew]->TileWidth = EWSTOP_TILEWIDTH[ew];
				EWSTOP[ew]->TileHeight = EWSTOP_TILEHEIGHT[ew];
			}
		}
		}
		else Game->PlaySound(SFX_FALL); //Debug sound used to tell if an attempt to use time-stopper in boss room.
		
		while(timer<duration){
			//TimestopDebug(STOPPED[2]);
			if ((timer%60)==0) Game->PlaySound(SFX_TIMETICK); //Play time ticking sound every 60 frames
			timer++;
			Waitframe();
		}
		Game->PlaySound(SFX_TIMESTOP_OFF); //Play timestop ending sound
		if (((Screen->EFlags[1])&8)==0){ // Don`t do anything in boss room
		for (int i=1; i<48; i++){
			if (STOPPED[i]->isValid()){ // Replace survived dummies with real enemies
				ENEMY_HP[i] = STOPPED[i]->HP; //Record dummy`s HP...
				if ((STOPPED[i]->Attributes[11])==0) { //Ghosted enemies should have special treatment.
				Remove(STOPPED[i]);
				int Origspawn = ENEMY_ID[i];
				STOPPED[i] = Screen->CreateNPC(Origspawn);
				Waitframe();
				if (STOPPED[i]->isValid()){
					//STOPPED[i]->OriginalTile = ENEMY_ORIGTILE[i];
				STOPPED[i]->X=ENEMY_X[i];
				STOPPED[i]->Y=ENEMY_Y[i];
				STOPPED[i]->HP = ENEMY_HP[i];// ...and assign it to respawned enemy
				STOPPED[i]->HitXOffset = ENEMY_HITXOFFSET[i];
				STOPPED[i]->HitYOffset = ENEMY_HITYOFFSET[i];
				STOPPED[i]->DrawXOffset = ENEMY_DRAWXOFFSET[i];
				STOPPED[i]->DrawYOffset = ENEMY_DRAWYOFFSET[i];
				STOPPED[i]->Extend = ENEMY_EXTEND[i];
				STOPPED[i]->HitWidth = ENEMY_HITWIDTH[i];
				STOPPED[i]->HitHeight = ENEMY_HITHEIGHT[i];
				STOPPED[i]->TileWidth= ENEMY_TILEWIDTH[i];
				STOPPED[i]->TileHeight = ENEMY_TILEHEIGHT[i];
				}
				}
			}
		}
		for (int ew = 1; ew<=1023; ew++){
			if (EWSTOP[ew]->isValid()){
				Remove(EWSTOP[ew]);
				EWSTOP[ew] = Screen->CreateEWeapon(EWSTOP_ID[ew]);
				EWSTOP[ew]->X = EWSTOP_X[ew];
				EWSTOP[ew]->Y = EWSTOP_Y[ew];
				EWSTOP[ew]->Z = EWSTOP_Z[ew];
				EWSTOP[ew]->Damage = EWSTOP_DAMAGE[ew];
				EWSTOP[ew]->Step = EWSTOP_SPEED[ew];
				EWSTOP[ew]->ASpeed = EWSTOP_ASPEED[ew];
				EWSTOP[ew]->Angular  = EWSTOP_ANGULAR[ew];
				EWSTOP[ew]->Angle = EWSTOP_ANGLE[ew];
				EWSTOP[ew]->OriginalTile = EWSTOP_ORIGTILE[ew];
				EWSTOP[ew]->Dir = EWSTOP_DIR[ew];
				FlipEweapon (EWSTOP[ew]);
				EWSTOP[ew]->OriginalCSet = EWSTOP_ORIGCSET[ew];
				EWSTOP[ew]->Flash = EWSTOP_FLASH[ew];
				EWSTOP[ew]->FlashCSet = EWSTOP_FLASH_CSET[ew];
				EWSTOP[ew]->NumFrames = EWSTOP_NUMFRAMES[ew];
				EWSTOP[ew]->Frame = EWSTOP_FRAME[ew];
				//EWSTOP[ew]->Flip = EWSTOP_FLIP[ew];
				EWSTOP[ew]->DeadState = EWSTOP_DEADSTATE[ew];
				EWSTOP[ew]->DrawXOffset = EWSTOP_DRAWXOFFSET[ew];
				EWSTOP[ew]->DrawYOffset = EWSTOP_DRAWYOFFSET[ew];
				EWSTOP[ew]->DrawZOffset = EWSTOP_DRAWZOFFSET[ew];
				EWSTOP[ew]->HitXOffset = EWSTOP_HITXOFFSET[ew];
				EWSTOP[ew]->HitYOffset = EWSTOP_HITYOFFSET[ew];
				EWSTOP[ew]->HitZHeight = EWSTOP_HITZHEIGHT[ew];
				EWSTOP[ew]->HitWidth = EWSTOP_HITWIDTH[ew];
				EWSTOP[ew]->HitHeight = EWSTOP_HITHEIGHT[ew];
				EWSTOP[ew]->Extend = EWSTOP_EXTEND[ew];
				EWSTOP[ew]->TileWidth = EWSTOP_TILEWIDTH[ew];
				EWSTOP[ew]->TileHeight = EWSTOP_TILEHEIGHT[ew];
				EWSTOP[ew]->Misc[0] = EWSTOP_MISC0[ew];
				EWSTOP[ew]->Misc[1] = EWSTOP_MISC1[ew];
				EWSTOP[ew]->Misc[2] = EWSTOP_MISC2[ew];
				EWSTOP[ew]->Misc[3] = EWSTOP_MISC3[ew];
				EWSTOP[ew]->Misc[4] = EWSTOP_MISC4[ew];
				EWSTOP[ew]->Misc[5] = EWSTOP_MISC5[ew];
				EWSTOP[ew]->Misc[6] = EWSTOP_MISC6[ew];
				EWSTOP[ew]->Misc[7] = EWSTOP_MISC7[ew];
				EWSTOP[ew]->Misc[8] = EWSTOP_MISC8[ew];
				EWSTOP[ew]->Misc[9] = EWSTOP_MISC9[ew];
				EWSTOP[ew]->Misc[10] = EWSTOP_MISC10[ew];
				EWSTOP[ew]->Misc[11] = EWSTOP_MISC11[ew];
				EWSTOP[ew]->Misc[12] = EWSTOP_MISC12[ew];
				EWSTOP[ew]->Misc[13] = EWSTOP_MISC13[ew];
				EWSTOP[ew]->Misc[14] = EWSTOP_MISC14[ew];
				EWSTOP[ew]->Misc[15] = EWSTOP_MISC15[ew];
			}
		}
		for (int i= 1; i<= Screen->NumLWeapons(); i++){
			lweapon reflect = Screen->LoadLWeapon(i);
			if (reflect->ID == LW_REFMAGIC) reflect->Step = 300;
			if (reflect->ID == LW_REFBEAM) reflect->Step = 300;
			if (reflect->ID == LW_REFROCK) reflect->Step = 300;
			if (reflect->ID == LW_REFFIREBALL) reflect->Step = 175;
		}
		}
		//for (int i=0; i<=300; i++){
			//TimestopDebug(STOPPED[2]);
			//Waitframe();
		//}
	}
}

//Needed for certain Eweapons to draw properly when time is stopped.
void FlipEweapon (eweapon e){
	//bool rotatetile = ((e->ID==EW_BEAM)||(e->ID==EW_MAGIC)||(e->ID==EW_ARROW)||(e->ID==EW_BOMB)||(e->ID==EW_SBOMB));
	//debugValue(1, rotatetile);
	//if (rotatetile){
	if (e->ID == EW_WIND) return;
	if (e->ID == EW_FIRE) return;
	if (e->ID == EW_FIRE2) return;
	if (e->ID == EW_FIRETRAIL) return;
	if (e->Dir==DIR_UP) e->Flip=0;
	else if (e->Dir==DIR_DOWN) e->Flip=2;
	else if (e->Dir==DIR_LEFT) e->Flip=5;
	else if (e->Dir==DIR_RIGHT) e->Flip=4;
	//}
	}