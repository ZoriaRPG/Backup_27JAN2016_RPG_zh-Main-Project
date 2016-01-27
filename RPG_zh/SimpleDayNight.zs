const int CSET_DAY = 0;
const int CSET_NIGHT = 1;

//Run before Waitdraw()
void DayNight(){
	int curCSet = GetLayerComboC(0,0);
	if (curCSet == CSET_DAY ) curCSet = CSET_NIGHT;
	for ( int q = 0; q < 7; q++ ) {
		for ( int w = 0; w < 176; w++ ) {
			SetLayerComboC(q,w,curCSet);
		}
	}
}