//Variable Armour v0.3

int RingDivisor;
const int I_ARMOUR = 17;
//Set the ring as follows:
////////////////
/// Data Tab ///
////////////////
//Class: Rings
//Level: 2 (or higher, if desired)
//Damage Divisor: 1
//Link CSet Palette: 0 (or as desired)
//Equipment Item: On


//////////////////
/// Action Tab ///
//////////////////
///Magic Cost: Set this to a value above '0', and every time the player takes a hit, he uses magic. 
///If he runs out, he shifts back to a stock ring (no protection). This is why you want the item to be Level '2'.

//Call every frame in your global active loop, before Waitdraw().
void SetRingPower(){
	//Check to see if itm->Power- is not already value.
	itemdata itm = Game->LoadItemData(I_ARMOUR);
	if ( itm->Power != RingDivisor ) {
		ModItemPower(I_ARMOUR, RingDivisor);
	}
}


///Functions to change value of ring divisor at will.

//Sets with a specific amount.
void SetRingDivisor(int val){
	RingDivisor = val;
}

//Sets either with index valB of array ValA (array == true) or random value between valA and valB ( array == false )
void SetRingDivisor(int valA, int valB, bool array){
	int val;
	if ( array ){
		val = valA[valB];
		RingDivisor = val;
	}
	else {
		val = Rand(min,max);
		RingDivisor = val;
	}
}

//Set using the direct (precise) value of a counter, or 1/16 of that value (!direct). Useful for basing on magic, or health.
void SetRingDivisor(int ctr, bool direct) {
	int val;
	if ( direct ) {
		val = Game->Counter[ctr];
		RingDivisor = val;
	}
	else {
		val = (Game->Counter[ctr] / 16);
		RingDivisor = val;
	}
}

//Set using either the percentage of a counter, or with a fixed amount if Link owns another item.
void SetRingDivisor(int var, bool direct, int how){
	int val;
	if ( !direct ) {
		val = ( Game->Counter[ctr] / 100 ) * percentage);
		RingDivisor = val;
	}
	else {
		if ( Link->Item[how] ) {
			RingDivisor = var;
	}
}



//Sets with a specific amount.
void _SetRingDivisor(int amount){
	ModItemPower(I_ARMOUR, amount);
}

//Sets either with index valB of array ValA (array == true) or random value between valA and valB ( array == false )
void _VaryRingDivisor(int valA, int valB, bool array){
	int val;
	if ( array ){
		val = valA[valB];
		ModItemPower(I_ARMOUR, val)
	}
	else {
		val = Rand(min,max);
		ModItemPower(I_ARMOUR, val);
	}
}
	
//Set using the direct (precise) value of a counter, or 1/16 of that value (!direct). Useful for basing on magic, or health.
void _VaryRingDivisor(int ctr, bool direct) {
	int val;
	if ( direct ) {
		val = Game->Counter[ctr];
		ModItemPower(I_ARMOUR, val);
	}
	else {
		val = (Game->Counter[ctr] / 16);
	}
}

//Set using either the percentage of a counter, or with a fixed amount if Link owns another item.
void _VaryRingDivisor(int var, bool direct, int how){
	int val;
	if ( !direct ) {
		val = ( Game->Counter[ctr] / 100 ) * percentage);
	}
	else {
		if ( Link->Item[how] ) {
			ModItemPower(I_ARMOUR, var);
	}
}



void VaryRingDivisor(bool usesItem, int itm){

}
	