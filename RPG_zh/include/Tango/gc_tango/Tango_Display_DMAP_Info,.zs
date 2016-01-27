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
		
		SetUpWindow(TANGO_SLOT_NORMAL, STYLE_PLAIN, 16, 16, 0);
		Tango_LoadString(TANGO_SLOT_NORMAL, dmapString);
		if ( type == 1 || type == 3 || type == 5 || type == 7 ) {
			Tango_AppendString(TANGO_SLOT_NORMAL, dmapName);
			Tango_AppendString(TANGO_SLOT_NORMAL, linebreak);
		}
		if ( type == 2 || type == 3 || type == 6 || type == 7 ) {
			Tango_AppendString(TANGO_SLOT_NORMAL, dmapTitle);
			Tango_AppendString(TANGO_SLOT_NORMAL, linebreak);
		}
		if ( type == 4 || type == 5 || type == 6 || type == 7 ) {
			Tango_AppendString(TANGO_SLOT_NORMAL, dmapIntro);
			Tango_AppendString(TANGO_SLOT_NORMAL, linebreak);
		}
		Tango_AppendString(TANGO_SLOT_NORMAL, suspendSlot);
		Tango_ActivateSlot(TANGO_SLOT_NORMAL);
		
		bool displaying = true;
		
		while (Tango_SlotIsActive(TANGO_SLOT_NORMAL) ){
			if ( PressedAnyActionButton() ){
				Tango_SuspendSlot(TANGO_SLOT_NORMAL);
				if ( Link->PressStart ) {
					displaying = false;
				}
				if ( !displaying ) {
					Quit();
				}
			}
			Waitframe();
		}
	}
}

bool PressedAnyActionButton(){
	if ( Link->PressA || Link->PressB || Link->PressR || Link->PressL || Link->PressEx1 || Link->PressEx2 || Link->PressEx3 || Link->PressEx4 ){
		return true;
	}
}

void SetUpWindow(int slot, int style, int x, int y, int size)
{
    
    Tango_ClearSlot(slot);
    Tango_SetSlotStyle(slot, STYLE_PLAIN);
    Tango_SetSlotPosition(slot, x, y);
}

void ShowString(int string, int slot, int style, int x, int y) {
    SetUpWindow(slot, style, x, y, 0);
    Tango_LoadString(slot, string);
    Tango_ActivateSlot(slot);
    while(Tango_SlotIsActive(slot))   
        Waitframe();
}

int ShowMessage(int msg, int slot, int style, int x, int y)
{
    int slot=Tango_GetFreeSlot(TANGO_SLOT_ANY);
    if(slot==TANGO_INVALID)
        return TANGO_INVALID;
    
    Tango_ClearSlot(slot);
    Tango_LoadMessage(slot, msg);
    Tango_SetSlotStyle(slot, style);
    Tango_SetSlotPosition(slot, x, y);
    Tango_ActivateSlot(slot);
    
    return slot;
}