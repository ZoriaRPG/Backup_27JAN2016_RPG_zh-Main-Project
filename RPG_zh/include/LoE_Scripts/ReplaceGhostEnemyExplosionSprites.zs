

[code]

eweapon wpn=FireAimedEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, 0, 200,wdamage, fireballSprite, fireballSFX, 0);
        int x=wpn->X;
        int y=wpn->Y;
        eweapon explosion=CreateEWeaponAt(EW_SCRIPT1, x, y);
        explosion->UseSprite(explosionSprite);
        explosion->HitWidth = 32;
        explosion->HitHeight = 32;
        explosion->Extend = 3;
        explosion->TileWidth = 2;
        explosion->TileHeight = 2;

        explosion->Misc[GHOST_EXPLOSION_SHOT] = EXPLOSION_FROM_ENEMY_GHOST; //Read this index at the global script level.

[/code]

const int EXPLODE_SPRITE = 20; //Set to the explosion sprite.
const int EXPLODE_WIDTH = 2; //TileWidth for replacement explosions.
const int EXPLODE_HEIGHT = 2; //TileHeight for replacement explosions.
const int EXPLOSE_EXTEND = 3; //Extend attribute for replacement explosions.
const int WDS_EXPLOSION = 30; //Initial DeadState for replacement explosions. 
const int GHOST_EXPLOSION_SHOT = 2; //ew->Misc[index 2]
const int EXPLOSION_FROM_ENEMY_GHOST = 1; //ew->Misc[GHOST_EXPLOSION_SHOT] will == this value if the shot sprite
					  //is froma ghosted enemy and should be changed.

void ReplaceGhostWeaponExplosionSprites(int sprite, int ewType, int deadState, int tileW, int tileH, int extend){
	for ( int q = 1; q < Screen->NumEWeapons(); q++ ) {
		eweapon blast = Game->LoadEWeapon(q);
		if ( ( blast->Type == EW_BOMBLAST || blast->Type == EW_SBOMBLAST ) && blast->isValid() 
			&& blast->Misc[GHOST_EXPLOSION_SHOT] == EXPLOSION_FROM_ENEMY_GHOST ){
			eweapon blast_sprite = Screen->CreateEWeapon(ewType);
			blast_sprite->CollDetection = false;
			blast_sprite->X = blast->X;
			blast_sprite->Y = blast->Y;
			blast_sprite->Z = blast->Z;
			blast_sprite->Extebd = extend;
			blast_sprite->TileHeight = tileH;
			blast_sprite->TileWidth = tileW;
			blast_sprite->UseSprite = sprite;
			blast_sprite->DeadState = deadState;
		}
	}
}




global script ExampleActive{
	void run(){
		while (true){
			ReplaceGhostWeaponExplosionSprites(EXPLODE_SPRITE, EW_SCRIPT1, WDS_EXPLOSION, EXPLODE_WIDTH, EXPLOSE_EXTEND, EXPLOSE_EXTEND);
			Waitdraw();
			Waitframe();
		}
	}
}