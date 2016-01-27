ffc script Nightmare{
	void run(){
		npc n = Screen->CreateNPC(NIGHTMARE);
		n->X = this->X;
		n->Y = this->Y;
		ffc f= Screen->LoadFFC(1);
		ffc f2= Screen->LoadFFC(2);
		ffc f3= Screen->LoadFFC(3);
		ffc f4= Screen->LoadFFC(4);
		f->Data = 29567;
		f2->Data = 29567;
		f3->Data = 29567;
		f4->Data = 29567;
		n->Extend =3;
		n->TileWidth = 2;
		n->TileHeight = 2;
		bool HasDied = false;
		float angle;

		while(n->HP>0 && !Screen->State[ST_SECRET]){ //Not sure why you're using the ST Secrets in this evaluation.
			for(angle = 0; true; angle = (angle + 1) % 360){
				f->X = n->X + 32 * Cos(angle);
				f->Y = n->Y + 32 * Sin(angle);
				f2->X= n->X + 64 * Cos(angle);
				f2->Y= n->Y + 64 * Sin(angle);
				f3->X= n->X + 32 * Cos(-1* angle);
				f3->Y= n->Y + 32 * Sin(-1* angle);
				f4->X= n->X + 64 * Cos(-1* angle);
				f4->Y= n->Y + 64 * Sin(-1* angle);
				if (LinkCollision(f) || LinkCollision(f2) || LinkCollision(f3) || LinkCollision(f4)){
					if(!Link->Action == LA_GOTHURTLAND){
						Link->HP -= n->Damage;
						Link->Action = LA_GOTHURTLAND;
						Game->PlaySound(LINK_HURT);
					}
				}
				Waitframe(); //This is forcing the for loop to execute only once per frame.
			}
			Waitframe(); //Whereas this runs your while loop once per frame. 
		}
		Screen->State[ST_SECRET] = true; //Executes if the while loop fails its expression test. 
		this->Data = 0; //Disables the script for this FFC. 
		return; //Quits this FFC. 
	}
}