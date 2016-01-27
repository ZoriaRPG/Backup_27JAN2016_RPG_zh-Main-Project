/======================================Dragon===================================
//-Multi segment enemy
//-Dragon moves in the air swooping down to attack. If any segment is killed the entire dragon is killed.
//-Dragon uses melee attacks. No weapons are used.
//-Dragon is immune to stun, No further special Defences.

ffc script Ghost_Dragon{
	void run(int enemyID){
	
		int DragonID;
		npc DragonSegment;
		int Timer = 0; //Swoop down every 4-6 seconds. Stay down for 1-2 seconds.
		int Rate = 960;
	
		//Initialization
		npc Dragon = Ghost_InitAutoGhost(this, enemyID);
		DragonID = ComboAt(Ghost_X, Ghost_Y);
		//Ghost_SetFlag(GHF_NO_FALL);
		Ghost_SetFlag(GHF_FLYING_ENEMY);
		Ghost_SetFlag(GHF_SET_OVERLAY);
		//Clock goes here.
		
		//Create segments
		for(int a = Dragon->Attributes[0]; a > 0; a--){
			DragonSegment = CreateNPCAt(Dragon->Attributes[1], this->X, this->Y);
			DragonSegment->Misc[0] = DragonID; //Pair with this dragon.
			DragonSegment->Misc[1] = a; //Set Segment number. Segments count down to 0.
		}
		DragonSegment = CreateNPCAt(Dragon->Attributes[2], this->X, this->Y); //Create Tail segment.
		DragonSegment->Misc[0] = DragonID; //Pair with this dragon.
		DragonSegment->Misc[1] = -1; //Set Segment number to tail.
		
		while(Ghost_Waitframe(this, Dragon, true, false)){
		
			//Dragon Movement.
			Timer = SegmentMove(DragonID, Rate, Timer, Dragon, this);
			
			//Update Timer and Rate.
			if(Timer > 1){
				Timer--;
			}
			else if(Timer < -1){
				Timer++;
			}
			if(Rate == 0){
				Rate = 960;
			}
			else{
				Rate--;
			}
		
		}
		
		//Dragon is dead. Kill all remaining segments.
		for(int a = 0; a <= Screen->NumNPCs(); a++){
			npc Temp = Screen->LoadNPC(a);
			if((Temp->ID == Dragon->Attributes[1] || Temp->ID == Dragon->Attributes[2]) && Temp->Misc[0] == DragonID){
				Temp->HP = HP_SILENT;
			}
		}
		
	}
}

//Save center X,Y of leading part.
//Check Distance from segment to leading part.
//If greater than # then move segment by Dragon->Step in that direction.

int SegmentMove(int DragonID, int Timer, int Rate, npc Dragon, ffc this){

	int X = Dragon->X;
	int Y = Dragon->Y;
	int Z = Dragon->Z;
	int X2;
	int Y2;
	int Z2;
	
	if(!Ghost_CanMove(Ghost_Dir, ((Dragon->Step)/100), 2) || Rate == 0){ //Find new direction.
		Ghost_Dir = Rand(0, 7);
	}
	else{
		Ghost_Move(Ghost_Dir, Dragon->Step/100, 2);
	}
	
	if(Timer == 1 && Dragon->Z > 0){ //Dive Down
		Dragon->Z -= 5;
		if(Dragon->Z == 0){
			Timer = (Rand(0, 60) + 60) * -1;
		}
	}
	else if(Timer == -1 && Dragon->Z <= 0){ //Dive Up
		Dragon->Z += 5;
		if(Dragon->Z == 20){
			Timer = Rand(240, 360);
		}
	}
	
	for(int Segment = Dragon->Attributes[0]; Segment >= -1; Segment--){
		for(int a = 0; a <= Screen->NumNPCs(); a++){
			npc Temp = Screen->LoadNPC(a);
			if((Temp->ID == Dragon->Attributes[1] || Temp->ID == Dragon->Attributes[2]) && Temp->Misc[0] == DragonID && Temp->Misc[1] == Segment){
			
				//Check if Distance is greater than 16.
				if(DragonCheckDistance(X, Y, Temp)){
					return Timer;
				}
			
				//Save this segment's pos.
				X2 = Temp->X;
				Y2 = Temp->Y;
				Z2 = Temp->Z;
				//Set this segment's pos.
				Temp->X = Temp->X + (X - Temp->X) / 2;
				Temp->Y = Temp->Y + (Y - Temp->Y) / 2;
				//If Tail, set new direction.
				if(Temp->Misc[1] == -1){
					if(Temp->X == X2 && Temp->Y < Y2){ //DIR_UP
						Temp->Dir = DIR_UP;
					}
					else if(Temp->X > X2 && Temp->Y < Y2){ //DIR_RIGHTUP
						Temp->Dir = DIR_RIGHTUP;
					}
					else if(Temp->X > X2 && Temp->Y == Y2){ //DIR_RIGHT
						Temp->Dir = DIR_RIGHT;
					}
					else if(Temp->X > X2 && Temp->Y > Y2){ //DIR_RIGHTDOWN
						Temp->Dir = DIR_RIGHTDOWN;
					}
					else if(Temp->X == X2 && Temp->Y > Y2){ //DIR_DOWN
						Temp->Dir = DIR_DOWN;
					}
					else if(Temp->X < X2 && Temp->Y > Y2){ //DIR_LEFTDOWN
						Temp->Dir = DIR_LEFTDOWN;
					}
					else if(Temp->X < X2 && Temp->Y == Y2){ //DIR_LEFT
						Temp->Dir = DIR_LEFT;
					}
					else if(Temp->X < X2 && Temp->Y < Y2){ //DIR_LEFTUP
						Temp->Dir = DIR_LEFTUP;
					}
				}
				//Move saved [X,Y,Z] to Stored values.
				X = X2;
				Y = Y2;
				Z = Z2;
			}
		}
	}
	
	return Timer;
	
}

bool DragonCheckDistance(int X, int Y, npc Temp){

	//Find Leader for Body segment.
	if(Distance(CenterX(Temp), CenterY(Temp), X + 8, Y + 8) >= 8){
		return false;
	}
	else return true;
} 