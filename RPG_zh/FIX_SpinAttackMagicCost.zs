int OwnsItems[256]; 
const int SPIN_ATTACK_COST = 1; //Set to value of spin attack.
const int SPIN_ATTACK_COUNTER = 4; //CR_MAGIC
x

item script Pickup_Spin_Attack{
	void run(int msg){
		Screen->Message(msg);
		OwnsItems[I_SPINATTACK] = 1;
	}
}

void SpinAttackMagicCost(int cost, int counter){
	cost = cost * Game->Generic[GEN_MAGICDRAINRATE];
	if ( Link->Counter[counter] < cost && OwnsItems[I_SPINATTACK] && Link->Item[I_SPINATTACK] && Link->Action != LA_CHARGING) {
		Link->Item[I_SPINATTACK] = false;
	}
	if ( Link->Counter[counter] >= cost && OwnsItems[I_SPINATTACK] && !Link->Item[I_SPINATTACK] )
		Link->Item[I_SPINATTACK] = true;
}

global script active{
	void run(){
		while(true){
			SpinAttackMagicCost(SPIN_ATTACK_COST,SPIN_ATTACK_COUNTER);
			Waitdraw();
			Waitframe();
		}
	}
}