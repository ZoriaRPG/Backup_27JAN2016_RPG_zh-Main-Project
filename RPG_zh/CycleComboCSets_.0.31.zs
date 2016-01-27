int CycleIceCombos[20];
const int TIMER_ICE_COMBO = 0;
const int CSET_ICE_CURRENT = 1;
const int CSET_ICE_FIRST = 2;
const int CSET_ICE_SECOND = 3;
const int CSET_ICE_THIRD = 4;
const int CSET_ICE_LAST = 5;

//We should be able to store this at the function level. 
//int CycleIceComboD[]={0}; //Populate with Combo IDs.

//Do we need any of these?
const int CSET_ICE_LAYER_1 = 10;
const int CSET_ICE_LAYER_2 = 11;
const int CSET_ICE_LAYER_3 = 12;
const int CSET_ICE_LAYER_4 = 13;
const int CSET_ICE_LAYER_5 = 14;
const int CSET_ICE_LAYER_6 = 15;
const int CSET_ICE_LAYER_7 = 17;

const int ICE_TIMER_VALUE = 5;

void IceCombos(int itemNumber, int level){
	int lvl = Game->GetCurLevel();
	int CycleIceComboD[]={2,3,4,9}; //Populate with Combo IDs.
	if ( lvl == level ) CycleCSets(CycleIceComboD,CycleIceCombos[TIMER_ICE_COMBO], game->LoadItemData(itemNumber), CycleIceCombos, CSET_ICE_FIRST, CSET_ICE_LAST, 7);
}

//Args: 'list is the array of COmb oD to use, 'useTimer' is the array[andindex] for the timer.
//'resetValue' is the vakue in frames, to reset the timer, 
//!In this version, it uses the Level attribute of any item, or dummy item.
//'cSetList' is the array holding the CSet and layer values,
//start, and end, are used in the for loop to determine the places to start checking CSets in the array, for changing them, 
//or to return to the start of the array, and maxLayer specifies the highest layer on which to change combos. 
void CycleCSets(int list, int useTimer, itemdata resetValue, int cSetList, int start, int end, int maxLayer){
	useTimer--;
	int curCSet;
	bool cannotMatch; 
	int safety  = cSetList[end] * 2;

	if ( useTimer == 0 ) {
		if ( maxLayer ) {
			for ( int layer = 0; layer <= maxLayer; layer++ ) {
				for ( int cmb = 0; cmb < 176; cmb++ ) {
					if ( IsComboD(cmb,list,layer) ) {
						//Figure out what CSet to use;
						curCSet = GetLayerComboC(layer,cmb); 
						//? Is this going to read the cset, or the position?
						//! Check the return values in the functions, to be certain.
						for ( int cs = cSetList[start]; cs <= cSetList[end]; cs++ ) 
						{
							if ( curCset == cSetList[end] ) 
							{
								curCSet = cSetList[start];
								break;
							}
							//if ( cSetList[cs] != curCSet && curCSet != cSetList[CSET_ICE_LAST] ) continue; 
							if ( cSetList[cs] == curCSet && curCSet != cSetList[end] ) 
							{
								curCSet = cSetList[cs+1];
								break;
							}
							safety--;
							if ( savety < 0 ) {
								cannotMatch = true;
								break;
							}
						}
						if ( !cannotMatch ) SetLayerComboC(layer,cmb);
					}
				}
			}
		}
		if ( !maxLayer ) {
			for ( int cmb = 1; cmb < 176, cmb++ ) {
				if ( IsComboD(cmb,list) {
					//Figure out what CSet to use;
					curCSet = Screen->ComboC[cmb];
					for ( int cs = cSetList[start]; cs <= cSetList[end]; cs++ ) 
					{
						if ( curCset == cSetList[end] ) 
						{
							curCSet = cSetList[start];
							break;
						}
						//if ( cSetList[cs] != curCSet && curCSet != cSetList[CSET_ICE_LAST] ) continue; 
						if ( cSetList[cs] == curCSet && curCSet != cSetList[end] ) 
						{
							curCSet = cSetList[cs+1];
							break;
						}
						safety--;
						if ( savety < 0 ) {
							cannotMatch = true;
							break;
						}
					}
					if ( !cannotMatch ) Screen->ComboC[pos] = curCSet;
				}
			}
		}
		useTimer = tesetValue;
	}
	if ( useTimer <= 0 ) useTimer = resetValue->Level;
}





int IsComboC(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( Screen->ComboC[pos] == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}


int IsComboC(int pos, int list, int layer){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( GetLayerComboC(layer,pos) == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

int IsComboD(int pos, int list, int layer){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( GetLayerComboD(layer,pos) == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

int IsComboD(int pos, int list){
	bool match;
	for ( int q = 0; q <= SizeOfArray(list); q++ ) {
		if ( Screen->ComboD[pos] == list[q] ) return q+1;
		
	}
	//return match;
	return 0;
}

void ComboC(int pos, int cmb, int offset){
	Screen->ComboC[pos-offset] = cmb;
}

void SetLayerComboC(int layer, int pos, int cmb, int offset){
	SetLayerComboC(layer,pos-offset,cmb);
}
