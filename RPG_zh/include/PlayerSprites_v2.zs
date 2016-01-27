item script PlayerSprites{ 
	void run(int SpriteLink){
		int x = 1;
		active.PlayerSprite(1,20); //Tsis works only because we know the pointer ID of the array.
		working = true;
	}
}

global script active{
	void run(){
		
		int SpriteLink[1]={12};
		while ( true ) {
			eweapon PlayerSprite = Screen->CreateEWeapon(EW_SCRIPT10);
			PlayerSprite->X = Link->X + 10;
			PlayerSprite->Y = Link->Y + 10;
			PlayerSprite->CollDetection = false;
			PlayerSprite->Dir = Link->Dir;
			PlayerSprite->Flip = Link->Flip;
			
			PlayerSprite->UseSprite(SpriteLink[0]);
			Waitdraw();
			PlayerSprite->DeadState = WDS_DEAD;
			//PlayerSprite(PlayerSprite,SpriteLink);
			Waitframe();
		}
	}
	void PlayerSprite(int SpriteLink, int sprite){
		SpriteLink[0] = sprite;
	}
	
}