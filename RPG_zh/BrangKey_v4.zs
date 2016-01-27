/// v4
/// Functions to grab, or drag keys, or items in lists back to Link; or give instantly to Link, 
/// when touched by a hookshot, or boomerang:

/// Default function uses only keys, and level keys as objects to collect with these weapons. 
/// Other versions accept args to do any of the following:

/// Return the item matching coordinates of lweapon each frame. 
/// ( May be unsafe? Will item return to its position if Link doesn;t take it? it ...should. )
/// Give the item directly to Link (instantaneous)
/// Hold the item overhead (bool holdUpItem).
/// Accept an array (int list) listing other itemd to give when a brang or hookshot touches them; obeys the same physics defined by bool instantaneous, and bool holdUpItem.

const int SFX_HOLDTOHAND = 20;

//Drags keys back to Link, if touched by a boomerang, or hookshot.  Call every frame before Waitdraw();


void BrangKey(){
	for ( int q = 0; q <= Screen->NumLWeapons(); q++ ){
		lweapon w = Screen->LoadLWeapon(q);
		if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ) {
			for ( int e = 0; e <= Screen->NumItems(); e ++ ) {
				item a = Screen->LoadItem(e);
				if ( Collision (w,a) ) {
					if ( a->ID == I_KEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						if ( a->isValid() ) {
							if ( a->Z != 0 ) {
								a->Z = 0;
							}
							a->X = w->X;
							a->Y = w->Y; //Drag the item back to Link.
							
						}
					}
					else if ( a->ID == I_LEVELKEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						if ( a->isValid() ) {
							if ( a->Z != 0 ) {
								a->Z = 0;
							}
							a->X = w->X;
							a->Y = w->Y; //Drag the item back to Link.
						}
					}
					else { 
						continue;
					}
				}
			}
		}
	}
}


