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
const int XP_MILLIONS = 10;
const int XP_HUNDREDS = 11;
const int XP_ONES = 12;

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