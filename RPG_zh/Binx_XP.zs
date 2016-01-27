const int MINSTAT = 3; //Minimum value for each stat.

float VitalStats[12]={1,1,1,1,1,1,1,1,1,0,0,0,0};

const int ST_CONSTITUTION = 0;
const int ST_WISDOM = 1;
const int ST_STAMINA = 2;
const int ST_STRENGTH = 3;
const int ST_DEXTERITY = 4;
const int ST_INTELLIGENCE = 5;
const int ST_CHARISMA = 6;
const int ST_LUCK = 7;
const int ST_LEVEL = 8;
const int ST_XP = 9;
const int XP_MILLIONS = 10; ///Used to store INT value of the millions place ( ###,xxx,xxx ) for drawing. 
const int XP_THOUSANDS = 11; ///Used to store INT value of the thousands place ( ###,xxx,xxx ) for drawing. 
const int XP_ONES = 12; ///Used to store INT value of the ones place ( ###,xxx,xxx ) for drawing. 


//This stores the NP needed for each level as a float. 
float LevelChart[24]={ //This needs to be a float, and we need to use decimal values for XP, or just smaller values.
	0,  //Level 0
	0.0000, //Level 1
	0.0150,  //Level 2
	0.0225,  //Level 3
	0.0338, //Level 4
	0.0506, //Level 5
	0.0759, //Leve 6
	0.1139, //Level 7
	0.1709,  //Level 8
	0.2562, //Level 9 
	0.3844, //Level 10
	0.5767, //Level 11
	0.8650, //Level 12
	1.2975, //Level 13
	1.9462, //Level 14
	2.9192, //Level 15
	4.3789, //Level 16
	6.5684, //Level 17
	9.8526, //Level 18
	14.7789, //Level 19
	22.1684, //Level 20
	214747.3647, //Can no longer gain levels
	0,0}; //Additional fields, if we need them. 
	
	//Xp is at VitalStats[ST_XP]
	
