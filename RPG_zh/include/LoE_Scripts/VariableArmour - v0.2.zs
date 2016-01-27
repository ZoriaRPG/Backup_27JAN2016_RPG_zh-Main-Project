//Variable Armour v0.2

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
///Magic Cost: Set this to a value above '0', and every time the player takes a hit, he uses magic. if he runs out, he shifts back to a stock ring.

void SetRingDivisor(){
	ModItemPower(I_ARMOUR, RingDivisor);
}

//Sets with a specific amount.
void SetRingDivisor(int amount){
	ModItemPower(I_ARMOUR, amount);
}

//Sets either with index valB of array ValA (array == true) or random value between valA and valB ( array == false )
void VaryRingDivisor(int valA, int valB, bool array){
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
void VaryRingDivisor(int ctr, bool direct) {
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
void VaryRingDivisor(int var, bool direct, int how){
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
	