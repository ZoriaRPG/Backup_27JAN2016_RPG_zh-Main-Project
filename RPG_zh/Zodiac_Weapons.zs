// Zodiac Weapon Charge Variables

	bool weapon_charging = 0;		// These help track weapons that need a charge up.
	int weapon_charge = 0;
	int charge_button = 0;			// Which button (a or b) was used to commence charge.
	int which_weapon = 0;			// Which Zodiac weapon was used to begin charge

	bool aquarius_bubble_on = false;
	bool gemini_copy_on = false;
	int gemini_copy_x = 0;
	int gemini_copy_y = 0;


//This goes inside the while loop of a global active script, or an ffc script that runs perpetually.
//C-Dawg uses a fixed ffc, 'jump' to run all the sidescrolling mechanics, and another to run the ship mechanics.
//The following is from 'ffc jump'

			// ===================
			// Charging Script
			// This script handles the charging up of the Zodiac
			// weapons.  Typically the weapon will keep charging
			// for 100 tics and then max out, giving a new effect.

			if(weapon_charging){

				if(
						((Link->InputA)&&(charge_button==0))||
						((Link->InputB)&&(charge_button==1)) 
				){
				// Charging process continues
						
					charge_delay_counter++;

					if((weapon_charge>20)&&(weapon_charge<68)){
						if(charge_delay_counter>1){
							Link->MP--;
						}
					}

					if(Link->MP<1){weapon_charging=false;}

					if((charge_delay_counter>1)||(weapon_charge>68)){
						weapon_charge++;
						charge_anim_counter++;
						charge_delay_counter = 0;
					}

					if(weapon_charge==20){Game->PlaySound(101);}
					if(weapon_charge==68){Game->PlaySound(104);}
						
					if((weapon_charge>20)&&(weapon_charge<=32)){
						if(charge_anim_counter>6){charge_anim_counter=0;}
						Screen->DrawTile(3,Link->X-12,Link->Y-12,42404+charge_anim_counter,1,1,6,-1,-1,0,0,0,0,true,128);
						Screen->DrawTile(3,Link->X+12,Link->Y-12,42404+charge_anim_counter,1,1,6,-1,-1,0,0,0,1,true,128);					
						Screen->DrawTile(3,Link->X-12,Link->Y+12,42404+charge_anim_counter,1,1,6,-1,-1,0,0,0,2,true,128);
						Screen->DrawTile(3,Link->X+12,Link->Y+12,42404+charge_anim_counter,1,1,6,-1,-1,0,0,0,3,true,128);
					}
					if((weapon_charge>32)&&(weapon_charge<=56)){
						if(charge_anim_counter>8){charge_anim_counter=0;}
						Screen->DrawTile(3,Link->X-8,Link->Y-8,42444+charge_anim_counter,1,1,6,-1,-1,0,0,0,0,true,128);
						Screen->DrawTile(3,Link->X+8,Link->Y-8,42444+charge_anim_counter,1,1,6,-1,-1,0,0,0,1,true,128);					
						Screen->DrawTile(3,Link->X-8,Link->Y+8,42444+charge_anim_counter,1,1,6,-1,-1,0,0,0,2,true,128);
						Screen->DrawTile(3,Link->X+8,Link->Y+8,42444+charge_anim_counter,1,1,6,-1,-1,0,0,0,3,true,128);
					}
					if((weapon_charge>56)&&(weapon_charge<=68)){
						if(charge_anim_counter>12){charge_anim_counter=0;}
						Screen->DrawTile(3,Link->X-8,Link->Y-8,42464+charge_anim_counter,1,1,6,-1,-1,0,0,0,0,true,128);
						Screen->DrawTile(3,Link->X+8,Link->Y-8,42464+charge_anim_counter,1,1,6,-1,-1,0,0,0,1,true,128);					
						Screen->DrawTile(3,Link->X-8,Link->Y+8,42464+charge_anim_counter,1,1,6,-1,-1,0,0,0,2,true,128);
						Screen->DrawTile(3,Link->X+8,Link->Y+8,42464+charge_anim_counter,1,1,6,-1,-1,0,0,0,3,true,128);
					}
					if(weapon_charge>68){
						if(charge_anim_counter>2){charge_anim_counter=0;}
						Screen->DrawTile(3,Link->X-8,Link->Y-8,42476+charge_anim_counter,1,1,6,-1,-1,0,0,0,0,true,128);
						Screen->DrawTile(3,Link->X+8,Link->Y-8,42476+charge_anim_counter,1,1,6,-1,-1,0,0,0,1,true,128);					
						Screen->DrawTile(3,Link->X-8,Link->Y+8,42476+charge_anim_counter,1,1,6,-1,-1,0,0,0,2,true,128);
						Screen->DrawTile(3,Link->X+8,Link->Y+8,42476+charge_anim_counter,1,1,6,-1,-1,0,0,0,3,true,128);
					}

					if(which_weapon==9){

						if((weapon_charge>=20)&&(weapon_charge<25)){
							Screen->DrawTile(3,Link->X-8,Link->Y-8,43380,2,2,7,-1,-1,0,0,0,0,true,128);
						}
						if((weapon_charge>=25)&&(weapon_charge<30)){
							Screen->DrawTile(3,Link->X-8,Link->Y-8,43382,2,2,7,-1,-1,0,0,0,0,true,128);
						}
						if((weapon_charge>=30)&&(weapon_charge<35)){
							Screen->DrawTile(3,Link->X-8,Link->Y-8,43384,2,2,7,-1,-1,0,0,0,0,true,128);
						}
						if((weapon_charge>=35)&&(weapon_charge<40)){
							Screen->DrawTile(3,Link->X-8,Link->Y-8,43386,2,2,7,-1,-1,0,0,0,0,true,128);
						}
						if((weapon_charge>=40)&&(weapon_charge<45)){
							Screen->DrawTile(3,Link->X-8,Link->Y-8,43388,2,2,7,-1,-1,0,0,0,0,true,128);
						}
						if((weapon_charge>=45)&&(weapon_charge<50)){
							Screen->DrawTile(3,Link->X-8,Link->Y-8,43390,2,2,7,-1,-1,0,0,0,0,true,128);
						}
						if((weapon_charge>=50)&&(weapon_charge<55)){
							Screen->DrawTile(3,Link->X-8,Link->Y-8,43392,2,2,7,-1,-1,0,0,0,0,true,128);
						}
						if((weapon_charge>=55)&&(weapon_charge<60)){
							Screen->DrawTile(3,Link->X-8,Link->Y-8,43392,2,2,7,-1,-1,0,0,0,0,true,128);
						}
						if(weapon_charge>60){

							if(Link->HP<player_last_hp){

								Game->Counter[3]++;
								if(Game->Counter[3]>Game->MCounter[3]){Game->Counter[3]=Game->MCounter[3];}
								Link->MP--;
								Game->PlaySound(25);
								Screen->DrawTile(3,Link->X-8,Link->Y-8,43396,2,2,7,-1,-1,0,0,0,0,true,128);

							}else{
								Screen->DrawTile(3,Link->X-8,Link->Y-8,43394,2,2,7,-1,-1,0,0,0,0,true,128);
							}

						}

					}

				}else{
				// Charging process ends, weapon fires if possible.
					charge_anim_counter = 0;
					weapon_charging = false;

					// AQUARIUS CHARGED SHOT
					// Creates a bubble around the player.  This bubble will absorb a single
					// hit for the player.
					if((which_weapon==1)&&(weapon_charge>=68)){

						aquarius_bubble_on = true;
						Game->PlaySound(61);

					} // end of Aquarius Charged Shot

					// SCORPIO CHARGED SHOT
					// Enemy Sweeper!
					if((which_weapon==2)&&(weapon_charge>=68)){

						Charged_Shot_Scorpio();

					}// end of Scorpio Charged Shot
					
					// ARIES CHARGED SHOT
					// Bladestorm!
					if((which_weapon==3)&&(weapon_charge>=68)){

						Charged_Shot_Aries();

					}// end of Aries Charged Shot

					// PICSES CHARGED SHOT
					// Seeker bullets
					if((which_weapon==4)&&(weapon_charge>=68)){

						Charged_Shot_Picses();

					}// end of Picses Charged Shot
	
					// GEMINI CHARGED SHOT
					// Copy image
					if((which_weapon==5)&&(weapon_charge>=68)){

						Charged_Shot_Gemini();

					}// end of Gemini Charged Shot

					// CANCER CHARGED SHOT
					// Bloody Tornado
					if((which_weapon==6)&&(weapon_charge>=68)){

						Charged_Shot_Cancer();

					}// end of Cancer Charged Shot

					// LIBRA CHARGED SHOT
					// Frozen platform
					if((which_weapon==7)&&(weapon_charge>=68)){

						Charged_Shot_Libra();

					}// end of Libra Charged Shot

					// TAURUS CHARGED SHOT
					// Slow moving fireball projectile
					if((which_weapon==8)&&(weapon_charge>=68)){

						Charged_Shot_Taurus();

					}// end of Taurus Charged Shot

					// LEO CHARGED SHOT
					// Dash Attack
					if((which_weapon==10)&&(weapon_charge>=68)){

						Charged_Shot_Leo();

					}// end of Leo Charged Shot

					// CAPRICORN CHARGED SHOT
					// Screen-wide damage
					if((which_weapon==11)&&(weapon_charge>=68)){

						Charged_Shot_Capricorn();

					}// end of Capricorn Charged Shot
					
					weapon_charge = 0;
				}
			
			} // end of weapon charging


			// ===================
			// Aquarius Bubble
			// This script handles the charged up effect of the bubble.
			// It will cause one hit to be absorbed

			if(aquarius_bubble_on){

				Screen->DrawTile(3,Link->X-8,Link->Y-8,14329,2,2,7,-1,-1,0,0,0,0,true,OP_TRANS);
				if(Link->HP<player_last_hp){
					aquarius_bubble_on = false;
					Link->HP = player_last_hp;
					Game->PlaySound(61);
				}

			}

			player_last_hp = Link->HP;
			Waitframe();
		} // end of while loop
	} // end of void run

	// This handles firing the Libra attack

	int Charged_Shot_Libra(){

		ffc charged_sting = Screen->LoadFFC(get_blank_FFC(20));	

		if(Link->Dir==0){
			charged_sting->X = Link->X+8;
			charged_sting->Y = Link->Y-32;
			charged_sting->Vx = 0;
			charged_sting->Vy = -0.5;
		}
		if(Link->Dir==1){
			charged_sting->X = Link->X+8;
			charged_sting->Y = Link->Y+32;
			charged_sting->Vx = 0;
			charged_sting->Vy = 0.5;
		}
		if(Link->Dir==2){
			charged_sting->X = Link->X-32;
			charged_sting->Y = Link->Y+8;
			charged_sting->Vx = -0.5;
			charged_sting->Vy = 0;
		}
		if(Link->Dir==3){
			charged_sting->X = Link->X+32;
			charged_sting->Y = Link->Y+8;
			charged_sting->Vx = 0.5;
			charged_sting->Vy = 0;
		}

		charged_sting->Script = 188;

	}

	// This handles firing the charged up scorpio attack

	int Charged_Shot_Scorpio(){

		int beam_animation = 1;				// Combo does not matter, we're setting a script.

		if(get_blank_FFC(20)>0){

			ffc charged_sting = Screen->LoadFFC(get_blank_FFC(20));	

			Game->PlaySound(102);

			if(Link->Dir == 0) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y - 16;
				charged_sting->Vy = -1;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 182;

			}

			if(Link->Dir == 1) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y + 16;
				charged_sting->Vy = 1;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 182;


			}
			if(Link->Dir == 2) {

				charged_sting->X = Link->X - 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = -1;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 182;

			}
			if(Link->Dir == 3) {

				charged_sting->X = Link->X + 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 1;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 182;
			}
		}

	}// end of Scorpio Attack

	int Charged_Shot_Taurus(){

		int beam_animation = 1;				// Combo does not matter, we're setting a script.

		if(get_blank_FFC(20)>0){

			ffc charged_sting = Screen->LoadFFC(get_blank_FFC(20));	

			Game->PlaySound(102);

			if(Link->Dir == 0) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vy = -1;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 189;

			}

			if(Link->Dir == 1) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vy = 1;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 189;


			}
			if(Link->Dir == 2) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = -1;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 189;

			}
			if(Link->Dir == 3) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 1;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 189;
			}
		}

	}// end of Taurus

	int Charged_Shot_Leo(){

		int beam_animation = 1;				// Combo does not matter, we're setting a script.

		if(get_blank_FFC(20)>0){

			ffc charged_sting = Screen->LoadFFC(get_blank_FFC(20));	

			Game->PlaySound(100);

			if(Link->Dir == 0) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vy = -4;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 190;

			}

			if(Link->Dir == 1) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vy = 4;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 190;


			}
			if(Link->Dir == 2) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = -4;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 190;

			}
			if(Link->Dir == 3) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 4;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 190;
			}
		}

	}// end of Leo Attack

	int Charged_Shot_Cancer(){

		int beam_animation = 1;				// Combo does not matter, we're setting a script.

		if(get_blank_FFC(20)>0){

			ffc charged_sting = Screen->LoadFFC(get_blank_FFC(20));	

			Game->PlaySound(70);

			if(Link->Dir == 0) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->CSet = 8;
				charged_sting->Vy = 0;
				charged_sting->Vx = 6;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 187;

			}

			if(Link->Dir == 1) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->CSet = 8;
				charged_sting->Vy = 0;
				charged_sting->Vx = -6;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 187;


			}
			if(Link->Dir == 2) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->CSet = 8;
				charged_sting->Vx = -6;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 187;

			}
			if(Link->Dir == 3) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->CSet = 8;
				charged_sting->Vx = 6;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 187;
			}
		}

	}// end of Cancer Attack

	int Charged_Shot_Aries(){

		int beam_animation = 1;				// Combo does not matter, we're setting a script.

		if(get_blank_FFC(20)>0){

			ffc charged_sting = Screen->LoadFFC(get_blank_FFC(20));	

			Game->PlaySound(102);

			if(Link->Dir == 0) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y - 16;
				charged_sting->Vy = 0;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 183;

			}

			if(Link->Dir == 1) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y + 16;
				charged_sting->Vy = 0;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 183;


			}
			if(Link->Dir == 2) {

				charged_sting->X = Link->X - 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 0;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 183;

			}
			if(Link->Dir == 3) {

				charged_sting->X = Link->X + 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 0;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 183;
			}
		}

	}// end of Aries Attack

	int Charged_Shot_Capricorn(){

		int beam_animation = 1;				// Combo does not matter, we're setting a script.

		if(get_blank_FFC(20)>0){

			ffc charged_sting = Screen->LoadFFC(get_blank_FFC(20));	

			Game->PlaySound(100);

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 0;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 191;
		}

	}// end of Capricorn Attack

	int Charged_Shot_Gemini(){

		int beam_animation = 1;				// Combo does not matter, we're setting a script.

		if(get_blank_FFC(20)>0){

			ffc charged_sting = Screen->LoadFFC(get_blank_FFC(20));	

			Game->PlaySound(93);

			if(Link->Dir == 0) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y - 16;
				charged_sting->Vy = -1;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 185;

			}

			if(Link->Dir == 1) {

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y + 16;
				charged_sting->Vy = 1;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 185;


			}
			if(Link->Dir == 2) {

				charged_sting->X = Link->X - 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = -1;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 185;

			}
			if(Link->Dir == 3) {

				charged_sting->X = Link->X + 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 1;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 185;
			}
		}

	}// end of Gemini Attack

	// This handles firing the charged up picses attack

	int Charged_Shot_Picses(){

		int beam_animation = 1;				// Combo does not matter, we're setting a script.

		if(get_blank_FFC(20)>0){

			ffc charged_sting; 	

			Game->PlaySound(102);

			if(Link->Dir == 0) {

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y - 16;
				charged_sting->Vy = -1;
				charged_sting->Vx = -0.5;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y - 16;
				charged_sting->Vy = -1;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 1;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y - 16;
				charged_sting->Vy = -1;
				charged_sting->Vx = 0.5;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 2;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

			}

			if(Link->Dir == 1) {

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y + 16;
				charged_sting->Vy = 1;
				charged_sting->Vx = -0.5;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y + 16;
				charged_sting->Vy = 1;
				charged_sting->Vx = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 1;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X; 
				charged_sting->Y = Link->Y + 16;
				charged_sting->Vy = 1;
				charged_sting->Vx = 0.5;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 2;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;


			}
			if(Link->Dir == 2) {

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X - 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = -1;
				charged_sting->Vy = -0.5;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X - 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = -1;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 1;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X - 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = -1;
				charged_sting->Vy = 0.5;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 2;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

			}
			if(Link->Dir == 3) {

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X + 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 1;
				charged_sting->Vy = -0.5;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 0;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X + 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 1;
				charged_sting->Vy = 0;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 1;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

				charged_sting = Screen->LoadFFC(get_blank_FFC(20));

				charged_sting->X = Link->X + 16; 
				charged_sting->Y = Link->Y;
				charged_sting->Vx = 1;
				charged_sting->Vy = 0.5;
				charged_sting->Data = beam_animation;
				charged_sting->Ax = 2;
				charged_sting->Ay = 0;
				charged_sting->Script = 184;

			}
		}

	}// end of Picses Attack

	// This function returns the ID of the next FFC larger than damage_ffc_number that has a zero
	// assigned to its data field and is less than ID number 26.  Returns -1 if it cannot find one.

	int get_blank_FFC(int first_combo_number){

		int i;
		ffc current_ffc;

			for(i = first_combo_number; i <= 26; i++){
				
					current_ffc = Screen->LoadFFC(i);;
					if(current_ffc->Data==0){
						return i;
					}
			} 

			return -1;

	} // end of get_blank_FFC


}// end of ffc script

