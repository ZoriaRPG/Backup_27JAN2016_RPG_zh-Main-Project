//Version 0.5.6 for RPG.zh 0.9.6.1
//Backup Arrays

int GameDynamics[8192];
bool GameEvents[8192];
bool Equipment_BAK[256];
int GameDynamics_BAK[8192];
bool GameEvents_BAL[8192];
int Counters_BAK[32];
int MCounters_BAK[32];


const int GAMESAVESTATED = 498;
const int SAVINGEQUIPMENT = 496;
const int RESTORINGEQUIPMENT = 497;
const int SAVESCREEN= 1020;
const int SAVEDMAP = 1021;
const int SAVEX = 1022;
const int SAVEY = 1023;
const int GAME_SAVED = 1024;
const int SOLID_BLACK = 1;

const int CMB_SAVE = 0; //COmbo ID of combo with inherent Save Point type.

bool GameSaveStated(){
	return GameEvents[GAMESAVESTATED];
}

bool GameSaveStated(bool set){
	GameEvents[GAMESAVESTATED] = set;
}


//bool EverSaved = false; 
//This is used exactly once, to prevent the 
//player from using the restore command if he has never saved using a Save command.
//Call this from the Tango menu for 'Game->Restore' and if false, report
//'No Saved Game to Restore' instead of restoring a blank game!

//bool SaveAndQuit = false; //This boolean is used to determine if the game was quit via the save and quit command, and not by death, or F6.
//If this boolean is true, the onContinue punishment is skipped. This boolean is set to false when the game starts every time, and set to true if the player
// Uses Game->Save and Quit or Game->Quit.
// Because it is set to false EVERY TIME THE GAME STARTS and ONLY set to TRUE when the game is SAVED FULLy with the MENU
// and NOT with QUICK SAVE, we do not need to store it in a _BAK table.



void SavePoint(){
	int curScreen = Game->GetCurScreen();
	int curDMAP = Game->GetCurDMap();
	int curX = Link->X;
	int curY = Link->Y;
	//Screen->FastCombo(0, curX, curY, CMB_SAVE, 0, 0);
	GameDynamics[SAVESCREEN] = curScreen;
	GameDynamics[SAVEDMAP] = curDMAP;
	GameDynamics[SAVEX] = curX;
	GameDynamics[SAVEY] = curY;
	GameEvents[GAME_SAVED] = true;
	SaveState();
	// ! 
	// ! Do save point combos store XY coordinates for a return point, or do they use the A warp return on a screen?
	// !
	//Link->InputStart;
	//Waitframes(1);
	//Link->InputDown;
	//Waitframes(1);
	//Link->InputDown;
	//Game->ShowSaveQuitScreen();
	Game->Save();
	//Display SAVED Message in menu. offer Quit Menu.
	//End(); //Do this if the player selects to quit.
	
}

void SaveGame(){
	int curScreen = Game->GetCurScreen();
	int curDMAP = Game->GetCurDMap();
	int curX = Link->X;
	int curY = Link->Y;
	Screen->FastCombo(0, curX, curY, CMB_SAVE, 0, 0);
	GameDynamics[SAVESCREEN] = curScreen;
	GameDynamics[SAVEDMAP] = curDMAP;
	GameDynamics[SAVEX] = curX;
	GameDynamics[SAVEY] = curY;
	SaveState();
	GameEvents[GAME_SAVED] = true;
}

void SaveGame(bool full){
	int curScreen = Game->GetCurScreen();
	int curDMAP = Game->GetCurDMap();
	int curX = Link->X;
	int curY = Link->Y;
	Screen->FastCombo(0, curX, curY, CMB_SAVE, 0, 0);
	GameDynamics[SAVESCREEN] = curScreen;
	GameDynamics[SAVEDMAP] = curDMAP;
	GameDynamics[SAVEX] = curX;
	GameDynamics[SAVEY] = curY;
	SaveState();
	GameEvents[GAME_SAVED] = true;
	if ( full ) {
		Game->Save();
	}
}