//Array index matches level number. First index (0) stores L0 XP; 

	
//A table to store the vale of an award, for each enemy in the editor./ 
float XPAwards[512]={		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //First 256, ID->0 to ID->255
	
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
				
				//Store the XP award for each enemy from the enemy editor. 
				//You should manually add the XP awards to ghosted enemies!
				/// We need these values as floats to use large numbers, so a value of '1' is 0.0001 here.
				/// 100 is 0.0100
				/// 1000 is 0.1000
				/// 10000 is 1.0000 and so forth.
				/// Easiest way is to enter integer values first, then go through and pop in a decimal point for each.
	
	
//Awards Enemy Award Value in XP from XPAwards[]
void AwardXP(){ //Call this every frame before Waitdraw(); 
	for ( int i = Screen->NumNPCs(); i >= 0; i-- ){
		npc enem = Screen->LoadNPC(i);
		int enemyID = enem->ID;
		if ( enem->HP <= 0 && enem->HP > -999 ){
			enem->HP = -999;
			int worth = XPAwards[enemyID];
			int pLevel = VitalStats[ST_LEVEL];
			int CRmax = 21; //Disable this, if you use a CR table. 
			//int CRmax = MaxLevelForAward[enemyID];
			if ( pLevel <= CRmax ) {
				AwardXP(worth);
			}
		}
	}
}

void AwardXP(float amount){
	VitalStats[ST_XP] += amount;
}

void AddXP(float amount){ //Adds raw value as float (thus, 1XP requires passing 0.0001). 
	VitalStats[ST_XP] += amount;
}

void GainXP(int amount){ //Adds INT XP as float to array. (Thus 1XP requires passing 1.0000)
	float val = amount ( * .0001 );
	VitalStats[ST_XP] += val;
}

void FloatXPtoIntXP(){ //Call ever frame before Waitdraw()
	int ones = GetPartialArg(VitalStats[ST_XP], -2, 3);
	int thousands = GetPartialArg(VitalStats[ST_XP], 1, 3);
	int millions = GetPartialArg(VitalStats[ST_XP], 4, 3);
	VitalStats[XP_ONES] = ones;
	VitalStats[XP_THOUSANDS] = thousands;
	VitalStats[XP_MILLIONS] = millions;
}

//If using counters...
//void UpdateXPCounters(){
//	Game->Counter[CR_XP_ONES] = VitalStats[XP_ONES];
//	Game->Counter[CR_XP_THOUSANDS] = VitalStats[XP_THOUSANDS];
//	Game->Counter[CR_XP_MILLIONS] = VitalStats[XP_MILLIONS];
//}

void LevelUp(){ //Run this every frame.
	int lvl = VitalStats[ST_LEVEL];
	int currXP = VitalStats[ST_XP];
	int XPforNext = LevelChart[lvl+1];
	if ( currXP >= XPforNext ) {
		//Need to check for 0 on-screen enemies here.
		Game->Counter[CR_LVL]++;
		//Uses the RPG.zh DoLevel() function. Replace with what you want to use. 
		//DoLevel(lvl, HP_INCREASE_DICE, HP_INCREASE_DIETYPE, MP_INCREASE_DICE, MP_INCREASE_DIETYPE, INCREASE_SKILLS_EVERY_X_LEVELS, SKILL_INCREASE_DIETYPE, SKILL_INCREASE_DICE, INCREASE_STATS_EVERY_X_LEVELS, STAT_INCREASE_DIETYPE, STAT_INCREASE_DICE);
	}
}

//Used for displaying 'Next Level At
//void AdjustNextLevelXP(){ //Run this every frame.
//	int currLevel = Game->Counter[CR_LEVEL];
//	int NextUp = Game->Counter[CR_LEVEL] + 1;
//	int presentXP = LevelChart[SUMXP];
//	int nextLevelXP = LevelChart[NextUp];
//	int diff = nextLevelXP - presentXP;
//	LevelChart[NEXTLEVELXP] = diff;
//}	

int MaxLevelForAward[512]={		40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40, //Enemy ID->) to ID->255
					
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40};
				
				//Store the MAXIMUM LEVEL the player may be, 
				//to earn an award for each enemy in the enemy editor.. 
				//You should manually add the XP awards to ghosted enemies
					//This is similar in function to enemy CR, but we'll use Enemy CR to do other things.
				
					
int EnemyChallengeRating[512]={	 	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  //Enemy ID->) to ID->255

					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1	};
	
//We use this table to define the challenge rating of any given enemy. 
// i.e., If the enemy would be:
//	( easy +0 ) ( normal + 5 ) ( moderate + 10 ) ( hard / difficult + 15 ) ( insane + 20 ) ( impossible + 25 ) 
// for the player at any given 'Level'. 
// To calculate this, we need a base CR. We'll call that '0', and that will be an 'easy' enemy at Player Level 1. 
// Add +5 for each difficulty tier above this as compared to player level vs an easy monster.
//Thus, a 0 player against a CR0 monster is easy, against a CR5	monster is moderate (challenging, but safe.
//Against a 10, it would be hard, against a 15 it would be quite difficult, but against a 15, it would be insane.
//If we value that a normal player in a Zelda game, with the L3 sword, and a red tunic, with 14 hearts, is around Level 15,
//and still finds Death Knights to be insane, then the CR for a Death Knight *might* be 40. 
//Thus, a Level 40 player would find them about as easy to handle as a L0 monster was to a L1 player. 

//That is called a CR adjustment, but I'll spare you the RPG technical details. Just figure out how powerful a character
//would (or should) be for a monster to fall into the easy category ...
//(as in the player has three hearts, green tunic, basic sword, no other gear, dies in a hit easy)
// I will populate this with my own expected values in a future release, or as an example .zlib file, but these
// will vary greatly from quest to quest, based on how you gear the player, and on how quickly they advance.
//CR should do a few things:
		//Generate Monster HP on the fly.
		//Set the base for awards.
		//Determine special qualities for the monster.
		//Determine number of attacks.
		//etc.


global script init {
	void run(){
		RandomStats(MINSTAT);
		Game->MCounter[CR_LEVEL] = VitalStats[ST_LEVEL];
		Game->Counter[CR_LEVEL] = VitalStats[ST_LEVEL];
		Game->MCounter[CR_MAXXP] = 32000;
		Game->Counter[CR_MAXXP] = 150;
	}
}

		
		
int Roll(int rollNumber, int dieType){
	int diceTotal = 0;
	for (int dice = 1; dice <= rollNumber; dice++){
		int roll = Rand(1, dieType);
		diceTotal = diceTotal+roll;
	}
	return diceTotal;
}

void ClearStats(){
	for ( int q = 0; q <=8; q++ ){
		VitalStats[q] = 1;
	}
}

void RandomStats(int minimumValue){
	do {
		VitalStats[ST_CONSTITUTION] = Roll(3,6);
	}
	while ( VitalStats[ST_CONSTITUTION] < minimumValue );
	
	
	Game->MCounter[CR_LIFE] = VitalStats[ST_CONSTITUTION];
	Game->Counter[CR_LIFE] = VitalStats[ST_CONSTITUTION];
	
	do {
		VitalStats[ST_WISDOM] = Roll(3,6);
	}
	while (VitalStats[ST_WISDOM] < minimumValue );
	
	Game->MCounter[CR_MAGIC] = VitalStats[ST_WISDOM];
	Game->Counter[CR_MAGIC] = VitalStats[ST_WISDOM];
	
	do {
		VitalStats[ST_STAMINA] = Roll(3,6);
	}
	while (VitalStats[ST_STAMINA] < minimumValue );
	
	Game->MCounter[CR_SP] = VitalStats[ST_WISDOM];
	Game->Counter[CR_SP] = VitalStats[ST_WISDOM];
	Game->MCounter[CR_MAXSP] = VitalStats[ST_WISDOM];
	Game->Counter[CR_MAXSP] = VitalStats[ST_WISDOM];
	
	do {
		VitalStats[ST_STRENGTH] = Roll(3,6);
	}
	while (VitalStats[ST_STRENGTH] < minimumValue );
	
	Game->MCounter[CR_STRENGTH] = VitalStats[ST_STRENGTH];
	Game->Counter[CR_STRENGTH] = VitalStats[ST_STRENGTH];
	
	do {
		VitalStats[ST_DEXTERITY] = Roll(3,6);
	}
	while (VitalStats[ST_DEXTERITY] < minimumValue );
	
	Game->MCounter[CR_DEXTERITY] = VitalStats[ST_DEXTERITY];
	Game->Counter[CR_DEXTERITY] = VitalStats[ST_DEXTERITY];
	
	do {
		VitalStats[ST_INTELLIGENCE] = Roll(3,6);
	}
	while (VitalStats[ST_INTELLIGENCE] < minimumValue );
	
	Game->MCounter[CR_INTELLECT] = VitalStats[ST_INTELLIGENCE];
	Game->Counter[CR_INTELLECT] = VitalStats[ST_INTELLIGENCE];
	
	do {
		VitalStats[ST_CHARISMA] = Roll(3,6);
	}
	while (VitalStats[ST_CHARISMA] < minimumValue );
	
	Game->MCounter[CR_CHARISMA] = VitalStats[ST_CHARISMA];
	Game->Counter[CR_CHARISMA] = VitalStats[ST_CHARISMA];
	
	do {
		VitalStats[ST_CHARISMA] = Roll(3,6);
	}
	while (VitalStats[ST_CHARISMA] < minimumValue );

	Game->MCounter[CR_LUCK] = VitalStats[ST_LUCK];
	Game->Counter[CR_LUCK] = VitalStats[ST_LUCK];
}

///Utility functions needed for this, to avoid thinking. 
//Disable if you already use them, or call them elsewhere, or want to calculate shifts directly. 

int GetRemainderAsInt(int v)
{
    int r = (v - (v << 0)) * 10000;
    return r;
}

// This function breaks up the value of an argument into individual digits. It is combined with the function GetDigit below.


int GetDigit(int n, int place)
{
	place = Clamp(place, -4, 4);
	if(place < 0)
	{
		n = GetRemainderAsInt(n);
		place += 4;
	}

	int r = ((n / Pow(10, place)) % 10) << 0;
	return r;
}

int GetPartialArg(int arg, int place, int num){
	place = Clamp(place, -4, 4);
	int r;
	int adj = 1;
	for(int i = num-1; i > -1; i--){
		if(place - i < -4) continue;
		r += GetDigit(arg, place - i) * adj;
		adj *= 10;
	}
	return r;
}