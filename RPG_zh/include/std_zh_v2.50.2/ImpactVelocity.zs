//Accepts the mass, and velocity if two objects. Determins the acceleration on impact. 
//Returns the change of acceleration for object 'B'. 
int ImpactVelocityA(int massA, int velocityA, int massB, int velociyB ) { //, int time){ //time is sed here, as the amount of time that both objects are in contact.
	int momentumA = massA*velocityA; //mv1
	int momentumB = massB*velociyB; //mv2
	int accelA = momentumA - momentumB;
	int accelB = momentumB - momentumA;
	return momentumA;
}

//Accepts the mass, and velocity if two objects. Determins the acceleration on impact. 
//Returns the change of acceleration for object 'B'.
int ImpactVelocityB(int massA, int velocityA, int massB, int velociyB ) { //, int time){ //time is sed here, as the amount of time that both objects are in contact.
	int momentumA = massA*velocityA; //mv1
	int momentumB = massB*velociyB; //mv2
	int accelA = momentumA - momentumB;
	int accelB = momentumB - momentumA;
	return momentumB;
}