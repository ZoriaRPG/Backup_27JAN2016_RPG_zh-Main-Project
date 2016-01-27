import "std.zh"
import "string.zh"
import "ffcscript.zh"
import "ghost.zh"

global script globalscrip{
	void run(){
		StartGhostZH();
		ForcePosX = -1000;
		ForcePosY = -1000;
		while(true){
			UpdateGhostZH1();
			Waitdraw();
			ForcePos();
			UpdateGhostZH2();
			Waitframe();
		}
	}
}

//Converts a direction to an angle
int DirAngle(int Dir){
	if(Dir==DIR_UP)return -90;
	else if(Dir==DIR_DOWN)return 90;
	else if(Dir==DIR_LEFT)return 180;
	else if(Dir==DIR_RIGHT)return 0;
	else if(Dir==DIR_LEFTUP)return -135;
	else if(Dir==DIR_RIGHTUP)return -45;
	else if(Dir==DIR_LEFTDOWN)return 135;
	else if(Dir==DIR_RIGHTDOWN)return 45;
}

bool Xor(bool A, bool B){
	if((A&&!B)||(B&&!A))
		return true;
	return false;
}

float ForcePosX;
float ForcePosY;

void ForcePos(){
	if(ForcePosX>-1000){
		Link->X = ForcePosX;
	}
	if(ForcePosY>-1000){
		Link->Y = ForcePosY;
	}
}

item script RunGrapple{
	void run(int dummy1, int dummy2, int slot, int d0, int d1, int d2){
		if(PressButtonItem(I_GRAPPLE)&&CountFFCsRunning(slot)==0){
			int Args[8] = {d0, d1, d2};
			RunFFCScript(slot, Args);
		}
	}
}

bool PressButtonItem(int itm){
	if(GetEquipmentA()==itm&&Link->PressA)return true;
	else if(GetEquipmentB()==itm&&Link->PressB)return true;
	return false;
}
bool InputButtonItem(int itm){
	if(GetEquipmentA()==itm&&Link->InputA)return true;
	else if(GetEquipmentB()==itm&&Link->InputB)return true;
	return false;
}

const int I_GRAPPLE = 52;
const int CT_GRAPPLE = 142;
const int TIL_LINKGRAPPLE = 32482;
const int TIL_GRAPPLEHOOK = 940;
const int CS_GRAPPLEHOOK = 1;
const int FREQ_GRAPPLESOUND = 4;
const int SFX_GRAPPLESOUND = 17;

int TimedSFX(int timer, int sfx, int freq){
	timer++;
	if(timer>=freq){
		Game->PlaySound(sfx);
		timer = 0;
	}
	return timer;
}