// ==================================================
// Libra Charged Shot
// Creates a temporary block.
// ==================================================

ffc script libra_charged_shot{

	void run (){

		ffc check_for_taurus = Screen->LoadFFC(2);

		for(int i = 0; i <= 24; i++){

			Screen->Circle(1,this->X,this->Y,i,108,1,0,0,0,true,128);
			Screen->Circle(1,this->X,this->Y,i-1,107,1,0,0,0,true,128);
			Screen->Circle(1,this->X,this->Y,i-3,106,1,0,0,0,true,128);
			Screen->Circle(1,this->X,this->Y,1-4,100,1,0,0,0,true,128);
			Waitframe();
		}

		this->Vx = 0;
		this->Vy = 0;

		Game->PlaySound(44);

		if(
			(Screen->ComboD[ComboAt(this->X-8,this->Y-8)]!=608)&&
			(canMove(this->X-8,this->Y-8))
		){
				Screen->ComboD[ComboAt(this->X-8,this->Y-8)] = 1672;
		}
		if(
			(Screen->ComboD[ComboAt(this->X+8,this->Y-8)]!=608)&&
			(canMove(this->X+8,this->Y-8))
		){
				Screen->ComboD[ComboAt(this->X+8,this->Y-8)] = 1688;
		}
		if(
			(Screen->ComboD[ComboAt(this->X-8,this->Y+8)]!=608)&&
			(canMove(this->X-8,this->Y+8))
		){
				Screen->ComboD[ComboAt(this->X-8,this->Y+8)] = 1704;
		}		
		if(
			(Screen->ComboD[ComboAt(this->X+8,this->Y+8)]!=608)&&
			(canMove(this->X+8,this->Y+8))
		){
				Screen->ComboD[ComboAt(this->X+8,this->Y+8)] = 1720;
		}	

			// Check to see if the shot is going to impact on taurus.
			// If so, communicate this fact to taurus.  This assumes
			// Taurus is loaded on FFC2
			
			if(	check_for_taurus->Ay == -0.00411){

				if(
					(Abs(check_for_taurus->X - this->X)<32) &&
					(Abs(check_for_taurus->Y - this->Y)<32)
				){
					check_for_taurus->Ax = 1;
				}

			}

	}// end of void run

}// end of libra charged shot

// ==================================================
// Scorpio Charged Shot
// This ffc script moves a projectile in a circular
// pattern across the screen determined by the initial
// location, dealing damage to enemies it encounters
// over time.
// ==================================================

ffc script scorpio_charged_shot{

	void run (){

		int orbit_hub_x = this->X;
		int orbit_hub_y = this->Y;
		int orbit_hub_Vx = this->Vx;
		int orbit_hub_Vy = this->Vy;

		this->Vx = 0;
		this->Vy = 0;

		int wobble = 0;
		int orbit_radius = 0;

		int blast_radius = 0;

		int i;

		int damage = sidearm_power + sidearm_speed + 3;

		npc current_npc;

		ffc check_for_tentaplus = Screen->LoadFFC(2);

		while(true){

			if(orbit_radius<=32){orbit_radius++;}
			wobble = wobble + 20;

			this->X = orbit_radius*Sin(wobble)+orbit_hub_x;
			this->Y = orbit_radius*Cos(wobble)+orbit_hub_y;

			orbit_hub_x = orbit_hub_x + orbit_hub_Vx;
			orbit_hub_y = orbit_hub_y + orbit_hub_Vy;

			blast_radius++;
			if(blast_radius>5){blast_radius=0;}
			Screen->Circle(1,this->X+8,this->Y+8,20-blast_radius,6,1,0,0,0,true,128);
			Screen->Circle(1,this->X+8,this->Y+8,17-blast_radius,5,1,0,0,0,true,128);
			Screen->Circle(1,this->X+8,this->Y+8,15-blast_radius,4,1,0,0,0,true,128);
			Screen->Circle(1,this->X+8,this->Y+8,14-blast_radius,109,1,0,0,0,true,128);

			for(i = 1; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);
				if( ((this->X-current_npc->X) < 15) &&
					((current_npc->X-this->X) < 15) &&
					((this->Y-current_npc->Y) < 15) &&
					((current_npc->Y-this->Y) < 15)
				){
					current_npc->HP = current_npc->HP-damage;
					Game->PlaySound(11);
				}

			}

			// Check to see if the shot is going to impact on Tentaplus.
			// If so, communicate this fact to Tentaplus.  This assumes
			// Tentaplus is loaded on FFC2 and that the script is 86
			
			if(	check_for_tentaplus->Ax == -0.0112){

				if(
					(Abs(check_for_tentaplus->X - this->X)<15) &&
					(Abs(check_for_tentaplus->Y - this->Y)<15)
				){
					check_for_tentaplus->Ay = 1;
				}

			}

			Waitframe();
		} // end of while loop

		this->Data = 0;
		this->Script = 0;

	}

}

// ==================================================
// Capricorn Charged Shot
// This ffc script flashes the screen and deals 
// damage to all enemies.
// ==================================================

ffc script capricorn_charged_shot{

	void run (){

		this->Vx = 0;
		this->Vy = 0;

		int i = 90;
		int attack_counter = 0;
		int anim_counter = 0;

		int damage = sidearm_energy/2;

		npc current_npc;

		for(attack_counter = 0; attack_counter<5; attack_counter++){

			if(anim_counter==1){
				anim_counter = 0;
				
				Screen->Circle(1,this->X+8,this->Y+8,300,109,1,0,0,0,true,128);

			}else{
				anim_counter = 1;
			}

			for(i = 1; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);
				current_npc->HP = current_npc->HP-damage;

			}

			Waitframe();
		} // end of while loop

		this->Data = 0;
		this->Script = 0;

	}

}

// ==================================================
// Leo Charged Shot
// This ffc script takes an FFC as it finds it and 
// displays a huge blast animation in the proper
// direction, above the player.
// The player's input is turned off and the player is 
// yanked along with the projectile, invulnerable,
// until it hits a wall.
// ==================================================

ffc script leo_charged_shot{

	void run (){

		ffc check_for_capricorn = Screen->LoadFFC(2);

		int i = 0;

		int attack_counter =  0;
		int anim_counter = 0;
		int delay_counter = 0;

		bool active = true;

		int damage = sidearm_energy*4;

		int last_Link_x = Link->X;
		int last_Link_y = Link->Y;
		int last_Link_HP = Link->HP;

		npc current_npc;

		while(active){

			// Player can't move
			Link->InputUp = false;
			Link->InputDown = false;
			Link->InputLeft = false;
			Link->InputRight = false;
			Link->InputA = false;
			Link->InputB = false;
			Link->InputL = false;
			Link->InputR = false;
			
			delay_counter++;
			if(delay_counter>2){
				anim_counter++;
				delay_counter=0;
				if(anim_counter>3){anim_counter=0;}
			}

			//Moving right
			if(this->Vx > 0){

				Link->X = this->X;
				Link->Y = this->Y;
				Screen->DrawTile(3,Link->X-16,this->Y-8,43420+(3*anim_counter),3,2,6,-1,-1,0,0,0,0,true,128);

				if(	!canMove(Link->X+17,Link->Y+4) || 
					!canMove(Link->X+17,Link->Y+8) || 
					!canMove(Link->X+17,Link->Y+12)
				){
					active = false;
				}

			}

			//Moving left
			if(this->Vx < 0){

				Link->X = this->X;
				Link->Y = this->Y;
				Screen->DrawTile(3,Link->X-16,this->Y-8,43420+(3*anim_counter),3,2,6,-1,-1,0,0,0,1,true,128);

				if(	!canMove(Link->X-1,Link->Y+4) || 
					!canMove(Link->X-1,Link->Y+8) || 
					!canMove(Link->X-1,Link->Y+12)
				){
					active = false;
				}

			}

			//Moving up
			if(this->Vy < 0){

				Link->X = this->X;
				Link->Y = this->Y;
				Screen->DrawTile(3,Link->X-8,this->Y-8,43460+(2*anim_counter),2,3,6,-1,-1,0,0,0,0,true,128);

				if(	!canMove(Link->X+4,Link->Y-1) || 
					!canMove(Link->X+8,Link->Y-1) || 
					!canMove(Link->X+12,Link->Y-1)
				){
					active = false;
				}

			}

			//Moving down
			if(this->Vy > 0){

				Link->X = this->X;
				Link->Y = this->Y;
				Screen->DrawTile(3,Link->X-8,this->Y-8,43460+(2*anim_counter),2,3,6,-1,-1,0,0,0,2,true,128);

				if(	!canMove(Link->X+4,Link->Y+17) || 
					!canMove(Link->X+8,Link->Y+17) || 
					!canMove(Link->X+12,Link->Y+17)
				){
					active = false;
				}

			}

			for(i = 1; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);
				if( ((this->X-current_npc->X) < 24) &&
					((current_npc->X-this->X) < 24) &&
					((this->Y-current_npc->Y) < 24) &&
					((current_npc->Y-this->Y) < 24)
				){
					current_npc->HP = current_npc->HP-damage;
					Game->PlaySound(11);
				}

			}

			// Cleanup necessary to keep player moving and invulnerable

			last_Link_x = Link->X;
			last_Link_y = Link->Y;
			Link->HP = last_Link_HP;

			// If, for some reason, this FFC stops moving, end effect.
			// Otherwise game will freeze.

			if( (this->Vx==0) && (this->Vy==0)){
				active = false;
			}

			// Check to see if the shot is going to impact on Capricorn.
			// If so, communicate this fact to Capricorn.  This assumes
			// Capricorn is loaded on FFC2 
			
			if(	check_for_capricorn->Ax == -0.00711){

				if(
						(Abs(this->X-check_for_capricorn->X)<32) &&
						(Abs(this->Y-check_for_capricorn->Y)<32)
				){
				check_for_capricorn->Ay = -0.001;
				}
			}

			Waitframe();

		} // end of for loop

		Game->PlaySound(86);
		Screen->Quake = 15; 

		this->Data = 0;
		this->Script = 0;
	}

}

// ==================================================
// Aries Charged Shot
// This ffc script takes an FFC as it finds it and 
// displays a cutting-blade animation for a short
// period of time.  Any enemies coming with in the
// area of effect of the blades are damaged.
// ==================================================

ffc script aries_charged_shot{

	void run (){

		ffc check_for_libra = Screen->LoadFFC(2);

		this->Vx = 0;
		this->Vy = 0;

		int i = 0;

		int attack_counter =  0;
		int anim_counter = 0;
		int delay_counter = 0;

		int damage = (sidearm_power+4)*2; 

		npc current_npc;

		for(attack_counter = 0; attack_counter<=100; attack_counter++){
			
			delay_counter++;
			if(delay_counter>2){
				anim_counter++;
				delay_counter=0;
				if(anim_counter>8){anim_counter=0; Game->PlaySound(30);}
			}

			Screen->DrawTile(3,this->X-8,this->Y-8,43200+(2*anim_counter),2,2,6,-1,-1,0,0,0,0,true,128);

			for(i = 1; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);
				if( ((this->X-current_npc->X) < 16) &&
					((current_npc->X-this->X) < 16) &&
					((this->Y-current_npc->Y) < 16) &&
					((current_npc->Y-this->Y) < 16)
				){
					current_npc->HP = current_npc->HP-damage;
					Game->PlaySound(11);
				}

			}

			// Check to see if the shot is going to impact on Libra boss.
			// If so, communicate this fact to Libra.  This assumes
			// Libra is loaded on FFC2 and that the script is 86
			
			if(	check_for_libra->Ax == 0.00333){

				if(
					(Abs(check_for_libra->X - this->X)<15) &&
					(Abs(check_for_libra->Y - this->Y)<15)
				){
					check_for_libra->Ay = 0.0345;
				}

			}

			Waitframe();

		} // end of for loop

		this->Data = 0;
		this->Script = 0;
	}

}

// ==================================================
// Taurus Charged Shot
// This ffc script takes an FFC as it finds it and 
// displays a large fireball animation for a short
// period of time.  Any enemies coming with in the
// area of effect of the blades are damaged.
// ==================================================

