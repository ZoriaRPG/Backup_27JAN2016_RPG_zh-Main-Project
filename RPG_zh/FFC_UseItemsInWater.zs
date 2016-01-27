//Use items while swimming

const int FFC_LINK_USE_ITEMS_WHILE_SWIMMING = 1;
const int SWIM_PRESS_A = 1;
const int SWIM_PRESS_B = 2;
const int I_DIVE = 254;
const int I_PADDLE = 255; 

void UseItemsWhileSwimming(){
	if ( Link->Action == LA_SWIMMING && Link->PressA && GetEquipmentA() != I_DIVE && GetEquipmentA() != I_PADDLE ) {
		RunFFCScript(FFC_LINK_USE_ITEMS_WHILE_SWIMMING, SWIM_PRESS_A);
	}
	if ( Link->Action == LA_SWIMMING && Link->PressA && GetEquipmentB() != I_DIVE && GetEquipmentB() != I_PADDLE ) {
		RunFFCScript(FFC_LINK_USE_ITEMS_WHILE_SWIMMING, SWIM_PRESS_B);
	}
}

ffc script LinkUseItemsInWater{
	void run(int press_button){
		bool running = true;
		while ( running ) {
			if ( press_button == SWIM_PRESS_A ) {
				Link->Action = LA_NONE; //Link's tile may be wrong for one frame, so 
							// We may need to substitute a tile for one frame to 
							//match his swimming tile.
				Link->InputA = true;
				running = false;
				Waitframe(); //If we don;t wait here, the item won't activate. 
			}
			if ( press_button == SWIM_PRESS_B ) {
				Link->Action = LA_NONE;
				Link->InputB = true;
				running = false;
				Waitframe();
			}
			Link->Action = LA_SWIMMING;
			Waitframe();
		}
		Link->Action = LA_SWIMMING;
		this->Data = 0;
		this->Script = 0;
		Quit();
	}
}
		