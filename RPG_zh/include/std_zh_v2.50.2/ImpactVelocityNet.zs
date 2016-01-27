//Accepts the mass, and velocity if two objects. Determins the acceleration on impact. 
//Returns the net change that would affect both objects. 
int ImpactVelocity(int mass1, int velocity1, int mass2, int velociy2 ) { //, int time){ //time is sed here, as the amount of time that both objects are in contact.
	int momentum1 = mass1*velocity1; //mv1
	int momentum2 = mass2*velociy2; //mv2
	//int accel1;
	//int accel2;
	return momentum1 - momentum2;
}

//Accepts the mass, and velocity if two weapons. Determins the acceleration on impact. 
//Changes the Step of both to reflect their mass on collision. 
void ImpactVelocity(lweapon A, eweapon B, int massA, int velocityA, int massB, int velociyB ) { //, int time){ //time is sed here, as the amount of time that both objects are in contact.
	int momentumA = massA*velocityA; //mv1
	int momentumB = massB*velociyB; //mv2
	int accelA = momentumA - momentumB;
	int accelB = momentumB - momentumA;
	A->Step += accelA;
	B->Step += accelB;
}