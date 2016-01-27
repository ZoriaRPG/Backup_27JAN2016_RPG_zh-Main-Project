//Start button-subscreen
			
if(Link->PressStart == true)
{
	Link->PressStart = false;
	Link->InputStart = false;
	freezeScreen();
	show_sub();
	unfreezeScreen();
}
			
if(Link->InputStart == true) Link->InputStart = false;		

const int RT_SUB = 2;

bool movecurs = false;

int epos;
bool epos_active[15];
int ewepid[15];
int eweptile[15];
int ewepcset[15];

int ipos;
bool ipos_active[10];
int iwepid[10];
int iweptile[10];
int iwepcset[10];

int tpos;
int tweptile[9];
int twepcset[9];
bool tscroll_active[12];
int tscrolltile[12];
int tscrollcset[12];


bool closescreen;
int screentoshow;

void show_sub()
{
	closescreen = false;
	
	screentoshow = 1;
	
	while(!closescreen)
	{
		Screen->FastTile(7, 118, -47, passivesubtile, passivesubtilecset, 128);
		if(screentoshow == 1) show_sub1();
		if(screentoshow == 2) show_sub2();
		if(screentoshow == 3) show_sub3();
	}
}

void show_sub1()
{
	int eposx;
	int eposy;
	int epostocheck;
	
	subscreen1();
	
	Screen->DrawBitmap(6, RT_SUB, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, true);
	
	eposx = 40 + (32 * (epos % 5));
	eposy = 40 + (24 * ((epos - (epos % 5)) / 5));
	
	if(Link->PressDown)
	{
		if(epos < 10) epostocheck = epos + 5;
		if(epos >= 10) epostocheck = epos - 10;
		while(epos_active[epostocheck] == false)
		{
			if(epostocheck < 10) epostocheck += 5;
			else if(epostocheck >= 10) epostocheck -= 10;
		}
		
		if(epos_active[epostocheck]) epos = epostocheck;
	}
	
	if(Link->PressUp)
	{
		if(epos < 5) epostocheck = epos + 10;
		if(epos >= 5) epostocheck = epos - 5;
		
		while(epos_active[epostocheck] == false)
		{
			if(epostocheck < 5) epostocheck += 10;
			else if(epostocheck >= 5) epostocheck -= 5;
		}
		
		if(epos_active[epostocheck]) epos = epostocheck;
	}
		
	if(Link->PressRight)
	{
		if(epos == 14) epostocheck = 0;
		if(epos != 14) epostocheck = epos + 1;
			
		while(epos_active[epostocheck] == false)
		{
			if(epostocheck == 14) epostocheck = 0;
			else if(epostocheck != 14) epostocheck += 1;
		}
			
		if(epos_active[epostocheck]) epos = epostocheck;
	}
		
	if(Link->PressLeft)
	{
		if(epos == 0) epostocheck = 14;
		if(epos != 0) epostocheck = epos - 1;
		
		while(epos_active[epostocheck] == false)
		{
			if(epostocheck == 0) epostocheck = 14;
			else if(epostocheck != 0) epostocheck -= 1;
		}
		
		if(epos_active[epostocheck]) epos = epostocheck;
	}
	
	if(Link->PressA || Link->PressB || Link->PressEx2)
	{
		if(epos == 0 || epos == 5 || epos == 10) equipItemB(ewepid[epos]);
		
		if(epos == 1 || epos == 6 || epos == 11 ||
		   epos == 2 || epos == 7 || epos == 12) equipItemA(ewepid[epos]);
			   
		if(epos == 3 || epos == 4 || epos == 8 || epos == 9 ||
		   epos == 13 || epos == 14) equipItemX(ewepid[epos]);
	}
	
	if(Link->PressStart) closescreen = true;
		
	if(Link->PressR) screentoshow = 2;
		
	Screen->FastTile(6, eposx, eposy, 1209, 1, OP_OPAQUE);
	
	settext1();
	
	Waitframe();
	
	return;
}
//if(Link->Item[]) {epos_active[] = true; ewepid[] = ; eweptile[] = ; ewepcset[] = ;}	//
void subscreen1()
{
	Screen->SetRenderTarget(RT_SUB);
	Screen->Rectangle(7, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 1, 0, 0, 0, true, OP_OPAQUE);
	Screen->DrawTile(7, 16, 0, 39000, 14, 11, 1, -1, -1, 0, 0, 0, 0, true, OP_OPAQUE);
	
	//Swords
	if(Link->Item[36]) {epos_active[0] = true; ewepid[0] = 36; eweptile[0] = 28700; ewepcset[0] = 8;}	//L4 Beam
	else if(Link->Item[104]) {epos_active[0] = true; ewepid[0] = 104; eweptile[0] = 28700; ewepcset[0] = 8;}	//L4 No Beam
	else if(Link->Item[7]) {epos_active[0] = true; ewepid[0] = 7; eweptile[0] = 28680; ewepcset[0] = 8;}	//L3 Beam
	else if(Link->Item[103]) {epos_active[0] = true; ewepid[0] = 103; eweptile[0] = 28680; ewepcset[0] = 8;}	//L3 No Beam
	else if(Link->Item[6]) {epos_active[0] = true; ewepid[0] = 6; eweptile[0] = 28660; ewepcset[0] = 7;}	//L2 Beam
	else if(Link->Item[102]) {epos_active[0] = true; ewepid[0] = 102; eweptile[0] = 28660; ewepcset[0] = 7;}	//L2 No Beam
	else if(Link->Item[5]) {epos_active[0] = true; ewepid[0] = 5; eweptile[0] = 28640; ewepcset[0] = 7;}	//L1 Beam
	else if(Link->Item[101]) {epos_active[0] = true; ewepid[0] = 101; eweptile[0] = 28640; ewepcset[0] = 7;}	//L1 No Beam
	
	//Bow & Arrow
	int arrowtype = 0;
	int bowtype = 0;
	epos_active[5] = false;
	ewepcset[5] = 7;
	
	if(Link->Item[41]) {ewepid[5] = 41; arrowtype = 3;}	//L3 LP
	else if(Link->Item[34]) {ewepid[5] = 34; arrowtype = 3;}	//L3 LS
	else if(Link->Item[32]) {ewepid[5] = 32; arrowtype = 3;}	//L3 SP
	else if(Link->Item[57]) {ewepid[5] = 57; arrowtype = 3;}	//L3 SS
	else if(Link->Item[30]) {ewepid[5] = 30; arrowtype = 2;}	//L2 LP
	else if(Link->Item[27]) {ewepid[5] = 27; arrowtype = 2;}	//L2 LS
	else if(Link->Item[16]) {ewepid[5] = 16; arrowtype = 2;}	//L2 SP
	else if(Link->Item[14]) {ewepid[5] = 14; arrowtype = 2;}	//L2 SS
	else if(Link->Item[12]) {ewepid[5] = 12; arrowtype = 1;}	//L1 LP
	else if(Link->Item[10]) {ewepid[5] = 10; arrowtype = 1;}	//L1 LS
	else if(Link->Item[11]) {ewepid[5] = 11; arrowtype = 1;}	//L1 SP
	else if(Link->Item[13]) {ewepid[5] = 13; arrowtype = 1;}	//L1 SS

	if(Link->Item[68]) bowtype = 2;	//Long Bow
	if(Link->Item[15]) bowtype = 1;	//Short Bow

	if(bowtype > 0 && Game->Counter[3] > 0)
	{
		eweptile[5] = (30214 + bowtype + (arrowtype * 20));
		ewepcset[5] = 7;
		epos_active[5] = true; 
	}
	
	if(bowtype > 0 && Game->Counter[3] == 0)
	{
		eweptile[5] = (30193 + (bowtype * 20));
		ewepcset[5] = 7;
		epos_active[5] = false;
	}
	
	if(bowtype == 0) eweptile[5] = (30291 + (20*arrowtype));
	
	//Wands
	if(Link->Item[109]) {epos_active[10] = true; ewepid[10] = 109; eweptile[10] = 30800; ewepcset[10] = 9;}	//Wand 3 (Sorcerer's Staff)
	else if(Link->Item[25]) {epos_active[10] = true; ewepid[10] = 25; eweptile[10] = 30740; ewepcset[10] = 8;}	//Wand 2 (Magic Rod)
	else if(Link->Item[110]) {epos_active[10] = true; ewepid[10] = 110; eweptile[10] = 30805; ewepcset[10] = 9;}	//Wand 1 (Wooden Staff)
	
	//Boomers
	
	if(Link->Item[105]) {epos_active[1] = true; ewepid[1] = 105; eweptile[1] = 29765; ewepcset[1] = 8;}	// Fire Boomer Long
	else if(Link->Item[35]) {epos_active[1] = true; ewepid[1] = 35; eweptile[1] = 29765; ewepcset[1] = 8;}	//Fire Boomer Short
	else if(Link->Item[24]) {epos_active[1] = true; ewepid[1] = 24; eweptile[1] = 29660; ewepcset[1] = 8;}	//Wood Boomer Long
	else if(Link->Item[23]) {epos_active[1] = true; ewepid[1] = 23; eweptile[1] = 29660; ewepcset[1] = 8;}	//Wood Boomer Short

	//Torches
	if(Link->Item[53]) {epos_active[2] = true; ewepid[2] = 53; eweptile[2] = 560; ewepcset[2] = 1;}	//Torch
	if(Game->Counter[CR_SCRIPT13] == 0) epos_active[2] = false;
	
	//Hookshot
	if(Link->Item[89]) {epos_active[6] = true; ewepid[6] = 89; eweptile[6] = 30900; ewepcset[6] = 7;}	//Long Hookshot
	else if(Link->Item[52]) {epos_active[6] = true; ewepid[6] = 52; eweptile[6] = 30900; ewepcset[6] = 6;}	//Short Hookshot
	
	//Bomb
	if(Game->Counter[2] > 0) {epos_active[7] = true; ewepid[7] = 3; eweptile[7] = 30011; ewepcset[7] = 1;}	//Bomb
	if(Game->Counter[2] == 0) epos_active[7] = false;
	
	//Whistle
	if(Link->Item[31]) {epos_active[11] = true; ewepid[11] = 31; eweptile[11] = 30520; ewepcset[11] = 7;}	//Whistle
	
	//Potion
	if(Link->Item[29]) {epos_active[12] = true; ewepid[12] = 29; eweptile[12] = 30660; ewepcset[12] = 8;}	//Potion
	if(Game->Counter[CR_SCRIPT15] == 0) epos_active[12] = false;
	
	//Life Magic
	if(Link->Item[65]) {epos_active[3] = true; ewepid[3] = 65; eweptile[3] = 31528; ewepcset[3] = 1;}	//Life 3
	else if(Link->Item[64]) {epos_active[3] = true; ewepid[3] = 64; eweptile[3] = 31508; ewepcset[3] = 1;}	//Life 2
	else if(Link->Item[63]) {epos_active[3] = true; ewepid[3] = 63; eweptile[3] = 31488; ewepcset[3] = 1;}	//Life 1
	
	//Shockwave Magic
	if(Link->Item[82]) {epos_active[4] = true; ewepid[4] = 82; eweptile[4] = 31529; ewepcset[4] = 1;}	//Shockwave 3
	else if(Link->Item[81]) {epos_active[4] = true; ewepid[4] = 81; eweptile[4] = 31509; ewepcset[4] = 1;}	//Shockwave 2
	else if(Link->Item[76]) {epos_active[4] = true; ewepid[4] = 76; eweptile[4] = 31489; ewepcset[4] = 1;}	//Shockwave 1
	
	//Shield Magic
	if(Link->Item[74]) {epos_active[8] = true; ewepid[8] = 74; eweptile[8] = 31530; ewepcset[8] = 0;}	//Shield 3
	else if(Link->Item[69]) {epos_active[8] = true; ewepid[8] = 69; eweptile[8] = 31510; ewepcset[8] = 0;}	//Shield 2
	else if(Link->Item[66]) {epos_active[8] = true; ewepid[8] = 66; eweptile[8] = 31490; ewepcset[8] = 0;}	//Shield 1
	
	//Stunner Magic
	if(Link->Item[90]) {epos_active[9] = true; ewepid[9] = 90; eweptile[9] = 31531; ewepcset[9] = 1;}	//Stun 3
	else if(Link->Item[88]) {epos_active[9] = true; ewepid[9] = 88; eweptile[9] = 31511; ewepcset[9] = 1;}	//Stun 2
	else if(Link->Item[83]) {epos_active[9] = true; ewepid[9] = 83; eweptile[9] = 31491; ewepcset[9] = 1;}	//Stun 1
	
	//Knowledge Magic
	if(Link->Item[75]) {epos_active[13] = true; ewepid[13] = 75; eweptile[13] = 31492; ewepcset[13] = 1;}	//Knowledge

	//Doom Magic
	if(Link->Item[97]) {epos_active[14] = true; ewepid[14] = 97; eweptile[14] = 31513; ewepcset[14] = 1;}	//Doom 2
	else if(Link->Item[96]) {epos_active[14] = true; ewepid[14] = 96; eweptile[14] = 31493; ewepcset[14] = 1;}	//Doom 1
	
	for(int i=0; i<15; i++)
	{
		if(epos_active[i] && i != 5) Screen->FastTile(7, 40 + (32 * (i % 5)), 40 + (24 * ((i - (i % 5)) / 5)), eweptile[i], ewepcset[i], 128);
		if(i == 5) Screen->FastTile(7, 40 + (32 * (i % 5)), 40 + (24 * ((i - (i % 5)) / 5)), eweptile[i], ewepcset[i], 128);
	}
	Screen->SetRenderTarget(RT_SCREEN);
}

