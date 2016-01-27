int BrangBushes={CMB_BRANGBUSH1, CMB_BRANGBUSH2,
		 CMB_BRANGBUSH3, CMB_BRANGBUSH4}; //Fiour original tiles. Expand as needed.

const int SFX_CHAKVINE = 0;
const int SPR_BUSH_CLIPPINGS = 122;
		 
void BushCleave(int arr, int ltype, int sfx, int clippingsSprite){
	int cmb;
	int match;
	for ( int q = 1; q <= Screen->NumLWeapons(); q++ ){
		lweapon l = Screen->LoadLWeapon(q);
		if ( l->Type == lType ) {
			for ( int w = 0; w < 176; w++ ) {
			cmb = ComboD[q];
			for ( int e = 0; e <=SizeOfArray(arr); e++){
				if ( cmb = BrangBushes[w] && l->isValid() && ComboCollision(l,cmb){
					Game->PlaySound(SFX_CHAKVINE);
					ComboD[q]++;
	
	
		
	
	
		
		

int FindLW(int lType){
	for ( int q = 1; q <= Screen->NumLWeapons(); q++ ){
		lweapon l = Screen->LoadLWeapon(q);
		if ( l->Type == lType ) {
			return q;
			
lweapon clippings = CreateAnimation (cx, cy, SPR_GRASS_CLIPPINGS, 0, 0, 0, 0, 15, false);

const int ANIMATION_ID = 31; //Animation Lweapon ID. Set it so it does not conflict with other scripts.
const int ANIMATION_MISC_VX = 1; //"Vertical velocity" misc variable.
const int ANIMATION_MISC_VY = 2; //"Horizontal velocity" misc variable.
const int ANIMATION_MISC_AX = 3; //"Horizontal Acceleration" misc variable.
const int ANIMATION_MISC_AY = 4; //"Vertical Acceleration" misc variable.
const int ANIMATION_MISC_TIMEOUT = 5; //"Particle Lifespan" misc variable.
const int ANIMATION_MISC_AFFECTED_BY_GRAVITY = 6; //"Gravity boolean" misc variable. Used in sideview areas.
const int ANIMATION_MISC_XPOS = 7; //"Paeticle X position" misc variable.
const int ANIMATION_MISC_YPOS = 8; //"Paeticle Y position" misc variable.
			
// Creates a particle. Setting lifespan to -2 sets it to one full animation cycle.
lweapon CreateAnimation (int x, int y, int sprite, int ax, int ay, int vx, int vy, int lifespan, bool grav){
	lweapon anim = Screen->CreateLWeapon(ANIMATION_ID);
	anim->X = x;
	anim->Y = y;
	anim->UseSprite(sprite);
	anim->CollDetection = false; //No one should want for any NPC do destroy particle by strpping on it`s spawn point.
	anim->Misc[ANIMATION_MISC_VX] = vx;
	anim->Misc[ANIMATION_MISC_VY] = vy;
	anim->Misc[ANIMATION_MISC_AX] = ax;
	anim->Misc[ANIMATION_MISC_AY] = ay;
	if (lifespan == -2){
		anim->Misc[ANIMATION_MISC_TIMEOUT] = (anim->ASpeed)*(anim->NumFrames);
	}
	else anim->Misc[ANIMATION_MISC_TIMEOUT] = lifespan;
	if (grav) anim->Misc[ANIMATION_MISC_AFFECTED_BY_GRAVITY] = 1;
	anim->Misc[ANIMATION_MISC_XPOS] = anim->X;
	anim->Misc[ANIMATION_MISC_YPOS] = anim->Y;
	return anim;
}