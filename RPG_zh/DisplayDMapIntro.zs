ffc script DisplayDmap {
	void run(int type, int dmap){
		int dmapString[]="The present area informtion, is: ";
		int dmapName[21]; //20 + NULL
		int dmapTitle[21]; //20 + NULL
		int dmapIntro[73]; //72 + NULL
		int linebreak[]="@26";
		int suspendSlot[]="@suspend";

		Game->GetDMapName(dmap,dmapName);
		Game->GetDMapIntro(dmap, dmapIntro);
		Game->GetDMapTitle(dmap, dmapTitle);
		
		SetUpWindow(WINDOW_SLOT_1, WINDOW_STYLE_1, 16, 16, SIZE_LARGE);
		Tango_LoadString(WINDOW_SLOT_1, dmapString);
		if ( type == 1 || type == 3 || type == 5 || type == 7 ) {
			Tango_AppendString(WINDOW_SLOT_1, dmapName);
			Tango_AppendString(WINDOW_SLOT_1, linebreak);
		}
		if ( type == 2 || type == 3 || type == 6 || type == 7 ) {
			Tango_AppendString(WINDOW_SLOT_1, dmapTitle);
			Tango_AppendString(WINDOW_SLOT_1, linebreak);
		}
		if ( type == 4 || type == 5 || type == 6 || type == 7 ) {
			Tango_AppendString(WINDOW_SLOT_1, dmapIntro);
			Tango_AppendString(WINDOW_SLOT_1, linebreak);
		}
		Tango_AppendString(WINDOW_SLOT_1, suspendSlot);
		Tango_ActivateSlot(WINDOW_SLOT_1);
		
		//Put while loop here.
	}
}