ffc script taurus_charged_shot{

	void run (){

		int i = 0;

		int attack_counter =  0;
		int anim_counter = 0;
		int delay_counter = 0;

		bool is_active = true;

		int damage = (sidearm_power+sidearm_energy+sidearm_speed)*2; 

		npc current_npc;

		ffc check_for_virgo = Screen->LoadFFC(2);

		while(is_active){
			
			delay_counter++;
			if(delay_counter>2){
				anim_counter++;
				delay_counter=0;
				if(anim_counter>2){anim_counter=0; Game->PlaySound(77);}
			}

			Screen->DrawTile(3,this->X-8,this->Y-8,43346+(2*anim_counter),2,2,5,-1,-1,0,0,0,0,true,128);

			for(i = 1; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);
				if( ((this->X-current_npc->X) < 16) &&
					((current_npc->X-this->X) < 16) &&
					((this->Y-current_npc->Y) < 16) &&
					((current_npc->Y-this->Y) < 16)
				){
					current_npc->HP = current_npc->HP-damage;
					Game->PlaySound(11);
				}

			}

			if(
				(Screen->ComboD[ComboAt(this->X+8,this->Y+8)]>=1604)&&
				(Screen->ComboD[ComboAt(this->X+8,this->Y+8)]<=1607)
			){
				Screen->ComboD[ComboAt(this->X+8,this->Y+8)]=562;

			}

			if(
					(this->X<0) ||
					(this->Y<0) ||
					(this->X>256) ||
					(this->Y>176)
			){
				is_active = false;
			}

			// Check to see if the shot is going to impact on Virgo boss.
			// If so, communicate this fact to Virgo.  This assumes
			// Virgo is loaded on FFC2.
			
			if(	check_for_virgo->Ay == 0.0073){

				if(
					(Abs(check_for_virgo->X - this->X)<32) &&
					(Abs(check_for_virgo->Y - this->Y)<32)
				){
					check_for_virgo->Ax = 0.001;
				}

			}

			Waitframe();

		} // end of while loop

		this->Data = 0;
		this->Script = 0;
	}

} // end of ffc script

// ==================================================
// Cancer Charged Shot
// This ffc script takes an FFC as it finds it and 
// displays a bloody tornado for a short period of time.
// ==================================================

ffc script cancer_charged_shot{

	void run (){

		this->Vy = 0;

		int i = 0;

		int attack_counter =  0;
		int anim_counter = 0;
		int delay_counter = 0;

		int damage = sidearm_power*4;

		ffc check_for_aries = Screen->LoadFFC(2);

		npc current_npc;

		Link->HP = Link->HP - 8;

		while(true){
			
			delay_counter++;
			if(delay_counter>3){
				anim_counter++;
				delay_counter=0;
				if(anim_counter>3){anim_counter=0;}
			}

			if(this->Vx>0){                      

				if(anim_counter == 0){
						Screen->DrawTile(3,this->X-40,this->Y-8,43300,6,2,5,-1,-1,0,0,0,0,true,128);
				}
				if(anim_counter == 1){
						Screen->DrawTile(3,this->X-40,this->Y-8,43306,6,2,5,-1,-1,0,0,0,0,true,128);
				}
				if(anim_counter == 2){
						Screen->DrawTile(3,this->X-40,this->Y-8,43312,6,2,5,-1,-1,0,0,0,0,true,128);
				}
				if(anim_counter == 3){
						Screen->DrawTile(3,this->X-40,this->Y-8,43340,6,2,5,-1,-1,0,0,0,0,true,128);
				}

			}

			if(this->Vx<0){                      

				if(anim_counter == 0){
						Screen->DrawTile(3,this->X-40,this->Y-8,43300,6,2,5,-1,-1,0,0,0,1,true,128);
				}
				if(anim_counter == 1){
						Screen->DrawTile(3,this->X-40,this->Y-8,43306,6,2,5,-1,-1,0,0,0,1,true,128);
				}
				if(anim_counter == 2){
						Screen->DrawTile(3,this->X-40,this->Y-8,43312,6,2,5,-1,-1,0,0,0,1,true,128);
				}
				if(anim_counter == 3){
						Screen->DrawTile(3,this->X-40,this->Y-8,43340,6,2,5,-1,-1,0,0,0,1,true,128);
				}

			}

			for(i = 1; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);
				if( (current_npc->X>this->X-40) &&
					(current_npc->X<this->X+55) &&
					(current_npc->Y>this->Y-40) &&
					(current_npc->Y<this->Y+55)
				){
					current_npc->HP = current_npc->HP-damage;
					Game->PlaySound(11);
				}

			}

			// Check to see if the shot is going to impact on Aries boss.
			// If so, communicate this fact to Aries.  This assumes
			// Tentaplus is loaded on FFC2 and that the script is 86
			
			if(	check_for_aries->Ax == 0.00135){

				if(
					(Abs(check_for_aries->X - this->X + 58)<40) &&
					(Abs(check_for_aries->Y - this->Y - 84)<40)
				){
					check_for_aries->Ay = 1;
				}

			}

			Waitframe();

		} // end of while loop

		this->Data = 0;
		this->Script = 0;
	}

}


// ==================================================
// Cancer Splat
// This ffc script takes an FFC as it finds it and 
// displays a bubble-bursting animation for a short
// period of time.  Any enemies coming with in the
// area of effect of the burst are damaged.
// ==================================================

ffc script cancer_splat{

	void run (){

		this->Vx = 0;
		this->Vy = 0;

		int i = 0;

		int attack_counter =  0;
		int anim_counter = 0;
		int delay_counter = 0;

		int damage = sidearm_power*2; 

		npc current_npc;

		while(attack_counter<=5){
			
			delay_counter++;
			if(delay_counter>3){
				attack_counter++;
				delay_counter=0;
			}

			Screen->DrawTile(3,this->X-8,this->Y-8,43260+(2*attack_counter),2,2,5,-1,-1,0,0,0,0,true,128);

			for(i = 0; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);
				if( ((this->X-current_npc->X) < 16) &&
					((current_npc->X-this->X) < 16) &&
					((this->Y-current_npc->Y) < 16) &&
					((current_npc->Y-this->Y) < 16)
				){
					current_npc->HP = current_npc->HP-damage;
					Game->PlaySound(11);
				}

			}

			Waitframe();

		} // end of for loop

		this->Data = 0;
		this->Script = 0;
	}

}

// ==================================================
// Pisces Charged Shot
// This ffc script locates the closest enemy
// on the screen and then locks in, chasing the 
// enemy.  When it hits, it explodes.
// Since we can't pass data fields, this will
// takes it's cue from passing Ax.  If you put
// values into Ax, it will be read as data.
// Ax = The number of projectile this is.
// Basically, projectile 0 seeks the closest
// enemy, projectile 1 seeks the second closest,
// and so on.
// ==================================================

ffc script pisces_charged_shot{

	void run (){

		int proj_number = this->Ax;
		this->Ax = 0;

		int i = 0;

		int damage = (sidearm_speed*4);  

		npc current_npc;
		npc target_npc;
		npc second_best_target_npc;
		npc third_best_target_npc;

		int distance = 0;
		int prev_best_distance = 10000;

		bool found_one = false;

		lweapon explosion;

		int tile_to_draw = 43240;

		bool has_exploded = false;

		ffc check_for_gemini = Screen->LoadFFC(2);
		
		// First, we need to target the closest npc
		// note the loop won't execute if there are no enemies;
		// projectiles will just wander off.

		for(i = 1; i <= Screen->NumNPCs(); i++){

			current_npc = Screen->LoadNPC(i);
			
			if((current_npc->X>0) && (current_npc->Y>0) && (current_npc->isValid())){
			
				distance = Sqrt( ((this->X - current_npc->X)*(this->X - current_npc->X)) + ((this->Y - current_npc->Y)*(this->Y - current_npc->Y)) );
		
				if(distance<prev_best_distance){

					third_best_target_npc = second_best_target_npc;
					second_best_target_npc = target_npc;
					target_npc = current_npc;

					prev_best_distance = distance;

					found_one = true;
				}
			}
		}

		// So after we do this, we should have up to three enemies ranked
		// in order of how close they are.  Let's choose a target based on proj_number.

		if(proj_number==1){target_npc = second_best_target_npc;}
		if(proj_number==2){target_npc = third_best_target_npc;}

		while(!has_exploded){

			if((found_one)&&(target_npc->isValid())){

				if(this->Y>target_npc->Y){
					this->Vy = this->Vy - 0.06;
					tile_to_draw = 43242;
				}
				if(this->Vy<-2){this->Vy=-2;}
			
				if(this->Y<target_npc->Y){
					this->Vy = this->Vy + 0.06;
					tile_to_draw = 43240;
				}
				if(this->Vy>2){this->Vy=2;}
		
				if(this->X>target_npc->X){
					this->Vx = this->Vx - 0.06;
					tile_to_draw = 43241;
				}
				if(this->Vx<-2){this->Vx=-2;}

				if(this->X<target_npc->X){
					this->Vx = this->Vx + 0.06;
					tile_to_draw = 43243;
				}
				if(this->Vx>2){this->Vx=2;}

			}

			Screen->DrawTile(1,this->X,this->Y,tile_to_draw,1,1,6,-1,-1,0,0,0,0,true,128);

			for(i = 1; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);
				if( ((this->X-current_npc->X) < 16) &&
					((current_npc->X-this->X) < 16) &&
					((this->Y-current_npc->Y) < 16) &&
					((current_npc->Y-this->Y) < 16)
				){
					explosion = Screen->CreateLWeapon(6);
					explosion->X = this->X;
					explosion->Y = this->Y;
					explosion->Damage = damage;
					has_exploded = true;
				}

			}

			if(	(this->X<0) || (this->X>256) || (this->Y<0) || (this->Y>176) ){
				has_exploded = true;
			}	

			// Check to see if the shot is going to impact on the Gemini Zodiac boss.
			// If so, communicate this fact to the boss.  This assumes
			// boss is loaded on FFC2.
			
			if(	check_for_gemini->Ay == 0.00191){

				if(
					(Abs(check_for_gemini->X - this->X)<16) &&
					(Abs(check_for_gemini->Y - this->Y)<16)
				){
					check_for_gemini->Ax = 1;

				}

			}

			Waitframe();

		} // end of while loop

		this->Data = 0;
		this->Script = 0;
	}

}

// ==================================================
// Gemini Charged Shot
// This script controls the Gemini Charged Shot.  A
// copy of the player will be created in front of the
// player and fire lazers in the direction faced
// for a short period of time.
// ==================================================

ffc script gemini_charged_shot{ 

	void run(){

		int damage = sidearm_power+sidearm_energy;

		int dir = 0;
		if(this->Vy<0){dir = 0;}
		if(this->Vy>0){dir = 1;}
		if(this->Vx<0){dir = 2;}
		if(this->Vx>0){dir = 3;}
		this->Vx = 0;
		this->Vy = 0;

		int i = 0;

		int shot_counter;

		int cset_counter;

		for(i = 0; i<10; i++){

			Screen->Circle(1,this->X+8,this->Y+8,i,6,1,0,0,0,true,128);
			Screen->Circle(1,this->X+8,this->Y+8,i-1,5,1,0,0,0,true,128);
			Screen->Circle(1,this->X+8,this->Y+8,i-3,4,1,0,0,0,true,128);
			Screen->Circle(1,this->X+8,this->Y+8,1-4,109,1,0,0,0,true,128);

			Waitframe();
		}

		Game->PlaySound(103);

		for(i = 0; i<=300; i++){
			

			shot_counter++;
			cset_counter++;

			if(dir==0){
				Screen->DrawTile(1,this->X,this->Y,7,1,1,cset_counter,-1,-1,0,0,0,0,true,128);
				if(shot_counter>20){
					shot_counter = 0;
					create_bullet(this->X, this->Y-16, 3, damage, dir);

				} 
			}
			
			if(dir==1){
				Screen->DrawTile(1,this->X,this->Y,26,1,1,cset_counter,-1,-1,0,0,0,0,true,128);
				if(shot_counter>20){
					shot_counter = 0;
					create_bullet(this->X, this->Y+16, 3, damage, dir);
				} 
			}

			if(dir==2){
				Screen->DrawTile(1,this->X,this->Y,25,1,1,cset_counter,-1,-1,0,0,0,1,true,128);
				if(shot_counter>20){
					shot_counter = 0;
					create_bullet(this->X-16, this->Y, 3, damage, dir);
				} 
			}
			
			if(dir==3){
				Screen->DrawTile(1,this->X,this->Y,25,1,1,cset_counter,-1,-1,0,0,0,0,true,128);
				if(shot_counter>20){
					shot_counter = 0;
					create_bullet(this->X+16, this->Y, 3, damage, dir);
				} 
			}

			gemini_copy_on = true;
			gemini_copy_x = this->X;
			gemini_copy_y = this->Y;

			Waitframe();

		} // end of for loop

		gemini_copy_on = false;
		this->Data = 0;
		this->Script = 0;

	} // end of void run

	void create_bullet(int x, int y, int speed, int power, int dir){

		int sidearm_bullet_general = 42380;
		// This is the combo number of the first bullet.
		// The script expects there to be 9 levels of bullet,
		// with each level having combos showing bullet pointing
		// UP, RIGHT, DOWN, and LEFT in that order.

		lweapon bullet;

			bullet = Screen->CreateLWeapon(8);
			bullet->Dir = dir;
			bullet->Damage = power;
			bullet->Step = speed*100;
			bullet->DeadState = -1;
			bullet->CSet = 6;
			bullet->X = x;
			bullet->Y = y;
			bullet->Tile = 15261;
	}

} // end of ffc script

// ==================================================
// Explosives
// This script controls the Explosives.  A
// copy of the player will be created in front of the
// player and fire lazers in the direction faced
// for a short period of time.
// ==================================================

item script explosives_item{

	void run(){

		ffc utility_ffc;
								
			if((get_blank_FFC()>0)&&(Link->MP>=10)){

				Link->MP = Link->MP - 10;
				Game->PlaySound(21);

				utility_ffc = Screen->LoadFFC(get_blank_FFC());
				utility_ffc->Vx = 0;
				utility_ffc->Vy = 0;
				utility_ffc->Data = 1;
				utility_ffc->Ax = 0;
				utility_ffc->Ay = 0;
				utility_ffc->Script = 220;

				if(Link->Dir==0){
					utility_ffc->X = Link->X;
					utility_ffc->Y = Link->Y-16;
				}else if (Link->Dir==1){
					utility_ffc->X = Link->X; 
					utility_ffc->Y = Link->Y+16;
				}else if (Link->Dir==2){
					utility_ffc->X = Link->X-16; 
					utility_ffc->Y = Link->Y;
				}else if (Link->Dir==3){
					utility_ffc->X = Link->X+16; 
					utility_ffc->Y = Link->Y;
				}

			}

	} // end of run

	int get_blank_FFC(){

		int i;
		ffc current_ffc;

			for(i = 3; i <= 26; i++){
				
					current_ffc = Screen->LoadFFC(i);
					if(current_ffc->Data==0){
						return i;
					}
			} 

			return -1;

	} // end of get_blank_FFC

} // end of item script

