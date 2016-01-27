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
