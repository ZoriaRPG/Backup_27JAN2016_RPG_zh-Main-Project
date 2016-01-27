

ffc script NineSwitchPuzzle{
	void run(int layer, int solveSFX, int failSFX, int pressButtonSFX, int sens){
		int orderPressed[9]; //Holds the actual order in which Link touches combos.
		bool triggered;
		bool triggeredFalse;
		bool correctOrder;
		int buttonsPressed; 
		bool done;
		int pressedOrderRequired[9]={6040,6052,6048,6044,6056,6060,6064,6068,6072}; 
		//Populate with the desired order of combos to press.
		
		while(true){
			for ( int q = 0; q <= SizeOfArray(orderPressed); q++ ) {
				
				int pos = orderPressed[q];
				if ( pos ) { //If the button was pressed. 
					if ( pos == pressedOrderRequired[q] ) correctOrder = true;
					if ( pos != pressedOrderRequired[q] ) correctOrder = false;
					//If thre is a value in the index...
					//and it matches the required order, set the value of correctOrder true.
					//otherwise, set it false.
					buttonsPressed++; //Increase the count of presses. 
				}
			}
			
			if ( buttonsPressed == 9 && correctOrder ) triggered = true;
			if ( buttonsPressed == 9 && !correctOrder ) triggeredFalse = true; 

			if ( triggered ) {
				//Play the sound for solving properly.
				if ( solveSFX ) Game->PlaySound(solveSFX); 
				//Effect of triggering properly.
				Screen->TriggerSecrets(); //Generic secrets triggered.
				
				//Should the secrets be perm?
				
				//Wait, or Quit
				done = true;
				Waitframe();
			}
			
			//If pressed in the incorrect order.
			if ( triggeredFalse ) {
				//Wipe the array of stored values. 
				for ( int q = 0; q <= SizeOfArray(orderPressed); q++ ) {
					orderPressed[q] = 0;
				}
				//Reset all nine combos from a pressed, to unpressed state...
				for ( int q = 0; q < 176; q++ ) {
					int cmb = GetLayerComboD(layer,q);
					if ( cmb == 6041 || cmb == 6053 || cmb == 6049 || cmb == 6045
					|| cmb == 6057 || cmb == 6061 || cmb == 6065 || cmb == 6069
					|| cmb == 6074 )  {
						//change the combo to the previous one in the combo list...
						SetLayerComboD(layer,q,cmb-1);
					}
				}
				if ( failSFX ) Game->PlaySound(failSFX); //Play the failure sfx sound.
				//Reset the variables.
				buttonsPressed = 0;
				triggered = false;
				triggeredFalse = false;
				correctOrder = false;
				Waitframe();
			}
				
			
			//If we haven't triggered either event...
			if ( !triggered && !triggeredFalse ) {
				for ( int q = 0; q < 176; q++ ) {
					int cmb = GetLayerComboD(layer,q);
					if ( ( cmb == 6040 || cmb == 6052 || cmb == 6048 || cmb == 6044
						|| cmb == 6056 || cmb == 6060 || cmb == 6064 || cmb == 6068
						|| cmb == 6072 ) && ( __LinkComboCollision(q,sens) ) 
					{
							//change the combo to the next in the combo list...
							SetLayerComboD(layer,q,cmb+1);
						
							//Play the sound for pressing a button...
							if ( pressButtonSFX ) Game->PlaySound(pressButtonSFX);
						
							//Look through the array orderPressed for a blank slot.
							for ( int q = 0; q <= SizeOfArray(orderPressed) q++ ) {
								int pos = orderPressed[q]; 
								//Fill the blank slot with the combo ID.
								if ( ! pos ) orderPressed[q] = cmb;
							}
					}
				}
			}
			
			if ( done ) {
				this->Data = 0;
				this->Script = 0;
				Quit();
			}
			Waitframe();
		}
	}
	//Returns TRUE if Link touches a combo.
	bool __LinkComboCollision(int loc, int sens){
		int ax = Link->X;
		int ay = Link->Y;
		int bx = (Link->X)+(Link->HitWidth);
		int by = (Link->Y)+(Link->HitHeight);
		if(!(RectCollision( ComboX(loc), ComboY(loc), (ComboX(loc)+16), (ComboY(loc)+16), ax, ay, bx, by))) return false;
		else if (!(Distance(CenterLinkX(), CenterLinkY(), (ComboX(loc)+8), (ComboY(loc)+8)) < (sens+8))) return false;
		else return true;
	}
}