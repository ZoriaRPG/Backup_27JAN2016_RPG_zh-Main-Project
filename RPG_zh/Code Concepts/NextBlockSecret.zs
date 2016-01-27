const int FIRST_BLOCK_UNDERCOMBO = 1500; //Set to Combo ID of undercombo. 
consst int SECOND_BLOCK_COMBO = 1501; //Set to Combo ID of blocks to change (source).

void NextBlockSecret(){
	int cmb;
	int cmb2;
	for (int q = 0; q < 176; q++){
		cmb = ComboD[q];
		if ( cmb == FIRST_BLOCK_UNDERCOMBO ) {
			for (int q = 0; q < 176; q++){
				cmb2 = ComboD[q];
				int cmb2X = ComboX(cmb2);
				int cmb2Y = ComboY(cmb2);
				if ( ( cmb2X <= Link->X -16) || ( cmb2X >= Link->X + 16 ) || ( cmb2Y <= Link->Y 16 ) || ( cmb2Y >= Link->Y +16 ) ){
					ComboD[q]++;
				}
			}
		}
	}
}
			