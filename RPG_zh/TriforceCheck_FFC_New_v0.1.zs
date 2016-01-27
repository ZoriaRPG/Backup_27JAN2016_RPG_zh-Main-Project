int TriforcePieces[24]; //Use item pickup script to set indices here to '1', or store item IDs here.

int CheckTriforceList(int list){
	int match = list[0];
	for ( int q = 0; q < SizeOfArray(list); q++ ) {
		if ( !match ) break;
		match = list[q];
	}
	return match;
}

item script TF_Pickup{
	void run(int tf_level, int midi){
		TriforcePieces[tf_level] = 1;
		if ( midi ) Game->PlayMIDI(midi);
	}
}

ffc script TF_Check{
	//Layer for solidity, inherent or placed flag to turn solid. 
	//Layer must be 0, or 1.
	//Placed flag is a positive value. Use a negative value for an inherent flag.
	void run(int layer, int flag, int message, int sfxPass){
		
		int cmb;
		int cmbIF;
		int blocked;
		if ( message && !CheckTriforceList(TF_PIECES_LIST) ) {
			for ( int q = 0; q < 176; q++ ) {
				if ( flag > 0 ) {
					cmb = GetLayerComboF(layer, q);
					if ( cmb == flag ) SetLayerComboS(layer, q, 4);
				}
				if ( flag < 0 ) {
					cmbIF = flag * -1;
					cmb = GetLayerComboI(layer, q);
					if ( cmb == cmbIF ) SetLayerComboS(layer, q, 4);
				}
			}
		}
		if ( CheckTriforceList(TF_PIECES_LIST) ) {
			Game->PlaySound(sfxPass);
		}
	}
}
		
		
		
		while ( running ) {
			if ( !CheckTriforceList ) {
				


		