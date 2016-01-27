void DisplayCharName(int layer, int x, int y, int font, int colour, int bgcolour, int format, int opacity, int msg){
	int charName[18]=" ";
	GetMessage(msg,charName);
	int length = strlen(charName);
	Screen->DrawString(layer, x, y, font, colour, bgcolour, format, charName, opacity, 1, length);
}

//Call as: DisplayCharName(6, 24+32+8, y-32+18, FONT_Z1, 1, -1, TF_NORMAL, 128, InternalStringID)


void DisplayCharName(int layer, int x, int y, int font, int colour, int bgcolour, int format, int opacity, int msg, int length){
	int charName[18]=" ";
	GetMessage(msg,charName);
	Screen->DrawString(layer, x, y, font, colour, bgcolour, format, charName, opacity, 1, length);
}

//Call as: DisplayCharName(6, 24+32+8, y-32+18, FONT_Z1, 1, -1, TF_NORMAL, 128, InternalStringID)

//Use the length arg to set the number of chars to print.
void DisplayCharName(int layer, int x, int y, int font, int colour, int bgcolour, int format, int opacity, int msg, int length){
	int charName[18]=" ";
	GetMessage(msg,charName);
	Screen->DrawString(layer, (x - (length * 8) ), y, font, colour, bgcolour, format, charName, opacity, 1, length);
}

//Will offset X by 8 pixels, per character in length.

//Use the length arg to set the number of chars to print.
void DisplayCharName(int layer, int x, int y, int font, int colour, int bgcolour, int format, int opacity, int msg){
	int charName[18]=" ";
	GetMessage(msg,charName);
	int chr;
	for ( int q = 0; q <= strlen(charName); q++ ){
		if ( isAlphaNumeric(charName[q] ) continue;
		else {
			charName[q] = 0;
			break;
		}
	}
	int length = strlen(charName);
	Screen->DrawString(layer, (x - (length * 8) ), y, font, colour, bgcolour, format, charName, opacity, 1, length);
}

//Will offset X by 8 pixels, per character in length.

void DisplayCharName(int layer, int x, int y, int font, int colour, int bgcolour, int format, int opacity, int msg){
	int charName[18]=" ";
	GetMessage(msg,charName);
	int chr;
	for ( int q = 0; q <= strlen(charName); q++ ){
		if ( isAlphaNumeric(charName[q] ) continue;
		else {
			charName[q] = 0;
			break;
		}
	}
	int length = strlen(charName);
	Screen->DrawString(layer, (x - (length * 8) ), y, font, colour, bgcolour, format, charName, opacity);
}