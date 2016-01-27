//bool pressJump;
//int jumpHeight = 1;

//JumpButton(){
//	if ( Link->InputL ) {
//		pressJump = true;
//	}
//}

int jumpTime = 1;
bool pressJump;
bool holdJump;

void TimedJumping(){
	if ( Link->PressL ) {
		pressJump = true;
	}
	if ( pressJump ) {
		do {
			jumpTime++;
			Link->Jump = jumpTime;
			if ( Link->InputL ) {
				holdJump = true;
			}
			if ( !Link->InputL ) {
				holdJump = false;
			}
		}
		while(holdJump);
	}
}
		