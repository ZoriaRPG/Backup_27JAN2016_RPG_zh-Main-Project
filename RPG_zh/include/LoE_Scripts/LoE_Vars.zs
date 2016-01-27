GC Main

Line 25
//bool noMenu = false; *

43,44,45
//bool LinkSeen;
//int DROP_ENEMY_ID = 0;
//int Drinks_Left;

59-74
//int f1 = 0;
//int f2 = 0;
//int rad = 0;
//int slower = 0;
//int bombs = 0;
//int r1 = 0;
//int r2 = 0;
//int slowera = 0;
//int ffcslot = 1;
//int usebombodo = 0;
//int ringTimer;	
//int byrnaTimer;
//int bootsTimer;
//bool ownStaff; Line 60-64 of global & 39-45 of gc_Jhkarr
//bool ownNightfall;
//bool ownSwordOfLight;

79
//bool ringOn;

81
//bool byrnaOn;

83-85
//bool bootsOn;
//bool gogglesOn;
//int gogglesTimer; //25th

231
//bool dalekLanding = false;


GC_GLOBAL 69

line 17
//bool ffcsSuspended;

RPG_zh

RPG_Backup
//These appear to be unused at present.

line 15
//bool EverSaved = false; 

21
//bool SaveAndQuit = false

137
XP_Bak[]

RPG_Definitions
(all strings)

RPG_Dialogue
Line 13
//bool playingMessage = false; 

RPG_DMAPS_Ext
Lines 1, 2, 3

int dmapName[21]; //20 + NULL
int dmapTitle[21]; //20 + NULL
int dmapIntro[73]; //72 + NULL

RPG_ENgine
Line 142
int GameEngine[]
142
int MeterGauges[10]={0,0,0,0,0,0,0,0,0,0};

150-155
//bool isSwimming; //Used with swimming functions.
//bool d20Mods = false; //Set to true, to use d20 System calculations, Otherwise, stat mods use...
//int statModMultiplier = 0.5; //Used if not using d20 Mods.
//int timerItem = 0;
//int timerValue = 0;
//bool cigarPickup; //This is a timer item pickup.

159
//int LastItemUsed = 0;

RPG_Experimental

Lines 642-663
Enemy Type Arrays

804
//int playerHP; //38th

RPG_Menus
Lines 17 to 26
//bool menuTalk = false; 
//bool playerTalking = false;
//bool playerListening = false;
//bool playerSearching = false;
//bool playerExamining = false;
//bool playerDisarming = false;
//bool playerTakingItem = false;
//bool playerChecking = false;
//bool playerLooking = false;
//bool playerVista = false;

44-45
//bool menuOpen; // Used to define if menus are active.
//bool equipItem = false; // Used to equip items through the menus. //50th


RPG_Money

Lines 74-91
float walletSize = 50; //Sts default space within wallets. Can be changed later in game.
int walletsOwned = 1; //Setsa initial number of wallets owned by player.
float walletSpaceUsed = 0; //Sets initial amount of used wallet space.
int pockets = 2; //Sets initial number of pockets player has. Can be changed with clothing upgrades.
float pocketCapacity = 20; // Sets pocket capacity for loose items.
float pocketSpaceUsed = 0; //Sets initial pocket space used by player.
float totalWalletSpace; // Total amount of available WALLET space.
float baseWalletSpace; // Base amount of space for ONE wallet.
float totalPocketSpace; // Total amount of available POCKET space.
float totalPocketAndWalletSpace; //Combined total available space.
float CR_CUSTOM_WALLET_SIZE = 0; // 

float freePocketSpace;  // Available (free) space in pockets.
float freeWalletSpace;// Available (free) space in wallets.

float freeSpace; // Total free space.
float valueStored; // Stored item volume.
float coinsize; // Size of coins.

97
bool noFreeSpace = false; 

101
bool reduced; // U3d for removing stored items, and reducing the amount of space used.

RPG_Overworld

Lines 21-22
//int challengeNumber = 0;
int warpArray[5]={0,0,0,0,0};

30
//int breathUnderwater; //Move this into an arrray

76
//bool FirstPlay = true; //Used once to determine if the game should show starting instructions.

RPG_Player

Line 106
int UselessCounterItems[30];

RPG_SKills

Lines 11-14

int loreSuccess = 0; //Shouldnl't this be part of the array?
int loreRow = 0;
int loreColumn = 0;

Line 50
int itemLoreRow = 0; //Move array pointer to desired row, by advancing it by 8 positions.

172
int loreSkill;

RPG_Stats
Line 19:
int statsArray[6]= {10, 10, 10, 10, 10, 10};

RPG_Status: Merge arrays.

RPG_TangoMen\us:

Lines 19-20
int menuCommand;
int menuArg;

These are probably also in Tango scripts.

RPG_Weapons
Lines 47-52
bool hasShield;
bool shieldMessage = true;
bool hasSword;
bool swordMessage = true;
bool hasArmour;
bool armourMessage = true;

62-66
int currentDamage; // A placeholder for storing the damage value of items.
int beamMultiplier = 0.5; //A placeholder for storing a variable multiplier.
bool WSpierce = false; //Used to determine of a weapon is piercing

bool WeaponCreated[40]; // Used for NWS v1, to tell the game engine to use the NWS global functions for a given weapon.





