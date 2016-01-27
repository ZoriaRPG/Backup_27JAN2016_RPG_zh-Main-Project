bool TooHeavyToSwing(int minStr, int minStrTimer, int dur){
	if ( GameDynamics[CR_MUSC] < minStr) {
		if ( Timers[minStrTimer] == 0 ) {
			Timers[minStrTimer] = dur;
			TimersRunning[minStrTimer] = true;
			TimersDecrements[minStrTimer] = 1;
		}
		if ( Timers[minStrTimer] > 0 ) {
			Link->Action = LA_SPINATTACK;
			Link->Action = LA_GOTHURTLAND;
			Link->HitDir = Rand(1,4);
			Link->Drunk = Rand(10,100);
			Game->PlaySound(SFX_WIFF);
			
		}
	return true;
	}
	return false;
}

const int HP_READ = 5; //NPC Misc Attribute;

void RollEnemyHP(int dietype){
	int curHP;
	int newHP;
	npc enem;
	for ( int q = 0; q <= NumEnemies(); q++ ){
		enem = Screen->LoadNPC[q]; 
		curHP = enem->HP;
		newHP = Roll(curHP,dietype);
		if ( enem->Misc[HP_READ] == 0 ){
			enem->[MiscHP_READ] = 1;
			enem-HP = newHP;
		}
	}
}

const int DIETYPE_ENEMY_HP = 8;

void EnemySetup(){
	RollEnemyHP(DIETYPE_ENEMY_HP);
	//DrawEnemyDamage();
	//Other enem setup functions.
}