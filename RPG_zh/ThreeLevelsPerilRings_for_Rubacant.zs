
//v0.2 26-NOV-2015

int OwnsItems[256];

//Pickup Script
item script Ownitem{
	void run(){
		OwnsItems[this->ID] = 1;
	}
}

const int I_PERILRING2 = 100; //Set to ID of Level 2 Peril Ring
const int I_PERILRING3 = 101; //Set to ID of Level 3 Peril Ring (15 at 1 heart)

//Assign to global slot 2 (active) if you do not already have a global active script.
global script active{
	void run(){
		while(true){
			ThreePerilRingLevels(I_PERILRING, I_PERILRING2, I_PERILRING3);
			PerilRingSwitch(I_PERILRING, I_PERILRING2, I_PERILRING3);
			Waitdraw();
			Waitframe();
		}
	}
}


//Call after ThreePerilRingLevels() and before Waitdraw();
void PerilRingSwitch(int firstRing, int secondRing, int thirdRing){
	if ( OwnsItems[secondRing] && OwnsItems[thirdRing] && OwnsItems[firstRing] ) {
		if ( Link->HP <= 16 ) {
			if ( !Link->Item[thirdRing] ) Link->Item[thirdRing] = true;
			if ( Link->Item[secondRing] ) Link->Item[secondRing] = false;
		}
		if ( Link->HP > 16 ) {
			if ( Link->Item[thirdRing] ) Link->Item[thirdRing] = false;
			if ( Link->Item[secondRing] ) Link->Item[secondRing] = false;
			if ( !Link->Item[firstRing] ) Link->Item[firstRing] = true;
		}
	}
}


//Calll before Waitdraw(), but before PerilRingSwitch() in a global script.
void ThreePerilRingLevels(int firstRing, int secondRing, int thirdRing){
    if (Link->Item[firstRing] && Link->Item[secondRing] && !Link->Item[thirdRing] ) {
	if ( !OwnsItems[thirdRing] ) OwnsItems[thirdRing] = 1;
        Link->Item[thirdRing] = true:
    }
}
