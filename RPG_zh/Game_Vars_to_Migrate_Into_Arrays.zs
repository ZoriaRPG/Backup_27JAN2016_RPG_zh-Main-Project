RPG Vars

Dialogue 
bool playingMessage = false; 

Engine
bool isSwimming; //Used with swimming functions.
bool d20Mods = false; //Set to true, to use d20 System calculations, Otherwise, stat mods use...
int statModMultiplier = 0.5; //Used if not using d20 Mods.
int timerItem = 0;
int timerValue = 0;
bool cigarPickup; //This is a timer item pickup.


// The item id of the last item Link has used.
int LastItemUsed = 0;
  
  // Cooldown timers for each button. Button presses are cancelled
// unless their cooldown timer is <= 0
int Cooldown_ATimer = -1;
int Cooldown_BTimer = -1;

Experimental
///Light
int illumination; //If this is false, screens with dark room FFC flags will be dark. Unsetting this disables that.
//RPG.zh NPC Expansion

bool screenUpdated = false;
bool scheenchanged = false;
int playerHP;

RPG_Menus
bool menuTalk = false; 
bool playerTalking = false;
bool playerListening = false;
bool playerSearching = false;
bool playerExamining = false;
bool playerDisarming = false;
bool playerTakingItem = false;
bool playerChecking = false;
bool playerLooking = false;
bool playerVista = false;
bool menuOpen; // Used to define if menus are active.
bool equipItem = false; // Used to equip items through the menus.

RPG_Money
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

//int totalWalletSpace = ( CR_WALLETSPACE * CR_WALLETS )
//int freeWalletSpace = Game->MCounter[CR_WALLETSPACE] - Game->Counter[CW_WALLETSPACE]

bool noFreeSpace = false; 
// THis becomes true after the game first displays
// an 'out of space' message, so that it doesn't constantly bother the 
// player. When space is freed, it resets this to false.
bool reduced; // U3d for removing stored items, and reducing the amount of space used.

Overworld
int challengeNumber = 0;

Skills
int loreSuccess = 0; //Shouldnl't this be part of the array?
int loreRow = 0;
int loreColumn = 0;
//Create a single pointer, that may not be needed.
int loreSkill;

Spells
bool playerCasting = false; //Like the menu function, this value is set to true
                            //when the player is casting a spell, that causes events
                            //in the main active loop to run, that, when complete,
                            //reset this to false.

Weapons
bool hasShield;
bool shieldMessage = true;
bool hasSword;
bool swordMessage = true;
bool hasArmour;
bool armourMessage = true;
int currentDamage; // A placeholder for storing the damage value of items.
int beamMultiplier = 0.5; //A placeholder for storing a variable multiplier.
bool WSpierce = false; //Used to determine of a weapon is piercing





