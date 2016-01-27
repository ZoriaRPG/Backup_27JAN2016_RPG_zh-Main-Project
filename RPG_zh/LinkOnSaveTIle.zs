
//String formatting.
const int SAVE_STRING_FONT = 0; //Z1 font. 
const int SAVE_STRING_FONT_COLOUR = 1; //White
const int SAVE_STRING_FONT_BACKGROUND_COLOUR = 16; //Black
const int SAVE_STRING_POS_X = 64; //Try to centre it. 
const int SAVE_STRING_POS_Y = -16; //Display over passive subscreen.
const int SAVE_STRING_LAYER = 6;
const int SAVE_STRING_FONT_OPACITY = 128; //Opaque.

//Combo collision settings.
const int SAVE_POINT_SENSITIVITY = 1;

//Call before Waitdraw() in your global active script. 
void LinkOnSaveTile{
	int saveString[]="Press Start to Save";
	for ( int q = 0; q < 176; q++ ) {
		if ( ( Screen->ComboT[q] == CT_SAVE || Screen->ComboT == CT_SAVE2 ) && _LinkComboCollision(q,SAVE_POINT_SENSITIVITY) ) {
			Screen->DrawString(	SAVE_STRING_LAYER, SAVE_STRING_POS_X, SAVE_STRING_POS_Y, SAVE_STRING_FONT, 
						SAVE_STRING_FONT_BACKGROUND_COLOUR, TF_NORMAL, saveString, SAVE_STRING_FONT_OPACITY );
		}
	}
}


//Returns TRUE if Link touches the combo.
bool _LinkComboCollision(int loc, int sens){
	int ax = Link->X;
	int ay = Link->Y;
	int bx = (Link->X)+(Link->HitWidth);
	int by = (Link->Y)+(Link->HitHeight);
	if(!(RectCollision( ComboX(loc), ComboY(loc), (ComboX(loc)+16), (ComboY(loc)+16), ax, ay, bx, by))) return false;
	else if (!(Distance(CenterLinkX(), CenterLinkY(), (ComboX(loc)+8), (ComboY(loc)+8)) < (sens+8))) return false;
	else return true;
}

