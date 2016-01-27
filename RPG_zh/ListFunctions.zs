const int OFFSET_LIST = 1;

void ComboD(int pos, int cmb, int offset){
	ComboD[pos-offset] = cmb;
}

void SetLayerComboD(int layer, int pos, int cmb, int offset){
	SetLayerComboD(layer,pos-offset,cmb);
}

void ComboC(int pos, int cmb, int offset){
	ComboC[pos-offset] = cmb;
}

int IsComboC(int pos, int list, int layer){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( GetLayerComboC(layer,pos) == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

void SetLayerComboC(int layer, int pos, int cmb, int offset){
	SetLayerComboC(layer,pos-offset,cmb);
}

void ComboF(int pos, int cmb, int offset){
	ComboD[pos-offset] = cmb;
}

void SetLayerComboF(int layer, int pos, int cmb, int offset){
	SetLayerComboD(layer,pos-offset,cmb);
}

void ComboI(int pos, int cmb, int offset){
	ComboI[pos-offset] = cmb;
}

void SetLayerComboI(int layer, int pos, int cmb, int offset){
	SetLayerComboI(layer,pos-offset,cmb);
}

void ComboT(int pos, int cmb, int offset){
	ComboT[pos-offset] = cmb;
}

void SetLayerComboS(int layer, int pos, int cmb, int offset){
	SetLayerComboS(layer,pos-offset,cmb);
}

void ComboS(int pos, int cmb, int offset){
	ComboS[pos-offset] = cmb;
}

void SetLayerComboD(int layer, int pos, int cmb, int offset){
	SetLayerComboD(layer,pos-offset,cmb);
}

int IsComboD(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboD[pos] == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

int IsComboC(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboC[pos] == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

int IsComboF(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboF[pos] == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

int IsComboI(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboI[pos] == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

int IsComboT(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboT[pos] == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

int IsComboS(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboS[pos] == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

int _IsComboD(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboD[pos] == list[q] ) return q;
		
	}
	//return match;
	return -1;
}

int _IsComboC(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboC[pos] == list[q] ) return q;
		
	}
	//return match;
	return -1;
}

int _IsComboF(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboF[pos] == list[q] ) return q;
		
	}
	//return match;
	return -1;
}

int _IsComboI(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboI[pos] == list[q] ) return q;
		
	}
	//return match;
	return -1;
}

int _IsComboT(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboT[pos] == list[q] ) return q;
		
	}
	//return match;
	return -1;
}

int _IsComboS(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( ComboS[pos] == list[q] ) return q;
		
	}
	//return match;
	return -1;
}

SetComboAttributes(int cmb, int data, int type, int flag, int inhFlag, int cset, int walk ){
	Screen->ComboD[cmb] = data;
	Screen->ComboT[cmb] = type;
	Screen->ComboF[cmb] = flag;
	Screen->ComboI[cmb] = inhFlag;
	Screen->ComboC[cmb] = cset;
	Screen->ComboS[cmb] = walk;
}