const int DAMAGE_VALUE_DURATION = 70;
const int DAMAGE_VALUE_OPACITY = 100;
const int DAMAGE_VALUE_COLOUR = 13; //Ruby
const int DAMAGE_VALUE_COLOUR_HEAL = 89; //Med Blue
const int DAMAGE_VALUE_COLOUR_OUTLINE = 1;
const int DAMAGE_VALUE_LAYER = 7;
const int DAMAGE_VALUE_OUTLINE_LAYER = 6;
const int DAMAGE_VALUE_X_OFFSET = 12;
const int DAMAGE_VALUE_Y_OFFSET = 12;
const int DAMAGE_VALUE_FONT = 2; //Small Z3 font.
const int DAMAGE_VALUE_SIZE = 20;
const int DAMAGE_VALUE_BG_COLOUR = -1; //Transparent.
const int DAMAGE_VALUE_FLOATING_POINT_PLACES = 0;

void StoreEnemyHP(){		
	for ( int q = 1; q < NumberOfNPCs(); q++ ){
		npc r = Screen->LoadNPC(q);
		int curHP = r->HP;
		if ( r->Misc[MISC_HP] == 0 ) {
			r->Misc[MISC_HP] = curHP;
		}
		if ( r->Misc[MISC_HP_MAX] == 0 ) {
			r->Misc[MISC_HP_MAX] = curHP;
		}
	}
}

//This function is designed to draw numeric values representing the damage an enemy took per hit. It should run immediately prior to Waitdraw(), after StoreEnemyHP(). 
//X and Y offset are how far from the enemy to draw the numbers. 
//The function will NOT draw damage if an enemiy DIES! It will draw only if the enemy remains alive after being damaged!
//It does not update on every hit. If the enemies is hit again, before the showFor duration ends, it does not display new values. 
void DrawDamage(int showFor, int thisLayer, int xOffset, int yOffset, int useFont, int damageColour, int healColour, int bgColour, int widthPX, int heightPX, int floatingPlaces, int opacity, bool outline, int outlineLayer, int outlineColour){ //Place after Waitdraw() ?
	for ( int q = 1; q < NumberOfNPCs(); q++ ){
		npc r = Screen->LoadNPC(q);
		int curHP = r->HP;
		int npcX;
		int npcY;
		int drawX; 
		int drawY; 
		if ( r->Misc[MISC_HP] != 0 ){

			int oldHP = r->Misc[MISC_HP];
			curHP = r->HP;
			int diff = oldHP - curHP;
			
			if ( diff > 0 ){				
				npcX = r->X;
				npcY = r->Y;
				drawX = npcX + xOffset;
				drawY = npcY + yOffset;
				int newDif = oldHP - r->HP;
				if ( diff < r->Misc[MISC_HP_MAX] ) {
					for ( int w = showFor; w > 0; w-- ) {
						npcX = r->X;
						drawX = npcX + xOffset;
						npcY = r->Y;
						drawY = npcY + yOffset;
						newDif = curHP - r->HP;
						//Try fonts: Z3 Small (2)
						if ( outline ){
							Screen->DrawInteger(outlineLayer, drawX+1, drawY+1, useFont, outlineColour, -1, widthPX, heightPX, diff, floatingPlaces, opacity);
						}
						Screen->DrawInteger(thisLayer, drawX, drawY, useFont, damageColour, -1, widthPX, heightPX, diff, floatingPlaces, opacity);
						if ( newDif != 0 && diff != newDif ) {
								diff = newDif;
								//break;
						}
						curHP = r->HP;
						Waitframe();
					}
				}

				r->Misc[MISC_HP] = r->HP;
				
			}
			else if ( diff < 0 ){				
				npcX = r->X;
				npcY = r->Y;
				drawX = npcX + xOffset;
				drawY = npcY + yOffset;
				if ( diff < r->Misc[MISC_HP_MAX] ) {
					for ( int w = showFor; w > 0; w-- ) {
						npcX = r->X;
						drawX = npcX + xOffset;
						npcY = r->Y;
						drawY = npcY + yOffset;
						//Try fonts: Z3 Small (2)
						if ( outline ){
							Screen->DrawInteger(outlineLayer, drawX+1, drawY+1, useFont, outlineColour, -1, widthPX, heightPX, diff, floatingPlaces, opacity);
						}
						Screen->DrawInteger(thisLayer, drawX, drawY, useFont, healColour, -1, widthPX, heightPX, diff, floatingPlaces, opacity);
						Waitframe();
					}
				}

				r->Misc[MISC_HP] = r->HP;
				
			}
		}
	}
}

//This function is designed to draw numeric values representing the damage an enemy took per hit. It should run immediately prior to Waitdraw(), after StoreEnemyHP(). 
//X and Y offset are how far from the enemy to draw the numbers. 
//The function will NOT draw damage if an enemiy DIES! It will draw only if the enemy remains alive after being damaged!
//It does not update on every hit. If the enemies is hit again, before the showFor duration ends, it does not display new values. 
void _DrawDamage(int showFor, int thisLayer, int xOffset, int yOffset, int useFont, int damageColour, int healColour, int bgColour, int widthPX, int heightPX, int floatingPlaces, int opacity, bool outline, int outlineLayer, int outlineColour){ //Place after Waitdraw() ?
	for ( int q = 1; q < NumberOfNPCs(); q++ ){
		npc r = Screen->LoadNPC(q);
		int curHP = r->HP;
		int npcX;
		int npcY;
		int drawX; 
		int drawY; 
		if ( r->Misc[MISC_HP] != 0 ){

			int oldHP = r->Misc[MISC_HP];
			curHP = r->HP;
			int diff = oldHP - curHP;
			
			if ( diff > 0 ){				
				npcX = r->X;
				npcY = r->Y;
				drawX = npcX + xOffset;
				drawY = npcY + yOffset;
				if ( diff < r->Misc[MISC_HP_MAX] ) {
					for ( int w = showFor; w > 0; w-- ) {
						npcX = r->X;
						drawX = npcX + xOffset;
						npcY = r->Y;
						drawY = npcY + yOffset;
						//Try fonts: Z3 Small (2)
						if ( outline ){
							Screen->DrawInteger(outlineLayer, drawX+1, drawY+1, useFont, outlineColour, -1, widthPX, heightPX, diff, floatingPlaces, opacity);
						}
						Screen->DrawInteger(thisLayer, drawX, drawY, useFont, damageColour, -1, widthPX, heightPX, diff, floatingPlaces, opacity);
						Waitframe();
					}
				}

				r->Misc[MISC_HP] = r->HP;
				
			}
			else if ( diff < 0 ){				
				npcX = r->X;
				npcY = r->Y;
				drawX = npcX + xOffset;
				drawY = npcY + yOffset;
				if ( diff < r->Misc[MISC_HP_MAX] ) {
					for ( int w = showFor; w > 0; w-- ) {
						npcX = r->X;
						drawX = npcX + xOffset;
						npcY = r->Y;
						drawY = npcY + yOffset;
						//Try fonts: Z3 Small (2)
						if ( outline ){
							Screen->DrawInteger(outlineLayer, drawX+1, drawY+1, useFont, outlineColour, -1, widthPX, heightPX, diff, floatingPlaces, opacity);
						}
						Screen->DrawInteger(thisLayer, drawX, drawY, useFont, healColour, -1, widthPX, heightPX, diff, floatingPlaces, opacity);
						Waitframe();
					}
				}

				r->Misc[MISC_HP] = r->HP;
				
			}
		}
	}
}