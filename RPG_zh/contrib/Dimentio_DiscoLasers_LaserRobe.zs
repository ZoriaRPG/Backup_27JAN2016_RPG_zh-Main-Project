import "std.zh"
import "string.zh"
import "ghost.zh"
import "laser.zh"
import "stdExtra.zh"

float angleDifference(float angle1, float angle2)
{
	// Get the difference between the two angles
	float dif = angle2 - angle1;
	
	// Compensate for the difference being outside of normal bounds
	if(dif >= PI)
		dif -= 2 * PI;
	else if(dif <= -1 * PI)
		dif += 2 * PI;
		
	return dif;
}

ffc script DiscoRobe{
	void run(int enemyid){
		npc ghost = Ghost_InitAutoGhost(this, enemyid);
		Ghost_SetFlag(GHF_SET_DIRECTION);
		Ghost_SetFlag(GHF_4WAY);
		bool Attack = false;
		bool Phase = false;
		int tics = 0;
		int Counter = -1;
		int Store[18];
		int DISCO_COMBO = Ghost_Data;
		while(true){
			if (Attack == false && Phase == false)
			{
				Counter = Ghost_ConstantWalk4(Counter, ghost->Step, ghost->Rate, ghost->Homing, ghost->Hunger);
				int Rander = Rand(20);
				if (Rander == 1 && Ghost_X % 16 == 0 && Ghost_X % 16 == 0)
				{
					bool Direction[4];
					if (Ghost_X > 48 && Ghost_X > 48)
					{
						Direction[0] = true;
					}
					if (Ghost_X < 48 && Ghost_X > 48)
					{
						Direction[0] = true;
					}
				}
				if (tics < 180)
				{
					tics++;
				}
				else
				{
					int Meh = Rand(2);
					if (Meh == 0)
					{
						Attack = true;
					}
					else if (Meh == 1)
					{
						Phase = true;
					}
				}
			}
			else if (Attack == true)
			{
				Ghost_StoreDefenses(ghost, Store);
				Ghost_SetAllDefenses(ghost, NPCDT_IGNORE);
				for (int i = 60; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
					}
					M1 %= 360;
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M1, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M1, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M1, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M2, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M2, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M2, 232);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M3, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M3, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M3, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M4, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M4, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M4, 232);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M5, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M5, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M5, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M4, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M5, ghost->WeaponDamage, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M6, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M6, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M6, 232);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M7, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M7, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M7, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M4, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M5, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M8, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M8, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M8, 232);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M7, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M7, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M7, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M8, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M8, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M8, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M8, 232);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M7, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M7, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M7, 232);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 30; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M8, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M6, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M6, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M6, 232);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M7, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M7, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M7, 232);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M8, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M6, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M6, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M6, 232);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M7, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M7, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M7, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M4, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M5, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M8, ghost->WeaponDamage, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M4, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M4, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M4, 232);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M5, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M5, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M5, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M4, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M5, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M8, ghost->WeaponDamage, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M2, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M2, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M2, 232);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M3, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M3, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M3, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M4, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M5, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M8, ghost->WeaponDamage, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M1, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M1, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M1, 232);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M3, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M3, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M3, 232);
					Ghost_Waitframe(this, ghost);
				}
				Game->PlaySound(37);
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M4, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M5, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M8, ghost->WeaponDamage, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M1, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M1, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M1, 232);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M3, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M3, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M3, 232);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 15; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					int M2 = dirToDeg(Ghost_Dir) + 45;
					int M3 = dirToDeg(Ghost_Dir) - 45;
					int M4 = dirToDeg(Ghost_Dir) + 90;
					int M5 = dirToDeg(Ghost_Dir) - 90;
					int M6 = dirToDeg(Ghost_Dir) - 135;
					int M7 = dirToDeg(Ghost_Dir) + 135;
					int M8 = dirToDeg(Ghost_Dir) - 180;
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
						M2 += 180;
						M3 += 180;
						M4 += 180;
						M5 += 180;
						M6 += 180;
						M7 += 180;
						M8 += 180;
					}
					M1 %= 360;
					M2 %= 360;
					M3 %= 360;
					M4 %= 360;
					M5 %= 360;
					M6 %= 360;
					M7 %= 360;
					M8 %= 360;
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M3, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M4, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M5, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M6, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M7, ghost->WeaponDamage, 230);
					//Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M8, ghost->WeaponDamage, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M1, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M1, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M1, 232);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M3, 230);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M3, 231);
					//DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M3, 232);
					Ghost_Waitframe(this, ghost);
				}
				Ghost_Data = DISCO_COMBO + 4;
				ghost->CollDetection = false;
				for (int i = 0; i < 30; i++)
				{
					int MehX = i / 4;
					int MehY = i / 2;
					Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 10; i > 0; i--)
				{
					int MehX = (i * 3) / 4;
					int MehY = (i * 3) / 2;
					Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 0; i < 60; i++)
				{
					int MehX = i * 4;
					int MehY = i / 4;
					Screen->DrawCombo(3, Ghost_X - (MehX / 2), Ghost_Y + MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 + MehX, 16 - MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				int MehC = FindSpawnPoint(true, false, true, true);
				Ghost_X = ComboX(MehC);
				Ghost_Y = ComboY(MehC);
				for (int i = 60; i > 0; i--)
				{
					int MehX = i * 4;
					int MehY = i / 4;
					Screen->DrawCombo(3, Ghost_X - (MehX / 2), Ghost_Y + MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 + MehX, 16 - MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 0; i < 10; i++)
				{
					int MehX = (i * 3) / 4;
					int MehY = (i * 3) / 2;
					Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 30; i > 0; i--)
				{
					int MehX = i / 4;
					int MehY = i / 2;
					Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				ghost->CollDetection = true;
				Ghost_Data = DISCO_COMBO;
				Ghost_SetDefenses(ghost, Store);
				tics = 0;
				Attack = false;
			}
			else if (Phase == true)
			{
				Ghost_StoreDefenses(ghost, Store);
				Ghost_SetAllDefenses(ghost, NPCDT_IGNORE);
				Ghost_UnsetFlag(GHF_4WAY);
				for (int i = 0; i < 30; i++)
				{
					Ghost_Data = DISCO_COMBO + (i % 4);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 0; i < 240; i++)
				{
					Ghost_Data = DISCO_COMBO + (i % 4);
					if (Link->X > Ghost_X)
					{
						Ghost_Ax=0.030;
						if (Ghost_Vx > 4) Ghost_Vx = 4;
					}
					else if (Link->X < Ghost_X)
					{
						Ghost_Ax=-0.030;
						if (Ghost_Vx < -4) Ghost_Vx = -4;
					}
					if (Link->Y > Ghost_Y)
					{
						Ghost_Ay=0.030;
						if (Ghost_Vy > 4) Ghost_Vy = 4;
					}
					else if (Link->Y < Ghost_Y)
					{
						Ghost_Ay=-0.020;
						if (Ghost_Vy < -4) Ghost_Vy = -4;
					}
					Ghost_Waitframe(this, ghost);
				}
				Ghost_UnsetFlag(GHF_SET_DIRECTION);
				Ghost_SetFlag(GHF_4WAY);
				Ghost_Data = DISCO_COMBO;
				Ghost_Dir = AngleDir4(WrapDegrees(Angle(Ghost_X, Ghost_Y, Link->X, Link->Y)));
				int Mangle = Angle(Ghost_X, Ghost_Y, Link->X, Link->Y);
				Ghost_Ax = 0;
				Ghost_Ay = 0;
				Ghost_Vx = 0;
				Ghost_Vy = 0;
				for (int i = 0; i < 45; i++)
				{
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, Mangle, 230);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, Mangle, 231);
					DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, Mangle, 232);
					Ghost_Waitframe(this, ghost);
				}
				bool Increase = true;
				int Adder = 0;
				for (int i = 0; i < 120; i++)
				{
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, Mangle, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, (Mangle + Adder) % 360, ghost->WeaponDamage, 230);
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, (Mangle - Adder) % 360, ghost->WeaponDamage, 230);
					if (Increase)
					{
						Adder++;
						if (Adder >= 45)
						{
							Increase = false;
						}
					}
					else
					{
						Adder--;
						if (Adder <= 0)
						{
							Increase = true;
						}
					}
					Ghost_Waitframe(this, ghost);
				}
				Ghost_SetFlag(GHF_SET_DIRECTION);
				Ghost_SetFlag(GHF_4WAY);
				Ghost_Data = DISCO_COMBO + 4;
				ghost->CollDetection = false;
				for (int i = 0; i < 30; i++)
				{
					int MehX = i / 4;
					int MehY = i / 2;
					Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 10; i > 0; i--)
				{
					int MehX = (i * 3) / 4;
					int MehY = (i * 3) / 2;
					Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 0; i < 60; i++)
				{
					int MehX = i * 4;
					int MehY = i / 4;
					Screen->DrawCombo(3, Ghost_X - (MehX / 2), Ghost_Y + MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 + MehX, 16 - MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				int MehC = FindSpawnPoint(true, false, true, true);
				Ghost_X = ComboX(MehC);
				Ghost_Y = ComboY(MehC);
				for (int i = 60; i > 0; i--)
				{
					int MehX = i * 4;
					int MehY = i / 4;
					Screen->DrawCombo(3, Ghost_X - (MehX / 2), Ghost_Y + MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 + MehX, 16 - MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 0; i < 10; i++)
				{
					int MehX = (i * 3) / 4;
					int MehY = (i * 3) / 2;
					Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				for (int i = 30; i > 0; i--)
				{
					int MehX = i / 4;
					int MehY = i / 2;
					Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - MehY, DISCO_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
					Ghost_Waitframe(this, ghost);
				}
				ghost->CollDetection = true;
				Ghost_Data = DISCO_COMBO;
				Phase = false;
				tics = 0;
				Ghost_SetDefenses(ghost, Store);
			}
			Ghost_Waitframe(this, ghost);
		}
	}
}