void SaveGameAndQuit(){
	int curScreen = Game->GetCurScreen();
	int curDMAP = Game->GetCurDMap();
	int curX = Link->X;
	int curY = Link->Y;
	Screen->FastCombo(0, curX, curY, CMB_SAVE, 0, 0);
	GameDynamics[SAVESCREEN] = curScreen;
	GameDynamics[SAVEDMAP] = curDMAP;
	GameDynamics[SAVEX] = curX;
	GameDynamics[SAVEY] = curY;
	SaveState();
	GameEvents[GAME_SAVED] = true;
	Game->Save();
	Game->End();
}

void RestoreGame(bool AndClearSave){
	int menuFFC = FindFFCRunning(FFCMENU);
	//Externally kill FFC 51?
	bool restoring = true;
	int restScreen = GameDynamics[SAVESCREEN];
	int restDMAP = GameDynamics[SAVEDMAP];
	int restX = GameDynamics[SAVEX];
	int restY = GameDynamics[SAVEY];
	do{
		restoring=false;
		Screen->Rectangle(6, 0, 0, 256, 172, SOLID_BLACK, 1, 0, 0, 0, true, 100);
		Link->CollDetection = false;
		Link->PitWarp(restDMAP, restScreen);
		Link->X = restX;
		Link->Y = restY;
		RestoreState();
		Link->CollDetection = true;
		if ( AndClearSave ) {
			ClearSave();
		}
	}
	while(restoring);
}

void ClearSave(){
	GameEvents[GAME_SAVED] = false;
}

bool CheckEquipment(int equip){
	for ( int i = 1; i < 255; i++){
		if ( Link->Item[equip] == true ){
			return true;
		}
	}
}

void RestoreEquipment(){
	//int state;
	for ( int i = 0; i < 255; i++ ) {
		if ( Link->Item[i] == true && Equipment_BAK[i] == false ) {
			Link->Item[i] = false;
		}
		else if ( Link->Item[i] == false && Equipment_BAK[i] == true ) {
			Link->Item[i] = true;
		}
		//Waitframe();
	}
}

void BackupEquipment(){
	//int state;
	for ( int i = 0; i < 255; i++ ) {
		if ( Link->Item[i] == true && Equipment_BAK[i] == false ) {
			Equipment_BAK[i] = true;
		}
		else if ( Link->Item[i] == false && Equipment_BAK[i] == true ) {
			Equipment_BAK[i] = false;
		}
		//Waitframe();
	}
}


void BackupCounters(){
	for (int i = 0; i < 32; i++){
		Counters_BAK[i] = Game->Counter[i];
		//Trace(Counters_BAK[i]);
	}
}

void RestoreCounters(){
	for (int i = 0; i < 32; i++){
		Game->Counter[i] = Counters_BAK[i];
	}
}



void BackupMCounters(){
	for (int i = 0; i < 32; i++){
		MCounters_BAK[i] = Game->MCounter[i];
		//Trace(Counters_BAK[i]);
	}
}

void RestoreMCounters(){
	for (int i = 0; i < 32; i++){
		Game->MCounter[i] = MCounters_BAK[i];
	}
}

void BackupGameArrays(){
	for (int i =0; i < SizeOfArray(GameDynamics); i++){
		GameEvents_BAK[i] = GameEvents[i];
		GameDynamics_BAK[i] = GameDynamics[i];
	}
}

void RestoreGameArrays(){
	for (int i = 0; i < SizeOfArray(GameDynamics); i++){
		GameEvents[i] = GameEvents_BAK[i];
		GameDynamics[i] = GameDynamics_BAK[i];
	}
}

bool RestoringEquipment(){
	if ( GameEvents[RESTORINGEQUIPMENT] == true ) {
		return true;
	}
	else {
		return false;
	}
}

bool RestoringEquipment(bool set){
	if ( set ) {
	GameEvents[RESTORINGEQUIPMENT] = true;
	}
	else if ( !set ) {
		GameEvents[RESTORINGEQUIPMENT] = false;
	}
}

