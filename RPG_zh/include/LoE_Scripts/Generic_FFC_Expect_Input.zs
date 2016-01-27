ffc script doMusic{
	void run(int d0, int d1){
		int pressed = 0;
		
		while (!pressed){ //Pressed is 0, and returns false. 
			if ( Link->PressUp ) {
				pressed = 1;
			}
			if ( Link->PressDown ) {
				pressed = 2;
			}
			if ( Link->PressLeft ) {
				pressed = 3;
			}
			if ( Link->PressRight ) {
				pressed = 4;
			}
			if ( Link->PressA || Link->PressB ) {
				pressed = 5; //If pressed A/B, cancel.
			}
			
			Waitframe();
		}
		
		if ( pressed == 1 ) {
			//Do warp things and music for choice 1.
		}
		if ( pressed == 2 ) {
			//Do warp things and music for choice 1.
		}
		if ( pressed == 3 ) {
			//Do warp things and music for choice 1.
		}
		if ( pressed == 4 ) {
			//Do warp things and music for choice 1.
		}
		if ( pressed == 5 ) {
			return; //Exit FFC
		}
	}
}
			
		
ffc script doWhileMusic{
	void run(int d0, int d1){
		int pressed = 0;
		
		do {
			
			//Draw functions here.
			if ( Link->PressUp ) {
				pressed = 1;
			}
			if ( Link->PressDown ) {
				pressed = 2;
			}
			if ( Link->PressLeft ) {
				pressed = 3;
			}
			if ( Link->PressRight ) {
				pressed = 4;
			}
			if ( Link->PressA || Link->PressB ) {
				pressed = 5; //If pressed A/B, cancel.
			}
			
			Waitframe();
		}
		while(!pressed); //Pressed is 0, and returns false. 
		
		if ( pressed == 1 ) {
			//Do warp things and music for choice 1.
		}
		if ( pressed == 2 ) {
			//Do warp things and music for choice 1.
		}
		if ( pressed == 3 ) {
			//Do warp things and music for choice 1.
		}
		if ( pressed == 4 ) {
			//Do warp things and music for choice 1.
		}
		if ( pressed == 5 ) {
			return; //Exit FFC
		}
	}
}

ffc script doWhileMusicExpanded{
	void run(int d0, int d1){
		bool running = true;
		int pressed = -1;
		while(running){
			do {
				
				//Draw functions here.
				if ( Link->PressUp ) {
					pressed = 1;
				}
				if ( Link->PressDown ) {
					pressed = 2;
				}
				if ( Link->PressLeft ) {
					pressed = 3;
				}
				if ( Link->PressRight ) {
					pressed = 4;
				}
				if ( Link->PressA || Link->PressB ) {
					pressed = 5; //If pressed A/B, cancel.
				}
				
				Waitframe();
			}
			while(!pressed); //Pressed is 0, and returns false. 
			
			if ( pressed == 1 ) {
				running = false; //Instructs script to halt further running after executing the instructions below.
				//Do warp things and music for choice 1.
			}
			if ( pressed == 2 ) {
				running = false;
				//Do warp things and music for choice 1.
			}
			if ( pressed == 3 ) {
				running = false;
				//Do warp things and music for choice 1.
			}
			if ( pressed == 4 ) {
				running = false;
				//Do warp things and music for choice 1.
			}
			if ( pressed == 5 ) {
				running = false;
				return; //Exit FFC
			}
			else {
				pressed = 0; //If no input, set pressed to '0' to repeat this loop. 
				
				//Put any instructions to run at the end of the first loop of the do-while here. 
				//These instructions will run once at the start of this script after the do-while
				//loop completes, if the player doesn't press anything.
				
			}
			
			
			Waitframe();
		}
		//Put post-running instructions here. These will execute following any 'pressed' operations
		//except a cancel operation (5). 
	}
}

item script ffcLaunch{
	void run(int arg0, int arg1, int arg2, int FFCSLot){
		//D0, D1, and D2 are variables for the item to pass on to the ffc. 
		//D3 (FFCSlot) is the slot we're going to run. 
		//Once the FFc is assigned to a slot, you can punch its value into D3 and use that.
		//You may also hard-code the value, or establish a game constant.
		
		int args[3]={arg0,arg1,arg2}; //Assign the values of the script arguments to a local array. 
		//We'll pass that to ffcscript to run them as args for the FFC.
		
		RunFFCScript(FFCSlot, args); //Runs the FFC designated in D3, and passes the D0 to D2 values through the array, to it. 
	}
}

const int FFC_EXPLODE = 20;

item script bomblast{
	void run(int phi, int pi, int beta){
		int args[3]={phi, pi, beta}; //Again, we pass the item script args into this array, and 
		//the pass the array as an argument to FFCScript. 
		
		RunFFCScript(FFC_EXPLODE,args);
		//The arguments should be placed in the array in the order that the FFC needs, so if you need to put 
		// arg beta in the first position for your FFC, you'd declare this instead:
		// int args[3]={beta,phi,pi};
		// The array declaration 'args' can be any name. You need only match the name when you add the RunFFCScript command.
		// Thus, if you have int arrayThis[3]={beta, pi, phi}; you would do this:
		// RunFFCScript(FFC_EXPLODE, arrayThis); The name of the aqrray is the second argument.
		// In this example, the constant for FFC_EXPLODE is 20, and that is the slot we're running.
	}
}

//If there are no args to pass to the FFC, use NULL:
// RunFFCScript(slot, NULL);