void settext1()
{
	int offset;
	
	//General Use Strings
	int desc1[60];
	int desc2[60];
	int desc3[60];
	
	int _sls[2] = "/";
	int _hyp[20] = "-";
	int _hp[20] = " HP";
	int _mp[20] = " MP";
	int _mpc[20] = "MP Cost: ";
	int _dmg[20] = "Dmg: ";
	int _sec[20] = " seconds";
	int _kn2[20] = ", secrets";
	int _dm2[20] = " dmg, drains";
	
	//Reset display strings
	memset(desc1, 0, 60);
	memset(desc2, 0, 60);
	memset(desc3, 0, 60);
	
	//Swords
	int dmg_sword;
	int _swd1[20] = "Iron Sword";
	int _swd2[20] = "Knight's Blade";
	int _swd3[20] = "Hrunting";
	int _swd4[20] = "Excalibur";
	int _beam[60] = "Fires beam at full health";
	int _swdd[20] = "Damage: ";
	
	if(epos == 0){
		if(ewepid[epos] == 5 || ewepid[epos] == 101) {
			strncatf(desc1, _swd1, 1, 20);
			strncatf(desc2, _dmg, 1, 20);
			strncatf(desc2, 2, 2, 2);}
		if(ewepid[epos] == 6 || ewepid[epos] == 102) {
			strncatf(desc1, _swd2, 1, 20);
			strncatf(desc2, _dmg, 1, 20);
			strncatf(desc2, 4, 2, 2);}
		if(ewepid[epos] == 103 || ewepid[epos] == 7) {
			strncatf(desc1, _swd3, 1, 20);
			strncatf(desc2, _dmg, 1, 20);
			strncatf(desc2, 8, 2, 2);}
		if(ewepid[epos] == 104 || ewepid[epos] == 36) {
			strncatf(desc1, _swd4, 1, 20);
			strncatf(desc2, _dmg, 1, 20);
			strncatf(desc2, 16, 2, 2);}
		if(Link->Item[145]) strncatf(desc3, _beam, 1, 60);
		
	}
	
	//Bows & Arrows
	int dmg_arrow;
	int _bow[40];
	int _bow1[40] = "Short Bow with ";
	int _bow2[40] = "Long Bow with ";
	int _arw1[20] = "Wooden Arrows";
	int _arw2[20] = "Silver Arrows";
	int _arw3[20] = "Golden Arrows";
	int _arwd[50] = "Damage: ";
	int _slow[20] = ", fires slow";
	int _fast[20] = ", fires fast";
	int _pntr[25] = ". Arrows penetrate";
	int _shrt[20] = " and short";
	int _long[20] = " and far";

	if(epos == 5){
		strncatf(desc2, _dmg, 1, 20);
		
		if(Link->Item[68]) strncatf(desc1, _bow2, 1, 20);
		else if(Link->Item[15]) strncatf(desc1, _bow1, 1, 20);
		
		if(Link->Item[41] || Link->Item[34] || Link->Item[32] || Link->Item[57]){
			strncatf(desc1, _arw3, 1, 20);
			strncatf(desc2, 8, 2, 2);
			}
		else if(Link->Item[14] || Link->Item[16] || Link->Item[27] || Link->Item[30]){
			strncatf(desc1, _arw2, 1, 20);
			strncatf(desc2, 4, 2, 2);
			}
		else if(Link->Item[13] || Link->Item[11] || Link->Item[10] || Link->Item[12]){
			strncatf(desc1, _arw1, 1, 20);
			strncatf(desc2, 2, 2, 2);
			}
		if(Link->Item[68]) strncatf(desc2, _fast, 1, 20);
		else if(Link->Item[15]) strncatf(desc2, _slow, 1, 20);
		
		if(Link->Item[42]) strncatf(desc2, _long, 1, 20);
		else strncatf(desc2, _shrt, 1, 20);
		
		if(Link->Item[50]) strncatf(desc2, _pntr, 1, 25);
		Screen->FastTile(6, 40, 144, 39237, 0, 128);					
		offset = 10;
		strncatf(desc3, Game->Counter[3], 2, 3);
		strncatf(desc3, _sls, 1, 3);
		strncatf(desc3, Game->MCounter[3], 2, 3);
	}
	
	//Wands & Staffs
	int _wnd1[40] = "Wooden Rod - No Magic"; 	
	int _wnd2[40] = "Magic Wand - Fires ";
	int _wnd3[40] = "Sorcerer's Staff - Fires ";
	int _1sht[20] = "1 shot";
	int _3sht[20] = "3 shots";
		
	if(epos == 10){
		if(ewepid[epos] == 110){
			strncatf(desc1, _wnd1, 1, 40);
			strncatf(desc2, _dmg, 1, 20);
			strncatf(desc2, 2, 2, 2);}
		if(ewepid[epos] == 25){
			strncatf(desc1, _wnd2, 1, 40);
			if(Link->Item[111]) strncatf(desc1, _3sht, 1, 20);
			else strncatf(desc1, _1sht, 1, 20);
			strncatf(desc2, _dmg, 1, 20);
			if(Link->Item[150]) strncatf(desc2, 8, 2, 2);
			else strncatf(desc2, 4, 2, 2);
			strncatf(desc3, _mpc, 1, 20);
			if(Link->Item[148]) strncatf(desc3, 4, 2, 2);
			else strncatf(desc3, 8, 2, 2);
			Screen->FastTile(6, 40, 144, 39215, 0, 128);
			offset = 10;}
		if(ewepid[epos] == 109){
			strncatf(desc1, _wnd3, 1, 40);
			if(Link->Item[111]) strncatf(desc1, _3sht, 1, 20);
			else strncatf(desc1, _1sht, 1, 20);
			strncatf(desc2, _dmg, 1, 20);
			if(Link->Item[150]) strncatf(desc2, 16, 2, 2);
			else strncatf(desc2, 8, 2, 2);
			strncatf(desc3, _mpc, 1, 20);
			if(Link->Item[148]) strncatf(desc3, 4, 2, 2);
			else strncatf(desc3, 8, 2, 2);
			Screen->FastTile(6, 40, 144, 39215, 0, 128);
			offset = 10;}
	}
	
	//Boomerangs
	int _bmr1[20] = "Wooden Boomerang";
	int _bmr2[20] = "Fire Boomerang";
	int _bmds[40] = "Stuns most enemies";
	int _bmd2[20] = ", fast throw";
	
	if(epos == 1){
		if(ewepid[epos] == 23 || ewepid[epos] == 24){
			strncatf(desc1, _bmr1, 1, 40);
			strncatf(desc2, _bmds, 1, 40);}
		if(ewepid[epos] == 35 || ewepid[epos] == 105){
			strncatf(desc1, _bmr2, 1, 40);
			strncatf(desc2, _dmg, 1, 40);
			strncatf(desc2, 4, 2, 2);}
		if(Link->Item[119]) strncatf(desc2, _bmd2, 1, 20);
	}	
	
	//Hookshot
	int _hok1[20] = "Short Hookshot";
	int _hok2[20] = "Long Hookshot";
	int _hokd[30] = "Cross pits";
	if(epos == 6){
		if(ewepid[epos] == 52) strncatf(desc1, _hok1, 1, 20);
		if(ewepid[epos] == 89) strncatf(desc1, _hok2, 1, 20);
		strncatf(desc2, _hokd, 1, 40);
		if(Link->Item[121]){
			strncatf(desc3, _dmg, 1, 20);
			strncatf(desc3, 2, 2, 2);
		}
		else strncatf(desc3, _bmds, 1, 40);
		
	}
	
	//Whistle
	int _whis[20] = "Magic Whistle";
	int _whd1[30] = "Summon whirlwind";
	int _whd2[30] = "Heals 25 HP each use";
	if(epos == 11){
		strncatf(desc1, _whis, 1, 40);
		strncatf(desc2, _whd1, 1, 40);
		if(Link->Item[122]) strncatf(desc2, _whd2, 1, 30);
		
	}
	
	//Potions
	int _pot1[30] = "Potion";
	int _potd[30] = "Heals ";
	int _and[10] = " and ";
	if(epos == 12){
		strncatf(desc1, _pot1, 1, 30);
		
		strncatf(desc2, _potd, 1, 30);
		if(Link->Item[108]) strncatf(desc2, 250, 2, 3);
		else strncatf(desc2, 100, 2, 3);
		strncatf(desc2, _hp, 1, 20);
		strncatf(desc2, _and, 1, 20);
		if(Link->Item[108]) strncatf(desc2, 100, 2, 3);
		else strncatf(desc2, 50, 2, 2);
		strncatf(desc2, _mp, 1, 20);
		Screen->FastTile(6, 40, 144, 39236, 1, 128);
		offset = 10;
		strncatf(desc3, Game->Counter[CR_SCRIPT15], 2, 3);
		strncatf(desc3, _sls, 1, 3);
		strncatf(desc3, Game->MCounter[CR_SCRIPT15], 2, 3);
	}
	
	//Torch
	int _trch[20] = "Torch";
	int _trcd[30] = "Burns bushes";
	int _trd2[35] = ", throws three flames at once";
	if(epos == 2){
		strncatf(desc1, _trch, 1, 20);
		strncatf(desc2, _trcd, 1, 30);
		if(Link->Item[144]) strncatf(desc2, _trd2, 1, 35);
		Screen->FastTile(6, 40, 144, 39216, 1, 128);
		offset = 10;
		strncatf(desc3, Game->Counter[CR_SCRIPT13], 2, 3);
		strncatf(desc3, _sls, 1, 3);
		strncatf(desc3, Game->Counter[CR_SCRIPT14], 2, 3);
	}
	
	//Bomb (Normal)
	int _bmb1[20] = "Small Bomb";
	int _bomd[30] = ", Blasts walls, rocks";
	if(epos == 7){
		strncatf(desc1, _bmb1, 1, 20);
		strncatf(desc2, _dmg, 1, 20);
		if(Link->Item[106]) strncatf(desc2, 16, 2, 2);
		else strncatf(desc2, 8, 2, 2);
		strncatf(desc2, _bomd, 1, 30);
		Screen->FastTile(6, 40, 144, 39217, 1, 128);
		offset = 10;
		strncatf(desc3, Game->Counter[2], 2, 3);
		strncatf(desc3, _sls, 1, 3);
		strncatf(desc3, Game->MCounter[2], 2, 3);
	}
	
	////////////////////
	//				  //
	//     MAGIC	  //
	//				  //
	////////////////////
	
	int _l1[10] = "Level 1";
	int _l2[10] = "Level 2";
	int _l3[10] = "Level 3";
		
	//Life Magic
	int _life[20] = "Life ";
	int _lifd[20] = "Heals ";
	if(epos == 3){
		strncatf(desc1, _life, 1, 20);
		strncatf(desc2, _lifd, 1, 20);
		strncatf(desc3, _mpc, 1, 20);
		Screen->FastTile(6, 40, 144, 39215, 0, 128);
		offset = 10;
		
		if(ewepid[epos] == 63){
			strncatf(desc1, _l1, 1, 10);
			strncatf(desc2, m_power[0] + boost, 2, 3);
			strncatf(desc2, _hyp, 1, 3);
			strncatf(desc2, m_power[0] + (boost*2), 2, 3);
			strncatf(desc2, _hp, 1, 3);
			strncatf(desc3, m_mp_cost[0], 2, 2);}
		if(ewepid[epos] == 64){
			strncatf(desc1, _l2, 1, 10);
			strncatf(desc2, m_power[1] + boost, 2, 3);
			strncatf(desc2, _hyp, 1, 3);
			strncatf(desc2, m_power[1] + (boost*2), 2, 3);
			strncatf(desc2, _hp, 1, 3);
			strncatf(desc3, m_mp_cost[1], 2, 2);}
		if(ewepid[epos] == 65){
			strncatf(desc1, _l3, 1, 10);
			strncatf(desc2, m_power[2] + boost, 2, 3);
			strncatf(desc2, _hyp, 1, 3);
			strncatf(desc2, m_power[2] + (boost*2), 2, 3);
			strncatf(desc2, _hp, 1, 3);
			strncatf(desc3, m_mp_cost[2], 2, 2);}
	}
	
	//Shield Magic
	int _shld[20] = "Shield ";
	int _shdc[40] = "Reduces damage by half for ";
		
	if(epos == 8){
		strncatf(desc1, _shld, 1, 20);
		strncatf(desc2, _shdc, 1, 40);
		strncatf(desc3, _mpc, 1, 20);
		Screen->FastTile(6, 40, 144, 39215, 0, 128);
		offset = 10;
		
		if(ewepid[epos] == 66){
			strncatf(desc1, _l1, 1, 10);
			strncatf(desc2, m_power[3], 2, 2);
			strncatf(desc2, _sec, 1, 20);
			strncatf(desc3, m_mp_cost[3], 2, 3);
		}
		if(ewepid[epos] == 69){
			strncatf(desc1, _l2, 1, 10);
			strncatf(desc2, m_power[4], 2, 2);
			strncatf(desc2, _sec, 1, 20);
			strncatf(desc3, m_mp_cost[4], 2, 3);
		}
		if(ewepid[epos] == 74){
			strncatf(desc1, _l3, 1, 10);
			strncatf(desc2, m_power[5], 2, 2);
			strncatf(desc2, _sec, 1, 20);
			strncatf(desc3, m_mp_cost[5], 2, 3);
		}
	}
	
	//Knowledge Magic
	int _know[20] = "Knowledge ";
	int _knd1[30] = "Reveal enemy HP";

	if(epos == 13){
		strncatf(desc1, _know, 1, 20);
		strncatf(desc2, _knd1, 1, 20);
		strncatf(desc3, _mpc, 1, 20);
		Screen->FastTile(6, 40, 144, 39215, 0, 128);
		strncatf(desc3, m_mp_cost[6], 2, 2);
		
		offset = 10;
	}
	
	//Stunner
	int _stun[20] = "Stunner ";
	int _stnd[25] = "Stuns most enemies";
	int _stn1[25] = ", single shot";
	int _stn2[25] = ", eight shots";
		
	if(epos == 9){
		strncatf(desc1, _stun, 1, 20);
		strncatf(desc2, _stnd, 1, 25);
		strncatf(desc3, _mpc, 1, 20);
		Screen->FastTile(6, 40, 144, 39215, 0, 128);
		offset = 10;
		
		if(ewepid[epos] == 83){
			strncatf(desc1, _l1, 1, 10);
			strncatf(desc2, _stn1, 1, 25);
			strncatf(desc3, m_mp_cost[10], 2, 2);}
		if(ewepid[epos] == 88){
			strncatf(desc1, _l2, 1, 10);
			strncatf(desc2, _stn2, 1, 25);
			strncatf(desc3, m_mp_cost[11], 2, 2);}
		if(ewepid[epos] == 90){
			strncatf(desc1, _l3, 1, 10);
	
			strncatf(desc3, m_mp_cost[12], 2, 2);}
	}
	
	
	//Shockwave
	int _shok[20] = "Shockwave ";
	int _shd1[20] = ", 1 blast";
	int _shd2[20] = ", 3 blasts";
	int _shd3[20] = ", 5 blasts";
	if(epos == 4){
		strncatf(desc1, _shok, 1, 20);
		strncatf(desc2, _dmg, 1, 20);
		strncatf(desc3, _mpc, 1, 20);
		Screen->FastTile(6, 40, 144, 39215, 0, 128);
		offset = 10;
		
		if(ewepid[epos] == 76){
			strncatf(desc1, _l1, 1, 10);
			strncatf(desc2, m_power[7] + boost, 2, 2);
			strncatf(desc2, _hyp, 1, 3);
			strncatf(desc2, m_power[7] + (boost*2), 2, 2);
			strncatf(desc2, _shd1, 1, 20);
			strncatf(desc3, m_mp_cost[7], 2, 2);}
		if(ewepid[epos] == 81){
			strncatf(desc1, _l2, 1, 10);
			strncatf(desc2, m_power[8] + boost, 2, 2);
			strncatf(desc2, _hyp, 1, 3);
			strncatf(desc2, m_power[8] + (boost*2), 2, 2);
			strncatf(desc2, _shd2, 1, 20);
			strncatf(desc3, m_mp_cost[8], 2, 2);}
		if(ewepid[epos] == 82){
			strncatf(desc1, _l3, 1, 10);
			strncatf(desc2, m_power[9] + boost, 2, 2);
			strncatf(desc2, _hyp, 1, 3);
			strncatf(desc2, m_power[9] + (boost*2), 2, 2);
			strncatf(desc2, _shd3, 1, 20);
			strncatf(desc3, m_mp_cost[9], 2, 2);}
	}
	
	//Doom
	int _doom[20] = "Doom ";
	int _dm1d[30] = "Massive damage";
	int _dm2d[30] = ", drains";
	
	if(epos == 14){
		strncatf(desc1, _doom, 1, 20);
		strncatf(desc2, _dm1d, 1, 20);
		strncatf(desc3, _mpc, 1, 20);
		Screen->FastTile(6, 40, 144, 39215, 0, 128);
		offset = 10;
		
		if(ewepid[epos] == 96){
			strncatf(desc1, _l1, 1, 10);
			strncatf(desc3, m_mp_cost[13], 2, 3);}
		if(ewepid[epos] == 97){
			strncatf(desc1, _l2, 1, 10);
			strncatf(desc2, _dm2d, 1, 20);
			strncatf(desc3, m_mp_cost[14], 2, 3);}
	}
	
	
	//Draw finished strings
	Screen->DrawString(6, 40, 120, 6, 8, -1, 0, desc1, 128);	//
	Screen->DrawString(6, 40, 132, 6, 8, -1, 0, desc2, 128);	//
	Screen->DrawString(6, 40 + offset, 144, 6, 8, -1, 0, desc3, 128); //
}