bool SavingEquipment(){
	if ( GameEvents[SAVINGEQUIPMENT] == true ) {
		return true;
	}
	else {
		return false;
	}
}

bool SavingEquipment(bool set){
	if ( set ) {
	GameEvents[SAVINGEQUIPMENT] = true;
	}
	else if ( !set ) {
		GameEvents[SAVINGEQUIPMENT] = false;
	}
}


void DoEquipmentRestore(){
	for ( int i = 0; i < 256; i++ ) {
		if ( i < 256 ) {
			if ( Link->Item[i] == true && Equipment_BAK[i] == false ) {
				Link->Item[i] == false;
			}
			else if ( Link->Item[i] == false && Equipment_BAK[i] == true ) {
				Link->Item[i] == true;
			}
		}
		else if ( i == 256 ) {
			RestoringEquipment(false);
		}
		Waitframe();
	}
}

void DoEquipmentBackup(){
	for ( int i = 0; i < 256; i++ ) {
		if ( i < 256 ) {
			if ( Link->Item[i] == true && Equipment_BAK[i] == false ) {
				Equipment_BAK[i] = true;
			}
			else if ( Link->Item[i] == false && Equipment_BAK[i] == true ) {
				Equipment_BAK[i] = false;
			}
		}
		else if ( i == 256 ) {
			RestoringEquipment(false);
		}
		Waitframe();
	}
}



void SaveState(){
	//FreezeAction();
	GameSaveStated(true);
	BackupEquipment();
	BackupGameArrays();
	BackupEquipmentArrays();
	BackupMCounters();
	BackupCounters();
	//BackupTeleportMatrixArrays();
	
	//SavingEquipment(true);
	
	//Restore stat arrays, and other arrays.
	//Read all screen NPCs and store them in an array.
	TraceNL();
	int string1[]="State Saved";
	TraceS(string1);
	TraceNL();
	//UnfreezeAction();
}

void RestoreState(){
	//FreezeAction();
	RestoreEquipment();
	//RestoringEquipment(true);
	//Waitframes(1);
	RestoreGameArrays();
	RestoreEquipmentArrays();
	RestoreMCounters();
	RestoreCounters();
	//RestoreTeleportMatrixArrays();
	//GameSaveStated(true);
	//Restore stat arrays, and other arrays.
	//Remove all screen NPCs.
	//Read ScreenNPCs array and reconstruct onto screen.
	TraceNL();
	int string1[]="State Restored";
	TraceS(string1);
	TraceNL();
	//UnfreezeAction();
}


//const int SFX_SAVE_ERROR = 88; //In gc_menus_GameMenu.z
//const int SFX_SAVE_SUCCESS = 93; //In gc_menus_GameMenu.z

