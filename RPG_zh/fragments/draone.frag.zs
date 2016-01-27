void DrawOne(ffc f npc n){
	for (int i = 0; i < 30; i++)
							
	//! You need to comment these for statements, and the reason for each. :p
	{
		int MehX = i / 4;
		int MehY = i / 2;
		Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
		Ghost_Waitframe(f, n); //We're doing drawing and movement set-up here; I believe this would work.
	}