void show_sub2()
{

	int iposx;
	int iposy;
	int ipostocheck;
	
	subscreen2();
	
	Screen->DrawBitmap(6, RT_SUB, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, true);
	
	iposx = 76 + (24 * (ipos % 2));
	
	iposy = 24 + (20 * ((ipos - (ipos % 2)) / 2));
	
	if(Link->PressDown)
	{
		if(ipos < 8) ipostocheck = ipos + 2;
		if(ipos >= 8) ipostocheck = ipos - 8;
		while(ipos_active[ipostocheck] == false)
		{
			if(ipostocheck < 8) ipostocheck += 1;
			else if(ipostocheck >= 8) ipostocheck -= 8;
		}
		
		if(ipos_active[ipostocheck]) ipos = ipostocheck;
	}
	
	if(Link->PressUp)
	{
		if(ipos < 2) ipostocheck = ipos + 8;
		if(ipos >= 2) ipostocheck = ipos - 2;
		
		while(ipos_active[ipostocheck] == false)
		{
			if(ipostocheck < 2) ipostocheck += 8;
			else if(ipostocheck >= 2) ipostocheck -= 2;
		}
		
		if(ipos_active[ipostocheck]) ipos = ipostocheck;
	}
		
	if(Link->PressRight)
	{
		if(ipos == 9) ipostocheck = 0;
		if(ipos != 9) ipostocheck = ipos + 1;
			
		while(ipos_active[ipostocheck] == false)
		{
			if(ipostocheck == 9) ipostocheck = 0;
			else if(ipostocheck != 9) ipostocheck += 1;
		}
			
		if(ipos_active[ipostocheck]) ipos = ipostocheck;
	}
		
	if(Link->PressLeft)
	{
		if(ipos == 0) ipostocheck = 9;
		if(ipos != 0) ipostocheck = ipos - 1;
		
		while(ipos_active[ipostocheck] == false)
		{
			if(ipostocheck == 0) ipostocheck = 9;
			else if(ipostocheck != 0) ipostocheck -= 1;
		}
		
		if(ipos_active[ipostocheck]) ipos = ipostocheck;
	}
	
	if(Link->PressStart) closescreen = true;
		
	if(Link->PressL) screentoshow = 1;
	
	if(Link->PressR) screentoshow = 3;
			
	Screen->FastTile(6, iposx, iposy, 1209, 1, OP_OPAQUE);
	
	settext2();
	
	Waitframe();
	
	return;
}

