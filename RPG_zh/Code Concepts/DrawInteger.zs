const DRAW_FONT =
const DRAW_FONT_COLOUR = 
const DRAW_FONT_SIZE_X = 
const DRAW_FONT_SIZE_Y = 
const DRAW_FONT_OPACITY = 
const DRAW_FONT_BG_COLOUR = 

void QuickInteger(int x, int y, int val){
	Screen->DrawInteger(7,x,y,DRAW_FONT,DRAW_FONT_COLOUR,DRAW_FONT_BG_COLOUR,DRAW_FONT_SIZE_X,DRAW_FONT_SIZE_Y,val,0,DRAW_FONT_OPACITY);
}

void QuickInteger(int x, int y, int val, int font){
	Screen->DrawInteger(7,x,y,font,DRAW_FONT_COLOUR,DRAW_FONT_BG_COLOUR,DRAW_FONT_SIZE_X,DRAW_FONT_SIZE_Y,val,0,DRAW_FONT_OPACITY);
}
	
void QuickInteger(int x, int y, int val, int font, int colour){
	Screen->DrawInteger(7,x,y,font,colour,DRAW_FONT_BG_COLOUR,DRAW_FONT_SIZE_X,DRAW_FONT_SIZE_Y,val,0,DRAW_FONT_OPACITY);
}

void QuickInteger(int x, int y, int val, int font, int colour, int background){
	Screen->DrawInteger(7,x,y,font,colour,background,DRAW_FONT_SIZE_X,DRAW_FONT_SIZE_Y,val,0,DRAW_FONT_OPACITY);
}