void BrangKey(bool instantaneous){ //instantly gives Link the item.
	for ( int q = 0; q <= Screen->NumLWeapons(); q++ ){
		lweapon w = Screen->LoadLWeapon(q);
		if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ) {
			for ( int e = 0; e <= Screen->NumItems(); e ++ ) {
				item a = Screen->LoadItem(e);
				if ( Collision (w,a) ) {
					if ( a->ID == I_KEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						if ( a->isValid() ) {
							if ( instantaneous ) {
								if ( a->Z != Link->Z ) {
									a->Z = Link->Z;
								}
								a->X = Link->X;
								a->Y = Link->Y; //Drag the item back to Link.
							}
							else {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = w->X;
								a->Y = w->Y; //Drag the item back to Link.	
							}
						}
					}
					else if ( a->ID == I_LEVELKEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						if ( a->isValid() ) {
							if ( instantaneous ) {
								if ( a->Z != Link->Z ) {
									a->Z = Link->Z;
								}
								a->X = Link->X;
								a->Y = Link->Y; //Drag the item back to Link.
							}
							else {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = w->X;
								a->Y = w->Y; //Drag the item back to Link.	
							}
						}
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
	for ( int q = 0; q <= Screen->NumLWeapons(); q++ ){
		lweapon w = Screen->LoadLWeapon(q);
		if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ) {
			for ( int e = 0; e <= Screen->NumItems(); e ++ ) {
				item a = Screen->LoadItem(e);
				if ( Collision (w,a) ) {
					if ( a->ID == I_KEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						if ( a->isValid() ) {
							if ( a->Z != 0 ) {
								a->Z = 0;
							}
							a->X = w->X;
							a->Y = w->Y; //Drag the item back to Link.
						}
					}
					else if ( a->ID == I_LEVELKEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						
						if ( a->isValid() ) {
							if ( a->Z != 0 ) {
								a->Z = 0;
							}
							a->X = w->X;
							a->Y = w->Y; //Drag the item back to Link.
						}
					}
					else if ( list ) {
						for ( int r = 0; r <= SizeOfArray(list); r++ ) {
							if ( a->ID == list[r] ) {
								w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
								//Bouncing must precede item movement. 
								if ( a->isValid() ) {
									if ( a->Z != 0 ) {
										a->Z = 0;
									}
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
}



//Drags keys, or anything on specified array of items back to link if touched by a boomerang, or hookshot.
void BrangKey(int list, bool instantaneous){
	for ( int q = 0; q <= Screen->NumLWeapons(); q++ ){
		lweapon w = Screen->LoadLWeapon(q);
		if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ) {
			for ( int e = 0; e <= Screen->NumItems(); e ++ ) {
				item a = Screen->LoadItem(e);
				if ( Collision (w,a) ) {
					if ( a->ID == I_KEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						
						if ( a->isValid() ) {
							if ( instantaneous ) {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = Link->X;
								a->Y = Link->Y; //Give the item directly to Link
							}
							else {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = w->X;
								a->Y = w->Y; //Drag the item back to Link.	
							}
						}
					}
					else if ( a->ID == I_LEVELKEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						
						if ( a->isValid() ) {
							if ( instantaneous ) {
								if ( a->Z != Link->Z ) {
									a->Z = Link->Z;
								}
								a->X = Link->X;
								a->Y = Link->Y; //Give the item directly to Link
							}
							else {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = w->X;
								a->Y = w->Y; //Drag the item back to Link.	
							}
						}
					}
					else if ( list ) {
						for ( int r = 0; r <= SizeOfArray(list); r++ ) {
							if ( a->ID == list[r] ) {
								w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
								//Bouncing must precede item movement. 
								
								if ( a->isValid() ) {
									if ( instantaneous ) {
										if ( a->Z != Link->Z ) {
											a->Z = 0;
										}
										a->X = Link->X;
										a->Y = Link->Y; //Give the item directly to Link
									}
									else {
										if ( a->Z != 0 ) {
											a->Z = 0;
										}
										a->X = w->X;
										a->Y = w->Y; //Drag the item back to Link.	
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

void BrangKey(bool instantaneous, bool holdUpItem){ //instantly gives Link the item.
	for ( int q = 0; q <= Screen->NumLWeapons(); q++ ){
		lweapon w = Screen->LoadLWeapon(q);
		if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ) {
			for ( int e = 0; e <= Screen->NumItems(); e ++ ) {
				item a = Screen->LoadItem(e);
				if ( Collision (w,a) ) {
					if ( a->ID == I_KEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						
						if ( a->isValid() ) {
							if ( instantaneous ) {
								if ( a->Z != Link->Z ) {
									a->Z = Link->Z;
								}
								a->X = Link->X;
								a->Y = Link->Y; //Give the item directly to Link
								
								if ( holdUpItem && LinkCollision(a) ) {
									Link->Action = LA_HOLD1LAND; //Hold item over head.
									Game->PlaySound(SFX_HOLDTOHAND);
									Link->HeldItem = a->ID;
								}
							}
							else {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = w->X;
								a->Y = w->Y; //Drag the item back to Link.	
								
								if ( holdUpItem && LinkCollision(a) ) {
									Link->Action = LA_HOLD1LAND; //Hold item over head, when it reaches Link.
									Game->PlaySound(SFX_HOLDTOHAND);
									Link->HeldItem = a->ID;
								}
							}
						}
						
					}
					else if ( a->ID == I_LEVELKEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						
						if ( a->isValid() ) {
							
							if ( instantaneous ) {
								if ( a->Z != Link->Z ) {
									a->Z = Link->Z;
								}
								a->X = Link->X;
								a->Y = Link->Y; //Give the item directly to Link
								
								if ( holdUpItem && LinkCollision(a) ) {
									Link->Action = LA_HOLD1LAND; //Hold item over head.
									Game->PlaySound(SFX_HOLDTOHAND);
									Link->HeldItem = a->ID;
								}
							}
							else {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = w->X;
								a->Y = w->Y; //Drag the item back to Link.	
								
								if ( holdUpItem && LinkCollision(a) ) {
									Link->Action = LA_HOLD1LAND; //Hold item over head, when it reaches Link.
									Game->PlaySound(SFX_HOLDTOHAND);
									Link->HeldItem = a->ID;
								}
							}
						}
						
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
void BrangKey(int list, bool instantaneous, bool holdUpItem){
	for ( int q = 0; q <= Screen->NumLWeapons(); q++ ){
		lweapon w = Screen->LoadLWeapon(q);
		if ( w->ID == LW_BRANG || w->ID == LW_HOOKSHOT ) {
			for ( int e = 0; e <= Screen->NumItems(); e ++ ) {
				item a = Screen->LoadItem(e);
				if ( Collision (w,a) ) {
					if ( a->ID == I_KEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						
						if ( a->isValid() ) {
							
							if ( instantaneous ) {
								if ( a->Z != Link->Z ) {
									a->Z = Link->Z;
								}
								a->X = Link->X;
								a->Y = Link->Y; //Give the item directly to Link
								
								if ( holdUpItem && LinkCollision(a) ) {
									Link->Action = LA_HOLD1LAND; //Hold item over head.
									Game->PlaySound(SFX_HOLDTOHAND);
									Link->HeldItem = a->ID;
								}
							}
							else {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = w->X;
								a->Y = w->Y; //Drag the item back to Link.

								if ( holdUpItem && LinkCollision(a) ) {
									Link->Action = LA_HOLD1LAND; //Hold item over head, when it reaches Link.
									Game->PlaySound(SFX_HOLDTOHAND);
									Link->HeldItem = a->ID;
								}							
							}
						}
					}
					else if ( a->ID == I_LEVELKEY ) {
						w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
						//Bouncing must precede item movement. 
						
						if ( a->isValid() ) {
							
							if ( instantaneous ) {
								if ( a->Z != Link->Z ) {
									a->Z = Link->Z;
								}
								a->X = Link->X;
								a->Y = Link->Y; //Give the item directly to Link
								
								if ( holdUpItem && LinkCollision(a) ) {
									Link->Action = LA_HOLD1LAND; //Hold item over head.
									Game->PlaySound(SFX_HOLDTOHAND);
									Link->HeldItem = a->ID;
								}
							}
							else {
								if ( a->Z != 0 ) {
									a->Z = 0;
								}
								a->X = w->X;
								a->Y = w->Y; //Drag the item back to Link.

								if ( holdUpItem && LinkCollision(a) ) {
									Link->Action = LA_HOLD1LAND; //Hold item over head, when it reaches Link.
									Game->PlaySound(SFX_HOLDTOHAND);
									Link->HeldItem = a->ID;
								}								
							}
						}
					}
					else if ( list ) {
						for ( int r = 0; r <= SizeOfArray(list); r++ ) {
							if ( a->ID == list[r] ) {
								w->DeadState = WDS_BOUNCE; //Starts return anim for boomerang, or hookshot.
								//Bouncing must precede item movement. 
								
								if ( a->isValid() ) {
									
									if ( instantaneous ) {
										if ( a->Z != Link->Z ) {
											a->Z = Link->Z;
										}
										a->X = Link->X;
										a->Y = Link->Y; //Give the item directly to Link
										
										if ( holdUpItem && LinkCollision(a) ) {
											Link->Action = LA_HOLD1LAND; //Hold item over head.
											Game->PlaySound(SFX_HOLDTOHAND);
											Link->HeldItem = a->ID;
										}
										
									}
									else {
										if ( a->Z != 0 ) {
											a->Z = 0;
										}
										a->X = w->X;
										a->Y = w->Y; //Drag the item back to Link.	
										
										if ( holdUpItem && LinkCollision(a) ) {
											Link->Action = LA_HOLD1LAND; //Hold item over head, when it reaches Link.
											Game->PlaySound(SFX_HOLDTOHAND);
											Link->HeldItem = a->ID;
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
