//Additional Items on a Screen
//v0.2

const int KEY_PRIORITY_LEVEL_NORMAL = 0; //Level keys have priority, when using a key.
const int KEY_PRIORITY_NORMAL_LEVEL = 1; //Normal keys have priority, when using a key.

const int SFX_SECRET_ITEM = 63;
const int COND_KILL_ALL_ENEMIES = 1;
const int COND_KILL_SPECIFIC_ENEMY = 2;
const int COND_TRIGGERED_BY_ITEM = 3;
const int COND_TRIGGERED_BY_LWEAPON = 4;
const int COND_TRIGGERED_BY_EWEAPON = 5;
const int COND_TRIGGERED_BY_COLLISION = 6;
const int COND_TRIGGERED_BY_COMBO = 7;
const int COND_CHEST_UNLOCKD = 8;
const int COND_CHEST_UNLOCKD_SLASH = 9;
const int COND_CHEST_LOCKED = 10;
const int COND_CHEST_BOSSLOCKED = 11;



const int COLLISION_PAIR_

ffc script ExtraItem{
	void run(int condition, int itm, int reg, int dat, int collision_pair, int sfx, int required_pointer, int item_needed_first, int combo){
		bool triggered = false;
		bool ignore_npx = false;
		bool itemCreated = false;
		bool itemTaken = false; 
		item i;
		while(true){
			if ( ! triggered ) {
				if ( condition == COND_KILL_ALL_ENEMIES ) {
					if ( !Screen->NumNPCs ) triggered = true;
					for ( int q = 1; q < Screen->NumNPCs(); q++ ) {
						npc n = Screen->LoadNPC(q);
						if ( q->Type == NPCT_GUY || q->Type == NPCT_TRAP || q->Type == NPCT_ROCK 
							|| q->Type == NPCT_FAIRY ) {
								ignore_npc = true;
								continue;
						}
						else {
							ignore_npc = false; 
							break;
						}
					}
					if ( ignore_npc ) triggered = true;
				}
				
				//If a chest type
					//If a normal chest
					//check if Link is standing in front of it
					//If so,a nd hepresses a button
					//change the chest combo ++
					//make the item
				
					//if it is a slash chest 
					//if link slashes it
					//change the chest combo ++
					//make the item
				
					//if it is a locked chest
					//and link is in front of it
					//and has a key or Lkey
					//and presses up for a few seconds
					//remove a key, normal keys have priority
						//or lkeys have priority
						//! WE NEED AN OPTION FOR THIS
					//change the chest combo ++
					//make the item
				
					//if it is a boss lock chest
					//and link has LItem BOSSKEY
					//and is standing in front of it for a few seconds
					//open it, and change the chest combo ++
					//make the item
				
				Waitframe();
			}
			if ( triggered && !itemTaken && !itemCreated ) {
				itemCreated = true;
				if ( sfx ) Game->PlaySound(sfx);
				else Game->PlaySound(SFX_SECRET_ITEM);
				i = Screen->CreateItem(itm);
				i->X = this->X;
				i->Y = this->Y;
				if ( LinkCollision(i) ) itemTaken = true;
				Waitframe();
			}
			if ( triggered && itemCreated && !itemTaken && LinkCollision(i) ) itemTaken = true; 
			Waitframe();
		}
	}
}
						
						