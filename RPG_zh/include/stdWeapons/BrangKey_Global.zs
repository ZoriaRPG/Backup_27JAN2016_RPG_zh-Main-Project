//Drags keys back to Link, if touched by a boomerang, or hookshot.

void BrangKey(){
	for ( int q = 0; q <= NumLWeapons(); q++ ){
		lweapon w = Screen->LoadItem[q];
		for ( e = 0; e <= Screen->NumItems(); e ++ ) {
			item a = Screen->LoadItem[e];
			if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ) {
				if ( Collision (w,a) ) {
					if ( a->ID == I_KEY ) {
						if ( a->ID == LW_BRANG ) {
							a->DeadState = WDS_BOUNCE;
						}
						if ( a->ID = LW_HOOKSHOT ) {
							a->DeadState = WDS_BOUNCE; //MDoes the hookshot also work like this?
						} //Bouncing must precede item movement. 
						a->X = w->X;
						a->Y = w->Y; //Drag the item back to Link.
						
						//RemoveItem(a);
						//Game->Counter[CR_KEYS]++;
					}
					else if ( a->ID == I_LKEY ) {
						if ( a->ID == LW_BRANG ) {
							a->DeadState = WDS_BOUNCE; //Make boomerangs return
						}
						if ( a->ID = LW_HOOKSHOT ) {
							a->DeadState = WDS_BOUNCE; //MDoes the hookshot also work like this? If so, we can just use WDS_BOUNCE on contact.
						}
						a->X = w->X;
						a->Y = w->Y; //Drag the item back to Link.
						
						//RemoveItem(a);
						//Increase LevelKeys
					}
					else { 
						continue;
					}
				}
			}
		}
	}
}

//Drags keys, or anything on specified array of items back to link if touched by a boomerang, or hookshot.
void BrangKey(int list){
	for ( int q = 0; q <= NumLWeapons(); q++ ){
		lweapon w = Screen->LoadItem[q];
		for ( e = 0; e <= Screen->NumItems(); e ++ ) {
			item a = Screen->LoadItem[e];
			if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ) {
				if ( Collision (w,a) ) {
					if ( a->ID == I_KEY ) {
						a->X = w->X;
						a->Y = w->Y; //Drag the item back to Link.
						//RemoveItem(a);
						//Game->Counter[CR_KEYS]++;
					}
					else if ( a->ID == I_LKEY ) {
						a->X = w->X;
						a->Y = w->Y; //Drag the item back to Link.
						//RemoveItem(a);
						//Increase LevelKeys
					}
					else if ( list ) {
						for ( int r = 0; r <= SizeOfArray(list); r++ ) {
							if ( a->ID == list[r] ) {
								a->X = w->X;
								a->Y = w->Y;
						
							}
						}
					}
				}
			}
		}
	}
}

		