//Increase walking speed when Link has a Piece of Power and LA_WALKING
void WalkSpeed(){
	int linkX;
	int linkY;
	if ( IronBoots() ) { //Check to see if Link has a Piece of Power power-up boost...
		if ( Link->Action == LA_HOLD1LAND ) return;
		if ( Link->Action == LA_WALKING && !LinkJump() && Link->Z == 0 ) { //If he isnt attacking, swimming, hurt, or casting, and h
			if ( Link->InputDown && !IsSideview() //If the player presses down, and we aren't in sideview mode...
				&& !Screen->isSolid(Link->X,Link->Y+17) //SW Check Solidity
				&& !Screen->isSolid(Link->X+7,Link->Y+17) //S Check Solidity
				&& !Screen->isSolid(Link->X+15,Link->Y+17) //SE Check Solidity
			) {
				//We use a timer to choke the walk speed. Without it, Link would move the full additional number of
				//pixels PER FRAME. THus, a walk speed bonus of +1 would be +60 pixels (almost four tiles) PER SECOND!
				if ( IronBoots[POWER_WALK_TIMER] == WALK_TIME ) {  //If our timer is fresh, or has reset...
					Link->Y += WALK_SPEED_POWERUP; //Let Link move faster...
					IronBoots[POWER_WALK_TIMER]--; //Decrement the timer, to start the ball rolling.
				}
			}
			else if ( Link->InputUp && !IsSideview()  //If the player presses up, and we aren't in sideview mode...
				&& !Screen->isSolid(Link->X,Link->Y+6) //NW Check Solidity
				&& !Screen->isSolid(Link->X+7,Link->Y+6) //N Check Solidity
				&& !Screen->isSolid(Link->X+15,Link->Y+6) //NE Check Solidity
			) {
				if ( IronBoots[POWER_WALK_TIMER] == WALK_TIME ) { //If our timer is fresh, or has reset...
					Link->Y -= WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
					IronBoots[POWER_WALK_TIMER]--; //Decrement the timer, to start the ball rolling.
				}
			}
			else if ( Link->InputRight && !Screen->isSolid(Link->X+17,Link->Y+8) //If the player presses right, check NE solidity...
				&& !Screen->isSolid(Link->X+17,Link->Y+15) //and check SE Solidity 
			) { 
				if ( IronBoots[POWER_WALK_TIMER] == WALK_TIME ) { //If our timer is fresh, or has reset...
					Link->X += WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
					IronBoots[POWER_WALK_TIMER]--; //Decrement the timer, to start the ball rolling.
				}
			}
			else if ( Link->InputLeft && !Screen->isSolid(Link->X-2,Link->Y+8)  //If the player presses right, check NW solidity...
				&& !Screen->isSolid(Link->X-2,Link->Y+15) //SW Check Solidity
			) {
				if ( IronBoots[POWER_WALK_TIMER] == WALK_TIME ) { //If our timer is fresh, or has reset...
					Link->X -= WALK_SPEED_POWERUP; //Increase the distance the player moves down, by this constant.
					IronBoots[POWER_WALK_TIMER]--; //Decrement the timer, to start the ball rolling.
				}
			}
		}
	}
	if ( IronBoots[POWER_WALK_TIMER] > 0 && IronBoots[POWER_WALK_TIMER] != WALK_TIME ) IronBoots[POWER_WALK_TIMER]--; 
	//Decrement the timer if it is greater than zero, and not = to WALK_TIME.
	if ( IronBoots[POWER_WALK_TIMER] <= 0 ) IronBoots[POWER_WALK_TIMER] = WALK_TIME; //If it's back to zero, reset it.
}