void subscreen2()
{
	Screen->SetRenderTarget(RT_SUB);
	Screen->Rectangle(7, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 1, 0, 0, 0, true, OP_OPAQUE);
	Screen->DrawTile(7, 16, 0, 39260, 14, 11, 1, -1, -1, 0, 0, 0, 0, true, OP_OPAQUE);
	
	//Selectable Items
	//Shield
	if(Link->Item[37]) {ipos_active[0] = true; iwepid[0] = 37; iweptile[0] = 28621; iwepcset[0] = 6;}	//L3 Shield
	else if(Link->Item[8]) {ipos_active[0] = true; iwepid[0] = 8; iweptile[0] = 28623; iwepcset[0] = 6;}	//L2 Shield
	else if(Link->Item[93]) {ipos_active[0] = true; iwepid[0] = 93; iweptile[0] = 28620; iwepcset[0] = 6;}	//L1 Shiled
	
	//Tunics
	if(Link->Item[61]) {ipos_active[1] = true; iwepid[1] = 61; iweptile[1] = 29231; iwepcset[1] = 1;}	//L4 Tunic
	else if(Link->Item[18]) {ipos_active[1] = true; iwepid[1] = 18; iweptile[1] = 29230; iwepcset[1] = 8;}	//L3 Tunic
	else if(Link->Item[17]) {ipos_active[1] = true; iwepid[1] = 17; iweptile[1] = 29230; iwepcset[1] = 7;}	//L2 Tunic
	else if(Link->Item[143]) {ipos_active[1] = true; iwepid[1] = 143; iweptile[1] = 29230; iwepcset[1] = 0;}	//L1 Tunic
	
	//Bracelet
	if(Link->Item[56]) {ipos_active[2] = true; iwepid[2] = 56; iweptile[2] = 31326; iwepcset[2] = 8;}	//Power Glove
	else if(Link->Item[19]) {ipos_active[2] = true; iwepid[2] = 19; iweptile[2] = 31325; iwepcset[2] = 1;}	//Power Bracelet

	//Jinx Amulet
	if(Link->Item[100]) {ipos_active[3] = true; iwepid[3] = 100; iweptile[3] = 31402; iwepcset[3] = 1;}	//
	else if(Link->Item[99]) {ipos_active[3] = true; iwepid[3] = 99; iweptile[3] = 31401; iwepcset[3] = 1;}	//
		
	//Hover Ring
	if(Link->Item[92]) {ipos_active[4] = true; iwepid[4] = 92; iweptile[4] = 29226; iwepcset[4] = 1;}
	
	//EXP Ring
	if(Link->Item[147]) {ipos_active[5] = true; iwepid[5] = 147; iweptile[5] = 29168; iwepcset[5] = 8;}
	
	//Savior Potion
	if(Link->Item[51]) {ipos_active[6] = true; iwepid[6] = 51; iweptile[6] = 30663; iwepcset[6] = 9;}	//
	
	//2x Magic Crystal
	if(Link->Item[148]) {ipos_active[7] = true; iwepid[7] = 148; iweptile[7] = 31481; iwepcset[7] = 9;}	//
	
	//Raft
	if(Link->Item[26]) {ipos_active[8] = true; iwepid[8] = 26; iweptile[8] = 31224; iwepcset[8] = 9;}	//
	
	//Stomp Boots
	if(Link->Item[120]) {ipos_active[9] = true; iwepid[9] = 120; iweptile[9] = 31269; iwepcset[9] = 7;}	//
	
	for(int j=0; j<10; j++)
	{
		if(ipos_active[j]) Screen->FastTile(7, 76 + (24 * (j % 2)), 24 + (20 * ((j - (j % 2)) / 2)), iweptile[j], iwepcset[j], 128);
	}

	//Objectives
	
	//DMAP 0 and 1 - Brightsea Island
	int objtile[4] = {31237, 31237, 31237, 31237};
	int objcset[4] = {1, 1, 1, 1};
	
	if(Game->GetCurDMap() == 0 || Game->GetCurDMap() == 1)
	{
		if(Link->Item[36]) {objtile[0] = 28700; objcset[0] = 8;}	//L4 Beam
		else if(Link->Item[104]) {objtile[0] = 28700; objcset[0] = 8;}	//L4 No Beam
		else if(Link->Item[7]) {objtile[0] = 28680; objcset[0] = 8;}	//L3 Beam
		else if(Link->Item[103]) {objtile[0] = 28680; objcset[0] = 8;}	//L3 No Beam
		else if(Link->Item[6]) {objtile[0] = 28660; objcset[0] = 7;}	//L2 Beam
		else if(Link->Item[102]) {objtile[0] = 28660; objcset[0] = 7;}	//L2 No Beam
		else if(Link->Item[5]) {objtile[0] = 28640; objcset[0] = 7;}	//L1 Beam
		else if(Link->Item[101]) {objtile[0] = 28640; objcset[0] = 7;}	//L1 No Beam

		if(Link->Item[82]) {objtile[1] = 31529; objcset[1] = 1;}	//Shockwave 3
		else if(Link->Item[81]) { objtile[1] = 31509; objcset[1] = 1;}	//Shockwave 2
		else if(Link->Item[76]) { objtile[1] = 31489; objcset[1] = 1;}	//Shockwave 1
		
		if(Link->Item[68]) {objtile[2] = 30216; objcset[2] =  7;}	//Long Bow
		else if(Link->Item[15]) {objtile[2] = 30215; objcset[2] = 7;}	//Short Bow
		
		if(Link->Item[56]) {objtile[3] = 31326; objcset[3] = 8;}	//Power Glove
		else if(Link->Item[19]) {objtile[3] = 31325; objcset[3] = 1;}	//Power Bracelet
	}


	if(Game->GetCurDMap() == 2)
	{
		if (GetLevelItem(Game->GetCurLevel(), LI_MAP)) {objtile[0] = 31803; objcset[0] = 7;}
		//if (Game->LItems[Game->GetCurLevel()] & LI_MAP != 0) {objtile[0] = 31803; objcset[0] = 7;}
		else {objtile[0] = 31235; objcset[0] = 2;}
		
		if (GetLevelItem(Game->GetCurLevel(), LI_COMPASS)) {objtile[1] = 31780; objcset[1] = 7;}
		//if (Game->LItems[Game->GetCurLevel()] & LI_COMPASS != 0){objtile[1] = 31780; objcset[1] = 7;}
		else {objtile[1] = 31236; objcset[1] = 2;}
		
		if (GetLevelItem(Game->GetCurLevel(), LI_BOSSKEY)) {objtile[2] = 31426; objcset[2] = 8;}
		//if (Game->LItems[Game->GetCurLevel()] & LI_BOSSKEY != 0){objtile[2] = 31426; objcset[2] = 8;}
		else {objtile[2] = 31234; objcset[2] = 2;}
			
		if(Link->Item[68]) {objtile[3] = 30216; objcset[3] =  7;}	//Long Bow
		else if(Link->Item[15]) {objtile[3] = 30215; objcset[3] = 7;}	//Short Bow
	}

	for(int i = 0; i < 4; i++) Screen->FastTile(7, 140 + (24 * (i % 2)), 44 + (24 * ((i - (i % 2)) / 2)), objtile[i], objcset[i], 128);

	//Rupees
	int rupeetile;
	int rupeecset;
	
	if(Game->Counter[1] >= 200) {rupeetile = 29829; rupeecset = 9;}
	if(Game->Counter[1] < 200)  {rupeetile = 29867; rupeecset = 7;}
	if(Game->Counter[1] < 100)  {rupeetile = 29847; rupeecset = 9;}
	if(Game->Counter[1] < 50)   {rupeetile = 29876; rupeecset = 7;}
	if(Game->Counter[1] < 20)   {rupeetile = 29856; rupeecset = 9;}
	if(Game->Counter[1] < 10)   {rupeetile = 29836; rupeecset = 7;}
	if(Game->Counter[1] < 5)    {rupeetile = 29836; rupeecset = 0;}
	
	int _slsh[2] = "/";
	int _rupe[15];
	
	Screen->FastTile(7, 132, 104, rupeetile, rupeecset, 128);
	
	strncatf(_rupe, Game->Counter[1], 2, 5);
	strncatf(_rupe, _slsh, 1, 2);
	strncatf(_rupe, Game->MCounter[1], 2, 5);
	
	Screen->DrawString(7, 152, 108, 6, 8, -1, 0, _rupe, 128);	//

	
	Screen->SetRenderTarget(RT_SCREEN);
}

