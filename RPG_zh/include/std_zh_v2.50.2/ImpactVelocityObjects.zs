//Accepts the mass, and velocity if two weapons. Determins the acceleration on impact. 
//Changes the Step of both to reflect their mass on collision. 
void ImpactVelocity(lweapon a, eweapon b, int massA, int velocityA, int massB, int velociyB ) { //, int time){ //time is sed here, as the amount of time that both objects are in contact.
	int momentumA = massA*velocityA; //mv1
	int momentumB = massB*velociyB; //mv2
	int accelA = momentumA - momentumB;
	int accelB = momentumB - momentumA;
	a->Step += accelA;
	b->Step += accelB;
}

void MoveLinkNPC_RelationalHitAccel(npc n, lweapon a, lweapon b, int massA, int massB, int velocityA, int velocityB, int massLink, int velocityLink, int massNPC, int velocityNPC){
	//Link velocity is simplifed as his direction.
	if ( velocityLink == DIR_UP && Link->InputUp ) //moving up full v
	if ( velocityLink == DIR_UP && !Link->InputUp && !Link->InpuutDown ) //standing still
	if ( velocityLink == DIR_UP && Link->InputDown ) //sudden reversal (moving up half velocity)
	if ( velocityLink == DIR_DOWN && Link->InputDown ) //moving down full vel
	if ( velocityLink == DIR_DOWN && !Link->InputDown && !Link->InputUp ) 
	if ( velocityLink == DIR_DOWN && Link->InputUp ) 
	if ( velocityLink == DIR_LEFT && Link->InputLeft ) 
	if ( velocityLink == DIR_LEFT && !Link->InputLeft && !Link->InputRight )
	if ( velocityLink == DIR_LEFT && Link->InputRight ) 
	if ( velocityLink == DIR_RIGHT && Link->InputRight )
	if ( velocityLink == DIR_RIGHT && !Link->InputLeft && !Link->InputRight )
	if ( velocityLink == DIR_RIGHT && Link->InputLeft ) 
	//Diagonals

	
	
	
	
	
}