ffc script explosives{ 

	void run(){

		int damage = (sidearm_energy+sidearm_power+sidearm_speed)/2;

		this->Vx = 0;
		this->Vy = 0;
		lweapon explosion;

		int i = 0;

		int shot_counter;

		int cset_counter;

		for(i = 0; i<40; i++){

			if(i<5){Screen->DrawTile(1,this->X,this->Y,51741,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=5)&&(i<10)){Screen->DrawTile(1,this->X,this->Y,51742,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=10)&&(i<15)){Screen->DrawTile(1,this->X,this->Y,51743,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=15)&&(i<20)){Screen->DrawTile(1,this->X,this->Y,51744,1,1,6,-1,-1,0,0,0,1,true,128);}
	
			if((i>=20)&&(i<25)){Screen->DrawTile(1,this->X,this->Y,51741,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=25)&&(i<30)){Screen->DrawTile(1,this->X,this->Y,51742,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=30)&&(i<35)){Screen->DrawTile(1,this->X,this->Y,51743,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=35)&&(i<40)){Screen->DrawTile(1,this->X,this->Y,51744,1,1,6,-1,-1,0,0,0,1,true,128);}

			Waitframe();
		}

		for(i = 0; i<4; i++){
			Screen->DrawTile(1,this->X,this->Y,51741+i,1,1,6,-1,-1,0,0,0,1,true,128);
			Waitframe();
		}
		for(i = 0; i<4; i++){
			Screen->DrawTile(1,this->X,this->Y,51741+i,1,1,6,-1,-1,0,0,0,1,true,128);
			Waitframe();
		}
		for(i = 0; i<4; i++){
			Screen->DrawTile(1,this->X,this->Y,51741+i,1,1,6,-1,-1,0,0,0,1,true,128);
			Waitframe();
		}
		for(i = 0; i<4; i++){
			Screen->DrawTile(1,this->X,this->Y,51741+i,1,1,6,-1,-1,0,0,0,1,true,128);
			Waitframe();
		}

		Game->PlaySound(84);

		explosion = Screen->CreateLWeapon(6);
		explosion->X = this->X;
		explosion->Y = this->Y;
		explosion->Damage = damage;

		this->Vy = -0.5;

		if(	(Abs(this->X - Link->X)<16)	&&
				(Abs(this->Y - Link->Y)<16)	&&
				canMove(Link->X+4,Link->Y-1) &&
				canMove(Link->X+8,Link->Y-1) &&
				canMove(Link->X+12,Link->Y-1)
		){
				jumpforce_current = 4;
				floaty = 6;
				airtime_current = 45;
		}

		for(i = 0; i<30; i++){

			if(i<5){Screen->DrawTile(6,this->X-30,this->Y-16,51810,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=5)&&(i<10)){Screen->DrawTile(6,this->X-30,this->Y-16,51808,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=10)&&(i<15)){Screen->DrawTile(6,this->X-30,this->Y-16,51806,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=15)&&(i<20)){Screen->DrawTile(6,this->X-30,this->Y-16,51804,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=20)&&(i<25)){Screen->DrawTile(6,this->X-30,this->Y-16,51802,2,2,6,64,64,0,0,0,1,true,128);}
			if(i>=25){Screen->DrawTile(6,this->X-30,this->Y-16,51800,2,2,6,64,64,0,0,0,1,true,128);}
		
			Waitframe();

		}

		this->Data = 0;

	} // end of void run

} // end of ffc script

// ==================================================
// Explosives2
// This script controls the second level Explosives.  A
// copy of the player will be created in front of the
// player and fire lazers in the direction faced
// for a short period of time.
// ==================================================

item script explosives_item2{

	void run(){

		ffc utility_ffc;
								
			if((get_blank_FFC()>0)&&(Link->MP>=10)){

				Link->MP = Link->MP - 10;
				Game->PlaySound(21);

				utility_ffc = Screen->LoadFFC(get_blank_FFC());
				utility_ffc->Vx = 0;
				utility_ffc->Vy = 0;
				utility_ffc->Data = 1;
				utility_ffc->Ax = 0;
				utility_ffc->Ay = 0;
				utility_ffc->Script = 221;

				if(Link->Dir==0){
					utility_ffc->X = Link->X;
					utility_ffc->Y = Link->Y-16;
				}else if (Link->Dir==1){
					utility_ffc->X = Link->X; 
					utility_ffc->Y = Link->Y+16;
				}else if (Link->Dir==2){
					utility_ffc->X = Link->X-16; 
					utility_ffc->Y = Link->Y;
				}else if (Link->Dir==3){
					utility_ffc->X = Link->X+16; 
					utility_ffc->Y = Link->Y;
				}

			}

	} // end of run

	int get_blank_FFC(){

		int i;
		ffc current_ffc;

			for(i = 3; i <= 26; i++){
				
					current_ffc = Screen->LoadFFC(i);
					if(current_ffc->Data==0){
						return i;
					}
			} 

			return -1;

	} // end of get_blank_FFC

} // end of item script

ffc script explosives2{ 

	void run(){

		int damage = (sidearm_energy+sidearm_power+sidearm_speed)/(1.5);

		this->Vx = 0;
		this->Vy = 0;
		lweapon explosion;

		int i = 0;
		int j = 0;
		eweapon current_eweapon;

		int shot_counter;

		int cset_counter;

		for(i = 0; i<40; i++){

			if(i<5){Screen->DrawTile(1,this->X,this->Y,51761,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=5)&&(i<10)){Screen->DrawTile(1,this->X,this->Y,51762,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=10)&&(i<15)){Screen->DrawTile(1,this->X,this->Y,51763,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=15)&&(i<20)){Screen->DrawTile(1,this->X,this->Y,51764,1,1,6,-1,-1,0,0,0,1,true,128);}
	
			if((i>=20)&&(i<25)){Screen->DrawTile(1,this->X,this->Y,51761,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=25)&&(i<30)){Screen->DrawTile(1,this->X,this->Y,51762,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=30)&&(i<35)){Screen->DrawTile(1,this->X,this->Y,51763,1,1,6,-1,-1,0,0,0,1,true,128);}
			if((i>=35)&&(i<40)){Screen->DrawTile(1,this->X,this->Y,51764,1,1,6,-1,-1,0,0,0,1,true,128);}

			Waitframe();
		}

		for(i = 0; i<4; i++){
			Screen->DrawTile(1,this->X,this->Y,51761+i,1,1,6,-1,-1,0,0,0,1,true,128);
			Waitframe();
		}
		for(i = 0; i<4; i++){
			Screen->DrawTile(1,this->X,this->Y,51761+i,1,1,6,-1,-1,0,0,0,1,true,128);
			Waitframe();
		}
		for(i = 0; i<4; i++){
			Screen->DrawTile(1,this->X,this->Y,51761+i,1,1,6,-1,-1,0,0,0,1,true,128);
			Waitframe();
		}
		for(i = 0; i<4; i++){
			Screen->DrawTile(1,this->X,this->Y,51761+i,1,1,6,-1,-1,0,0,0,1,true,128);
			Waitframe();
		}

		Game->PlaySound(84);

		explosion = Screen->CreateLWeapon(6);
		explosion->X = this->X-8;
		explosion->Y = this->Y;
		explosion->Damage = damage;

		explosion = Screen->CreateLWeapon(6);
		explosion->X = this->X+8;
		explosion->Y = this->Y;
		explosion->Damage = damage;

		explosion = Screen->CreateLWeapon(6);
		explosion->X = this->X;
		explosion->Y = this->Y-8;
		explosion->Damage = damage;

		explosion = Screen->CreateLWeapon(6);
		explosion->X = this->X;
		explosion->Y = this->Y+8;
		explosion->Damage = damage;

		this->Vy = -0.5;

		if(	(Abs(this->X - Link->X)<16)	&&
				(Abs(this->Y - Link->Y)<16)	&&
				canMove(Link->X+4,Link->Y-1) &&
				canMove(Link->X+8,Link->Y-1) &&
				canMove(Link->X+12,Link->Y-1)
		){
				jumpforce_current = 5;
				floaty = 7;
				airtime_current = 50;
		}

		for(i = 0; i<40; i++){

			for(j = 0; j<Screen->NumEWeapons(); j++){
				current_eweapon = Screen->LoadEWeapon(j);
				if(	(Abs(this->X - current_eweapon->X)<24)	&&
					(Abs(this->Y - current_eweapon->Y)<24)
				){
					current_eweapon->X = -100;
					current_eweapon->Y = -100;
				}
			}

			if(i<5){Screen->DrawTile(6,this->X-30,this->Y-16,51810,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=5)&&(i<10)){Screen->DrawTile(6,this->X-50,this->Y-16,51808,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=10)&&(i<15)){Screen->DrawTile(6,this->X-50,this->Y-16,51806,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=15)&&(i<20)){Screen->DrawTile(6,this->X-50,this->Y-16,51804,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=20)&&(i<25)){Screen->DrawTile(6,this->X-50,this->Y-16,51802,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=25)&&(i<30)){Screen->DrawTile(6,this->X-50,this->Y-16,51800,2,2,6,64,64,0,0,0,1,true,128);}

			if((i>=10)&&(i<15)){Screen->DrawTile(6,this->X-30,this->Y-16,51810,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=15)&&(i<20)){Screen->DrawTile(6,this->X-10,this->Y-16,51808,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=20)&&(i<25)){Screen->DrawTile(6,this->X-10,this->Y-16,51806,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=25)&&(i<30)){Screen->DrawTile(6,this->X-10,this->Y-16,51804,2,2,6,64,64,0,0,0,1,true,128);}
			if((i>=30)&&(i<35)){Screen->DrawTile(6,this->X-10,this->Y-16,51802,2,2,6,64,64,0,0,0,1,true,128);}
			if(i>=35){Screen->DrawTile(6,this->X-10,this->Y-16,51800,2,2,6,64,64,0,0,0,1,true,128);}
		
			Waitframe();

		}

		this->Data = 0;

	} // end of void run

} // end of ffc script

// ==================================================
// Explosives3
// This script controls the second level Explosives.  A
// copy of the player will be created in front of the
// player and fire lazers in the direction faced
// for a short period of time.
// ==================================================

item script explosives_item3{

	void run(){

		ffc utility_ffc;
								
			if((get_blank_FFC()>0)&&(Link->MP>=15)){

				Link->MP = Link->MP - 15;
				Game->PlaySound(21);

				utility_ffc = Screen->LoadFFC(get_blank_FFC());
				utility_ffc->Vx = 0;
				utility_ffc->Vy = 0;
				utility_ffc->Data = 1;
				utility_ffc->Ax = 0;
				utility_ffc->Ay = 0;
				utility_ffc->Script = 222;

				if(Link->Dir==0){
					utility_ffc->X = Link->X;
					utility_ffc->Y = Link->Y-16;
				}else if (Link->Dir==1){
					utility_ffc->X = Link->X; 
					utility_ffc->Y = Link->Y+16;
				}else if (Link->Dir==2){
					utility_ffc->X = Link->X-16; 
					utility_ffc->Y = Link->Y;
				}else if (Link->Dir==3){
					utility_ffc->X = Link->X+16; 
					utility_ffc->Y = Link->Y;
				}

			}

	} // end of run

	int get_blank_FFC(){

		int i;
		ffc current_ffc;

			for(i = 3; i <= 26; i++){
				
					current_ffc = Screen->LoadFFC(i);
					if(current_ffc->Data==0){
						return i;
					}
			} 

			return -1;

	} // end of get_blank_FFC

} // end of item script


//The rest here, is for weapon control and movement, including ship weapons.

// ====================================
// GENERAL WEAPON SCRIPT
// This script will use FFCs 31, 30, and 29 to 
// simulate weapons.  The script looks for 
// these FFCs to change to certain combos; once 
// the combo changes, the weapon fires appropriately.
// D0 = This ffc number.
// ====================================