void settext2()
{
	//General Use Strings
	int desc1[60];
	int desc2[60];
	int _slow[20] = "slowly";
	int _quik[20] = "quickly";
	
	
	//Reset display strings
	memset(desc1, 0, 60);
	memset(desc2, 0, 60);
	
	//Shield
	int _shl1[20] = "Small Shield";
	int _shl2[20] = "Big Shield";
	int _shl3[20] = "Mirror Shield";
	int _shd1[40] = "Blocks rocks, arrows";
	int _shd2[40] = "Blocks most attacks";
	int _shd3[40] = "Blocks attacks, reflects some";
	
	if(ipos == 0)
	{
		if(iwepid[ipos] == 93)
		{
			strncatf(desc1, _shl1, 1, 20);
			strncatf(desc2, _shd1, 1, 40);
		}
		if(iwepid[ipos] == 8)
		{
			strncatf(desc1, _shl2, 1, 20);
			strncatf(desc2, _shd2, 1, 40);
		}
		if(iwepid[ipos] == 37)
		{
			strncatf(desc1, _shl3, 1, 20);
			strncatf(desc2, _shd3, 1, 40);
		}
	}
	
	//Tunic
	int _tun1[20] = "Green Tunic";
	int _tun2[20] = "Blue Tunic";
	int _tun3[20] = "Red Tunic";
	int _tun4[20] = "Golden Tunic";
	int _tund[20] = "Reduces damage by ";
	int _tnd2[20] = "1/2";
	int _tnd3[20] = "1/3";
	int _tnd4[20] = "1/5";
	
	if(ipos == 1)
	{
		if(iwepid[1] == 143)
		{
			strncatf(desc1, _tun1, 1, 20);
		}
		if(iwepid[1] == 17)
		{
			strncatf(desc1, _tun2, 1, 20);
			strncatf(desc2, _tund, 1, 20);
			strncatf(desc2, _tnd2, 1, 20);
		}
		if(iwepid[1] == 18)
		{
			strncatf(desc1, _tun3, 1, 20);
			strncatf(desc2, _tund, 1, 20);
			strncatf(desc2, _tnd3, 1, 20);
		}
		if(iwepid[1] == 61)
		{
			strncatf(desc1, _tun4, 1, 20);
			strncatf(desc2, _tund, 1, 20);
			strncatf(desc2, _tnd4, 1, 20);
		}
	}
	
	//Power Bracelets
	int _brac[20] = "Power Bracelet";
	int _brcd[20] = "Move heavy things";
	int _glov[20] = "Power Glove";
	int _glvd[25] = "Move very heavy things";
	
	if(ipos == 2)
	{
		if(iwepid[2] == 19)
		{
			strncatf(desc1, _brac, 1, 20);
			strncatf(desc2, _brcd, 1, 20);
		}
		if(iwepid[2] == 56)
		{
			strncatf(desc1, _glov, 1, 20);
			strncatf(desc2, _glvd, 1, 25);
		}
	}
	
	//Jinx Amulet
	int _jnx1[20] = "Jinx Amulet L1";
	int _jnx2[20] = "Jinx Amulet L2";
	int _jxd1[40] = "Prevents permanent jinxes";
	int _jxd2[40] = "Prevents all jinxes";
	if(ipos == 3)
	{
		if(iwepid[ipos] == 99)
		{
			strncatf(desc1, _jnx1, 1, 20);
			strncatf(desc2, _jxd1, 1, 40);
		}
		if(iwepid[ipos] == 100)
		{
			strncatf(desc1, _jnx2, 1, 20);
			strncatf(desc2, _jxd2, 1, 40);
		}
	}
	
	//Hover Ring
	int _hovr[20] = "Hover Ring";
	int _hovd[40] = "Jump three extra tiles";
	if(ipos == 4)
	{
		strncatf(desc1, _hovr, 1, 20);
		strncatf(desc2, _hovd, 1, 40);
	}
	
	//EXP Ring
	int _exrn[20] = "EXP Ring";
	int _exrd[20] = "Earn double EXP";
	if(ipos == 5)
	{
		strncatf(desc1, _exrn, 1, 20);
		strncatf(desc2, _exrd, 1, 40);
	}
	
	//Savior Potion
	int _savi[20] = "Savior Potion";
	int _savd[40] = "Refill HP, used on death";
	if(ipos == 6)
	{
		strncatf(desc1, _savi, 1, 20);
		strncatf(desc2, _savd, 1, 40);
	}
	
	//Magic Crystal
	int _magc[20] = "Magic Crystal";
	int _magd[40] = "Spells use 50% MP";
	if(ipos == 7)
	{
		strncatf(desc1, _magc, 1, 20);
		strncatf(desc2, _magd, 1, 40);
	}
	
	//Raft
	int _raft[20] = "Raft";
	int _rftd[40] = "Sail across the water";
	if(ipos == 8)
	{
		strncatf(desc1, _raft, 1, 20);
		strncatf(desc2, _rftd, 1, 40);
	}
	
	//Stomp Boots
	int _boot[20] = "Stomp Boots";
	int _botd[40] = "Dmg: 2, jump to stomp";
	if(ipos == 9)
	{
		strncatf(desc1, _boot, 1, 20);
		strncatf(desc2, _botd, 1, 40);
	}

	Screen->DrawString(6, 72, 134, 6, 8, -1, 0, desc1, 128);	//lttp small
	Screen->DrawString(6, 72, 146, 6, 8, -1, 0, desc2, 128);	//small
}