bool SaveMenu(){

    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";

    int line1[]="@choice(1)Quick Save@26";
    int line2[]="@choice(2)Full Save@26";
int line3[]="@choice(3)Save and Quit@26";
	int line4[]="@choice(4)Cancel@26";
	int line5[]="@26@choice(5)CLEAR SAVE";


    
    SetUpWindow(WINDOW_SLOT_3, WINDOW_STYLE_3, 32, 32, SIZE_LARGE);
        Tango_LoadString(WINDOW_SLOT_3, line1);
        Tango_AppendString(WINDOW_SLOT_3, line2);
	Tango_AppendString(WINDOW_SLOT_3, line3);
	Tango_AppendString(WINDOW_SLOT_3, line4);
	Tango_AppendString(WINDOW_SLOT_3, line5);
        Tango_AppendString(WINDOW_SLOT_3, menuEnd);
        Tango_ActivateSlot(WINDOW_SLOT_3);
    
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[278];
		int menuState[960];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_3, slotState);
    Tango_SaveMenuState(menuState);
    
    int done=0;
    int choice;
    while(true)
    {
    
        while(Tango_MenuIsActive())
        {
            
            cursorPos=Tango_GetMenuCursorPosition();
          
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=2;
            
        else if(choice == 1) 
        {
		done = 1;
           SaveGame();
		Game->PlaySound(SFX_SAVE_SUCCESS);
		
		int text[]="Game State Saved";
            Tango_ClearSlot(3);
            ShowString(text, WINDOW_SLOT_5, WINDOW_STYLE_2, 48, 48);
		menuArg=choice;
        }
	
	else if(choice == 2) 
        {
		done = 1;
           SaveGame(true);
		Game->PlaySound(SFX_SAVE_SUCCESS);
		int text[]="Game Fully Saved";
            Tango_ClearSlot(3);
            ShowString(text, WINDOW_SLOT_5, WINDOW_STYLE_2, 48, 48);
		menuArg=choice;
        }
	
	else if(choice == 3) 
        {
            done = 1;
		SaveGameAndQuit();
		menuArg = choice;
        }
	
	else if(choice == 4) 
        {
            done = 1;
		menuArg = choice;
        }
	
	else if(choice == 5) 
        {
            done = 1;
	    ClearSave();
	    int text[]="Save Cleared";
            Tango_ClearSlot(3);
            ShowString(text, WINDOW_SLOT_5, WINDOW_STYLE_2, 48, 48);
		menuArg = choice;
        }
         
        else if (Link->PressEx1){
                done = 2;
        }
        else
            done=2;

        

        
        if(done>0){
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_3, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    
    Tango_ClearSlot(WINDOW_SLOT_3);
    
    if(done==1)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}

//const int SFX_SAVE_ERROR = 88; //In gc_menus_GameMenu.z
//const int SFX_SAVE_SUCCESS = 93; //In gc_menus_GameMenu.z

bool RestoreMenu()
{
    //SetUpWindow(WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32, SIZE_LARGE);
    //int spellFormat[]="@choice(%d)Spell %d";
    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";
    //int spellIce[]="@choice(%d)Water/Ice";
    //int spellFire[]="@choice(%d)Fire/Heat";
    
    //for(int i=1; i<9; i++)
    //{
    //    int buffer[40];
    //    sprintf(buffer, spellFormat, i, i);
    //    Tango_AppendString(WINDOW_SLOT_2, buffer);
    //    if(i<7)
    //        Tango_AppendString(WINDOW_SLOT_2, lineBreak);
    //}
    
    int line1[]="@choice(1)Restore@26";
    int line2[]="@choice(2)Cancel@26";
    
    //@choice(2)Light@domenu(1)@suspend()
    
    SetUpWindow(WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32, SIZE_LARGE);
        Tango_LoadString(WINDOW_SLOT_2, line1);
        Tango_AppendString(WINDOW_SLOT_2, line2);
        Tango_AppendString(WINDOW_SLOT_2, menuEnd);
        Tango_ActivateSlot(WINDOW_SLOT_2);
    
    
    //Tango_AppendString(WINDOW_SLOT_2, menuEnd);
    //Tango_ActivateSlot(WINDOW_SLOT_2);
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[278];
	int menuState[960];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_2, slotState);
    Tango_SaveMenuState(menuState);
    
    bool done = false;
    int choice;
    while(true)
    {
    
        while(Tango_MenuIsActive())
        {
            
            cursorPos=Tango_GetMenuCursorPosition();
          
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=true;
            
        else if(choice == 1) 
        {
		if ( !GameSaveStated() ) {
			Game->PlaySound(SFX_SAVE_ERROR);
			int text[]="No Quick Save to Restore";
			Tango_ClearSlot(3);
			ShowString(text, WINDOW_SLOT_5, WINDOW_STYLE_2, 48, 48);
			menuArg=choice;
		}
		else{
			RestoreGame(false);
			return true;
			done = true;
			//menuArg=choice;
		}
        }
        
        else if(choice == 2) 
        {
	
           done = true;
        }
        

            
        else if (Link->PressEx1){
                done = true;
        }
        else
            done=true;

        

        
        if(done){
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_2, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    
    Tango_ClearSlot(WINDOW_SLOT_2);
    
    if(done)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}
