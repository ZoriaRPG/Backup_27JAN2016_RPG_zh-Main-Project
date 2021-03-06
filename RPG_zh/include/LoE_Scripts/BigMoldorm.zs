import "std.zh"

const int BIG_MOLDORM_ONE = 185;//Invulnerable Moldrom core;
const int TAIL_ONE= 186;//Invulnerable Moldorm tail segement.
const int BIG_MOLDORM_TWO = 184;//Normal Moldorm Core.
const int TAIL_TWO = 187;//Normal Moldorm Tail segment.

//D0 is the screen reg to use. If this value is -1, the script will run at all times.
//D1 is a flag, to trigger screen secrets. If 0, no secrets are triggered. If 1, secrets are temporarily triggers.
// 	if 2 or higher, secrets are triggered in a permanent manner. 
//D2 Sets a custom speed. If none defined (set to 0), it uses the default speed from the enemy editor (Step).

ffc script Big_Moldorm{
	void run(int reg, int triggerSecrets, int speed){
		npc n = Screen->CreateNPC(BIG_MOLDORM_ONE);
		npc n2 = Screen->CreateNPC(TAIL_ONE);
		npc n3 = Screen->CreateNPC(TAIL_ONE);
		npc n4 = Screen->CreateNPC(TAIL_ONE);
		npc n5 = Screen->CreateNPC(TAIL_TWO);
		int Speed;
		if ( speed > 0 ) {
		     Speed = speedl
		}
		else {
			Speed = n->Step;
		}
		bool isAlive1 = true;
		bool isAlive2 = true;
		bool isAlive3 = true;
		bool isAlive4 = true;
		bool StartTimer = false;
		int timer = 0;
		n->X = this->X;
		n->Y = this->Y;
		n->Extend = 3;
		n->TileWidth = 2;
		n->TileHeight = 2;
		n2->X = n->X-16;
		n2->Y = n->Y;
		n3->X = n2->X-16;
		n3->Y = n2->Y;
		n4->X = n3->X-16;
		n4->Y = n3->Y;
		n5->X = n4->X-16;
		n5->Y = n4->Y;

		int curScreen = Game->GetCurScreen();

		int dat = Game->GetScreenD(curScreen, int reg);

		if ( reg > -1 && dat > 0 ){
			this->Data = 0;
			return;
		}
	
		if ( reg < 0 || ( reg > 0 && Screen->D[reg] == 0 ) {
			while(n->HP > 0 ){
				//Movement code.
				if(Abs(n->X - n2->X)>16){
					if (n2->X < n->X-16)n2->X++;
					else if(n2->X > n->X+16)n2->X--;
				}
				if(Abs(n2->X - n3->X)>16){
					if (n3->X < n2->X-16)n3->X++;
					else if(n3->X > n2->X+16)n3->X--;
				}
				if(Abs(n3->X - n4->X)>16){
					if (n4->X < n3->X-16)n4->X++;
					else if(n4->X > n3->X+16)n4->X--;
				}
				if(Abs(n4->X - n5->X)>16){
					if (n5->X < n4->X-16)n5->X++;
					else if(n5->X > n4->X+16)n5->X--;
				}
				if(Abs(n->Y - n2->Y)>16){
					if (n2->Y < n->Y-16)n2->Y++;
					else if(n2->Y > n->Y+16)n2->Y--;
				}
				if(Abs(n2->Y - n3->Y)>16){
					if (n3->Y < n2->Y-16)n3->Y++;
					else if(n3->Y > n2->Y+16)n3->Y--;
				}
				if(Abs(n3->Y - n4->Y)>16){
					if (n4->Y < n3->Y-16)n4->Y++;
					else if(n4->Y > n3->Y+16)n4->Y--;
				}
				if(Abs(n4->Y - n5->Y)>16){
					if (n5->Y < n4->Y-16)n5->Y++;
					else if(n5->Y > n4->Y+16)n5->Y--;
				}
				//Check each part to see if it is still alive.
				if(n5->HP <= 0 && isAlive4){
					isAlive4 = false;
					StartTimer = true;
				}
				if (n4->HP <=0 && isAlive3){
					isAlive3 = false;
					StartTimer = true;
				}
				if (n3->HP<= 0 && isAlive2){
					isAlive2 = false;
					StartTimer = true;
				}
				if (n2->HP <= 0 && isAlive1){
					isAlive1 = false;
					StartTimer = true;
				}
				//All parts are dead, make the core vulnerable.
				if(!isAlive1 && !isAlive2 && !isAlive3 && !isAlive4){
					this->X = n->X;
					this->Y = n->Y;
					n->HP = 0;
					n = Screen->CreateNPC(BIG_MOLDORM_TWO);
					n->X = this->X;
					n->Y = this->Y;
					n->Extend = 3;
					n->TileWidth = 2;
					n->TileHeight = 2;
				}
				//A part has been damaged, make it angry.
				if(StartTimer){
					timer = 600;
					StartTimer = false;
				}
				while(timer > 0){
					//Repeat movement code, because the main while loop doesn't run while this is going on.
					if(Abs(n->X - n2->X)>16){
						if (n2->X < n->X-16)n2->X++;
						else if(n2->X > n->X+16)n2->X--;
					}
					if(Abs(n2->X - n3->X)>16){
						if (n3->X < n2->X-16)n3->X++;
						else if(n3->X > n2->X+16)n3->X--;
					}
					if(Abs(n3->X - n4->X)>16){
						if (n4->X < n3->X-16)n4->X++;
						else if(n4->X > n3->X+16)n4->X--;
					}
					if(Abs(n4->X - n5->X)>16){
						if (n5->X < n4->X-16)n5->X++;
						else if(n5->X > n4->X+16)n5->X--;
					} 
					if(Abs(n->Y - n2->Y)>16){
						if (n2->Y < n->Y-16)n2->Y++;
						else if(n2->Y > n->Y+16)n2->Y--;
					}
					if(Abs(n2->Y - n3->Y)>16){
						if (n3->Y < n2->Y-16)n3->Y++;
						else if(n3->Y > n2->Y+16)n3->Y--;
					}
					if(Abs(n3->Y - n4->Y)>16){
						if (n4->Y < n3->Y-16)n4->Y++;
						else if(n4->Y > n3->Y+16)n4->Y--;
					}
					if(Abs(n4->Y - n5->Y)>16){
						if (n5->Y < n4->Y-16)n5->Y++;
						else if(n5->Y > n4->Y+16)n5->Y--;
					}
					n->Step = 2* Speed;
					timer--;
					//It isn't angry anymore.
					if(timer <= 0){
						n->Step = Speed;
						//Check to see which parts have died, then replace with vulnerable ones.
						if(isAlive3 && isAlive2 && isAlive1){
							n4->HP = 0;
							n4 =Screen->CreateNPC(TAIL_TWO);
							n4->X = n3->X-16;
							n4->Y = n3->Y;
						}
						if(!isAlive3 && isAlive2 && isAlive1){
							n3->HP = 0;
							n3= Screen->CreateNPC(TAIL_TWO);
							n3->X = n2->X-16;
							n3->Y = n2->Y;
						}
						if(!isAlive3 && !isAlive2 && isAlive1){
							n2->HP = 0;
							n2 = Screen->CreateNPC(TAIL_TWO);
							n2->X = n->X-16;
							n2->Y = n->Y;
						}
					}
					Waitframe();
				}
				//The whole boss is dead, so trigger secrets.
				Waitframe();
			}
			if ( reg >= 0 ) {
				Game->SetScreenD(curScreen, reg, 1);
			}
			if ( triggerSecrets ) {
				Screen->TriggerSecrets();
				if ( triggerSecrets > 1 ) {
					Screen->State[ST_SECRET] = true;
				}
			}
			this->Data = 0;
			return;
		}
	}
} 
