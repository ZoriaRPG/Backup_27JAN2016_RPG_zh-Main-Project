//Sets a decimal place of a Screen->D[register]. Returns true if successful, false if unsuccessful. 

bool SetScreenDPlace(int reg, int place, int val){
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
	bool success;
	
	if ( val != KICK && val != BUMP ) {
		if ( place == TEN_THOUSANDS && val <= 2 && val >= 0 ){
			ten_thousands_place = val * 10000;
			success = true;
		}
		if ( place == THOUSANDS && val >= 0 ) {
			thousands_place = val * 1000;
			success = true;
		}
		if ( place == HUNDREDS && val >= 0 ) {
			hundreds_place = val * 100;
			success = true;
		}
		if ( place == TENS && val >= 0 ) {
			tens_place = val * 10;
			success = true;
		}
		if ( place == ONES && val >= 0 ) {
			ones_place = val * 1;
			success = true;
		}
		if ( place == TENTHS && val >= 0 ) {
			tenths_place = val * 0.1;
			success = true;
		}
		if ( place == HUNDRETHS && val >= 0 ) {
			hundredths_place = val * 0.01;
			success = true;
		}
		if ( place == THOUSANDTHS && val >= 0 ) {
			thousandths_place = val * 0.001;
			success = true;
		}
		if ( place == TEN_THOUSANDTHS && val >= 0 ) {
			ten_thousandths_place = val * 0.0001;
			success = true;
		}
	}
	
	if ( val == KICK ) {
		if ( place == TEN_THOUSANDS ){
			int tenThousands = GetScreenDPlace(reg, TEN_THOUSANDS);
			tenThousands--;
			if ( tenThousands >= 0 ) {
				ten_thousands_place = tenThousands * 10000;
				success = true;
			}
		}
		if ( place == THOUSANDS ) {
			int thousands = GetScreenDPlace(reg, THOUSANDS);
			thousands--;
			if ( thousands >= 0 ) {
				thousands_place = thousands * 1000;
				success = true;
			}
		}
		if ( place == HUNDREDS ) {
			int hundreds = GetScreenDPlace(reg, HUNDREDS);
			hundreds--;
			if ( hundreds >= 0 ) {
				hundreds_place = val * 100;
				success = true;
			}
		}
		if ( place == TENS ) {
			int tens = GetScreenDPlace(reg, TENS);
			tens--;
			if ( tens >= 0 ) {
				tens_place = val * 10;
				success = true;
			}
		}
		if ( place == ONES ) {
			int ones = GetScreenDPlace(reg, ONES);
			ones--;
			if ( ones >= 0 ) {
				ones_place = val * 1;
				success = true;
			}
		}
		if ( place == TENTHS ) {
			int tenths = GetScreenDPlace(reg, TENTHS);
			tenths--;
			if ( tenths >= 0 ) {
				tenths_place = val * 0.1;
				success = true;
			}
		}
		if ( place == HUNDRETHS ) {
			int hundreths = GetScreenDPlace(reg, HUNDRETHS);
			hundreths--;
			if ( hundreths >=0 ) {
				hundredths_place = val * 0.01;
				success = true;
			}
		}
		if ( place == THOUSANDTHS ) {
			int thousandths = GetScreenDPlace(reg, THOUSANDTHS);
			thousandths--;
			if ( thousandths >= 0 ) {
				thousandths_place = val * 0.001;
				success = true;
			}
		}
		if ( place == TEN_THOUSANDTHS ) {
			int tenThousandths = GetScreenDPlace(reg, TEN_THOUSANDTHS);
			tenThousandths--;
			if ( tenThousandths >= 0 ) {
				ten_thousandths_place = val * 0.0001;
				success = true;
			}
		}
	}
	if ( val == BUMP ) {
		if ( place == TEN_THOUSANDS ){
			int tenThousands = GetScreenDPlace(reg, TEN_THOUSANDS);
			tenThousands++;
			if ( tenThousands < 10 ) {
				ten_thousands_place = tenThousands * 10000;
				success = true;
			}
		}
		if ( place == THOUSANDS ) {
			int thousands = GetScreenDPlace(reg, THOUSANDS);
			thousands++;
			if ( thousands < 10 ) {
				thousands_place = thousands * 1000;
				success = true;
			}
		}
		if ( place == HUNDREDS ) {
			int hundreds = GetScreenDPlace(reg, HUNDREDS);
			hundreds++;
			if ( hundreds < 10 ) {
				hundreds_place = val * 100;
				success = true;
			}
		}
		if ( place == TENS ) {
			int tens = GetScreenDPlace(reg, TENS);
			tens++;
			if ( tens < 10 ) {
				tens_place = val * 10;
				success = true;
			}
		}
		if ( place == ONES ) {
			int ones = GetScreenDPlace(reg, ONES);
			ones++;
			if ( ones < 10 ) {
				ones_place = val * 1;
				success = true;
			}
		}
		if ( place == TENTHS ) {
			int tenths = GetScreenDPlace(reg, TENTHS);
			tenths++;
			if ( tenths < 10 ) {
				tenths_place = val * 0.1;
				success = true;
			}
		}
		if ( place == HUNDRETHS ) {
			int hundreths = GetScreenDPlace(reg, HUNDRETHS);
			hundreths++;
			if ( hundreths < 10 ) {
				hundredths_place = val * 0.01;
				success = true;
			}
		}
		if ( place == THOUSANDTHS ) {
			int thousandths = GetScreenDPlace(reg, THOUSANDTHS);
			thousandths++;
			if ( thousandths < 10 ) {
				thousandths_place = val * 0.001;
				success = true;
			}
		}
		if ( place == TEN_THOUSANDTHS ) {
			int tenThousandths = GetScreenDPlace(reg, TEN_THOUSANDTHS);
			tenThousandths++;
			if ( tenThousandths < 10 ) {
				ten_thousandths_place = val * 0.0001;
				success = true;
			}
		}
	}
		
	if ( success ) {
		valModified = ten_thousandths_place + thousandths_place + hundredths_place + tenths_place + ones_place + tens_place + hundreds_place + thousands_place + ten_thousands_place;
		SetScreenD(reg, valModified);
		return true;
	}
	
	return false;
}

//Returns a single digit of a Screen->D[register].
int GetScreenDPlace(int reg, int place){
	int val = GetDigit(Screen->D[reg],place);
	return val;
}