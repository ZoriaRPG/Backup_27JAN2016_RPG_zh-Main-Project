int EnemyHP[4096]; //Intentionally large size, as we're storing in-game pointers. 



void ClearEnemyHP(){ //Run before Waitdraw, early, before StoreEnemyHP().
	if ( Event(SCREENCHANGED) ) {
		for ( int q = 0; q < SizeOfArray(EnemyHP); q++ ){
			EnemyHP[q] = 0;
		}
	}
}

void StoreEnemyHP(){ //Run after ClearEnemyHP, precisely before Waitdraw.
	for ( int q = 0; q < Screen->NumNPCs(); q++ ) {
		npc r = Screen->LoadNPC(q);
		int presentHP = r->HP;
		EnemyHP[q] = presentHP;
	}
}

const int DAMAGE_VALUE_OPACITY = 100;
const int DAMAGE_VALUE_COLOUR = 13; //Ruby
const int DAMAGE_VALUE_COLOUR_HEAL = 89; //Med Blue
const int DAMAGE_VALUE_LAYER = 7;
const int DAMAGE_VALUE_X_OFFSET = -4;
const int DAMAGE_VALUE_Y_OFFSET = 18;
const int DAMAGE_VALUE_FONT = 2; //Small Z3 font.
const int DAMAGE_VALUE_SIZE = 8;
const int DAMAGE_VALUE_BG_COLOUR = -1; //Transparent.
const int DAMAGE_VALUE_FLOATING_POINT_PLACES = 0;

//This function is designed to draw numeric values representing the damage an enemy took per hit. I believe it should run after Waitdraw(). 
//X and Y offset are how far from the enemy to draw the numbers. 
void DrawDamage(int thisLayer, int xOffset, int yOffset, int useFont, int damageColour, int healColour, int bgColour, int widthPX, int heightPX, int floatingPlaces, int opacity ){ //Place after Waitdraw() ?
	int curHP;
	int newHP;
	int diff;
	int npcX;
	int npcY;
	int modDiff; //Used to display damage as a negative value. If DrawInteger() does not automatically place a (-) sign in front of it, then we can later simplify this to use colours only. 
	int buff; //Used to display healing (a positive value)
	int drawX;
	int drawY;
	for ( int q = 0; q < Screen->NumNPCs(); q++){
		npc r = Screen->LoadNPC(q);
		curHP = EnemyHP[q];
		newHP = r->HP;
		diff = curHP - newHP;
		buff = newHP - EnemyHP[q];
		if ( diff > 0 ) { //Enemy damaged
			modDiff = diff - ( diff * 2 ); //Turn difference into negative number reflecting amount of damage dealt.
			npcX = r->X;
			npcY = r->Y;
			drawX = npcX + DAMAGE_VALUE_X_OFFSET;
			drawY = npcY + DAMAGE_VALUE_Y_OFFSET;
			Screen->DrawInteger(thisLayer, drawX, drawY, useFont, damageColour, bgColour, widthPX, heightPX, modDiff, floatingPlaces, opacity);
		}
		
		//void DrawInteger(int layer, int x, int y, int font,int color, int background_color,int width, int height, int number, int number_decimal_places, int opacity);

		else if ( diff < 0 ) { //Enemy healed.
			modDiff = buff;
			npcX = r->X;
			npcY = r->Y;
			drawX = npcX + DAMAGE_VALUE_X_OFFSET;
			drawY = npcY + DAMAGE_VALUE_Y_OFFSET;
			Screen->DrawInteger(thisLayer, drawX, drawY, useFont, healColour, bgColour, widthPX, heightPX, buff, floatingPlaces, opacity);
		}
	}
}