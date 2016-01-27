import "std.zh"
int PlayerSprites[100] = {12};

const int OLD_LINK_TILE = 1;
const int ZQ_LAST_TILE = 65519;
const int ZQ_BLANK_TILE = 65518;

const int BASE_TILE = 37440;
const int TILE_LENGTH = 259; //EACH TILE PAGE CONTAINS 259 TILES.

global script active{
	void run(){
		//Link->Invisible = true;
		int SpriteLink[1]={12};
		int LinkTile;
		while ( true ) {
			LinkTile = Link->Tile;
			if ( Link->Tile != ZQ_BLANK_TILE ) {
				CopyTile(LinkTile,ZQ_LAST_TILE);
				CopyTile(ZQ_BLANK_TILE,LinkTile);
			}
			eweapon PlayerSprite = Screen->CreateEWeapon(EW_SCRIPT10);
			PlayerSprite->X = Link->X;
			PlayerSprite->Y = Link->Y;
			PlayerSprite->CollDetection = false;
			PlayerSprite->Dir = Link->Dir;
			PlayerSprite->Flip = Link->Flip;
			
			PlayerSprite->UseSprite(PlayerSprites[0]);
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

item script PlayerSprites{ 
	void run(int SpriteLink){
		PlayerSprites[0]=Rand(1,50);
		
	}
}