//Some constants, that are likely to change.

const int SUMXP = 41;
const int XPCOUNTER = 42;
const int XP10KCOUNTER = 43;
const int NEXTLEVELXP = 44;
const int XP_ONES = 45; //Assign to lowest XP set.
const int XP_THOUSANDS = 46; //Assign to thousands XP set.
const int XP_MILLIONS = 47; //Assign to millions XP set.
	
	
//This stores the NP needed for each level as a float. 
float LevelChart[46]={ //This needs to be a float, and we need to use decimal values for XP, or just smaller values.
	0,
	0.0100,0.0150,0.0200,0.0275,0.0375,0.0512,0.0700,0.0956,0.1306,0.1784,
	0.2437,0.3329,0.4548,0.6213,0.8487,1.1594,1.5888,2.1685,2.9629,4.0472,
	5.5286,7.5522,10.3165,14.0926,19.2509,26.2972,35.9227,49.0763,67.0377,91.5745,
	125.0939,170.8812,233.3181,318.7587,435.4178,594.7172,910.4261,1207.7847,1662.9978,2266.8902,
	0,0,0,0}; //Each next at + 1/2 previous level base.
	
	
void FloatXPtoIntXP(){
	int hundreds = ( GetDigit(XP[0],-4) +
			( GetDigit(XP[0],-3) * 10 ) +
			( GetDigit(XP[0],-2) * 100 ) );
	int thousands = ( ( GetDigit(XP[0],-1)  +
			( GetDigit(XP[0],0) * 10 ) +
			( GetDigit(XP[0],1) * 100 ) ) );
	int millions = ( GetDigit(XP[0],2) +
			( GetDigit(XP[0],3) * 10 ) +
			( GetDigit(XP[0],4) * 100 ) );
	XP[ONESPLACE] = hundreds;
	LevelChart[XP_ONES] = hundreds;
	XP[THOUSANDSPLACE] = thousands;
	LevelChart[XP_THOUSANDS] = thousands;
	XP[MILLIONSPLACE] = millions;
	LevelChart[XP_MILLIONS] = millions;
	
}

void UpdateXPCounters(){
	Game->Counter[CR_XP_ONES] = LevelChart[XP_ONES];
	Game->Counter[CR_XP_THOUSANDS] = LevelChart[XP_THOUSANDS];
	Game->Counter[CR_XP_MILLIONS] = LevelChart[XP_MILLIONS];
}

int NextLevelXP(){
	return LevelChart[NEXTLEVELXP];
}

int NextLevelAt(){
	int nxt = Game->Counter[CR_LEVEL] +1;
	return LevelChart[nxt];
}


//Version 0.5.9.1 for RPG.zh v0.96.8

const int XPCOUNT = 1003; //XP is now its own array (a float) and will need space in this array to store float to int conversions.
const int XPSUM = 1004; //The CONVERTED values here, should adjust counters or thing sused to display them in game, and need to append leading ciphers.
const int PLAYERLEVEL = 1005; //The present level of the player.
const int OLD_LEVEL = 1006; //The prior level of the player. Needed or comparison functions. 

//This all belongs in RPG_Experimental_Ext.zlib, or rather, in RPG_XP.zlib when done.


float XPAwards[256]={	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
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
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
				
				//Store the XP award for each enemy from the enemy editor. 
				//You should manually add the XP awards to ghosted enemies!
				/// We need these values as floats to use large numbers, so a value of '1' is 0.0001 here.
				/// 100 is 0.0100
				/// 1000 is 0.1000
				/// 10000 is 1.0000 and so forth.
				/// Easiest way is to enter integer values first, then go through and pop in a decimal point for each.
				
int MaxLevelForAward[256]={	40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,
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
					40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40 };
				
				//Store the MAXIMUM LEVEL the player may be, 
				//to earn an award for each enemy in the enemy editor.. 
				//You should manually add the XP awards to ghosted enemies
					//This is similar in function to enemy CR, but we'll use Enemy CR to do other things.
				
					
int EnemyChallengeRating[256]={	 	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
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
					1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 };
	
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
	
void AwardXP(){ //Call this every frame before Waitdraw();
	for ( int i = Screen->NumNPCs(); i > 0; i-- ){
		npc enem = Screen->LoadNPC(i);
		int enemyID = enem->ID;
		if ( enem->HP <= 0 && enem->HP > -999 ){
			enem->HP = -999;
			int worth = XPAwards[enemyID];
			int pLevel = Game->Counter[CR_LEVEL];
			int CRmax = MaxLevelForAward[enemyID];
			if ( pLevel <= CRmax ) {
				AwardXP(worth);
			}
		}
	}
}

