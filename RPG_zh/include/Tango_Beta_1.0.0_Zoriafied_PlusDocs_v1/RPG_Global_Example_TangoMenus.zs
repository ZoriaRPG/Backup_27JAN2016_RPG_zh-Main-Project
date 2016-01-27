bool ffcsSuspended;
int menuCommand; //Used to store the present command selected in a menu that launches an FFC script.
bool noMenu = false; //THis allows you to prevent using menus on desired maps, screens, and so forth. i use it for the title screen in LoE.
const int TANGO_MENU_FFC_SLOT = 0; //Set to FFC slot of FFC script 'Menu'

global script Init
{
    void run()
    {
        SetCommonStyleData(WINDOW_STYLE_1);
        SetCommonStyleData(WINDOW_STYLE_2);
        SetCommonStyleData(WINDOW_STYLE_3);
    }
}

global script activeMenus{
	void run(){
		ffcsSuspended = false;
		Tango_Start();
		menuCommand=0;
		//InitializeGhostZHData();
		while(true){
			Tango_Update1();
			if ( noMenu == false ) {
			if(Link->PressEx1 && !Tango_SlotIsActive(WINDOW_SLOT_1))
			RunFFCScript(TANGO_MENU_FFC_SLOT, NULL); // Menu script
			
			if(menuCommand>0){ // A menu changed the variable menuCommand to an FFC slot number.
				RunFFCScript(menuCommand, NULL); //Run that FFC script without args.
				menuCommand=0; //Reset the var.
			}
			Waitdraw();
			Tango_Update2();
			Waitframe();

		}
	}
}