void show_sub3()
{
	int tposx;
	int tposy;
	int tpostocheck;
	
	subscreen3();
	
	Screen->DrawBitmap(6, RT_SUB, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, true);
	
	tposx = 112 + (32 * (tpos % 3));
	tposy = 40 + (24 * ((tpos - (tpos % 3)) / 3));
	
	if(Link->PressDown)
	{
		if(tpos < 6) tpos += 3;
		else if(tpos >= 6) tpos -= 6;
	}
	
	if(Link->PressUp)
	{
		if(tpos < 3) tpos += 6;
		else if(tpos >= 3) tpos -= 3;
	}
		
	if(Link->PressRight)
	{
		if(tpos == 8) tpos = 0;
		else if(tpos != 8) tpos ++;
	}
		
	if(Link->PressLeft)
	{
		if(tpos == 0) tpos = 8;
		else if(tpos != 0) tpos --;
	}
			
	if(Link->PressL) screentoshow = 2;
	
	if(Link->PressStart) closescreen = true;
	
	Screen->FastTile(6, tposx, tposy, 1209, 1, OP_OPAQUE);
	
	settext3();
	
	Waitframe();
	
	return;
}

void subscreen3()
{
	Screen->SetRenderTarget(RT_SUB);
	Screen->Rectangle(7, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 1, 0, 0, 0, true, OP_OPAQUE);
	Screen->DrawTile(7, 16, 0, 39520, 14, 11, 1, -1, -1, 0, 0, 0, 0, true, OP_OPAQUE);
	
	//Establish Buttons
	//Sword
	if(!epos_active[0]) {tweptile[0] = 28640; twepcset[0] = 7;}
	else {tweptile[0] = eweptile[0]; twepcset[0] = ewepcset[0];}
	
	//Bow
	tweptile[3] = 30235; twepcset[3] = 7;
	
	//Wand
	tweptile[6] = eweptile[10]; twepcset[6] = ewepcset[10];
	
	//Brang
	tweptile[1] = eweptile[1]; twepcset[1] = ewepcset[1];
	
	//Torch
	tweptile[2] = 560; twepcset[2] = 1;
	
	//Hookshot
	tweptile[4] = 30900;
	if(!epos_active[6]) twepcset[4] = 6;
	else twepcset[4] = ewepcset[6];
	
	//Bomb
	tweptile[5] = 30011; twepcset[5] = 1;
	
	//Whistle
	tweptile[7] = 30520; twepcset[7] = 7;
	
	//Potion
	tweptile[8] = 30660; twepcset[8] = 8;
	
	for(int k=0; k<9; k++)
	{
		Screen->FastTile(7, 112 + (32 * (k % 3)), 40 + (24 * ((k - (k % 3)) / 3)), tweptile[k], twepcset[k], 128);
	}
	
	//Scrolls!
	if(Link->Item[145])	//Sword Beams
	{
		tscroll_active[0] = true;
		tscrolltile[0] = 31368;
		tscrollcset[0] = 8;
	}
	if(Link->Item[149])	//Hurricane Spin
	{
		tscroll_active[1] = true;
		tscrolltile[1] = 31388;
		tscrollcset[1] = 7;
	}
	if(Link->Item[42])	//Long Arrows
	{
		tscroll_active[2] = true;
		tscrolltile[2] = 31369;
		tscrollcset[2] = 7;
	}
	if(Link->Item[50])	//Penetrating Arrows
	{
		tscroll_active[3] = true;
		tscrolltile[3] = 31389;
		tscrollcset[3] = 1;
	}
	if(Link->Item[111])	//Triple Magic
	{
		tscroll_active[4] = true;
		tscrolltile[4] = 31370;
		tscrollcset[4] = 9;
	}
	if(Link->Item[150])	//Power Magic
	{
		tscroll_active[5] = true;
		tscrolltile[5] = 31390;
		tscrollcset[5] = 11;
	}
	if(Link->Item[119])	//Hard Boomer
	{
		tscroll_active[6] = true;
		tscrolltile[6] = 31371;
		tscrollcset[6] = 1;
	}
	if(Link->Item[144])	//Triple Torch
	{
		tscroll_active[7] = true;
		tscrolltile[7] = 31372;
		tscrollcset[7] = 1;
	}
	if(Link->Item[121])	//Hookshot Damage
	{
		tscroll_active[8] = true;
		tscrolltile[8] = 31393;
		tscrollcset[8] = 11;
	}
	
	if(Link->Item[106])	//Power Bombs
	{
		tscroll_active[9] = true;
		tscrolltile[9] = 31391;
		tscrollcset[9] = 1;
	}
	if(Link->Item[122])	//Healing Music
	{
		tscroll_active[10] = true;
		tscrolltile[10] = 31373;
		tscrollcset[10] = 8;
	}
	if(Link->Item[108])	//Potion Master
	{
		tscroll_active[11] = true;
		tscrolltile[11] = 31392;
		tscrollcset[11] = 8;
	}
	
	
	
	for(int m=0; m<6; m++)
	{
		if(tscroll_active[m])Screen->FastTile(7, 80 + (16 * (m % 2)), 40 + (24 * ((m - (m % 2)) / 2)), tscrolltile[m], tscrollcset[m], 128);
	}
	
	for(int n=6; n<12; n++)
	{
		if(tscroll_active[n])Screen->FastTile(7, 160 + (32 * (n % 2)), 40 + (24 * (((n-6) - ((n-6) % 2)) / 2)), tscrolltile[n], tscrollcset[n], 128);
	}
	Screen->SetRenderTarget(RT_SCREEN);
}

