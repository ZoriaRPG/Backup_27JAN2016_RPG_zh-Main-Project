void SetScreenDPlace(int reg, int place, int val){
	float ten_thousands_place = GetScreenDPlace(reg, TEN_THOUSANDS) * 10000;
	float thousands_place = GetScreenDPlace(reg, THOUSANDS) * 1000;
	float hundreds_place = GetScreenDPlace(reg, HUNDREDS) * 100;
	float tens_place = GetScreenDPlace(reg, TENS) * 10;
	float ones_place = GetScreenDPlace(reg, ONES);
	float tenths_place = GetScreenDPlace(reg, TENTHS) * 0.1;
	float hundredths_place = GetScreenDPlace(reg, HUNDRETHS) * 0.01;
	float thousandths_place = GetScreenDPlace(reg, THOUSANDTHS) * 0.001;
	float ten_thousandths_place = GetScreenDPlace(reg, TEN_THOUSANDTHS) * 0.0001;

	float valModified;
	
	if ( place == TEN_THOUSANDS ) ten_thousands_place = val * 10000;
	if ( place == THOUSANDS ) thousands_place = val * 1000;
	if ( place == HUNDREDS ) hundreds_place = val * 100;
	if ( place == TENS ) tens_place = val * 10;
	if ( place == ONES ) ones_place = val * 1;
	if ( place == TENTHS ) tenths_place = val * 0.1;
	if ( place == HUNDRETHS ) hundredths_place = val * 0.01;
	if ( place == THOUSANDTHS ) thousandths_place = val * 0,001;
	if ( place == TEN_THOUSANDTHS ) ten_thousandths_place = val * 0.0001;
	
	valModified = ten_thousandths_place + thousandths_place + hundredths_place + tenths_place
			+ ones_place + tens_place + hundreds_place + thousands_place + ten_thousands_place;
			
	SetScreenD(reg, valModified);
}

int GetScreenDPlace(int reg, int place){
	int val = GetDigit(Screen->D[reg],place);
	return val;
}