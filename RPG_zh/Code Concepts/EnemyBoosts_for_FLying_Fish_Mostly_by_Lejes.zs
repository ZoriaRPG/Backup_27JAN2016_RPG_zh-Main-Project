import "std.zh"
import "ffcscript.zh"

//Main arrays.

int EnemiesNotToBump[]={0,200}; 	//Populate this with the IDs of enemies for which you DO NOT want to 
					//increase stats. 

int EnemyStatBoosts[4]={0,1,1,1}; 	//Replace the four global vars with an array, and...


	
//EnemyStatBoost[] indices
const int ENEM_STATS_BOOSTED = 0;	//Assign constants to each index for easy use. 
const int ENEM_HEALTH = 1;
const int ENEM_POW = 2;
const int ENEM_WEAP_POW = 3;

//npc->Misc[] indices
const int ENEMY_LEVEL_INCREASE = 0; //npc->Misc[0]

//EnemyStatBoost[ENEM_STATS_BOOSTED] & npc->Misc[ENEMY_LEVEL_INCREASE] Values
const int ENEM_BOOST_NOT_APPLIED = 0; 
const int ENEM_BOOST_APPLIED = 1;





global script Mexp
{
	void run (){
		while (true)
		{
			ELevelup();
			Eapply();
			Waitdraw();
			Waitframe();
		}
	}
}

void ELevelup() {
	npc eexp;
	if ( EnemyStatBoosts[ENEM_STATS_BOOSTED] )
	{
		EnemyStatBoosts[ENEM_HEALTH] = EnemyStatBoosts[ENEM_HEALTH]  * 2.1;
		EnemyStatBoosts[ENEM_POW] = EnemyStatBoosts[ENEM_POW] * 2.1;
		EnemyStatBoosts[ENEM_WEAP_POW] = EnemyStatBoosts[ENEM_WEAP_POW] * 2.1;
		EnemyStatBoosts[ENEM_STATS_BOOSTED] = ENEM_BOOST_NOT_APPLIED;
	}
}

void Eapply(){
	npc eexp;
	for (int npccounter = 1; npccounter <= Screen->NumNPCs(); npccounter ++)
	{
		exp = Screen->LoadNPC(npccounter);
		for ( int q = 0; q <= SizeOfArray(EnemiesNotToBump); q++ ) {
			if ( !eexp->Misc[ENEMY_LEVEL_INCREASE] && eexp->ID != EnemiesNotToBump[q] )
			{
				eexp->Damage *= EnemyStatBoosts[ENEM_POW];
				eexp->HP *= EnemyStatBoosts[ENEM_HEALTH];
				eexp->Misc[ENEMY_LEVEL_INCREASE] = ENEM_BOOST_APPLIED;
			}
		}
	}
}

item script Message
{
	void run(int m)
	{
		Screen->Message(m);
		EnemyStatBoosts[ENEM_STATS_BOOSTED] = ENEM_BOOST_APPLIED;
	}
}