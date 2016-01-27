int currentDamage;

item script fluxWeaponDamage{
	//D0: ####.xxxxx -> Amount to reduce counter.
	//D0: xxxx.##### -> Counter to decrement.
	
	//D1: Step Speed
	
	//D2: ####.xxxxx -> Number of Dice to Roll; If one per level, set this to 0. 
	//D2: xxxx.##### -> Type of die to roll. If set to 0, this will not add extra damage. 
	
	void run(int cost_and_Counter, int speed, int dieDice, int spriteUsed, int maxProjectiles, int SXF_ERROR, int SFX_ITEM, int LW_Type){
		
		int useCounter = ( cost_and_Counter >> 0 );
		int cost = ( ( cost_and_Counter - (cost_and_Counter >> 0)) * 10000 );
		
		int dice = ( dieDice >> 0 );
		int dieType = ( ( dieDice - (dieDice >> 0)) * 10000 );
		
		if ( dice == 0 ) {
			dice = Game->Counter[CR_LEVEL];
		
		if ( LY_Type == 0 ) {
			LW_Type = LW_ARROW; //Do something is user forgets to fill in D7 field.
		}
		if ( speed == 0 ) {
			speed = 100; //Ensure that a step speed of zero is impossible. 
		}
		if ( maxProjectiles == 0 ) {
		    maxProjectiles = 9999; //Ensure that the user does not forget to make it possible to use the item.
		}
		if ( ( Game->Counter[useCounter] >= cost && NumLWeaponsOf(LW_Type) < maxProjectiles ) || ( cost == 0  && NumLWeaponsOf(LW_Type) < maxProjectiles ) ) {
			//Fill in the numbers for counter consumption and number of projectiles allowed on screen
       
			Game->Counter[useCounter] -= cost; //fill in the magic consumption here as well
			lweapon fluxWeap = Screen->CreateLWeapon(LW_Type);
			fluxWeap->UseSprite(spriteUsed); // the number of the sprite used for the projectile. Use two tiles, the first for up/down, the second for left/right
			fluxWeap->X = Link->X; //Find Link's Position X
			fluxWeap->Y = Link->Y; //Find Link's Position Y
			fluxWeap->Dir = Link->Dir; //Find the Direction that Link is facing.
			fluxWeap->Step = speed; // the speed the projectile travels
			currentDamage = ( Roll(die,dice) );
			fluxWeap->Damage = currentDamage; //the damage the projectile will do
			Game->PlaySound(SFX_ITEM); // the sound effect for the weapon
				//Link->ItemJinx = (nouse * 1); //Set delay between firing. Change multiplier if desired, but set base in argument D7.
			if(Link->Dir == DIR_DOWN) //If Link is facing down...
			    {
			    fluxWeap->Flip = 2; //Change direction of spriteUsed to down.
			    }
			if(Link->Dir == DIR_RIGHT) //If Link is facing right.
			    {
			    fluxWeap->Tile += 1; //Use next tile as well.
			    }
			if(Link->Dir == DIR_LEFT)
			    {
			    fluxWeap->Tile += 1; //If Link is facing left.
			    fluxWeap->Flip = 1; //Flip spriteUsed tile and use next tile as well.
			    }
				
		}
			
		else{
			Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
		}
	}
}