int drift_y = Rand(16,30);
int drift_x = Rand(16,30);

if ( n->HP <= 0 ) {
	n->HP = 1;
	n->CollDetection = false;
	int nx = Choose(-1,1);
	int ny = Choose(-1,1);
	n->Y = drift_y * ny;
	n->X = drift_z * nx;
	//This needs multiple frames of movement.
	//Set enemy hp to 1 and disable collisopn in global, and do the rest in the ffc
	//n->HP = -9999;
	//Explosion;
	Remove(n);
}