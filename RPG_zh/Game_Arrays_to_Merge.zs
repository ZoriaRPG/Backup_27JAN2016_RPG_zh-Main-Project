//Game Arrays to Merge into GameDynamics
/// or make _BAK versions of these, and use SaveGame() to copy all arrays into their _BAK equivalent, and restore to copy from _BAK to the main array.

RPG.zh

Engine
// Arrays
int GameDynamics[8192] = {0}; //This array holds numeric values, and strings, used by the game. 
bool GameEvents[8192] = {false}; //This array is used for most custom game engine dynamics as a boolean control. 
//It works with GameDynamics[], which holds numeric values for these same things. 
//The constants, and array index size should match when completed. 

//Constants 0 to 499 reserved. DO NOT USE FOR ITEMS!
	
bool OwnsItems[2048]={0}; //512 items, x4 characters. Items that the player has, to allow 'Equip/Unequip'
bool ItemEquipped[2048]={0}; //512 items, x4 characters

int GameEngine[]={0};
int MeterGauges[10]={0,0,0,0,0,0,0,0,0,0};

Experimental
int GameClock[10] = {0,0,0,0,0,0,0,0,0,0};
// Second	Segment	Minute ( Round )	Turn		Span 	( Hour ) 
// 15 seconds per segment. Four Segments per Round. Ten rounds per turn. Three turns per Span Two Spans per Hour. 28 hours per day. 7 days per week. Five weeks per month. Ten months per annus.



Experimental_Ext
//Need to copy SUMXP on Quick Save and restore on Restore() or move XP into GameDynamics entirely, keeping only the table portions of XPAwards

RPG_Levels
int levelStrings[21] = { 61, 61, 61, 61, 60, 59, 59, 59, 59, 61, 59, 59, 59, 59, 59, 62, 59, 59, 59, 63, 85 };
// Element [0] General string, for common use.
// Element [1] to [20]The strings to play when gaining levels 1, through 20.
	///This is fixed. No need to merge.


Money
/// !These arrays need a separate backup for quick save and restore!
	float capacitiyArray[26]={ 
                    0, //baseWalletSpace[0]
                    50, //walletSize [1]
                    1, //walletsOwned [2]
                    0, //CR_CUSTOM_WALLET_SIZE [3] (add space to this for wallets that have a size > walletSize)
                    50, //totalWalletSpace [4]

                    2, //pockets [5]
                    20, //pocketCapacity [6]
                    40, //totalPocletSpace [7]
                    
                    90, //totalPocketAndWalletSpace [8]

                    0, //pocketSpaceUsed [9]
                    0, //walletSpaceUsed [10]
                    0, //fineSpaceUsed [11] (for items smaller than 1, multiply this by *0.10, then add this to spaceUsed)
                    0, //totalSpaceUsed [12]
                    
                    0, //freePocketSpace [13]
                    0, //freeWalletSpace [14]
                    0, //freeFineSpace [15]
                    0, //freeSpace [16]
                    
                    0, //valueStored [17]
                    0, //coinsize [18]
                    
                    0, //Merks Carried [19]
                    
                    0, //Value of Dsari banked [20]
                    0, //Value of Merks banked [21]
                    0, //Dsari CryDiscs [22]
                    0, //merks CryDiscs [23]
                    
                    
                    0, //NO_FREE_SPACE [24] Message
                    0}; //NO_SPACE_SFX [25] SFX
                    
NPCDs
int ScriptTypes[10]={0,0,0,0,0,0,0,0,0,0}; //Temporary array for special script types. Use NPCDT_ constants in indixes.


Overworldint warpArray[5]={0,0,0,0,0};

const int warpDMAP = 0;
const int warpScreen = 1;
const int warpX = 2;
const int warpY = 3;
const int warpZ = 4;

//Merge this all into GameDynamics!

Skills
int skillCheckArray[32] = { 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0 };
			

int skillLevels[11]={ 1, // Lore
                    1, // Mystic Lore
                    1, // Site & History Lore
                    1, // Swordsmanship
                    1, // Marksmanship
                    1, // Diplomacy
                    1, // Spellcraft
                    1, // Perception
                    1, // Language
                    1, // Thief
                    1}; //Assense
		    
		    
Spells
int currentSpells[9]={0,0,0,0,0,0,0,0,0};   //Hplds current spells (see Spell Constants) for each 
                                            //item that can be set with the SET menuy command.


Stats
int statsArray[6]= {10, 10, 10, 10, 10, 10};
// Muscle, Body, Mind, Myst, infl, Luck
// These are the starting values. The Increase functions 
// will operate via this array, as will all other stat functions.

Status
int savingThrows[22]={  0, // Posion
                        0, // Stun
                        0, // Fatigue
                        0, // Magic
                        0, // Psychic
                        0, // Fire
                        0, // Water
                        0, // Air
                        0, // Earth
                        0, // Light
                        0, // Darkness
                        0, // Sonic
                        0, // Petrification
                        0, // Fear
                        0, // Death
                        0, // Horror
                        0, // Insanity
                        0, // Corruption
                        0, // Depravity
                        0, // Righteousness
                        0, // Purity
                        0}; // Fate
			
int elementalResistance[7]={0, //Fire & Heat
                            0, //Water & Ice
                            0, //Air & Electricity
                            0, //Earth & Acid
                            0, //Light
                            0, //Darkness
                            0}; //Sonic
                            
int taintArray[4]={ 0, //Corruption
                    0, //Depravity
                    0, //Righteusness
                    0}; //Purity
		    

Weapons
		    
int NPC_SCRIPT_DEFENSE[1000]; //An array, to hold NPC defence flags.

float armourDefenseArray[20]={0,0,0,0,0,0,0,0,0,0,
                             0,0,0,0,0,0,0,0,0,0};
			     
bool WeaponCreated[40]; // Used for NWS v1, to tell the game engine to use the NWS global functions for a given weapon.

