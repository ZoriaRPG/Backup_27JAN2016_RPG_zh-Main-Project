//Enemy Script File

//import "std.zh"
//import "string.zh"
//import "ghost.zh"
//import "tango.zh"

float SafeSqrt(float val)
{
	if ( val > MAX_CONSTANT ) val = MAX_CONSTANT;
	if ( val > 0 && val <= MAX_CONSTANT ) return Sqrt(val);
	if ( val < 0 ) return -32678;
	return 0;
}

ffc script Patra
{
	
	void run(int enemyID)
	{
		
		npc ghost = Ghost_InitAutoGhost(this, enemyID);
		Ghost_Transform(this, ghost, 991, 10, 2, 2);
		Ghost_SetFlag(GHF_IGNORE_ALL_TERRAIN);
		
		npc n1 = Screen->CreateNPC(184);
		npc n2 = Screen->CreateNPC(184);
		npc n3 = Screen->CreateNPC(184);
		npc n4 = Screen->CreateNPC(184);
		
		npc p1 = Screen->CreateNPC(185);
		npc p2 = Screen->CreateNPC(185);
		npc p3 = Screen->CreateNPC(185);
		npc p4 = Screen->CreateNPC(185);
		
		npc p5 = Screen->CreateNPC(185);
		npc p6 = Screen->CreateNPC(185);
		npc p7 = Screen->CreateNPC(185);
		npc p8 = Screen->CreateNPC(185);
		
		npc p9 = Screen->CreateNPC(185);
		npc p10 = Screen->CreateNPC(185);
		npc p11 = Screen->CreateNPC(185);
		npc p12 = Screen->CreateNPC(185);
		
		npc p13 = Screen->CreateNPC(185);
		npc p14 = Screen->CreateNPC(185);
		npc p15 = Screen->CreateNPC(185);
		npc p16 = Screen->CreateNPC(185);
		
		int NX[4];
		int NY[4];
		int NA[4];
		
		int Rotate = 0; 
		int Phase = 0;
		int AimX = 0;
		int AimY = 0;
		int Cooldown = 0;
		int Spin = 24;
		int Spinner = 300;
		int Spintype = 0;
		int SpinDelay = 2;
		eweapon Dummy = FireEWeapon(EW_ARROW, 1, 1, 0, 0, 0, 90, 0, EWF_NO_COLLISION|EWF_UNBLOCKABLE);
		
		while(true)
		{
			Dummy->DeadState = -1;
			if (!Dummy->isValid())
			{
				eweapon Dummy = FireEWeapon(EW_ARROW, 1, 1, 0, 0, 0, 90, 0, EWF_NO_COLLISION|EWF_UNBLOCKABLE);
				Dummy->UseSprite(90);
			}
			Dummy->UseSprite(90);
			Ghost_MoveTowardLink(0.375, 4);
			NX[0] = Ghost_X + 8 + Spin*Cos(Rotate*2);
			NY[0] = Ghost_Y + 8 + (48 - Spin)*Sin(Rotate*2);
			NX[1] = Ghost_X + 8 + Spin*Cos((Rotate*2) + 90);
			NY[1] = Ghost_Y + 8 + (48 - Spin)*Sin((Rotate*2) + 90);
			NX[2] = Ghost_X + 8 + Spin*Cos((Rotate*2) + 180);
			NY[2] = Ghost_Y + 8 + (48 - Spin)*Sin((Rotate*2) + 180);
			NX[3] = Ghost_X + 8 + Spin*Cos((Rotate*2) + 270);
			NY[3] = Ghost_Y + 8 + (48 - Spin)*Sin((Rotate*2) + 270);
			
			if (Phase == 0)
			{
				if (Spinner <=0)
				{
					if (SpinDelay <= 0)
					{
						if (Spintype == 0)
						{
							Spin++;
							if (Spin >= 42)
							{
								Spintype = 1;
							}
						}
						else if (Spintype == 1)
						{
							Spin--;
							if (Spin <= 8)
							{
								Spintype = 2;
							}
						}
						else if (Spintype == 2)
						{
							if (Spin > 24)
							{
								Spin--;
							}
							else if (Spin < 24)
							{
								Spin++;
							}
							else if (Spin == 24)
							{
								Spintype = 0;
								Spinner = 300;
							}
						}
						SpinDelay = 2;
					}
					else
					{
						SpinDelay--;
					}
				}
				else
				{
					Spinner--;
					Spin = 24;
				}
				if (p1->isValid())p1->X = n1->X + 12*Cos((Rotate*-3) + 45);
				if (p1->isValid())p1->Y = n1->Y + 12*Sin((Rotate*-3) + 45);
				if (p2->isValid())p2->X = n1->X + 12*Cos((Rotate*-3) + 135);
				if (p2->isValid())p2->Y = n1->Y + 12*Sin((Rotate*-3) + 135);
				if (p3->isValid())p3->X = n1->X + 12*Cos((Rotate*-3) + 225);
				if (p3->isValid())p3->Y = n1->Y + 12*Sin((Rotate*-3) + 225);
				if (p4->isValid())p4->X = n1->X + 12*Cos((Rotate*-3) + 315);
				if (p4->isValid())p4->Y = n1->Y + 12*Sin((Rotate*-3) + 315);
				
				if (p5->isValid())p5->X = n2->X + 12*Cos((Rotate*-3) + 45);
				if (p5->isValid())p5->Y = n2->Y + 12*Sin((Rotate*-3) + 45);
				if (p6->isValid())p6->X = n2->X + 12*Cos((Rotate*-3) + 135);
				if (p6->isValid())p6->Y = n2->Y + 12*Sin((Rotate*-3) + 135);
				if (p7->isValid())p7->X = n2->X + 12*Cos((Rotate*-3) + 225);
				if (p7->isValid())p7->Y = n2->Y + 12*Sin((Rotate*-3) + 225);
				if (p8->isValid())p8->X = n2->X + 12*Cos((Rotate*-3) + 315);
				if (p8->isValid())p8->Y = n2->Y + 12*Sin((Rotate*-3) + 315);
				
				p9->X = n3->X + 12*Cos((Rotate*-3) + 45);
				p9->Y = n3->Y + 12*Sin((Rotate*-3) + 45);
				p10->X = n3->X + 12*Cos((Rotate*-3) + 135);
				p10->Y = n3->Y + 12*Sin((Rotate*-3) + 135);
				p11->X = n3->X + 12*Cos((Rotate*-3) + 225);
				p11->Y = n3->Y + 12*Sin((Rotate*-3) + 225);
				p12->X = n3->X + 12*Cos((Rotate*-3) + 315);
				p12->Y = n3->Y + 12*Sin((Rotate*-3) + 315);
				
				p13->X = n4->X + 12*Cos((Rotate*-3) + 45);
				p13->Y = n4->Y + 12*Sin((Rotate*-3) + 45);
				p14->X = n4->X + 12*Cos((Rotate*-3) + 135);
				p14->Y = n4->Y + 12*Sin((Rotate*-3) + 135);
				p15->X = n4->X + 12*Cos((Rotate*-3) + 225);
				p15->Y = n4->Y + 12*Sin((Rotate*-3) + 225);
				p16->X = n4->X + 12*Cos((Rotate*-3) + 315);
				p16->Y = n4->Y + 12*Sin((Rotate*-3) + 315);
			}
			
			if (NA[0] == 0)
			{
				n1->X = NX[0];
				n1->Y = NY[0];
				n1->Defense[NPCD_BRANG] = NPCDT_BLOCK;
				n1->Defense[NPCD_SCRIPT] = NPCDT_BLOCK;
			}
			if (NA[1] == 0)
			{
				n2->X = NX[1];
				n2->Y = NY[1];
				n2->Defense[NPCD_BRANG] = NPCDT_BLOCK;
				n2->Defense[NPCD_SCRIPT] = NPCDT_BLOCK;
			}
			if (NA[2] == 0)
			{
				n3->X = NX[2];
				n3->Y = NY[2];
				n3->Defense[NPCD_BRANG] = NPCDT_BLOCK;
				n3->Defense[NPCD_SCRIPT] = NPCDT_BLOCK;
			}
			if (NA[3] == 0)
			{
				n4->X = NX[3];
				n4->Y = NY[3];
				n4->Defense[NPCD_BRANG] = NPCDT_BLOCK;
				n4->Defense[NPCD_SCRIPT] = NPCDT_BLOCK;
			}
			if (!n1->isValid())
			{
				NA[0] = 0;
			}
			if (!n2->isValid())
			{
				NA[1] = 0;
			}
			if (!n3->isValid())
			{
				NA[2] = 0;
			}
			if (!n4->isValid())
			{
				NA[3] = 0;
			}
			if (n1->X > 255 || n1->X < 0 || n1->Y > 175 || n1->Y < 0)
			{
				NA[0] = 0;
			}
			if (n2->X > 255 || n2->X < 0 || n2->Y > 175 || n2->Y < 0)
			{
				NA[1] = 0;
			}
			if (n3->X > 255 || n3->X < 0 || n3->Y > 175 || n3->Y < 0)
			{
				NA[2] = 0;
			}
			if (n4->X > 255 || n4->X < 0 || n4->Y > 175 || n4->Y < 0)
			{
				NA[3] = 0;
			}
			Rotate %= 360;
			Rotate++;
			if (!p1->isValid() && !p2->isValid() && !p3->isValid() && !p4->isValid() 
			&& !p5->isValid() && !p6->isValid() && !p7->isValid() && !p8->isValid() 
			&& !p9->isValid() && !p10->isValid() && !p11->isValid() && !p12->isValid() 
			&& !p13->isValid() && !p14->isValid() && !p15->isValid() && !p16->isValid() 
			&& Phase == 0)
			{
			   Phase = 1;
			}
			if (!n1->isValid() && !n2->isValid() && !n3->isValid() && !n4->isValid()
			&& Phase < 2)
			{
			   Phase = 2;
			}
			if (Phase == 1)
			{
				Spin = 24;
				if (n1->Stun > 0)
				{
					Dummy->Step = 0;
					n1->Defense[NPCD_BRANG] = NPCDT_BLOCK;
					n1->Defense[NPCD_SCRIPT] = NPCDT_NONE;
				}
				else if (n2->Stun > 0)
				{
					Dummy->Step = 0;
					n2->Defense[NPCD_BRANG] = NPCDT_BLOCK;
					n2->Defense[NPCD_SCRIPT] = NPCDT_NONE;
				}
				else if (n3->Stun > 0)
				{
					Dummy->Step = 0;
					n3->Defense[NPCD_BRANG] = NPCDT_BLOCK;
					n3->Defense[NPCD_SCRIPT] = NPCDT_NONE;
				}
				else if (n4->Stun > 0)
				{
					Dummy->Step = 0;
					n4->Defense[NPCD_BRANG] = NPCDT_BLOCK;
					n4->Defense[NPCD_SCRIPT] = NPCDT_NONE;
				}
				else
				{
					if (NA[0] == 0 && NA[1] == 0 && NA[2] == 0 && NA[3] == 0)
					{
						Dummy->Step = 0;
						Dummy->Angle = 0;
						if (Cooldown >= 120)
						{
							int Meh = Rand(4);
							if (Meh == 0 && n1->isValid())
							{
								NA[0] = 1;
								Cooldown = 0;
								Dummy->X = n1->X;
								Dummy->Y = n1->Y;
								Dummy->Step = 175;
								Dummy->Angle = RadianAngle(n1->X, n1->Y, AimX, AimY);
							}
							else if (Meh == 1 && n2->isValid())
							{
								NA[1] = 1;
								Cooldown = 0;
								Dummy->X = n2->X;
								Dummy->Y = n2->Y;
								Dummy->Step = 175;
								Dummy->Angle = RadianAngle(n2->X, n2->Y, AimX, AimY);
							}
							else if (Meh == 2 && n3->isValid())
							{
								NA[2] = 1;
								Cooldown = 0;
								Dummy->X = n3->X;
								Dummy->Y = n3->Y;
								Dummy->Step = 175;
								Dummy->Angle = RadianAngle(n3->X, n3->Y, AimX, AimY);
							}
							else if (Meh == 3 && n4->isValid())
							{
								NA[3] = 1;
								Cooldown = 0;
								Dummy->X = n4->X;
								Dummy->Y = n4->Y;
								Dummy->Step = 175;
								Dummy->Angle = RadianAngle(n4->X, n4->Y, AimX, AimY);
							}
							AimX = Link->X;
							AimY = Link->Y;
						}
						else
						{
							Cooldown++;
						}
					}
					else if (NA[0] == 1)
					{
						n1->X = Dummy->X;
						n1->Y = Dummy->Y;
						n1->Defense[NPCD_BRANG] = NPCDT_STUN;
						Screen->FastCombo(3, n1->X, n1->Y, 219, 7, OP_OPAQUE);
						int angle = RadianAngle(n1->X, n1->Y, AimX, AimY);
						Dummy->Angle = angle;
						Dummy->Step = 175;
						if (Abs(AimX - n1->X) < 4 && Abs(AimY - n1->Y) < 4)
						{
							NA[0] = 2;
						}
						//int Hey[] = "1";
						//Screen->DrawString(7, 25, 25, 1, 15, 1, 0, Hey, OP_OPAQUE);
					}
					else if (NA[1] == 1)
					{
						n2->X = Dummy->X;
						n2->Y = Dummy->Y;
						n2->Defense[NPCD_BRANG] = NPCDT_STUN;
						Screen->FastCombo(3, n2->X, n2->Y, 219, 7, OP_OPAQUE);
						int angle = RadianAngle(n2->X, n2->Y, AimX, AimY);
						Dummy->Angle = angle;
						Dummy->Step = 175;
						if (Abs(AimX - n2->X) < 4 && Abs(AimY - n2->Y) < 4)
						{
							NA[1] = 2;
						}
						//int Hey[] = "2";
						//Screen->DrawString(7, 25, 25, 1, 15, 1, 0, Hey, OP_OPAQUE);
					}
					else if (NA[2] == 1)
					{
						n3->X = Dummy->X;
						n3->Y = Dummy->Y;
						n3->Defense[NPCD_BRANG] = NPCDT_STUN;
						Screen->FastCombo(3, n3->X, n3->Y, 219, 7, OP_OPAQUE);
						int angle = RadianAngle(n3->X, n3->Y, AimX, AimY);
						Dummy->Angle = angle;
						Dummy->Step = 175;
						if (Abs(AimX - n3->X) < 4 && Abs(AimY - n3->Y) < 4)
						{
							NA[2] = 2;
						}
						//int Hey[] = "3";
						//Screen->DrawString(7, 25, 25, 1, 15, 1, 0, Hey, OP_OPAQUE);
					}
					else if (NA[3] == 1)
					{
						n4->X = Dummy->X;
						n4->Y = Dummy->Y;
						n4->Defense[NPCD_BRANG] = NPCDT_STUN;
						Screen->FastCombo(3, n4->X, n4->Y, 219, 7, OP_OPAQUE);
						int angle = RadianAngle(n4->X, n4->Y, AimX, AimY);
						Dummy->Angle = angle;
						Dummy->Step = 175;
						if (Abs(AimX - n4->X) < 4 && Abs(AimY - n4->Y) < 4)
						{
							NA[3] = 2;
						}
						//int Hey[] = "4";
						//Screen->DrawString(7, 25, 25, 1, 15, 1, 0, Hey, OP_OPAQUE);
					}
					else if (NA[0] == 2)
					{
						n1->X = Dummy->X;
						n1->Y = Dummy->Y;
						n1->Defense[NPCD_BRANG] = NPCDT_STUN;
						Screen->FastCombo(3, n1->X, n1->Y, 219, 7, OP_OPAQUE);
						int angle = RadianAngle(n1->X, n1->Y, NX[0], NY[0]);
						Dummy->Angle = angle;
						Dummy->Step = 175;
						if (Abs(NX[0] - n1->X) < 4 && Abs(NY[0] - n1->Y) < 4)
						{
							NA[0] = 0;
						}
						//int Hey[] = "5";
						//Screen->DrawString(7, 25, 25, 1, 15, 1, 0, Hey, OP_OPAQUE);
					}
					else if (NA[1] == 2)
					{
						n2->X = Dummy->X;
						n2->Y = Dummy->Y;
						n2->Defense[NPCD_BRANG] = NPCDT_STUN;
						Screen->FastCombo(3, n2->X, n2->Y, 219, 7, OP_OPAQUE);
						int angle = RadianAngle(n2->X, n2->Y, NX[1], NY[1]);
						Dummy->Angle = angle;
						Dummy->Step = 175;
						if (Abs(NX[1] - n2->X) < 4 && Abs(NY[1] - n2->Y) < 4)
						{
							NA[1] = 0;
						}
						//int Hey[] = "6";
						//Screen->DrawString(7, 25, 25, 1, 15, 1, 0, Hey, OP_OPAQUE);
					}
					else if (NA[2] == 2)
					{
						n3->X = Dummy->X;
						n3->Y = Dummy->Y;
						n3->Defense[NPCD_BRANG] = NPCDT_STUN;
						Screen->FastCombo(3, n3->X, n3->Y, 219, 7, OP_OPAQUE);
						int angle = RadianAngle(n3->X, n3->Y, NX[2], NY[2]);
						Dummy->Angle = angle;
						Dummy->Step = 175;
						if (Abs(NX[2] - n3->X) < 4 && Abs(NY[2] - n3->Y) < 4)
						{
							NA[2] = 0;
						}
						//int Hey[] = "7";
						//Screen->DrawString(7, 25, 25, 1, 15, 1, 0, Hey, OP_OPAQUE);
					}
					else if (NA[3] == 2)
					{
						n4->X = Dummy->X;
						n4->Y = Dummy->Y;
						n4->Defense[NPCD_BRANG] = NPCDT_STUN;
						Screen->FastCombo(3, n4->X, n4->Y, 219, 7, OP_OPAQUE);
						int angle = RadianAngle(n4->X, n4->Y, NX[3], NY[3]);
						Dummy->Angle = angle;
						Dummy->Step = 175;
						if (Abs(NX[3] - n4->X) < 4 && Abs(NY[3] - n4->Y) < 4)
						{
							NA[3] = 0;
						}
						//int Hey[] = "8";
						//Screen->DrawString(7, 25, 25, 1, 15, 1, 0, Hey, OP_OPAQUE);
					}
				}
			}
			if (Phase == 2)
			{
				Ghost_SetAllDefenses(ghost, NPCDT_NONE);
				ghost->Defense[0] = 13;
				if (Cooldown >= 240)
				{
					eweapon L1 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(0), 150, 3, -1, -1, 0);
					eweapon L2 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(30), 150, 3, -1, -1, 0);
					eweapon L3 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(60), 150, 3, -1, -1, 0);
					eweapon L4 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(90), 150, 3, -1, -1, 0);
					eweapon L5 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(120), 150, 3, -1, -1, 0);
					eweapon L6 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(150), 150, 3, -1, -1, 0);
					eweapon L7 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(180), 150, 3, -1, -1, 0);
					eweapon L8 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(210), 150, 3, -1, -1, 0);
					eweapon L9 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(240), 150, 3, -1, -1, 0);
					eweapon L10 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(270), 150, 3, -1, -1, 0);
					eweapon L11 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(300), 150, 3, -1, -1, 0);
					eweapon L12 = FireEWeapon(EW_FIREBALL, Ghost_X, Ghost_Y, DegtoRad(330), 150, 3, -1, -1, 0);
					SetEWeaponMovement(L1, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L2, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L3, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L4, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L5, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L6, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L7, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L8, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L9, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L10, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L11, EWM_HOMING, 0.025, 45);
					SetEWeaponMovement(L12, EWM_HOMING, 0.025, 45);
					Cooldown = 0;
				}
				else
				{
					Cooldown++;
				}
			}
			if (Ghost_HP <= 0)
			{
				Ghost_HP = 1;
				Ghost_SetAllDefenses(ghost, NPCDT_IGNORE);
				Ghost_DeathAnimation(this, ghost, 2);
			}
			Ghost_Waitframe(this, ghost, false, false);
		}
	}
}
