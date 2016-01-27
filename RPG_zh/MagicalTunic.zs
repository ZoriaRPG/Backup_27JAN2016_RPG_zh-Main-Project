const int I_MAGICAL_TUNIC_PROXY = 200; //item ID of magical tunic proxy (dummy) item.
const int I_MAGICAL_TUNUC = 199; //ID of actual Magical Tunic.

const int TILE_MAGICAL_TUNIC_ON = 1200; //Set to Tile ID of illuminated Magical Tunic.
					
const int TILE_MAGICAL_TUNIC_OFF = 1201; //Set to Tile ID of non-illuminated Magical Tunic Tile.
					 //This should also be the tile that you use for the Magical
					 //Tunic Proxy Item in the Item Editor.

float OwnsMagicalTunic;

//Magical Tunic Item Pickup Script.

item script MagicalTunicPickup{
	void run(){
		OwnsMagicalTunic = 1;
		if ( !Link->Item[I_MAGICAL_TUNIC_PROXY] ) Link->Item[I_MAGICAL_TUNIC_PROXY] = true;
	}
}

// Item script for Proxy item. 
// Use this in the subscreen. Selecting it, and pressing a button (A/B) will turn it on, and off. 
// This is the item to give, to the player as a treasure. 

item script EquipUnequipMagicalTunic{
	void run(){
		if ( !OwnsmagicalTunic ) Quit();
		if ( !Link->Item[I_MAGICAL_TUNIC] ) {
			SwapTile(TILE_MAGICAL_TUNIC_ON, TILE_MAGICAL_TUNIC_OFF); //Illuminates item tile. 
			Link->Item[I_MAGICAL_TUNIC] = true;
		}
		if ( Link->Item[I_MAGICAL_TUNIC] ) {
			SwapTile(TILE_MAGICAL_TUNIC_OFF, TILE_MAGICAL_TUNIC_ON ); //Dim item tile. 
			Link->Item[I_MAGICAL_TUNIC] = false;
		}
	}
}

// Function to set tile and item state on game load.

void DisableMagicalTunic(){
	if ( OwnsmagicalTunic ) {
		if ( Link->Item[I_MAGICAL_TUNIC] ) {
			Link->Item[I_MAGICAL_TUNIC] = false;
		}
	}
}

//Sample global scripts

global acript OnContinue{
	void run(){
		DisableMagicalTunic();
	}
}

global script active{
	void run(){
		DisableMagicalTunic();
		while ( true ) {
			Waitdraw();
			Waitframe();
		}
	}
}