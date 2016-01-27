//FFC Script to check *up to* fifteen items, and use them similarly to a Triforce check...
//D8 Decimal is used to set conditional flags, 
ffc script TriforceCheck {
	void run(float itm1_9, float itm2_10, float itm3_11, float itm4_12, float itm5_13, float itm6_14, float itm7_15, float itm8_16){
		bool passedChecks = true; //Used to determine if player has all the mandatory items.
		
		//Store the args into sixteen vars.
		int itm1 = __GetHighArgument(itm1_9);	int itm2 = __GetHighArgument(itm2_10);
		int itm3 = __GetHighArgument(itm3_11);	int itm4 = __GetHighArgument(itm4_12);
		int itm5 = __GetHighArgument(itm5_13);	int itm6 = __GetHighArgument(itm6_14);
		int itm7 = __GetHighArgument(itm7_15);	int itm8 = __GetHighArgument(itm8_16);
		int itm9 = __GetLowArgument(itm1_9);	int itm10 = __GetLowArgument(itm2_10);
		int itm11 = __GetLowArgument(itm3_11);	int itm12 = __GetLowArgument(itm4_12);
		int itm13 = __GetLowArgument(itm5_13);	int itm14 = __GetLowhArgument(itm6_14);
		int itm15 = __GetLowArgument(itm7_15);	float conditions = __GetLowArgument(itm8_16);
		
		bool passCheck[17]; //Array to store if each item validates. 
		
		while (true){
			passedChecks = true; //Set to true initially, each frame, and set false if a check fails.
			
			//Run checks on all the items entered as FFC args.
			if (itm1 && !Link->Item[itm1] ) {
				passCheck[1] = false;
			}
			if ( ( itm1 && Link->Item[itm1] ) || !itm1 ) passCheck[1] = true;
			
			if ( itm2 && !Link->Item[itm2] ) {
				passCheck[2] = false; break;
			}
			if ( ( itm2 && Link->Item[itm2] ) || !itm2 ) passCheck[2] = true;
		 
			if ( itm3 && !Link->Item[itm3] ) {
				passCheck[3] = false;
			}
			if ( ( itm3 && Link->Item[itm3] ) || !itm3 ) passCheck[3] = true;
			
			if ( itm4 && !Link->Item[itm4] ) {
				passCheck[4] = false; 
			}
			if ( ( itm4 && Link->Item[itm4] ) || !itm4 ) passCheck[4] = true;
			
			if ( itm5 && !Link->Item[itm5] ) {
				passCheck[5] = false;
			}
			if ( ( itm5 && Link->Item[itm5] ) || !itm5 ) passCheck[5] = true;
			
			if ( itm6 && !Link->Item[itm6] ) {
				passCheck[6] = false; 
			}
			if (itm6 && Link->Item[itm6] ) passCheck[6] = true;
			
			if ( itm7 && !Link->Item[itm7] ) {
				passCheck[7] = false;
			}
			if ( ( itm7 && Link->Item[itm7] ) || !itm7 ) passCheck[7] = true;
			
			if ( itm8 && !Link->Item[itm8] ) {
				passCheck[8] = false;
			}
			if ( ( itm8 && Link->Item[itm8] ) || !itm8 ) passCheck[8] = true;
			
			if ( itm9 && !Link->Item[itm9] ) {
				passCheck[9] = false;
			}
			if ( ( itm9 && Link->Item[itm9] ) || !itm9 ) passCheck[9] = true;
			
			if ( itm10 && !Link->Item[itm10] ) {
				passCheck[10] = false;
			}
			if ( ( itm10 && Link->Item[itm10] ) || !itm10 ) passCheck[10] = true;
			
			if ( itm11 && !Link->Item[itm11] ) {
				passCheck[11] = false;
			}
			if ( ( itm11 && Link->Item[itm11] ) || !itm11 ) passCheck[11] = true;
			
			if ( itm12 && !Link->Item[itm12] ) {
				passCheck[12] = false;
			}
			if ( ( itm12 && Link->Item[itm12] ) || !itm12) passCheck[12] = true;
			
			if ( itm13 && !Link->Item[itm13] ) {
				passCheck[13] = false;
			}
			if ( itm13 && Link->Item[itm13] ) || !itm13 ) passCheck[13] = true;
			
			if ( itm14 && !Link->Item[itm14] ) {
				passCheck[14] = false;
			}
			if ( ( itm14 && Link->Item[itm14] ) || !itm14 ) passCheck[14] = true;
			
			if ( itm15 && !Link->Item[itm15] ) {
				passCheck[15] = false;
			}
			if ( ( itm15 && Link->Item[itm15] ) || !itm15 ) passCheck[15] = true;
			
			
			//Run through array indices, to see if we passed all the checks. if we do, keep the 
			//passedChecks variable set true, else set it false.
			for ( int q = 0; q < 16; q++ ) {
				if ( passCheck[q] = true ) continue;
				if ( passCheck[q] = false ) passedChecks = false;
			}
			
			//Run these routines if we pass the checks.
			if ( passedChecks ) {
				//int condFlag_1 = __GetDigit(conditions,0);
				//int condFlag_2 = __GetDigit(conditions,1);
				//int condFlag_3 = __GetDigit(conditions,2);
				//int condFlag_4 = __GetDigit(conditions,3);
				
				//Use conditions as flags, or use specific conditional types?
				
					//Unlock secret, unblock path, or run other game event (e.g. Windfish).
				break;
			}
			
			
			Waitframe();
		}
		__EndFFC(this);
	}
	//Functions to use decimal, and integer portions of args as separate values. 
	int __GetHighArgument(int arg) {
		return arg >> 0;
	}

	int __GetLowArgument(int arg) {
		return (arg - (arg >> 0)) * 10000;
	}
	
	//Kill an ffc with one command. Call as EndFFC(this) or EndFFC(id)
	void __EndFFC(ffc f){
		f->CSet = 0;
		f->Delay = 0;
		f->Y = -32768;
		f->X = -32768;
		f->Vy = 0;
		f->Vx = 0;
		f->Ax = 0;
		f->Ay = 0;
		for ( int q = 0; q <  SizeOfArray(f->Flags); q++) f->Flags[q] = 0;
		f->TileWidth = 0;
		f->TileHeight
		f->EffectWidth
		f->EffectHeight
		f->Link
		for ( int q = 0; q <  SizeOfArray(f->InitD); q++) f->InitD[q] = 0;
		for ( int q = 0; q <  SizeOfArray(f->Misc); q++) f->Misc[q] = 0;
		f->Data = 0;
		f->Script = 0;
		Quit();
	}
}