ffc script General_Weapon{

	void run(int this_ffc_number, int damage){
		
		//ffc this_ffc = Screen->LoadFFC(this_ffc_number);
		ffc this_ffc = this;

		int last_screen = 0;

		ffc check_for_leo = Screen->LoadFFC(2);

	// Load the FFC number into this_ffc_number (thanks to Saffith)
	for(int i=1; i<=32; i++)
	{
     	  if(Screen->LoadFFC(i)==this_ffc)
          this_ffc_number = i;
    }

		bool in_use = false;	// set to true each frame if the weapon is in use

		int i;

		lweapon missile_impact;

		ffc first_beam = Screen->LoadFFC(31);	// Hard-coded to use FFC 31.

		ffc second_beam = Screen->LoadFFC(30);	// Hard-coded to use FFC 30.

		ffc third_beam = Screen->LoadFFC(29);	// Hard-coded to use FFC 29.

		int beam_animation = 1745;	// Aquarius Bubble
		int beam_animation2 = 1832;	// Scorpio Sting
		int beam_animation3 = 1840;	// Aries Saber
		int beam_animation4 = 1661;	// Pieces Spread
		int beam_animation5a = 1779;	// Gemini Beam
		int beam_animation5b = 1783;	
		int beam_animation5c = 1787;
		int beam_animation5d = 1791;
		int beam_animation6 = 1807;	// Cancer Splatter
		int beam_animation7 = 394;	// Ship Cannon
		int beam_animation8 = 476;	// Ship Cannon 2
		int beam_animation9 = 477;	// Ship Cannon 3
		int beam_animation10a = 3416;  // Leo Lazer
		int beam_anmiation10b = 3421;
		int beam_animation10c = 3426;
		int beam_animation10d = 3431;	
		int beam_animation11 = 3444;	// Taurus Flame
		int beam_animation12 = 3448; // Virgo Whip
		int beam_animation13 = 3476; // Libra Crystal
		int beam_animation14 = 3414; // Capricorn Wave
		int beam_animation15 = 503;  // Ship Cannon 4 
		int beam_animation16 = 507;  // Ship Cannon 5
		int beam_animation17 = 3492; // Pulse Hammer
		int beam_animation18a = 3504; // Disentigrator
		int beam_animation18b = 3508;

		int missile_animation = 3772; // Level 2 missiles 
		int missile_animation2 = 3780; // Level 3 missiles

		int wobble = 0;
		int x_wave;
		int y_wave;

		int initialize = 0;
		int starting_X = 0;
		int starting_Y = 0;
		
		int charge_counter = 0;
			
		ffc utility_ffc;
		ffc utility_ffc2;

		int rapid_fire_delay_current = 0;
		int rapid_speed = 0;
		int rapid_beam = 0;

		// Variables to determine whether enemy is impacted

		int current_enemy_number = 0;
		npc current_enemy;

		// Variables to record which enemy is damaged

		npc enemy_1_damaged;			// A pointer to the first damaged enemy	
		int enemy_1_cset = 0;			// The first damaged enemy's original Cset.
		int enemy_1_damaged_counter = 0;	// A counter to keep track of how long the enemy animation lasts.

		npc enemy_2_damaged;			// Same for the second enemy damaged.
		int enemy_2_cset = 0;			// etc.
		int enemy_2_damaged_counter = 0;

		npc enemy_3_damaged;
		int enemy_3_cset = 0;
		int enemy_3_damaged_counter = 0;

		npc enemy_4_damaged;
		int enemy_4_cset = 0;
		int enemy_4_damaged_counter = 0;

		while (true){


			// =================================
			//           AQUARIUS BUBBLE MOVEMENT
			// =================================

			if (this_ffc->Data == beam_animation){

				this->CSet = 7;

				in_use = true;
				damage = sidearm_power + 2;

				if (initialize == 0) {
					starting_X = this_ffc->X; 
					starting_Y = this_ffc->Y;
					if( (this_ffc->Vx > 0) && (this_ffc->Vy == 0)){ wobble = 180; }
					if( (this_ffc->Vx == 0) && (this_ffc->Vy > 0)){ wobble = 270; }
					if( (this_ffc->Vx < 0) && (this_ffc->Vy == 0)){ wobble = 0; }
					if( (this_ffc->Vx == 0) && (this_ffc->Vy < 0)){ wobble = 90; }
				}
				
				initialize++;
				this_ffc->Vx = -3 * Sin(wobble);
				this_ffc->Vy = 3 * Cos(wobble);
				wobble = wobble + 10;

				if ( (initialize > 10) && 
					(this_ffc->X - 8 < starting_X) &&
					(this_ffc->X + 8 > starting_X) &&
					(this_ffc->Y - 8 < starting_Y) &&
					(this_ffc->Y + 8 > starting_Y)){
					this_ffc->Data = 1;
					wobble = 0;
					initialize = 0;
				}

			}

			// =================================
			//           SCORPIO STING MOVEMENT
			// =================================

			if ( (this_ffc->Data >= beam_animation2) && (this_ffc->Data <= (beam_animation2 + 6)) ){

				this->CSet = 6;

				in_use = true;
				damage = sidearm_power + sidearm_speed;

				if (initialize == 0) {
					wobble = 0;
					if(this_ffc->Vx != 0){ x_wave = 0; y_wave = 1;}
					if(this_ffc->Vy != 0){x_wave = 1; y_wave = 0;}
				}
				
				initialize++;
				if(x_wave == 1){this_ffc->Vx = 2 * Cos(wobble);}
				if(y_wave == 1){this_ffc->Vy = 2 * Cos(wobble);}

				wobble = wobble + 10;
 
				if ( (this_ffc->Data < beam_animation2) || (this_ffc->Data > beam_animation2+6) ||
				     (this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)
				 ){

					this_ffc->Data = 1;
					wobble = 0;
					initialize = 0;
					this_ffc->X = 16;
					this_ffc->Y = 16;
				}

			}

			// ================================
			//	ARIES SABER MOVEMENT
			// ================================
	
				if( (this_ffc->Data >= beam_animation3) && (this_ffc->Data <= beam_animation3 + 46) ){

					this->CSet = 6;

					in_use = true;
					damage = sidearm_power+4;	// doesnt move!

					if ( (this_ffc->Data < beam_animation3) || (this_ffc->Data > beam_animation3+46) ||
					    (this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)
				 		){

						this_ffc->Data = 1;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;
					}
					
				}
		
					

			// ================================
			//	PIECES SPREAD MOVEMENT
			//================================
	
				if(this_ffc->Data == beam_animation4){

					this->CSet = 6;

					in_use = true;
					damage = sidearm_speed*2;	// go along its merry path as set by the original item script.

					if ( (!(this_ffc->Data == beam_animation4))||(this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

						this_ffc->Data = 1;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;
					}
					
				}
	

			// ================================
			//	PULSE CANNON MOVEMENT
			//================================
	
				if((this_ffc->Data >= beam_animation17)&&(this_ffc->Data <= beam_animation17+9)){

					this->CSet = 6;

					in_use = true;
					damage = 2;	// go along its merry path as set by the original item script.

					if ( (  !((this_ffc->Data >= beam_animation17)&&(this_ffc->Data<=beam_animation17+9))   )
					||(this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

						this_ffc->Data = 1;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;
					}
					
				}

			// ================================
			//	MISSILE MOVEMENT
			//================================
	
				if( (this_ffc->Data >= missile_animation)&&(this_ffc->Data <= missile_animation+15) ){

					in_use = true; // go along its merry path as set by the original item script.

					this_ffc->CSet = 7;

					if ( (  !((this_ffc->Data >= missile_animation)&&(this_ffc->Data <= missile_animation+15))   )
					||(this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

						this_ffc->Data = 1;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;
					}


					if(
						(!canMove(this_ffc->X + 8, this_ffc->Y + 8)) ||
						((this_ffc->Vy<0)&&(!canMove(this_ffc->X + 8, this_ffc->Y))) ||
						((this_ffc->Vx<0)&&(!canMove(this_ffc->X, this_ffc->Y + 8)))
					){


						if((this_ffc->Data >= missile_animation)&&(this_ffc->Data <= missile_animation +5)){

							missile_impact = Screen->CreateLWeapon(6);
							missile_impact->X = this_ffc->X;
							missile_impact->Y = this_ffc->Y;
							missile_impact->Damage = 20;
							
							if(this_ffc->Data==missile_animation){missile_impact->Y=this_ffc->Y-2;}

							this_ffc->Data = 1;
							wobble = 0;
							initialize = 0;
							this_ffc->X = 16;
							this_ffc->Y = 16;


							Screen->Quake = 15;
						}

						if((this_ffc->Data >= missile_animation+8)&&(this_ffc->Data <= missile_animation +15)){

							missile_impact = Screen->CreateLWeapon(6);
							missile_impact->Damage = 50;
							missile_impact->X = this_ffc->X;
							missile_impact->Y = this_ffc->Y;

							missile_impact = Screen->CreateLWeapon(7);
							missile_impact->Damage = 75;
							missile_impact->X = this_ffc->X;
							missile_impact->Y = this_ffc->Y;
	
							missile_impact = Screen->CreateLWeapon(6);
							missile_impact->Damage = 50;
							missile_impact->X = this_ffc->X-20;
							missile_impact->Y = this_ffc->Y-20;
	
							missile_impact = Screen->CreateLWeapon(6);
							missile_impact->Damage = 50;
							missile_impact->X = this_ffc->X+20;
							missile_impact->Y = this_ffc->Y-20;
	
							missile_impact = Screen->CreateLWeapon(6);
							missile_impact->Damage = 50;
							missile_impact->X = this_ffc->X-20;
							missile_impact->Y = this_ffc->Y+20;
	
							missile_impact = Screen->CreateLWeapon(6);
							missile_impact->Damage = 50;
							missile_impact->X = this_ffc->X+20;
							missile_impact->Y = this_ffc->Y+20;

							Screen->Quake = 30;

							this_ffc->Data = 1;
							wobble = 0;
							initialize = 0;
							this_ffc->X = 16;
							this_ffc->Y = 16;
						}

					}
					
				}

			// ================================
			//	DISENTIGRATOR MOVEMENT
			//================================
	
				if((this_ffc->Data >= beam_animation18a)&&(this_ffc->Data <= beam_animation18a+5)){

					this->CSet = 2;
					
					in_use = true;
					damage = 3;	// go along its merry path as set by the original item script.

					if (  
						(!((this_ffc->Data >= beam_animation18a)&&(this_ffc->Data <= beam_animation18a+5)))
						||(this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

						this_ffc->Data = 1;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;
					}
					
				}

			// ============================
			//   GEMINI BEAM MOVEMENT
			// ============================

				if( (this_ffc->Data==beam_animation5a) || (this_ffc->Data==beam_animation5b) || (this_ffc->Data==beam_animation5c) || (this_ffc->Data==beam_animation5d) ){

					this->CSet = 6;

					in_use = true;	
					damage = sidearm_power+sidearm_energy;	// go along its merry path as set by the original item script.

					if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

						this_ffc->Data = 1;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;
					}

				}

			// ================================
			//	CAPRICORN WAVE MOVEMENT
			//================================
	
				if(this_ffc->Data == beam_animation14){

					this->CSet = 6;

					in_use = true;
					damage = sidearm_power*2;	
			
					if(wobble==0){wobble=32;}
					else{wobble = wobble-2;}

					// Draw waves around the beam
					
					Screen->Circle(
						3,				// Layer	
						this_ffc->X+8,		// X coordinate of center	
						this_ffc->Y+8,		// Y coordinate of center
						wobble,			// radius
						109,				// color				
						1,				// scale
						0,				// no rotation
						0,				// no rotation
						0,				// no rotation
						false,			// wireframe
						128				// solid
					);

					Screen->Circle(
						3,				// Layer	
						this_ffc->X+8,		// X coordinate of center	
						this_ffc->Y+8,		// Y coordinate of center
						wobble/2,			// radius
						109,				// color				
						1,				// scale
						0,				// no rotation
						0,				// no rotation
						0,				// no rotation
						false,			// wireframe
						128				// solid
					);
						
					if ( (!(this_ffc->Data == beam_animation14))||(this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

						this_ffc->Data = 1;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;
					}
					
				}

			// ============================
			// CANCER SPLATTER MOVEMENT
			// ============================
		
				if(this_ffc->Data==beam_animation6){

					this->CSet = 5;

					in_use = true;
					damage = sidearm_power*3;
					
					this->Vy = this->Vy + 0.08;	

					//Splatters on impact
					
					if(
						((this_ffc->Vx > 0)&&(!canMove(this_ffc->X+9,this_ffc->Y))) ||
						((this_ffc->Vx < 0)&&(!canMove(this_ffc->X+7,this_ffc->Y))) ||
						((this_ffc->Vy > 0)&&(!canMove(this_ffc->X,this_ffc->Y+9))) ||
						((this_ffc->Vy < 0)&&(!canMove(this_ffc->X,this_ffc->Y+7)))
					){

						this->Data=1;
						in_use = false;

						Game->PlaySound(78);

						utility_ffc = Screen->LoadFFC(get_blank_FFC(20));

						utility_ffc->X = this->X; 
						utility_ffc->Y = this->Y;
						utility_ffc->Vx = 0;
						utility_ffc->Vy = 0;
						utility_ffc->Data = 1;
						utility_ffc->Ax = 0;
						utility_ffc->Ay = 0;
						utility_ffc->Script = 186;

					}

				}


			// ===========================
			// LEO LAZER MOVEMENT
			// ===========================

			if((this_ffc->Data >= beam_animation10a)&&(this_ffc->Data <= beam_animation10d+4)){

				this->CSet = 2;

				in_use = true;
				damage = sidearm_energy*2;

				if((this_ffc->Data == 3416)||(this_ffc->Data == 3417)){	// drawing north strong beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 3,	// top left corner
						0,			
						this_ffc->X + 12, // bottom right corner
						this_ffc->Y,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 4,	// top left corner
						0,			
						this_ffc->X + 11, // bottom right corner
						this_ffc->Y,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}
				if((this_ffc->Data == 3418)||(this_ffc->Data == 3419)){	// drawing north med beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 4,	// top left corner
						0,			
						this_ffc->X + 11, // bottom right corner
						this_ffc->Y,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 5,	// top left corner
						0,			
						this_ffc->X + 10, // bottom right corner
						this_ffc->Y,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if(this_ffc->Data == 3420){	// drawing north weak beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 6,	// top left corner
						0,			
						this_ffc->X + 9, // bottom right corner
						this_ffc->Y,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 7,	// top left corner
						0,			
						this_ffc->X + 8, // bottom right corner
						this_ffc->Y,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if((this_ffc->Data == 3421)||(this_ffc->Data == 3422)){	// drawing south strong beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 3,	// top left corner
						this_ffc->Y + 15,			
						this_ffc->X + 12, // bottom right corner
						200,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 4,	// top left corner
						this_ffc->Y + 15,			
						this_ffc->X + 11, // bottom right corner
						200,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if((this_ffc->Data == 3423)||(this_ffc->Data == 3424)){	// drawing south med beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 4,	// top left corner
						this_ffc->Y + 15,			
						this_ffc->X + 11, // bottom right corner
						200,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 5,	// top left corner
						this_ffc->Y + 15,			
						this_ffc->X + 10, // bottom right corner
						200,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if(this_ffc->Data == 3425){	// drawing south weak beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 6,	// top left corner
						this_ffc->Y+ 15,			
						this_ffc->X + 9, // bottom right corner
						200,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X + 7,	// top left corner
						this_ffc->Y + 15,			
						this_ffc->X + 8, // bottom right corner
						200,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if((this_ffc->Data == 3431)||(this_ffc->Data == 3432)){	// drawing west strong beam

					Screen->Rectangle(
						3,			// draw on layer 3
						0,			// top left corner
						this_ffc->Y+3,			
						this_ffc->X, 	// bottom right corner
						this_ffc->Y+12,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						0,			// top left corner
						this_ffc->Y+4,			
						this_ffc->X, 	// bottom right corner
						this_ffc->Y+11,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if((this_ffc->Data == 3433)||(this_ffc->Data == 3434)){	// drawing west med beam

					Screen->Rectangle(
						3,			// draw on layer 3
						0,			// top left corner
						this_ffc->Y+4,			
						this_ffc->X, 	// bottom right corner
						this_ffc->Y+11,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						0,			// top left corner
						this_ffc->Y+5,			
						this_ffc->X, 	// bottom right corner
						this_ffc->Y+10,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);
				}

				if(this_ffc->Data == 3435){	// drawing west weak beam

					Screen->Rectangle(
						3,			// draw on layer 3
						0,			// top left corner
						this_ffc->Y+6,			
						this_ffc->X, 	// bottom right corner
						this_ffc->Y+9,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						0,			// top left corner
						this_ffc->Y+7,			
						this_ffc->X, 	// bottom right corner
						this_ffc->Y+8,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);


				}

				if((this_ffc->Data == 3426)||(this_ffc->Data == 3427)){	// drawing east strong beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X+15,	// top left corner
						this_ffc->Y+3,			
						260,		 	// bottom right corner
						this_ffc->Y+12,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X+15,	// top left corner
						this_ffc->Y+4,			
						260,		 	// bottom right corner
						this_ffc->Y+11,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if((this_ffc->Data == 3428)||(this_ffc->Data == 3429)){	// drawing east MED beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X+15,	// top left corner
						this_ffc->Y+4,			
						260,		 	// bottom right corner
						this_ffc->Y+11,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X+15,	// top left corner
						this_ffc->Y+5,			
						260,		 	// bottom right corner
						this_ffc->Y+10,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if(this_ffc->Data == 3430){	// drawing east WEAK beam

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X+15,	// top left corner
						this_ffc->Y+6,			
						260,		 	// bottom right corner
						this_ffc->Y+9,	
						106,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

					Screen->Rectangle(
						3,			// draw on layer 3
						this_ffc->X+15,	// top left corner
						this_ffc->Y+7,			
						260,		 	// bottom right corner
						this_ffc->Y+8,	
						109,			// color
						1,			// scale
						0,			// no rotation, please.
						0,
						0,
						true,			// draw filled
						128			// opaque
					);

				}

				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 16;
					this_ffc->Y = 16;
				}

			}

			// ============================
			// TAURUS FLAME MOVEMENT
			// ============================

			if( (this_ffc->Data >= beam_animation11) && (this_ffc->Data <= beam_animation11+3) ){

				this->CSet = 2;

				in_use = true;
				damage = sidearm_power+sidearm_energy+sidearm_speed;

				this_ffc->Vy = this_ffc->Vy - (Rand(1)/2) -0.1;

				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 16;
					this_ffc->Y = 16;
				}
			}

			// ============================
			// VIRGO WHIP MOVEMENT
			// ============================			

			if( (this_ffc->Data >= beam_animation12) && (this_ffc->Data <= beam_animation12+27) ){

				this->CSet = 2;

				in_use = true;
				damage = sidearm_speed*2;
				this_ffc->Vy = 0;
				this_ffc->Vx = 0;				

				if ( wobble <= 5 ){

					if(Link->Dir == 0) {
						first_beam->X = Link->X + 8; 
						first_beam->Y = Link->Y + 8;
						first_beam->Data = beam_animation12+8;
						second_beam->Data = 3410;
						third_beam->Data = 3410;
					}

					if(Link->Dir == 1) {

						first_beam->X = Link->X - 8; 
						first_beam->Y = Link->Y - 8;
						first_beam->Data = beam_animation12+12;
						second_beam->Data = 3410;
						third_beam->Data = 3410;						
					
					}
					if(Link->Dir == 2) {

						first_beam->X = Link->X + 8; 
						first_beam->Y = Link->Y - 8;
						first_beam->Data = beam_animation12+4;
						second_beam->Data = 3410;
						third_beam->Data = 3410;
					}
					if(Link->Dir == 3) {

						first_beam->X = Link->X - 8; 
						first_beam->Y = Link->Y - 8;
						first_beam->Data = beam_animation12;
						second_beam->Data = 3410;
						third_beam->Data = 3410;
					}
				}
				
				if ( (wobble > 5) && (wobble <= 20) ){

					if(Link->Dir == 0) {
						first_beam->X = Link->X; 
						first_beam->Y = Link->Y - 12;
						first_beam->Data = beam_animation12+26;
						second_beam->X = Link->X; 
						second_beam->Y = Link->Y - 28;
						second_beam->Data = beam_animation12+22;
						third_beam->X = Link->X; 
						third_beam->Y = Link->Y - 44;
						third_beam->Data = beam_animation12+18;
					}

					if(Link->Dir == 1) {

						first_beam->X = Link->X; 
						first_beam->Y = Link->Y + 12;
						first_beam->Data = beam_animation12+16;
						second_beam->X = Link->X; 
						second_beam->Y = Link->Y + 28;
						second_beam->Data = beam_animation12+20;
						third_beam->X = Link->X; 
						third_beam->Y = Link->Y + 44;
						third_beam->Data = beam_animation12+24;					
					
					}
					if(Link->Dir == 2) {

						first_beam->X = Link->X - 12; 
						first_beam->Y = Link->Y;
						first_beam->Data = beam_animation12+11;
						second_beam->X = Link->X - 28; 
						second_beam->Y = Link->Y;;
						second_beam->Data = beam_animation12+10;
						third_beam->X = Link->X - 44; 
						third_beam->Y = Link->Y;
						third_beam->Data = beam_animation12+9;

					}
					if(Link->Dir == 3) {

						first_beam->X = Link->X + 12; 
						first_beam->Y = Link->Y;
						first_beam->Data = beam_animation12+1;
						second_beam->X = Link->X + 28; 
						second_beam->Y = Link->Y;;
						second_beam->Data = beam_animation12+2;
						third_beam->X = Link->X + 44; 
						third_beam->Y = Link->Y;
						third_beam->Data = beam_animation12+3;
					}
				}

				if ( (wobble > 20) ){

					if(Link->Dir == 0) {
						first_beam->X = Link->X; 
						first_beam->Y = Link->Y - 12;
						first_beam->Data = beam_animation12+27;
						second_beam->X = Link->X; 
						second_beam->Y = Link->Y - 28;
						second_beam->Data = beam_animation12+23;
						third_beam->X = Link->X; 
						third_beam->Y = Link->Y - 44;
						third_beam->Data = beam_animation12+19;
					}

					if(Link->Dir == 1) {

						first_beam->X = Link->X; 
						first_beam->Y = Link->Y + 12;
						first_beam->Data = beam_animation12+17;
						second_beam->X = Link->X; 
						second_beam->Y = Link->Y + 28;
						second_beam->Data = beam_animation12+21;
						third_beam->X = Link->X; 
						third_beam->Y = Link->Y + 44;
						third_beam->Data = beam_animation12+25;					
					
					}
					if(Link->Dir == 2) {

						first_beam->X = Link->X - 12; 
						first_beam->Y = Link->Y;
						first_beam->Data = beam_animation12+15;
						second_beam->X = Link->X - 28; 
						second_beam->Y = Link->Y;;
						second_beam->Data = beam_animation12+14;
						third_beam->X = Link->X - 44; 
						third_beam->Y = Link->Y;
						third_beam->Data = beam_animation12+13;

					}
					if(Link->Dir == 3) {

						first_beam->X = Link->X + 12; 
						first_beam->Y = Link->Y;
						first_beam->Data = beam_animation12+5;
						second_beam->X = Link->X + 28; 
						second_beam->Y = Link->Y;;
						second_beam->Data = beam_animation12+6;
						third_beam->X = Link->X + 44; 
						third_beam->Y = Link->Y;
						third_beam->Data = beam_animation12+7;
					}
				}

				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 16;
					this_ffc->Y = 16;
				}

				wobble++;

				// Check to see if the shot is going to impact on Leo
				// If so, communicate this fact to Leo.  This assumes
				// leo is loaded on FFC2 and that the script is 86
			
				if(	check_for_leo->Ax == 0.00419){

					if(
						(	(Abs(check_for_leo->X - first_beam->X)<15) &&
							(Abs(check_for_leo->Y - first_beam->Y)<15)
						) ||
						(	(Abs(check_for_leo->X - second_beam->X)<15) &&
							(Abs(check_for_leo->Y - second_beam->Y)<15)
						) ||
						(	(Abs(check_for_leo->X - third_beam->X)<15) &&
							(Abs(check_for_leo->Y - third_beam->Y)<15)
						)
					){
						check_for_leo->Ay = 0.01;
					}

				}
			}

			// ============================
			// LIBRA CRYSTAL MOVEMENT
			// ============================			

			if( this_ffc->Data == beam_animation13){
	
				this->CSet = 2;

				in_use = true;
				damage = sidearm_energy+sidearm_speed+4;

				if(
					((this_ffc->Vx > 0)&&(!canMove(this_ffc->X+17,this_ffc->Y))) ||
					((this_ffc->Vx < 0)&&(!canMove(this_ffc->X-1,this_ffc->Y)))
				){
					Game->PlaySound(6);
					this_ffc->Vx = -this_ffc->Vx;
				}

				if(
					((this_ffc->Vy > 0)&&(!canMove(this_ffc->X,this_ffc->Y+17))) ||
					((this_ffc->Vy < 0)&&(!canMove(this_ffc->X,this_ffc->Y-1)))
				){
					Game->PlaySound(6);
					this_ffc->Vy = -this_ffc->Vy;
				}

				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 16;
					this_ffc->Y = 16;
				}


			}

			// ============================
			// SHIP GUN 1 MOVEMENT
			// ============================

			if(this_ffc->Data == beam_animation7){
					
				in_use = true;						
				damage = 5;
				this->CSet = 6;
											
				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 16;
					this_ffc->Y = 16;
				}

				if( (ship_rapid_fire==1) && (!Link->InputA)&&(!Link->InputB)){

					ship_rapid_fire = 0;
				}
										
			}

			// ============================
			// SHIP GUN 2 MOVEMENT
			// ============================

			if(this_ffc->Data == beam_animation8){
				
				in_use = true;							
				damage = 9;
				this->CSet = 6;
											
				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 0;
					this_ffc->Y = 0;
				}
			}

			// ============================
			// SHIP GUN 3 MOVEMENT
			// ============================
											
			if(this_ffc->Data == beam_animation9){
				
				in_use = true;							
				damage = 12;

				this->CSet = 6;
											
				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 0;
					this_ffc->Y = 0;
				}

				if(this_ffc->Y>0){

					Screen->DrawTile(3,this_ffc->X - 16,this_ffc->Y + 8,17172,1,1,6,-1,-1,0,0,0,0,true,128);
					Screen->DrawTile(3,this_ffc->X + 16,this_ffc->Y + 8,17172,1,1,6,-1,-1,0,0,0,0,true,128);

				}

				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 0;
					this_ffc->Y = 0;
				}

			}

			// ============================
			// SHIP GUN 4 MOVEMENT
			// ============================
											
			if(this_ffc->Data == beam_animation15){
					
				in_use = true;						
				damage = 15;

				this->CSet = 6;

				if(this_ffc->Y>0){

					Screen->DrawTile(3,this_ffc->X - 16,this_ffc->Y + 8,17173,1,1,6,-1,-1,0,0,0,0,true,128);
					Screen->DrawTile(3,this_ffc->X + 16,this_ffc->Y + 8,17173,1,1,6,-1,-1,0,0,0,0,true,128);
				
				}
							
				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 0;
					this_ffc->Y = 0;
				}
			}

			// ============================
			// SHIP GUN 5 MOVEMENT
			// ============================
											
			if(this_ffc->Data == beam_animation16){
						
				in_use = true;					
				damage = 17;
				
				this->CSet = 6;

				if(this_ffc->Y>0){

					Screen->DrawTile(3,this_ffc->X - 16,this_ffc->Y + 8,17173,1,1,6,-1,-1,0,0,0,0,true,128);
					Screen->DrawTile(3,this_ffc->X + 16,this_ffc->Y + 8,17173,1,1,6,-1,-1,0,0,0,0,true,128);

					Screen->DrawTile(3,this_ffc->X - 32,this_ffc->Y + 8,17172,1,1,6,-1,-1,0,0,0,0,true,128);
					Screen->DrawTile(3,this_ffc->X + 32,this_ffc->Y + 8,17172,1,1,6,-1,-1,0,0,0,0,true,128);
				
				}
											
				if ((this_ffc->X < 0) || (this_ffc->X > 240) || (this_ffc->Y > 160) || (this_ffc->Y < 0)){

					this_ffc->Data = 1;
					this_ffc->X = 0;
					this_ffc->Y = 0;
				}
			}

			// ===================================
			// No weapon in use, reset.
			// Also handles rapid fire resetting
			// for weapons that have that capability.
			// ===================================

			if ( in_use == false ){
		
				this_ffc->Data = 1;
				wobble = 0;
				initialize = 0;
				this_ffc->X = 0;
				this_ffc->Y = 0;
			}

			// ==================================
			// Turn off the weapon if the player
			// has moved to a new screen.
			// ==================================

				if (last_screen != Game->GetCurScreen()){
					last_screen = Game->GetCurScreen();

					this_ffc->Data = 1;
					wobble = 0;
					initialize = 0;
					this_ffc->X = 0;
					this_ffc->Y = 0;

				}

			in_use = false;

			// If rapid fire is enabled, fire again.

			if ((rapid_fire_delay_current >= (rapid_fire_delay*2))&&(this_ffc_number==30)){
												
				rapid_fire_delay_current = 0;

				if( (ship_rapid_fire==1) && ((Link->InputA)||(Link->InputB))){

					if(Link->Item[7]){rapid_beam = beam_animation7; rapid_speed = 4;}
					if(Link->Item[36]){rapid_beam = beam_animation8; rapid_speed = 6;}
					if(Link->Item[139]){rapid_beam = beam_animation9; rapid_speed = 8;}
					if(Link->Item[174]){rapid_beam = beam_animation15; rapid_speed = 10;}
					if(Link->Item[175]){rapid_beam = beam_animation16; rapid_speed = 12;}

					if (first_beam->Data != rapid_beam){
						Game->PlaySound(74);	
						first_beam->X = Link->X; 
						first_beam->Y = Link->Y - 16;
						first_beam->Vy = -rapid_speed;
						first_beam->Vx = 0;
						first_beam->Data = rapid_beam;
					}
					else{
						if (second_beam->Data != rapid_beam){
	
							Game->PlaySound(74);
							second_beam->X = Link->X; 
							second_beam->Y = Link->Y - 16;
							second_beam->Vy = -rapid_speed;
							second_beam->Vx = 0;
							second_beam->Data = rapid_beam;
						}
						else{
							if (third_beam->Data != rapid_beam){
	
								Game->PlaySound(74);
								third_beam->X = Link->X; 
								third_beam->Y = Link->Y - 16;
								third_beam->Vy = -rapid_speed;
								third_beam->Vx = 0;
								third_beam->Data = rapid_beam;
							}
						}	
					} 	

				}
				else{ ship_rapid_fire = 0; }
			}
			else{ rapid_fire_delay_current++;}
			// =================================
			//      ENEMY IMPACT AND DAMAGE
			// =================================

			// Ensure that the weapon power doesn't go out of control!

			if (damage>90){damage=90;}

			// collision detection
			// Note: If boss_flag = true, this script only checks the first 25 enemies for collisions.
	
				current_enemy_number = Screen->NumNPCs();
				if ((current_enemy_number > 25)&&(boss_flag==true)){ current_enemy_number = 25;}
				while(current_enemy_number > 0){
			
					current_enemy = Screen->LoadNPC(current_enemy_number);

					// Missile Impact and Explosion

					if (
						((this_ffc->Data >= missile_animation)&&(this_ffc->Data <= missile_animation+5))&&
						(	
							(	(this_ffc->X - 12 < current_enemy->X) &&
								(this_ffc->X + 12 > current_enemy->X) &&
								(this_ffc->Y - 12 < current_enemy->Y) &&
								(this_ffc->Y + 12 > current_enemy->Y)
							)
							
						)
					){

						missile_impact = Screen->CreateLWeapon(6);
						missile_impact->X = this_ffc->X;
						missile_impact->Y = this_ffc->Y;

						this_ffc->Data = 1;
						missile_impact->Damage = 20;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;

						Screen->Quake = 15;
					}

					if (
						((this_ffc->Data >= missile_animation2)&&(this_ffc->Data <= missile_animation2+5))&&
						(	
							(	(this_ffc->X - 12 < current_enemy->X) &&
								(this_ffc->X + 12 > current_enemy->X) &&
								(this_ffc->Y - 12 < current_enemy->Y) &&
								(this_ffc->Y + 12 > current_enemy->Y)
							)

						)
					){
						missile_impact = Screen->CreateLWeapon(7);
						missile_impact->Damage = 75;
						missile_impact->X = this_ffc->X;
						missile_impact->Y = this_ffc->Y-8;

						missile_impact = Screen->CreateLWeapon(6);
						missile_impact->Damage = 50;
						missile_impact->X = this_ffc->X-20;
						missile_impact->Y = this_ffc->Y-20;

						missile_impact = Screen->CreateLWeapon(6);
						missile_impact->Damage = 50;
						missile_impact->X = this_ffc->X+20;
						missile_impact->Y = this_ffc->Y-20;

						missile_impact = Screen->CreateLWeapon(6);
						missile_impact->Damage = 50;
						missile_impact->X = this_ffc->X-20;
						missile_impact->Y = this_ffc->Y+20;

						missile_impact = Screen->CreateLWeapon(6);
						missile_impact->Damage = 50;
						missile_impact->X = this_ffc->X+20;
						missile_impact->Y = this_ffc->Y+20;

						Screen->Quake = 30;

						this_ffc->Data = 1;
						wobble = 0;
						initialize = 0;
						this_ffc->X = 16;
						this_ffc->Y = 16;
					}

					// Other weapons

					if (	
						(

						(				// impacts if leo lazer is lined up properly...

							((this_ffc->Data >= 3416) && (this_ffc->Data <= 3420) && (current_enemy->Y < this_ffc->Y) && (Abs(this_ffc->X-current_enemy->X)<=8))||
							((this_ffc->Data >= 3421) && (this_ffc->Data <= 3425) && (current_enemy->Y > this_ffc->Y) && (Abs(this_ffc->X-current_enemy->X)<=8))||
							((this_ffc->Data >= 3426) && (this_ffc->Data <= 3430) && (current_enemy->X > this_ffc->X) && (Abs(this_ffc->Y-current_enemy->Y)<=8))||
							((this_ffc->Data >= 3431) && (this_ffc->Data <= 3435) && (current_enemy->X < this_ffc->X) && (Abs(this_ffc->Y-current_enemy->Y)<=8))

						)||

										// impacts if Capricorn Wave or high level ship cannons are lined up

							((this_ffc->Data == beam_animation14) && (Abs(this_ffc->X - current_enemy->X)<32) && (Abs(this_ffc->Y - current_enemy->Y)<32)) ||
							(

								(
									(this_ffc->Data == beam_animation9)&&(Abs(this_ffc->X - current_enemy->X)<24)&&(Abs(this_ffc->Y - current_enemy->Y)<8)
								) ||

								(
									(this_ffc->Data == beam_animation15)&&(Abs(this_ffc->X - current_enemy->X)<32)&&(Abs(this_ffc->Y - current_enemy->Y)<8)
								) ||

								(
									(this_ffc->Data == beam_animation16)&&(Abs(this_ffc->X - current_enemy->X)<48)&&(Abs(this_ffc->Y - current_enemy->Y)<8)
								)
					
							) ||

							(			// OR if the ffc is a different beam, but ffc is close to the enemy

							(

							(this_ffc->Data == beam_animation) ||
							(this_ffc->Data == beam_animation4) ||
							(this_ffc->Data == beam_animation5a) ||
							(this_ffc->Data == beam_animation5b) ||
							(this_ffc->Data == beam_animation5c) ||
							(this_ffc->Data == beam_animation5d) ||
							(this_ffc->Data == beam_animation6) ||
							(this_ffc->Data == beam_animation7) ||
							(this_ffc->Data == beam_animation8) ||
							(this_ffc->Data == beam_animation13) ||
							(this_ffc->Data == beam_animation18a) ||
							((this_ffc->Data >= beam_animation18a)&&(this_ffc->Data <= beam_animation18a+5)) ||

							((this_ffc->Data >= beam_animation11) && (this_ffc->Data <= beam_animation11+4)) ||

							((this_ffc->Data >= beam_animation17) && (this_ffc->Data <= beam_animation17+9)) ||

							((this_ffc->Data >= beam_animation2) && (this_ffc->Data <= beam_animation2+6)) ||
							((this_ffc->Data >= beam_animation12) && (this_ffc->Data <= beam_animation12+27)) ||
							((this_ffc->Data >= beam_animation3) && (this_ffc->Data <= beam_animation3 + 46))

							)&&

							(this_ffc->X - 12 < current_enemy->X) &&
							(this_ffc->X + 12 > current_enemy->X) &&
							(this_ffc->Y - 12 < current_enemy->Y) &&
							(this_ffc->Y + 12 > current_enemy->Y)

						)
					
						)&&  		// either way, don't impact on shooters.

						(!(current_enemy->Tile==0))	

						){
						
						// Once an enemy is impacted, need to record
						// which enemy it is in one of the enemy 
						// variables.  

						// Note that MOST weapons stop damaging the
						// enemy on contact.  Not so with the special
						// melee weapons like Aries Saber, Virgo Whip, Leo Lazer.

						Game->PlaySound(11);

						// if this is the Virgo Whip, increase health

						if((this_ffc->Data >= beam_animation12) && (this_ffc->Data <= beam_animation12+27)){
							Link->HP = Link->HP + 1;
							if(Link->HP>Link->MaxHP){Link->HP=Link->MaxHP;}
						}


						// If this is the Cancer Splatter, spray projectiles.

						if(this_ffc->Data == beam_animation6){ 

							Game->PlaySound(78);
								utility_ffc = Screen->LoadFFC(get_blank_FFC(20));

								utility_ffc->X = this->X; 
								utility_ffc->Y = this->Y;
								utility_ffc->Vx = 0;
								utility_ffc->Vy = 0;
								utility_ffc->Data = 1;
								utility_ffc->Ax = 0;
								utility_ffc->Ay = 0;
								utility_ffc->Script = 186;

						}

						if(enemy_1_damaged_counter == 0){ 
							if(!(

									((this_ffc->Data > beam_animation3) && (this_ffc->Data < beam_animation3+46))||
									((this_ffc->Data >= beam_animation10a) && (this_ffc->Data <= beam_animation10d+5)) ||
									((this_ffc->Data >= beam_animation12) && (this_ffc->Data <= beam_animation12+27)) 
								)
							){
								this_ffc->Data = 1;
							} 
							initialize = 0; wobble = 0; enemy_1_damaged = current_enemy;  enemy_1_damaged_counter = 10; enemy_1_cset = current_enemy->CSet;
						}
						else{
							if(enemy_2_damaged_counter == 0){ 
								if(!(

										((this_ffc->Data > beam_animation3) && (this_ffc->Data < beam_animation3+46))||
										((this_ffc->Data >= beam_animation10a) && (this_ffc->Data <= beam_animation10d+5)) ||
										((this_ffc->Data >= beam_animation12) && (this_ffc->Data <= beam_animation12+27)) 
									)
								){
									this_ffc->Data = 1;
								}
								initialize = 0; wobble = 0; enemy_2_damaged = current_enemy;  enemy_2_damaged_counter = 10; enemy_2_cset = current_enemy->CSet;
							}
							else{
								if(enemy_3_damaged_counter == 0){ 
									if(!(

											((this_ffc->Data > beam_animation3) && (this_ffc->Data < beam_animation3+46))||
											((this_ffc->Data >= beam_animation10a) && (this_ffc->Data <= beam_animation10d+5)) ||
											((this_ffc->Data >= beam_animation12) && (this_ffc->Data <= beam_animation12+27)) 
										)
									){
										this_ffc->Data = 1;
									}
									initialize = 0; wobble = 0; enemy_3_damaged = current_enemy;  enemy_3_damaged_counter = 10; enemy_3_cset = current_enemy->CSet;
								}
								else{
									if(enemy_4_damaged_counter == 0){
										if(!(

											((this_ffc->Data > beam_animation3) && (this_ffc->Data < beam_animation3+46))||
											((this_ffc->Data >= beam_animation10a) && (this_ffc->Data <= beam_animation10d+5)) ||
											((this_ffc->Data >= beam_animation12) && (this_ffc->Data <= beam_animation12+27)) 
										)
										){
											this_ffc->Data = 1;
										}
										 initialize = 0; wobble = 0; enemy_4_damaged = current_enemy;  enemy_4_damaged_counter = 10; enemy_4_cset = current_enemy->CSet;
									} 
								}
							}
						}

					}	
					current_enemy_number--;

				}// end of collison detection

			// Damage simulation for enemy 1
			
			if(enemy_1_damaged_counter > 0){

				// enemy always moves away from the player while damaged

				if((enemy_1_damaged->X > Link->X) && (canMove(enemy_1_damaged->X + 24, enemy_1_damaged->Y)) &&
				(canMove(enemy_1_damaged->X + 24, enemy_1_damaged->Y + 8)) && (canMove(enemy_1_damaged->X + 24, enemy_1_damaged->Y + 15))
				){
					 enemy_1_damaged->X++; 
				}

				if((enemy_1_damaged->X < Link->X) && (canMove(enemy_1_damaged->X - 1, enemy_1_damaged->Y)) &&
				(canMove(enemy_1_damaged->X - 1, enemy_1_damaged->Y + 8)) && (canMove(enemy_1_damaged->X - 1, enemy_1_damaged->Y + 15))
				){
					 enemy_1_damaged->X--; 
				}

				if((enemy_1_damaged->Y > Link->Y) && (canMove(enemy_1_damaged->X, enemy_1_damaged->Y + 24)) &&
				(canMove(enemy_1_damaged->X + 8, enemy_1_damaged->Y + 24)) && (canMove(enemy_1_damaged->X + 15, enemy_1_damaged->Y + 24))
				){
					 enemy_1_damaged->Y++; 
				}

				if((enemy_1_damaged->Y < Link->Y) && (canMove(enemy_1_damaged->X, enemy_1_damaged->Y - 1)) &&
				(canMove(enemy_1_damaged->X + 8, enemy_1_damaged->Y - 1)) && (canMove(enemy_1_damaged->X + 15, enemy_1_damaged->Y - 1))
				){
					 enemy_1_damaged->Y--; 
				}

				// flash enemy's Cset
				
				enemy_1_damaged->CSet++;

				// If this is the first call to this function, reduce enemy hp.
		
				if (enemy_1_damaged_counter == 10) {enemy_1_damaged->HP = enemy_1_damaged->HP - damage;}

				// Decrement enemy counter

				enemy_1_damaged_counter--;

				// Finally, return enemy to normal if time is up.	

				if(enemy_1_damaged_counter == 0){
					enemy_1_damaged->CSet = enemy_1_cset;
				}

			} // end of damage simulation for enemy 1

			// Damage simulation for enemy 2
			
			if(enemy_2_damaged_counter > 0){

				// enemy always moves away from the player while damaged

				if((enemy_2_damaged->X > Link->X) && (canMove(enemy_2_damaged->X + 24, enemy_2_damaged->Y)) &&
				(canMove(enemy_2_damaged->X + 24, enemy_2_damaged->Y + 8)) && (canMove(enemy_2_damaged->X + 24, enemy_2_damaged->Y + 15))
				){
					 enemy_2_damaged->X++; 
				}

				if((enemy_2_damaged->X < Link->X) && (canMove(enemy_2_damaged->X - 1, enemy_2_damaged->Y)) &&
				(canMove(enemy_2_damaged->X - 1, enemy_2_damaged->Y + 8)) && (canMove(enemy_2_damaged->X - 1, enemy_2_damaged->Y + 15))
				){
					 enemy_2_damaged->X--; 
				}

				if((enemy_2_damaged->Y > Link->Y) && (canMove(enemy_2_damaged->X, enemy_2_damaged->Y + 24)) &&
				(canMove(enemy_2_damaged->X + 8, enemy_2_damaged->Y + 24)) && (canMove(enemy_2_damaged->X + 15, enemy_2_damaged->Y + 24))
				){
					 enemy_2_damaged->Y++; 
				}

				if((enemy_2_damaged->Y < Link->Y) && (canMove(enemy_2_damaged->X, enemy_2_damaged->Y - 1)) &&
				(canMove(enemy_2_damaged->X + 8, enemy_2_damaged->Y - 1)) && (canMove(enemy_2_damaged->X + 15, enemy_2_damaged->Y - 1))
				){
					 enemy_2_damaged->Y--; 
				}

				// flash enemy's Cset
				
				enemy_2_damaged->CSet++;

				// If this is the first call to this function, reduce enemy hp.
		
				if (enemy_2_damaged_counter == 10) {enemy_2_damaged->HP = enemy_2_damaged->HP - damage;}

				// Decrement enemy counter

				enemy_2_damaged_counter--;

				// Finally, return enemy to normal if time is up.	

				if(enemy_2_damaged_counter == 0){
					enemy_2_damaged->CSet = enemy_2_cset;
				}

			} // end of damage simulation for enemy 2

			// Damage simulation for enemy 3
			
			if(enemy_3_damaged_counter > 0){

				// enemy always moves away from the player while damaged

				if((enemy_3_damaged->X > Link->X) && (canMove(enemy_3_damaged->X + 24, enemy_3_damaged->Y)) &&
				(canMove(enemy_3_damaged->X + 24, enemy_3_damaged->Y + 8)) && (canMove(enemy_3_damaged->X + 24, enemy_3_damaged->Y + 15))
				){
					 enemy_3_damaged->X++; 
				}

				if((enemy_3_damaged->X < Link->X) && (canMove(enemy_3_damaged->X - 1, enemy_3_damaged->Y)) &&
				(canMove(enemy_3_damaged->X - 1, enemy_3_damaged->Y + 8)) && (canMove(enemy_3_damaged->X - 1, enemy_3_damaged->Y + 15))
				){
					 enemy_3_damaged->X--; 
				}

				if((enemy_3_damaged->Y > Link->Y) && (canMove(enemy_3_damaged->X, enemy_3_damaged->Y + 24)) &&
				(canMove(enemy_3_damaged->X + 8, enemy_3_damaged->Y + 24)) && (canMove(enemy_3_damaged->X + 15, enemy_3_damaged->Y + 24))
				){
					 enemy_3_damaged->Y++; 
				}

				if((enemy_3_damaged->Y < Link->Y) && (canMove(enemy_3_damaged->X, enemy_3_damaged->Y - 1)) &&
				(canMove(enemy_3_damaged->X + 8, enemy_3_damaged->Y - 1)) && (canMove(enemy_3_damaged->X + 15, enemy_3_damaged->Y - 1))
				){
					 enemy_3_damaged->Y--; 
				}

				// flash enemy's Cset
				
				enemy_3_damaged->CSet++;

				// If this is the first call to this function, reduce enemy hp.
		
				if (enemy_3_damaged_counter == 10) {enemy_3_damaged->HP = enemy_3_damaged->HP - damage;}

				// Decrement enemy counter

				enemy_3_damaged_counter--;

				// Finally, return enemy to normal if time is up.	

				if(enemy_3_damaged_counter == 0){
					enemy_3_damaged->CSet = enemy_3_cset;
				}

			} // end of damage simulation for enemy 3

			// Damage simulation for enemy 4
			
			if(enemy_4_damaged_counter > 0){

				// enemy always moves away from the player while damaged

				if((enemy_4_damaged->X > Link->X) && (canMove(enemy_4_damaged->X + 24, enemy_4_damaged->Y)) &&
				(canMove(enemy_4_damaged->X + 24, enemy_4_damaged->Y + 8)) && (canMove(enemy_4_damaged->X + 24, enemy_4_damaged->Y + 15))
				){
					 enemy_4_damaged->X++; 
				}

				if((enemy_4_damaged->X < Link->X) && (canMove(enemy_4_damaged->X - 1, enemy_4_damaged->Y)) &&
				(canMove(enemy_4_damaged->X - 1, enemy_4_damaged->Y + 8)) && (canMove(enemy_4_damaged->X - 1, enemy_4_damaged->Y + 15))
				){
					 enemy_4_damaged->X--; 
				}

				if((enemy_4_damaged->Y > Link->Y) && (canMove(enemy_4_damaged->X, enemy_4_damaged->Y + 24)) &&
				(canMove(enemy_4_damaged->X + 8, enemy_4_damaged->Y + 24)) && (canMove(enemy_4_damaged->X + 15, enemy_4_damaged->Y + 24))
				){
					 enemy_4_damaged->Y++; 
				}

				if((enemy_4_damaged->Y < Link->Y) && (canMove(enemy_4_damaged->X, enemy_4_damaged->Y - 1)) &&
				(canMove(enemy_4_damaged->X + 8, enemy_4_damaged->Y - 1)) && (canMove(enemy_4_damaged->X + 15, enemy_4_damaged->Y - 1))
				){
					 enemy_4_damaged->Y--; 
				}

				// flash enemy's Cset
				
				enemy_4_damaged->CSet++;

				// If this is the first call to this function, reduce enemy hp.
		
				if (enemy_4_damaged_counter == 10) {enemy_4_damaged->HP = enemy_4_damaged->HP - damage;}

				// Decrement enemy counter

				enemy_4_damaged_counter--;

				// Finally, return enemy to normal if time is up.	

				if(enemy_4_damaged_counter == 0){
					enemy_4_damaged->CSet = enemy_3_cset;
				}

			} // end of damage simulation for enemy 4
			
			
			Waitframe();

		} // end of while loop
	} // end of void run


	// This function returns the ID of the next FFC larger than damage_ffc_number that has a zero
	// assigned to its data field and is less than ID number 26.  Returns -1 if it cannot find one.

	int get_blank_FFC(int first_combo_number){

		int i;
		ffc current_ffc;

			for(i = first_combo_number; i <= 26; i++){
				
					current_ffc = Screen->LoadFFC(i);;
					if(current_ffc->Data==0){
						return i;
					}
			} 

			return -1;

	} // end of get_blank_FFC

} // end of ffc script

/// Ship weapons


// ================================
// Ship Gun Item (Level 1)
// This item script changes the combo
// and position of FFCs 31, 30, and 29
// to activate the general weapon script.
// The Ship Gun item will fire a blast
// in front of the player, moving upwards.
// ================================


item script Ship_Gun_Item1{

	void run (){

		int beam_animation = 394;			// Combo of the Ship Gun (Level 1) graphic

		ffc first_beam = Screen->LoadFFC(31);	// Hard-coded to use FFC 31.

		ffc second_beam = Screen->LoadFFC(30);	// Hard-coded to use FFC 30.

		ffc third_beam = Screen->LoadFFC(29);	// Hard-coded to use FFC 29.

		ship_rapid_fire = 1;				// Set rapid-fire 
		rapid_fire_delay = 4;			   // Set rapid fire delay

		if (!((first_beam->Data >= beam_animation)&&(first_beam->Data <= beam_animation+6))){
			Game->PlaySound(74);
			first_beam->X = Link->X; 
			first_beam->Y = Link->Y - 16;
			first_beam->Vy = -3;
			first_beam->Vx = 0;
			first_beam->Data = beam_animation;
		}
		else{
			if (!((second_beam->Data >= beam_animation)&&(second_beam->Data <= beam_animation+6))){

				Game->PlaySound(74);
				second_beam->X = Link->X; 
				second_beam->Y = Link->Y - 16;
				second_beam->Vy = -3;
				second_beam->Vx = 0;
				second_beam->Data = beam_animation;
			}
			else{
				if (!((third_beam->Data >= beam_animation)&&(third_beam->Data <= beam_animation+6))){

					Game->PlaySound(74);
					third_beam->X = Link->X; 
					third_beam->Y = Link->Y - 16;
					third_beam->Vy = -3;
					third_beam->Vx = 0;
					third_beam->Data = beam_animation;
				}
			}	
		} 

	} // end of void run

} // end of item script

// ================================
// Ship Gun Item (Level 2)
// This item script changes the combo
// and position of FFCs 31, 30, and 29
// to activate the general weapon script.
// The Ship Gun item will fire a blast
// in front of the player, moving upwards.
// ================================


item script Ship_Gun_Item2{

	void run (){

		int beam_animation = 476;			// Combo of the Ship Gun (Level 1) graphic

		ffc first_beam = Screen->LoadFFC(31);	// Hard-coded to use FFC 31.

		ffc second_beam = Screen->LoadFFC(30);	// Hard-coded to use FFC 30.

		ffc third_beam = Screen->LoadFFC(29);	// Hard-coded to use FFC 29.

		ship_rapid_fire = 1;				// Set rapid-fire 
		rapid_fire_delay = 3;			   // Set rapid fire delay

		if (!((first_beam->Data >= beam_animation)&&(first_beam->Data <= beam_animation+6))){
			Game->PlaySound(74);
			first_beam->X = Link->X; 
			first_beam->Y = Link->Y - 16;
			first_beam->Vy = -3;
			first_beam->Vx = 0;
			first_beam->Data = beam_animation;
		}
		else{
			if (!((second_beam->Data >= beam_animation)&&(second_beam->Data <= beam_animation+6))){

				Game->PlaySound(74);
				second_beam->X = Link->X; 
				second_beam->Y = Link->Y - 16;
				second_beam->Vy = -3;
				second_beam->Vx = 0;
				second_beam->Data = beam_animation;
			}
			else{
				if (!((third_beam->Data >= beam_animation)&&(third_beam->Data <= beam_animation+6))){

					Game->PlaySound(74);
					third_beam->X = Link->X; 
					third_beam->Y = Link->Y - 16;
					third_beam->Vy = -3;
					third_beam->Vx = 0;
					third_beam->Data = beam_animation;
				}
			}	
		} 

	} // end of void run

} // end of item script

// ================================
// Ship Gun Item (Level 3)
// This item script changes the combo
// and position of FFCs 31, 30, and 29
// to activate the general weapon script.
// The Ship Gun item will fire a blast
// in front of the player, moving upwards.
// ================================


item script Ship_Gun_Item3{

	void run (){

		int beam_animation = 477;			// Combo of the Ship Gun (Level 1) graphic

		ffc first_beam = Screen->LoadFFC(31);	// Hard-coded to use FFC 31.

		ffc second_beam = Screen->LoadFFC(30);	// Hard-coded to use FFC 30.

		ffc third_beam = Screen->LoadFFC(29);	// Hard-coded to use FFC 29.

		ship_rapid_fire = 1;				// Set rapid-fire 
		rapid_fire_delay = 2;			   // Set rapid fire delay

		if (!((first_beam->Data >= beam_animation)&&(first_beam->Data <= beam_animation+6))){
			Game->PlaySound(74);
			first_beam->X = Link->X; 
			first_beam->Y = Link->Y - 16;
			first_beam->Vy = -4;
			first_beam->Vx = 0;
			first_beam->Data = beam_animation;
		}
		else{
			if (!((second_beam->Data >= beam_animation)&&(second_beam->Data <= beam_animation+6))){

				Game->PlaySound(74);
				second_beam->X = Link->X; 
				second_beam->Y = Link->Y - 16;
				second_beam->Vy = -4;
				second_beam->Vx = 0;
				second_beam->Data = beam_animation;
			}
			else{
				if (!((third_beam->Data >= beam_animation)&&(third_beam->Data <= beam_animation+6))){

					Game->PlaySound(74);
					third_beam->X = Link->X; 
					third_beam->Y = Link->Y - 16;
					third_beam->Vy = -4;
					third_beam->Vx = 0;
					third_beam->Data = beam_animation;
				}
			}	
		} 

	} // end of void run

} // end of item script

// ================================
// Ship Gun Item (Level 4)
// This item script changes the combo
// and position of FFCs 31, 30, and 29
// to activate the general weapon script.
// The Ship Gun item will fire a blast
// in front of the player, moving upwards.
// ================================


item script Ship_Gun_Item4{

	void run (){

		int beam_animation = 503;			// Combo of the Ship Gun (Level 1) graphic

		ffc first_beam = Screen->LoadFFC(31);	// Hard-coded to use FFC 31.

		ffc second_beam = Screen->LoadFFC(30);	// Hard-coded to use FFC 30.

		ffc third_beam = Screen->LoadFFC(29);	// Hard-coded to use FFC 29.

		ship_rapid_fire = 1;				// Set rapid-fire 
		rapid_fire_delay = 2;			   // Set rapid fire delay

		if (!((first_beam->Data >= beam_animation)&&(first_beam->Data <= beam_animation+6))){
			Game->PlaySound(74);
			first_beam->X = Link->X; 
			first_beam->Y = Link->Y - 16;
			first_beam->Vy = -4;
			first_beam->Vx = 0;
			first_beam->Data = beam_animation;
		}
		else{
			if (!((second_beam->Data >= beam_animation)&&(second_beam->Data <= beam_animation+6))){

				Game->PlaySound(74);
				second_beam->X = Link->X; 
				second_beam->Y = Link->Y - 16;
				second_beam->Vy = -4;
				second_beam->Vx = 0;
				second_beam->Data = beam_animation;
			}
			else{
				if (!((third_beam->Data >= beam_animation)&&(third_beam->Data <= beam_animation+6))){

					Game->PlaySound(74);
					third_beam->X = Link->X; 
					third_beam->Y = Link->Y - 16;
					third_beam->Vy = -4;
					third_beam->Vx = 0;
					third_beam->Data = beam_animation;
				}
			}	
		} 

	} // end of void run

} // end of item script

// ================================
// Ship Gun Item (Level 5)
// This item script changes the combo
// and position of FFCs 31, 30, and 29
// to activate the general weapon script.
// The Ship Gun item will fire a blast
// in front of the player, moving upwards.
// ================================


item script Ship_Gun_Item5{

	void run (){

		int beam_animation = 507;			// Combo of the Ship Gun (Level 1) graphic

		ffc first_beam = Screen->LoadFFC(31);	// Hard-coded to use FFC 31.

		ffc second_beam = Screen->LoadFFC(30);	// Hard-coded to use FFC 30.

		ffc third_beam = Screen->LoadFFC(29);	// Hard-coded to use FFC 29.

		ship_rapid_fire = 1;				// Set rapid-fire 
		rapid_fire_delay = 1;			   // Set rapid fire delay

		if (!((first_beam->Data >= beam_animation)&&(first_beam->Data <= beam_animation+6))){
			Game->PlaySound(74);
			first_beam->X = Link->X; 
			first_beam->Y = Link->Y - 16;
			first_beam->Vy = -5;
			first_beam->Vx = 0;
			first_beam->Data = beam_animation;
		}
		else{
			if (!((second_beam->Data >= beam_animation)&&(second_beam->Data <= beam_animation+6))){

				Game->PlaySound(74);
				second_beam->X = Link->X; 
				second_beam->Y = Link->Y - 16;
				second_beam->Vy = -5;
				second_beam->Vx = 0;
				second_beam->Data = beam_animation;
			}
			else{
				if (!((third_beam->Data >= beam_animation)&&(third_beam->Data <= beam_animation+6))){

					Game->PlaySound(74);
					third_beam->X = Link->X; 
					third_beam->Y = Link->Y - 16;
					third_beam->Vy = -5;
					third_beam->Vx = 0;
					third_beam->Data = beam_animation;
				}
			}	
		} 

	} // end of void run

} // end of item script



//Other item scripts, for weapons


// STUN BEAM SCRIPT
// -----------------
// This script codes the Stun beam.  It will
// continue to move in the direction fired until it
// impacts a solid surface or an enemy.
// Then, it will explode into a jazzy electrical field 
// for a short period of time.  Some enemies 
// will be stunned by field.
// Stun field also hatches Spacefish eggs.
//------------------

// Item script

item script stun_beam2_item{

	void run(){

		if((get_blank_FFC()>0)&&(Link->MP>10)){

			Link->MP = Link->MP - 10;
			Game->PlaySound(108);

			ffc stun_beam = Screen->LoadFFC(get_blank_FFC());
			if(Link->Dir == 0){
				stun_beam->X = Link->X;
				stun_beam->Y = Link->Y-8;
				stun_beam->Script = 212;
				stun_beam->Vy = -4;
				stun_beam->Vx = 0;
				stun_beam->Data = 1;
			}

			if(Link->Dir == 1){
				stun_beam->X = Link->X;
				stun_beam->Y = Link->Y+8;
				stun_beam->Script = 212;
				stun_beam->Vy = 4;
				stun_beam->Vx = 0;
				stun_beam->Data = 1;
			}

			if(Link->Dir == 2){
				stun_beam->X = Link->X-8;
				stun_beam->Y = Link->Y;
				stun_beam->Script = 212;
				stun_beam->Vy = 0;
				stun_beam->Vx = -4;
				stun_beam->Data = 1;
			}

			if(Link->Dir == 3){
				stun_beam->X = Link->X+8;
				stun_beam->Y = Link->Y;
				stun_beam->Script = 212;
				stun_beam->Vy = 0;
				stun_beam->Vx = 4;
				stun_beam->Data = 1;
			}

		}

	} // end run

	// This function returns the ID of the next FFC larger than damage_ffc_number that has a zero
	// assigned to its data field and is between 1 and 15.  Returns -1 if it cannot find one.

	int get_blank_FFC(){

		int i = 7;
		ffc current_ffc;

			for(i = 1; i <= 15; i++){
				
					current_ffc = Screen->LoadFFC(i);
					if(current_ffc->Data==0){
						return i;
					}
			} 

			return -1;

	} // end of get_blank_FFC

} // end of item

// FFC Script

ffc script stun_beam2{

	void run(){

		int dir;
		if(this->Vy<0){dir=0;}
		if(this->Vy>0){dir=1;}
		if(this->Vx<0){dir=2;}
		if(this->Vx>0){dir=3;}
		
		bool impact = false;

		npc current_npc;
		ffc current_ffc;

		int i;
		int j;

		int delay_counter = 0;
		int anim_counter = 0;

		bool stunned_something = false;

		while(!impact){

			delay_counter++;
			if(delay_counter>4){
				anim_counter++;
				if(anim_counter>3){anim_counter=0;}
			}

			// draw projectile
			if(dir==0){Screen->DrawTile(3,this->X,this->Y,49144+anim_counter,1,1,6,-1,-1,0,0,0,2,true,128);}
			if(dir==1){Screen->DrawTile(3,this->X,this->Y,49144+anim_counter,1,1,6,-1,-1,0,0,0,0,true,128);}
			if(dir==2){Screen->DrawTile(3,this->X,this->Y,49140+anim_counter,1,1,6,-1,-1,0,0,0,1,true,128);}
			if(dir==3){Screen->DrawTile(3,this->X,this->Y,49140+anim_counter,1,1,6,-1,-1,0,0,0,0,true,128);}

			// check for impact on solid surface
			if(!canMove(this->X+8,this->Y+8)){impact = true;}
			
			// check for impact on enemies
			for(i = 0; i <= Screen->NumNPCs(); i++){

				current_npc = Screen->LoadNPC(i);

				if(	(Abs(this->X-current_npc->X)<8)
					&& (Abs(this->Y-current_npc->Y)<8)
				){
					impact = true;
					current_npc->Stun=70;
				}
			}// end for

			Waitframe();
		} // end of traveling loop

		this->Vx = 0;
		this->Vy = 0;
		this->Ay = 0;
		this->Ax = 0;
		anim_counter = 0;
		delay_counter = 0;
	
		// Combo 7 is set aside for the use of the Stun Beam only!
		this->Data = 7;

		for(j=0;j<=50;j++){

			delay_counter++;
			if(delay_counter>3){
				delay_counter = 0;
				anim_counter++;
				if(anim_counter>5){anim_counter=0;}
				Game->PlaySound(98);
			}	
	
			Screen->DrawTile(3,this->X-8,this->Y-8,49160+(anim_counter*2),2,2,6,-1,-1,0,0,0,0,true,128);

			//Break open spacefish eggs
			
				// Middle of explosion
				if(Screen->ComboD[ComboAt(this->X+8,this->Y+8)] == 1044){
						Screen->ComboD[ComboAt(this->X+8,this->Y+8)] = 562;
				}
				// Top left corner
				if(Screen->ComboD[ComboAt(this->X,this->Y)] == 1044){
						Screen->ComboD[ComboAt(this->X,this->Y)] = 562;
				}
				// Top right corner
				if(Screen->ComboD[ComboAt(this->X+15,this->Y)] == 1044){
						Screen->ComboD[ComboAt(this->X,this->Y)] = 562;
				}
				// Bottom left corner
				if(Screen->ComboD[ComboAt(this->X,this->Y+15)] == 1044){
						Screen->ComboD[ComboAt(this->X,this->Y)] = 562;
				}
				// Bottom right corner
				if(Screen->ComboD[ComboAt(this->X+15,this->Y+15)] == 1044){
						Screen->ComboD[ComboAt(this->X,this->Y)] = 562;
				}
				
			Waitframe();

		} // end of stunned loop

		this->Data = 0;
		
	} // end of void run

} // end ffc script