ffc script LaserRobe{
	void run(int enemyid){
		npc ghost = Ghost_InitAutoGhost(this, enemyid);
		Ghost_SetFlag(GHF_4WAY);
		int Store[18];
		Ghost_CSet = 10;
		int LASER_COMBO = Ghost_Data;
		Ghost_StoreDefenses(ghost, Store);
		Ghost_SetAllDefenses(ghost, NPCDT_IGNORE);
		Ghost_Data = LASER_COMBO + 4;
		bool Eppy;
		ghost->CollDetection = false;
		if (Ghost_GetAttribute(ghost, 0, 0) >= 1)
		{
			Eppy = true;
		}
		else
		{
			Eppy = false;
		}
		while(true){	
			int MehC = FindSpawnPoint(true, true, true, true);
			Ghost_X = ComboX(MehC);
			Ghost_Y = ComboY(MehC);
			if (Ghost_X != GridX(Link->X) && Ghost_Y != GridY(Link->Y))
			{
				int Lel = Rand(2);
				if (Lel == 1)
				{
					Ghost_X = GridX(Link->X);
				}
				else
				{
					Ghost_Y = GridY(Link->Y);
				}
			}
			Ghost_Dir = AngleDir4(WrapDegrees(Angle(Ghost_X, Ghost_Y, Link->X, Link->Y)));
			for (int i = 60; i > 0; i--)
			{
				int MehX = i / 4;
				int MehY = i * 4;
				Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - (MehY / 2), LASER_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
				Ghost_Waitframe(this, ghost);
			}
			for (int i = 0; i < 10; i++)
			{
				int MehX = (i * 3) / 2;
				int MehY = (i * 3) / 4;
				Screen->DrawCombo(3, Ghost_X - (MehX / 2), Ghost_Y + (MehY / 2), LASER_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 + MehX, 16 - MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
				Ghost_Waitframe(this, ghost);
			}
			for (int i = 30; i > 0; i--)
			{
				int MehX = i / 2;
				int MehY = i / 4;
				Screen->DrawCombo(3, Ghost_X - (MehX / 2), Ghost_Y + (MehY / 2), LASER_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 + MehX, 16 - MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
				Ghost_Waitframe(this, ghost);
			}
			ghost->CollDetection = true;
			Ghost_Data = LASER_COMBO;
			Ghost_SetDefenses(ghost, Store);
			for (int i = 60; i > 0; i--)
			{
				int M1 = dirToDeg(Ghost_Dir);
				if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
				{
					M1 += 180;
				}
				M1 %= 360;
				DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 3, M1, 230);
				DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 2, M1, 231);
				DrawLaser(3, Ghost_X + 8, Ghost_Y + 8, 1, M1, 232);
				Ghost_Waitframe(this, ghost);
			}
			Game->PlaySound(37);
			if (Eppy == false)
			{
				for (int i = 120; i > 0; i--)
				{
					int M1 = dirToDeg(Ghost_Dir);
					if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
					{
						M1 += 180;
					}
					M1 %= 360;
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M1, ghost->WeaponDamage, 230);
					Ghost_Waitframe(this, ghost);
				}
			}
			else
			{
				int M2 = dirToDeg(Ghost_Dir);
				if (Ghost_Dir == DIR_UP || Ghost_Dir == DIR_DOWN)
				{
					M2 += 180;
				}
				M2 %= 360;
				for (int i = Ghost_GetAttribute(ghost, 1, 60); i > 0; i--)
				{
					int Hex = (Angle(Ghost_X, Ghost_Y, Link->X, Link->Y));
					if (Sign(angleDifference(DegtoRad(M2), DegtoRad(Hex))) > 0)
					{
						M2++;
					}
					else if (Sign(angleDifference(DegtoRad(M2), DegtoRad(Hex))) < 0)
					{
						M2--;
					}
					M2 %= 360;
					Laser3Color(3, Ghost_X + 8, Ghost_Y + 8, 8, M2, ghost->WeaponDamage, 230);
					Ghost_Waitframe(this, ghost);
				}
			}
			Ghost_Data = LASER_COMBO + 4;
			Ghost_StoreDefenses(ghost, Store);
			Ghost_SetAllDefenses(ghost, NPCDT_IGNORE);
			ghost->CollDetection = false;
			for (int i = 0; i < 30; i++)
			{
				int MehX = i / 2;
				int MehY = i / 4;
				Screen->DrawCombo(3, Ghost_X - (MehX / 2), Ghost_Y + (MehY / 2), LASER_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 + MehX, 16 - MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
				Ghost_Waitframe(this, ghost);
			}
			for (int i = 10; i > 0; i--)
			{
				int MehX = (i * 3) / 2;
				int MehY = (i * 3) / 4;
				Screen->DrawCombo(3, Ghost_X - (MehX / 2), Ghost_Y + (MehY / 2), LASER_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 + MehX, 16 - MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
				Ghost_Waitframe(this, ghost);
			}
			for (int i = 0; i < 60; i++)
			{
				int MehX = i / 4;
				int MehY = i * 4;
				Screen->DrawCombo(3, Ghost_X + (MehX / 2), Ghost_Y - (MehY / 2), LASER_COMBO + Ghost_Dir, 1, 1, Ghost_CSet, 16 - MehX, 16 + MehY, 0, 0, 0, -1, 0, true, OP_TRANS);
				Ghost_Waitframe(this, ghost);
			}
			Ghost_Waitframe(this, ghost);
		}
	}
}