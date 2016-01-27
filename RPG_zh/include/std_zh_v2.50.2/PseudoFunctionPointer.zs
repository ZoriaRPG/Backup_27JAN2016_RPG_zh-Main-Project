const int FunctionA = 1;
const int FunctionB = 2;

int FunctionA(int val, int var){
	return val*var;
}

int FunctionB(int val, int var);
	reutrn val+var;
}

int Compound(int val, int var, int fptr, int mod){
	if ( fptr ==  FunctionA ) {
		return FunctionA(val,var) + 100;
	}
	if ( fptr == FunctionB ) {
		return FunctionB(val,var) * mod;
	}
}