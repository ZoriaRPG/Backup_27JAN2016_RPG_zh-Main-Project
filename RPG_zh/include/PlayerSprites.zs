item script PlayerSprites{ 
	void run(){
		int x = 1;
		active.PlayerSpriteChange(0,20);
		working = true;
	}
}

global script active{
	void run(){
		eweapon PlayerSprite;
		int SpriteLink[1];
		int x = SizeOfArray(MyArray);
		Trace(x);
		while ( true ) {
			PlayerSprite(PlayerSprite,SpriteLink);
			Waitframe();
		}
	}
	void PlayerSprite(int PlayerSprite, int SpriteLink){
		PlayerSprite->X = Link->X+10;
		PlayerSprite->Y = Link->Y+10;
		PlayerSprite->UseSprite(10);
		PlayerSprite->DeadState = WDS_ALIVE;
	}
	void PlayerSpriteChange(int SpriteLink, int sprite){
		SpriteLink[0] = sprite;
	}
}