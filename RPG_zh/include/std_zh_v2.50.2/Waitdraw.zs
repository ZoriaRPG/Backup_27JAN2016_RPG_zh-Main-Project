void Waitdraw();		ZASM Instruction:
				WAITDRAW
/**
* Halts execution of the script until ZC's internal code has been run (movement,
* collision detection, etc.), but before the screen is drawn. This can only
* be used in the active global script.
* Waitdraw() may only be called from the global active script; not from FFC scripts.
* The sequence of ZC actions is as follows:

* FFCs (in numerical sequence, from FFC 01, to FFC 32)
* Enemies
* EWeapons
* Link
* LWeapons
* Hookshot
* Collision Checking
* Store Link->Input / Link->Press
* Waitdraw()
* Drawing
*
* Anything placed after Waitdraw() will not present graphical effects until the next frame. 
* It is possible { ! CHECK } to read/store Link->Tile, Link->Dir and other variables *after( Waitdraw()
* in one frame, and then use these values to modify other pointer members so that they are drawn correctly
* at the next execution of Waitdraw().
*
*/ Example Use:

	Waitdraw();