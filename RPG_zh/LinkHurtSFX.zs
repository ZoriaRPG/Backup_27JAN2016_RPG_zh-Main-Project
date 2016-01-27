int HurtSFX[]={103,105,110,52};

int LinkStats[100]; //An arbitrary size, so that we can expand it.

const int CURRENT_HP = 0;
const int LAST_HP = 1;
const int LINK_HURT = 2;

void StoreHP(){ //Call in global script init, and global script OnContinue
	LinkStats[CURRENT_HP] = Link->HP;
	LinkStats[LAST_HP = Link->HP;
}

     

void UpdateHP(){ //Call Every Frame
	if ( Link->HP != LinkStats[CURRENTHP] ){
		LinkStats[CURRENT_HP] - Link->HP;
	}
}


void LinkDamaged(){ //Call every frame.
	if ( LinkStats[CURRENT_HP] < LinkStats[LAST_HP] )
		LinkStats[LINK_HURT] = 1;
		LinkStats[LAST_HP] = LinkStats[CURRENT_HP];
	}
}

void HurtSound(){
	if ( ( Link->Action == LA_GOTHURTLAND || Link->Action == LA_GOTHURTWATER ) && LinkStats[LINK_HURT != 0 ){
		LinkStats[LINK_HURT] = 0;
		int HurtSound = HurtSFX[Rand(1,SizeOfArray(HurtSFX))];
		Game->PlaySound(HurtSound);
	}
}