ffc script Grapple{
	int HookX(int dir){
		if(dir==DIR_LEFT)
			return -16;
		else if(dir==DIR_LEFTUP||dir==DIR_LEFTDOWN)
			return -12;
		else if(dir==DIR_RIGHT)
			return 16;
		else if(dir==DIR_RIGHTUP||dir==DIR_RIGHTDOWN)
			return 12;
		else
			return 0;
	}
	int HookY(int dir){
		if(dir==DIR_UP||dir==DIR_LEFTUP||dir==DIR_RIGHTUP)
			return -16;
		else if(dir==DIR_LEFTUP||dir==DIR_RIGHTUP)
			return -16;
		else if(dir==DIR_DOWN)
			return 16;
		else if(dir==DIR_LEFTDOWN||dir==DIR_RIGHTDOWN)
			return 12;
		else
			return 0;
	}
	bool CanPlaceLink(int X, int Y){
		for(int x=0; x<3; x++){
			for(int y=0; y<3; y++){
				if(Screen->isSolid(X+x*7.5, Y+y*7.5))
					return false;
			}
		}
		return true;
	}
	int GrappleDetect(int X, int Y){
		if(Screen->ComboT[ComboAt(X+4, Y+4)]==CT_GRAPPLE)
			return ComboAt(X+4, Y+4);
		else if(Screen->ComboT[ComboAt(X+12, Y+4)]==CT_GRAPPLE)
			return ComboAt(X+12, Y+4);
		else if(Screen->ComboT[ComboAt(X+4, Y+12)]==CT_GRAPPLE)
			return ComboAt(X+4, Y+12);
		else if(Screen->ComboT[ComboAt(X+12, Y+12)]==CT_GRAPPLE)
			return ComboAt(X+12, Y+12);
		return -1;
	}
	bool GrappleSolid(int X, int Y){
		if(Screen->isSolid(X+4, Y+4)||
			Screen->isSolid(X+12, Y+4)||
			Screen->isSolid(X+4, Y+12)||
			Screen->isSolid(X+12, Y+12))
			return true;
		return false;
	}
	void run(int Max_Length){
		int OldJump = Link->Jump;
		Game->PlaySound(SFX_GRAPPLESOUND);
		itemdata grapple = Game->LoadItemData(I_GRAPPLE);
		bool Grapple;
		int Length;
		int LinkX = Link->X;
		int LinkY = Link->Y;
		int HookStartX = Link->X+HookX(Link->Dir);
		int HookStartY = Link->Y+HookY(Link->Dir);
		int HookX = HookStartX;
		int HookY = HookStartY;
		int HookAngle = DirAngle(Link->Dir);
		int SFXTimer = 0;
		lweapon Damage = CreateLWeaponAt(LW_MAGIC, HookX, HookY);
		Damage->Step = 0;
		Damage->DrawYOffset = -1000;
		Damage->Damage = 1;
		Damage->Dir = Link->Dir;
		while(Length<Max_Length){
			Length+=4;
			HookStartX = Link->X+HookX(Link->Dir);
			HookStartY = Link->Y+HookY(Link->Dir);
			HookX += VectorX(4, HookAngle);
			HookY += VectorY(4, HookAngle);
			for(int i=0; i<Ceiling(Length/8); i++){
				Screen->FastTile(2, HookX+VectorX(8*i, HookAngle-180), HookY+VectorY(8*i, HookAngle-180), TIL_GRAPPLEHOOK+8, CS_GRAPPLEHOOK, 128);
			}
			Screen->DrawTile(2, HookX, HookY, TIL_GRAPPLEHOOK+9, 1, 1, CS_GRAPPLEHOOK, -1, -1, HookX, HookY, HookAngle, 0, true, 128);
			Link->X = LinkX;
			Link->Y = LinkY;
			Link->Jump = 0;
			Screen->FastTile(2, HookStartX, HookStartY, TIL_GRAPPLEHOOK+Link->Dir, CS_GRAPPLEHOOK, 128);
			if(GrappleDetect(HookX, HookY)>-1){
				HookX = ComboX(GrappleDetect(HookX, HookY));
				HookY = ComboY(GrappleDetect(HookX, HookY));
				Grapple = true;
				break;
			}
			else if(GrappleSolid(HookX, HookY)||!InputButtonItem(I_GRAPPLE)||HookX<0||HookX>240||HookY<0||HookY>160||!Damage->isValid()){
				break;
			}
			SFXTimer = TimedSFX(SFXTimer, SFX_GRAPPLESOUND, FREQ_GRAPPLESOUND);
			if(Damage->isValid()){
				Damage->Dir = Link->Dir;
				Damage->X = HookX;
				Damage->Y = HookY;
			}
			WaitNoAction();
		}
		if(Damage->isValid())
			Damage->DeadState = 0;
		if(Grapple){
			int LinkAngle = Angle(Link->X, Link->Y, HookX, HookY);
			int VAng;
			int Dist = Distance(Link->X, Link->Y, HookX, HookY);
			int VDist;
			int VY;
			if(ForcePosX==-1000&&ForcePosY==-1000){
				while(InputButtonItem(I_GRAPPLE)){
					HookStartX = Link->X+HookX(AngleDir8(LinkAngle));
					HookStartY = Link->Y+HookY(AngleDir8(LinkAngle));
					HookAngle = Angle(HookStartX, HookStartY, HookX, HookY);
					for(int i=0; i<Ceiling(Distance(HookStartX, HookStartY, HookX, HookY)/8); i++){
						Screen->FastTile(2, HookX+VectorX(8*i, LinkAngle-180), HookY+VectorY(8*i, LinkAngle-180), TIL_GRAPPLEHOOK+8, CS_GRAPPLEHOOK, 128);
					}
					Screen->DrawTile(2, HookX, HookY, TIL_GRAPPLEHOOK+9, 1, 1, CS_GRAPPLEHOOK, -1, -1, HookX, HookY, LinkAngle, 0, true, 128);
					if(LinkAngle>90||LinkAngle<-90){
						Link->Dir = DIR_LEFT;
						if(VAng<GH_TERMINAL_VELOCITY)
							VAng += GH_GRAVITY;
					}
					else if(LinkAngle>-90&&LinkAngle<90){
						if(VAng>-GH_TERMINAL_VELOCITY)
							VAng -= GH_GRAVITY;
						Link->Dir = DIR_RIGHT;
					}
					if(Link->Dir==DIR_UP||Link->Dir==DIR_DOWN)
						Link->Dir = DIR_LEFT;
					if(Xor(Link->InputLeft, Link->InputRight)){
						if(Link->InputLeft){
							if(VAng<GH_TERMINAL_VELOCITY*2)
								VAng += 0.08;//This was the main line I changed, to increase how far it swings in sideview.
						}
						else if(Link->InputRight){
							if(VAng>-GH_TERMINAL_VELOCITY*2)
								VAng -= 0.08;
						}
					}
					if(!CanPlaceLink(HookX+VectorX(Dist, LinkAngle+180+VAng), HookY+VectorY(Dist, LinkAngle+180+VAng)))
						VAng = -VAng/2;
					VDist = Clamp(VDist-Sign(VDist)*0.01, -1, 1);
					if(Xor(Link->InputUp, Link->InputDown)){
						if(Link->InputUp)
							VDist = Clamp(VDist-0.1, -1, 1);
						else if(Link->InputDown)
							VDist = Clamp(VDist+0.1, -1, 1);
					}
					if(!CanPlaceLink(HookX+VectorX(Dist+VDist, LinkAngle+180), HookY+VectorY(Dist+VDist, LinkAngle+180)))
						VDist = -VDist;
					float OldY = HookY+VectorY(Dist, LinkAngle+180);
					LinkAngle = WrapDegrees(LinkAngle+VAng);
					Dist = Clamp(Dist+VDist, 24, 96);
					Link->X = HookX+VectorX(Dist, LinkAngle+180);
					Link->Y = HookY+VectorY(Dist, LinkAngle+180);
					VY = HookY+VectorY(Dist, LinkAngle+180)-OldY;
					Link->Jump = 0;
					Screen->FastTile(2, HookStartX, HookStartY, TIL_GRAPPLEHOOK+AngleDir8(LinkAngle), CS_GRAPPLEHOOK, 128);
					WaitNoAction();
				}
				if(VY<0)
					Link->Jump = Clamp(Abs(VAng), -GH_TERMINAL_VELOCITY, GH_TERMINAL_VELOCITY);
			}
		}
		else{
			if(OldJump>0)
				OldJump = -OldJump;
			Link->Jump = OldJump;
		}
		while(Distance(HookStartX, HookStartY, HookX, HookY)>8){
			HookStartX = Link->X+HookX(Link->Dir);
			HookStartY = Link->Y+HookY(Link->Dir);
			HookAngle = Angle(HookStartX, HookStartY, HookX, HookY);
			HookX += VectorX(8, HookAngle-180);
			HookY += VectorY(8, HookAngle-180);
			for(int i=0; i<Ceiling(Distance(HookStartX, HookStartY, HookX, HookY)/8); i++){
				Screen->FastTile(2, HookX+VectorX(8*i, HookAngle-180), HookY+VectorY(8*i, HookAngle-180), TIL_GRAPPLEHOOK+8, CS_GRAPPLEHOOK, 128);
			}
			Screen->DrawTile(2, HookX, HookY, TIL_GRAPPLEHOOK+9, 1, 1, CS_GRAPPLEHOOK, -1, -1, HookX, HookY, HookAngle, 0, true, 128);
			Screen->FastTile(2, HookStartX, HookStartY, TIL_GRAPPLEHOOK+Link->Dir, CS_GRAPPLEHOOK, 128);
			SFXTimer = TimedSFX(SFXTimer, SFX_GRAPPLESOUND, FREQ_GRAPPLESOUND);
			Link->InputUp = false;
			Link->InputDown = false;
			Link->InputA = false;
			Link->InputB = false;
			Waitframe();
		}
	}
}