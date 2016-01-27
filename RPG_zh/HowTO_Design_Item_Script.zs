//Link will get healed if he use this item
item script healingstone {
        void run(){
		if ( Link->HP < Link->MaxHP ) Link->HP += 1;
        }
}

//Link will get healed if he use this item
item script healingstone {
        void run(int amount){
		if ( Link->HP < Link->MaxHP ) Link->HP += amount;
        }
}

//Link will get healed if he use this item
item script healingstone {
        void run(int amount, int counter, int cost){
		if ( Link->HP < Link->MaxHP ) {
			if ( Game->Counter[counter] >= cost ) {
				Game->Counter -= cost;
				Link->HP += amount;
			}
		}
        }
}

//Link will get healed if he use this item
item script healingstone {
        void run(int amount, int counter, int cost, int sfx){
		if ( Link->HP < Link->MaxHP ) {
			if ( Game->Counter[counter] >= cost ) {
				Game->PlaySound(sfx);
				Game->Counter -= cost;
				Link->HP += amount;
			}
		}
        }
}

//Link will get healed if he use this item
item script healingstone {
        void run(int amount, int counter, int cost, int sfx, int errorSFX){
		if ( Link->HP < Link->MaxHP ) {
			if ( Game->Counter[counter] >= cost ) {
				Game->PlaySound(sfx);
				Game->Counter -= cost;
				Link->HP += amount;
			}
			else Game->PlaySound(errorSFX);
		}
		else Game->PlaySound(errorSFX);
        }
}

//D0: Amount to heal the player.
//D1: counter reference to use.
//D2: Amount to reduce the counter.
//D3: Sound effect to play while healing.
//D4: Sound effect to play if Link can;t pay the cost, or is at full HP.

const int SFX_ERROR = 50; //Set to the ID of an error sound effect.
const int SFX_HEAL = 51; //Set to the ID of a healing sound. 
//Link will get healed if he use this item
item script healingstone {
        void run(int amount, int counter, int cost, int sfx, int errorSFX){
		if ( Link->HP < Link->MaxHP ) {
			if ( Game->Counter[counter] >= cost || !counter || !cost ) {
				if ( sfx ) Game->PlaySound(sfx);
				if ( !sfx ) Game->PlaySound(SFX_HEAL);
				Game->Counter -= cost;
				Link->HP += amount;
			}
			else {
				if ( errorSFX ) Game->PlaySound(errorSFX);
				else Game->PlaySound(SFX_ERROR);
			}
		}
		else {
			if ( errorSFX) Game->PlaySound(errorSFX);
			else Game->PlaySound(SFX_ERROR);
		}
        }
}