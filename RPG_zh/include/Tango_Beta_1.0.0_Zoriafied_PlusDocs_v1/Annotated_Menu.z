bool isActive = false; //Gives us a boolean for the Tango menu. I use this in my global script, so that the player can't open menus on title, or transition screens.
bool ffcsSuspended; //Establishes if FFCs suspended.
int menuCommand; //Used to store the present command selected in a menu that launches an FFC script.
bool noMenu = false; //This allows you to prevent using menus on desired maps, screens, and so forth. i use it for the title screen in LoE.


const int TANGO_MENU_FFC_SLOT = 0; //Set to FFC slot of FFC script 'Menu'

global script Init { //This script auto-loads into slot ~Init when compiling. It is used to set up the basic tango styles.
    void run() {
        SetCommonStyleData(WINDOW_STYLE_1); //Sets 'Style 1' Tango settings.
        SetCommonStyleData(WINDOW_STYLE_2); //Sets 'Style 2' Tango settings.
        SetCommonStyleData(WINDOW_STYLE_3); //Sets 'Style 1' Tango settings.
    }
}

global script activeMenus{ //This is an *example global active script, so that you know where to place TangoStart() TangoUpdate1() and TangoUodate2().
	void run(){
		ffcsSuspended = false;
		Tango_Start(); //Starts Tango.
		menuCommand=0; //Initialises the global variable menuCommand,
		//InitializeGhostZHData();
		while(true){ //This runs once per frame.
			Tango_Update1(); //Do initial Tango bitn=map updating.
			if ( noMenu == false ) { //If we're allowed to open a menu...
				if(Link->PressEx1 && !Tango_SlotIsActive(WINDOW_SLOT_1)) //If the player presses Button Ex1, the main menu opens. You can change the button.
				RunFFCScript(TANGO_MENU_FFC_SLOT, NULL); // Runs Menu FFC, from the slot assigned to constant TANGO_MENU_FFC_SLOT.
			}
			if(menuCommand>0){ // A menu changed the variable menuCommand to an FFC slot number.
				RunFFCScript(menuCommand, NULL); //Run that FFC script without args.
				menuCommand=0; //Reset the var.
			}
			Waitdraw(); //Paises to do drawing of screen gfx.
			Tango_Update2(); //Post Waitdraw refreshing.
			Waitframe(); //Pause the loop, to repeat.

		}
	}
}

ffc script TangoBox{
	void run(){
		
		int firstline[]="My first Tango box.";
		int nextline[]="This is my second line."
		int choice1[]="@choice(1)MenuChoice"; // This is a menu choice with the choice token. The menu will display the words 'MenuVhoice' as option-12, and if the player selects it, then menuChoice = 1;
		int linebreak[]="@26"
		int choice2[]="@choice()Second Option"; //This is a second menu choice, displaying 'Secomnd Option' in the ment. Selecting it sets menuChoice = 2;
		int domenu[]="@domenu(1)";
		int lastline[]="@suspend()";
		
		SetUpWindow(WINDOW_SLOT_1, WINDOW_STYLE_1, 16, 16, SIZE_LARGE);
		//Makes a Tango text box, in slot 1, with the parameters defined as 'WINDOW_STYLE_1', upper-left cornet at X16 and Y16, with dimensions defined as 'SIZE_LARGE'
		
		Tango_LoadString(WINDOW_SLOT_1, firstline);
		//Loads the initial string, to initialise the dialogue box.
		
		Tango_AppendString(WINDOW_SLOT_1, linebreak);
		//Appends the string 'linebreak', cauing a blank line to follow under 'firstline'
		
		Tango_AppendString(WINDOW_SLOT_1, nextline);
		//Appends the string 'nextline' after the linebreak.
		
		Tango_AppendString(WINDOW_SLOT_1, choice1);
		//Appends the string with a menu choice (1).
		
		Tango_AppendString(WINDOW_SLOT_1, choice2);
		//Appends the string with a menu choice (2).
		
		Tango_AppendString(WINDOW_SLOT_1, domenu);
		//Appends the string terminating menu additions, and telling Tango that the menu is ready.
		
		Tango_AppendString(WINDOW_SLOT_1, lastline);
		//Runs the Suspend Tango operation.
   
		Tango_ActivateSlot(WINDOW_SLOT_1);
		//Primes the off-screen bitmap.
		
		while(!isActive){
			Waitframe(); //While we're waiting for the player to open the menu, do nothing.
		}
		
		// Save the state of the text slot and menu. The bitmap won't change,
		// so it doesn't need saved.
		int slotState[278]; //Arrays to hold the Tango window datum.
		int menuState[960]; //These need to match the sizes in Tango.zh:
			// menuState = 24+3*__TANGO_MAX_MENU_ITEMS (40)
			// Menu Data (float __Tango_Data[960])
			// slotState = ( Number of Slots * 20 ) + 38
			// ( int __Tango_SlotData[240]; // 20 * __TANGO_NUM_SLOTS )
			// For some reason, i added + 38 to the value, and I honestly do not recall
			// why, but it was necessary to avoid some kind of script, array overflow. 
		int cursorPos; //A variable to track cursor position.
		Tango_SaveSlotState(WINDOW_SLOT_1, slotState); //Saves the bitmap state every frame off-screen, so that it can be drawn every frame on-screen.
		Tango_SaveMenuState(menuState); //Saves the menu state, cursor position, and such, off-screen every frame, and redraws on-screen.
		
		bool done=false; //Gives us a local boolean variable to control menu closing.
		int choice; //Gives us a variable to set the numeric value of selecting a menu option.
		
		while(true) { //While the tango FFC exists...
			if ( Link->PressEx1 ){ //If the player presses button Ex1 (You can change the button)
				Quit(); //Kill the FFC, closing all boxes.
			}
			 while(Tango_MenuIsActive()) { //While a menu is open...
				cursorPos=Tango_GetMenuCursorPosition(); //Updates cursor movement.
				Waitframe(); Waits a frame, to draw.
			}
			choice=Tango_GetLastMenuChoice(); //Forwards an int, to modify, for int-based options.
			if(choice==1) { // If the player selects choice 1.
				int text[]="The Look function is not yet available. Please use your 'L' button for the present."; //Creates a new string to display.
					ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32); //Displays string 'text' in a new window, cascading from the main menu; using SLOT 2.
				done=true; //Tell FFC menu to close on input
			}
			else if(choice==2) { //If player selects choice 2.
				showStats(); //Cals the Boolean function showStats()
				done=true; //Tells menu we're done here.
			}
			else if (Link->PressEx1){
				Quit(); //If we press Ex1 while this menu is active, it quits the FFC. Run from base menus only, and use return true to close daughter windows.
			}
			else {
				done=true; //Enables the loop below if the player presses anything other than 'A'.
			}
			// If we need to return to the top-level menu,
			// restore the state and loop again.
			if(done){ //if boolean 'done' = true...
				break; //Breaks the main while loop, closing the menu.
			}
			else { //If the player did not give any inouts this frame that close the menu...
				Tango_RestoreSlotState(WINDOW_SLOT_1, slotState); //Refresh the menu bitmap this frame.
				Tango_RestoreMenuState(menuState); //Redraw bitmap to FFC.
				Tango_SetMenuCursorPosition(cursorPos); Redraw menu curson on choice to which the selector last pointed.
			}
		}
		//If we reach here, then the menu is closing.
		Tango_ClearSlot(WINDOW_SLOT_1); //Now that we break out, we clear the slot and remove the FFC DISPLAY. This wipes the bitmap, and allows drawing a different bitmap at its location.
	}
}