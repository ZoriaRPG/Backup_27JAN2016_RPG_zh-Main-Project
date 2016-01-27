const int I_DOUBLEJUMP = 100; //Set to required item for double jump.

void TapJump() // Makes Link Jump
{
	if( ( Link->InputR && SV_OnGround() && JumpFrames <= 10) || ( Link->InputR && Link->Jump > 0 && Link->Item[I_DOUBLEJUMP] ) )
	{
		Game->PlaySound(45);			
	
		for(int i = 0; i < 8; i += 1)
		{
			if ( !SV_UnderCombo() ) {
				break;
			}
			Link->Y -= JumpPixles;
			JumpFrames += 1;
			Waitframe();		
		}					
	}
	
	if(SV_OnGround() == true)
	{
		JumpFrames = 0;
		//Waitframe(); //This is only setting a var. You don;t need to wait for that. 
	}
}

// Thought including these might be important, too:

bool SV_OnGround() // Detects if Link is on a solid combo, mainly to be used in Sideview.
{
	if(Screen->isSolid(Link->X, Link->Y + 16) == true || Screen->isSolid(Link->X + 15, Link->Y + 16) == true)
	{return true;}
}

bool SV_UnderCombo() // Detects if Link is under a solid combo, mainly to be used in Sideview.
{
	if(Screen->isSolid(Link->X, Link->Y - 16) == true || Screen->isSolid(Link->X + 15, Link->Y - 16) == true)
	{return true;} //This could break, if there is a partially solid combo, with solid combos over it. Just a precaution. 
}

