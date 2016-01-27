/// Debug Menu FFC !Z!

const int CHEATLEVEL = 4;
const int MENUFFC = 59;

ffc script DebugMenu {
	void run() {

		int line1[]="@choice(1)Report Screen@26";
		//int line2[]="@choice(4)Enable Cheat@26";
		int line3[]="@choice(3)Toggle Cheat@26";
		int line2[]="@choice(4)Print Cheat@26";
		int line4[]="@choice(5)Full Equip.@26";
		int line5[]="@choice(6)Max HP & MP@26";
		int line6[]="@choice(7)Max Counters@26";
		int line7[]="@26@choice(2)Cancel@domenu(1)@suspend()";

		
		
		SetUpWindow(WINDOW_SLOT_1, WINDOW_STYLE_1, 16, 16, SIZE_LARGE);
		
		Tango_LoadString(WINDOW_SLOT_1, line1);
		Tango_AppendString(WINDOW_SLOT_1, line2);
		Tango_AppendString(WINDOW_SLOT_1, line3);
		//Tango_AppendString(WINDOW_SLOT_1, line4);
		/// Some equipment object in this game fixes Link's position, and does strange things if enabled. That must be excluded, and traced. 
		Tango_AppendString(WINDOW_SLOT_1, line5);
		Tango_AppendString(WINDOW_SLOT_1, line6);
		Tango_AppendString(WINDOW_SLOT_1, line7);
		Tango_ActivateSlot(WINDOW_SLOT_1);
		
		
		while(!Tango_MenuIsActive()){
		    
		    Waitframe();
		}
		
		// Save the state of the text slot and menu. The bitmap won't change,
		// so it doesn't need saved.
		int slotState[278];
		int menuState[960];
		int cursorPos;
		Tango_SaveSlotState(WINDOW_SLOT_1, slotState);
		Tango_SaveMenuState(menuState);
		
		bool done=false;
		int choice;
		while(true) {
			if ( Link->PressEx4 ){
				done = true;
			}
			

			while(Tango_MenuIsActive()){
				cursorPos=Tango_GetMenuCursorPosition();
				Waitframe();
			}
			    
			    
			choice=Tango_GetLastMenuChoice();
			
			if(choice==1) { // Look
				done=true;
				Debug();
				int text[]="Report saved to Allegro.log";
				Tango_ClearSlot(3);
				ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 48, 48);
				menuArg=choice;
			}
			
			else if(choice == 2) {
				done = 1;
				menuArg = choice;
			}

			else if(choice == 3) {
			
			done = true;
				if ( Game->Cheat > 0 ) {
					Game->Cheat = 0;
				}
				else if ( Game-> Cheat == 0 ) {
					Game->Cheat = CHEATLEVEL;
				}
				int cheatNow = Game->Cheat;
				int text[]="Current Cheat is:";
				TraceS(text);
				Trace(cheatNow);
			}
			
			else if(choice == 4) {
				done = true;
				int cheatNow = Game->Cheat;
				int text[]="Current Cheat is:";
				TraceS(text);
				Trace(cheatNow);
			}
			
			else if(choice == 5) {
				done = true;
				CheatEquipment(true);
				int text[]="Enabled All Equipment";
				TraceS(text);
			}
			else if(choice == 6) {
				done = true;
				Link->MaxHP = 9999;
				Link->MaxMP = 9999;
				Link->HP = 9999;
				Link->MP = 9999;
				int text[]="Enabled Max HP & MP";
				TraceS(text);
			}
			else if(choice == 7) {
				done = true;
				MaxCounters();
				int text[]="Counters Maximised";
				TraceS(text);
			}
			else if(choice == 8) {
				done = true;
				godMode(true);
				int text[]="godMode Enabled";
				TraceS(text);
			}
			    
				
			else if (Link->PressEx4){
				Quit();
			}
			
			else{
				done=true;
			}
			    
			    // If we need to return to the top-level menu,
			    // restore the state and loop again.
			if(done){
				break;
			}
			else {
				Tango_RestoreSlotState(WINDOW_SLOT_1, slotState);
				Tango_RestoreMenuState(menuState);
				Tango_SetMenuCursorPosition(cursorPos);
			}
		}
		Tango_ClearSlot(WINDOW_SLOT_1);
	}
}