void settext3()
{
	int _nscrl[35] = "No Scroll found yet";
	
	int _swrd1[35] = "Fire a beam when at 100% health";
	int _swrd2[35] = "Hold B for hurricane spin";
	
	int _arrw1[30] = "Arrows fly further";
	int _arrw2[30] = "Arrows penetrate enemies";
	
	int _wand1[30] = "Wand fires 3 magic shots";
	int _wand2[30] = "Magic does 2x damage";
	
	int _boomr[30] = "Throw boomerang further";
	int _3trch[40] = "Throw three flames with one torch";
	int _grapl[40] = "Hookshot does 2 damage";
	int _pbomb[30] = "Bombs do 2x damage";
	int _music[40] = "Using the whistle heals 10 HP";
	int _potin[30] = "Potions heal more";
	

	int desc1[60];
	int desc2[60];
		
	//Reset display strings
	memset(desc1, 0, 60);
	memset(desc2, 0, 60);
	
	if(tpos == 0)
	{
		if(tscroll_active[0]) strncatf(desc1, _swrd1, 1, 35);
		if(tscroll_active[1]) strncatf(desc2, _swrd2, 1, 35);
		if(!tscroll_active[0] && !tscroll_active[1]) strncatf(desc1, _nscrl, 1, 35);
	}

	if(tpos == 3)
	{
		if(tscroll_active[2]) strncatf(desc1, _arrw1, 1, 30);
		if(tscroll_active[3]) strncatf(desc2, _arrw2, 1, 30);
		if(!tscroll_active[2] && !tscroll_active[3]) strncatf(desc1, _nscrl, 1, 35);
	}
	
	if(tpos == 6)
	{
		if(tscroll_active[4]) strncatf(desc1, _wand1, 1, 30);
		if(tscroll_active[5]) strncatf(desc2, _wand2, 1, 30);
		if(!tscroll_active[4] && !tscroll_active[5]) strncatf(desc1, _nscrl, 1, 35);
	}
	
	if(tpos == 1) {if(tscroll_active[6]) strncatf(desc1, _boomr, 1, 30); else strncatf(desc1, _nscrl, 1, 35);}
	if(tpos == 2) {if(tscroll_active[7]) strncatf(desc1, _3trch, 1, 40); else strncatf(desc1, _nscrl, 1, 35);}
	if(tpos == 4) {if(tscroll_active[8]) strncatf(desc1, _grapl, 1, 40); else strncatf(desc1, _nscrl, 1, 35);}
	if(tpos == 5) {if(tscroll_active[9]) strncatf(desc1, _pbomb, 1, 30); else strncatf(desc1, _nscrl, 1, 35);}
	if(tpos == 7) {if(tscroll_active[10]) strncatf(desc1, _music, 1, 40); else strncatf(desc1, _nscrl, 1, 35);}
	if(tpos == 8) {if(tscroll_active[11]) strncatf(desc1, _potin, 1, 30); else strncatf(desc1, _nscrl, 1, 35);}
	
	Screen->DrawString(6, 72, 118, 6, 8, -1, 0, desc1, 128);	
	Screen->DrawString(6, 72, 130, 6, 8, -1, 0, desc2, 128);	
}