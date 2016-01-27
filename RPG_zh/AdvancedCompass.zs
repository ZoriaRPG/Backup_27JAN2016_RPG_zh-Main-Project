//Advanced Compass

//Makes different sounds based on the types of secrets in a room

const int SFX_COMPASS_WATER = 
const int SFX_COMPASS_CHEST_ITEM
const int SFX_COMPASS_KEY
const int SFX_COMPASS_ENEMIES_ITEM
const int SFX_COMPASS_SECRETCHEST
const int SFX_COMPASS_COMBO

int ScreenItem(){
	if ( Screen->RoomType == RT_SPECIALITEM ) return Screen->RoomData;
}

if ( HasCompass(Game->GetCurLevel() ) {
	int scritem = ScreenItem();
	int type;
	//Check for money;
	int moneyIDs[]={}; //Popukate with IDs of rupee awards.
	int arrows[]={}; //Popuklate with IDs of arrow awards.
	int bombs[]={}; //Populate with IDs of bomb awards.
	int inventoryitems[]={}; //Populate with inventory items.
	int keytypes[]={}; //Populate with IDs of keys.
	int bosskeytypes[]={}; //Populate with IDs of boss keys.
	int maptypes[]={}; //Populate with map items.
	int compasstypes={}; //Populatge with compass item types.
	int chestcombos[]={}; //Populate with ids of chest combos (used with secret combos).
		//! We should use one array, and use different starting indices to run for loops. 
		//! instead of a huge list of arrays; to save registers.
	if ( ScreenItem() == 


//Refs
//Item pickup flags. OR (|) these together to use with item->Pickup
//Other values are reserved for internal usage, and have no effect
const int IP_HOLDUP			= 0x002; //Link holds it up when collecting it.
const int IP_ST_ITEM			= 0x004; //Sets the screen state "Item" when collected.
const int IP_DUMMY			= 0x008; //A 'dummy' item, such as rupee markers in shops. Can't be collected and ignores gravity.
const int IP_ENEMYCARRIED		= 0x080; //The item-carrying NPC carries it. If no NPC has an item, the most recently created NPC carries it.
const int IP_TIMEOUT			= 0x100; //Disappears after 512 frames. Can be collected by melee weapons if the related quest rule is not set.
const int IP_ST_SPECIALITEM		= 0x800; //Sets the screen state "Special Item" when collected.