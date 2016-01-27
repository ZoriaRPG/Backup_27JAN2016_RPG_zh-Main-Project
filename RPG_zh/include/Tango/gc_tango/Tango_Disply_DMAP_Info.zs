//Types for this function.

const int T_DISP_DMAP_NAME = 1;
const int T_DISPLAY_DMAP_TITLE = 2;
const int T_DISP_DMAP_INTRO = 4;
//Can stack these in any combination. Thus, T_DISPLAY_DMAP_NAME + T_DISPLAY_DMAP_TITLE would be '4'.

ffc script DisplayDmap {
	void run(int type, int dmap){
		int dmapString[]="The present area informtion, is: ";
		int dmapName[20];
		int dmapTitle[20];
		int dmapIntro[72];
		int linebreak[]="@26";
		int suspendSlot[]="@suspend";

		Game->GetDmapName(dmap,dmapName);
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
			Tango_AppendString(WINDOW_SLOT_1, linebrek);
		}
		Tango_AppendString(WINDOW_SLOT_1, suspendSLot);
		Tango_ActivateSlot(WINDOW_SLOT_1);
		
		//Put while loop here.
	}
}