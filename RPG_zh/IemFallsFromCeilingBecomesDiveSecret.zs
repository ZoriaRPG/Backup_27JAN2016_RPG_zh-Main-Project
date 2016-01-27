//Key falls from ceiling into water and becomes dive item
//ffc should be on layer above water.

const int CMB_SPLASH = 1;
const int CMB_RIPPLES = 1;

ffc script FallThenDiveItem{
	void run(int wait_frames){
		int splashCycle = 120;
		int rippleCycle = 240;
		//Read the room type to determine the item we're using.
		//item itm = Roomitem 
		itemdata it = Game->LoadItemData(itm);
		int itemId = it->ID;
		Waitframes(wait_frames); //Wait for the item to fall.
		
		
		
		while(true){
			
			
			
			//Item falls from ceiling over ffc
			//remove the item and make a splash graphic or ripples
			
			Remove(itm);
			//We need timers for the ripples, and splash, or a combo that is animated.
			if ( splashCycle ) {
				splashCycle--;
				if ( this->Data != CMB_SPLASH ) this->Data = CMB_SPLASH;
			}
			if ( splashCycle <= 0 && rippleCycle ) {
				rippleCycle--;
				if ( this->Data != CMB_RIPPLE ) this->Data = CMB_RIPPLE;
			}
			
			//mark the spot as able to dive
			
			//if Link dives here
			if ( Link->Action == LA_SWIMMING && Link->PressA && LinkCollision(this) ) 
			//make an item at his location
			//hold over head then breakx
			Waitframe();
		}
	}
}