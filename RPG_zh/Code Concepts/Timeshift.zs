item script TimeshiftOrb{
	
	
}

ffc script Timeshift_Orb{
	//Link should be able to lift this, carry it to a spot, and set it down. 
	//Its radius should affect combos and enemies. Use CenterX() and CenterY() based on area of effrct, for combos
	void run(){
		int layerCombos[176*3];
		int changedCombos[176*3];
		int npcs[25600];
		bool shiftBackward;
		//store initial combos in array.
		Waitframes(5); //Wait to store the combos, and allow enemies to spawn.
		//store enemies now.
			while(shiftBackward){
			//make radius effect
				//Define the radius range. 
				//checj for flagged combos that fall into this radius]
				//draw blurred ring around edge of radius (event horizon) to cover up combo change squareness
				if ( ComboX() && ComboY() < Radius
					//or GridX
			//increase combos with specific flag by +1 if their ID still matches the position in the indices. 
			
				//if a combo is flagged to change, and has an enemy flag on it
				//spawn that enemy and contrain it to be inside the radius
				//kill it if it moves outside
				//or track its position, but make it invis and turn colldet off
				//until it's inside the effect again
				
				//Store the combos that we change in the array changedCombos. 
				//if the centre of the effect changes (orb has moved)
					//if a combo falls outside the radius,, change it back
				
			//When turned off, change them back.
			Waitframe();
		}
	}
}