//ZRPG Edit v0.2
//24MAY2015

//Constants
const int WPS_BLOCKPROJECTILE = 93; //The sprite ID to use for the block projectiles' graphics.
const int WPS_BLOCKPUFF = 23; //The sprite ID to use for the block's creation and destruction.
const int WPS_BLANK = 98; //A Sprite ID that is blank.
const int LW_BLOCKPROJECTILE = 154; //The scripted weapon to use for the block projectiles.
const int LW_BLOCKCHECKER = 154; //The scripted weapon used to check for existing blocks.
const int CT_COSBLOCK = 12; //The combo type (Not number) to use for cane of somaria blocks.
const int CT_COSCHANGE1 = 143; //The combo type (Not number) to denote a optional change of direction for the platforms.
const int CT_COSCHANGE2 = 144;//The combo type (Not number) to denote a force change of direction for the platforms.
const int CF_NOCOSBLOCKS = 99; //Flag used to denote that a block cannot be created at this combo.
const int CF_UPLEFT_DOWNRIGHT = 100; //Make this the forced change combo's inherent flag.
const int CF_DOWNLEFT_UPRIGHT = 101; //Make this the forced change combo's inherent flag.
 
const int WSP_FALLING        = 100; //Weapon/Misc. sprite for Link falling down a hole
const int WSP_LAVA            = 101; //Weapon/Misc. sprite for Link drowning in lava
const int SFX_FALLING        = 38; //SFX for falling down a hole
const int SFX_LAVA            = 55; //SFX for drowning in lava=
const int CMB_AUTOWARP        = 7; //Combo ID of a transparent AutoWarp A combotype
 
const int CT_HOLELAVA        = 11; //Combotype to give hole functionality to (default is Left Statue)

//Platform array constants.
const int PLATFORM_COMBO_DATA = 15616; //Assign combo of platform to this constant.
const int PLATFORM_DEFAULT_SPEED = 100;
const int PLATFORM_DEFAULT_CSET = 2;

const int PLATFORM_DATA = 0;
const int PLATFORM_CSET = 1;
const int PLATFORM_SPEED = 2;
const int PLATFORM_X = 3;
const int PLATFORM_Y = 4;
const int PLATFORM_X_OFFSET = 16;
const int PLAYFORM_Y_OFFSET = 16;
	
	
//Global Variables
int platformscript; //Cane of Somaria platform script.
float platformargs[8]={PLATFORM_COMBO_DATA, PLATFORM_DEFAULT_CSET, PLATFORM_DEFAULT_SPEED, 20,20}; //Cane of Somaria platform script arguments.
int blockarray[4]; //Array that contains the block data.
int combo; //The combo that is currently being effected by the cane of somaria.
int undercombo[3]; //Array used to store the combo underneath the cane of somaria blocks.
int platformdir; //Stores the platform's current direction.
bool usedcane; //Boolean used to determine when the cane has just been used.
bool createplatform; //Boolean used to determine if a platform is to be created instead of a block.
bool onplatform; //Boolean used to determine if Link is on a cane of somaria platform.
bool blockmoving; //Boolean that is true when a block is currently moving.
 
global script Slot2{
        void run(){
                bool delaying;
        bool scrollinginit;
        int scrollingframes;
        int platformx;
        int platformy;
        int delay;
        onplatform = false;
        platformdir = -1;
        usedcane = false;
                StartClock();
                while(true){
                        resetLinkCollision();
                        UpdateGhostZHData();
                        UpdateEWeapons();
                        CleanUpGhostFFCs();
                        Waitdraw();
                        AutoGhost();
                        DrawGhostFFCs();
                        CrystalBlocks();
                        ImmolatedHookshot();
                        DoABWeaponCycling();
                       
                        if(usedcane){
                if(!delaying){
                    delaying = true;
                    delay = 12;
                }
                else if(delay != 0){
                    delay--;
                }
                else{
                    delaying = false;
                    if(!BlockExist()){
                         if(createplatform){
                             createplatform = false;
                             lweapon puff = CreateLWeaponAt(LW_SPARKLE,ComboX(combo),ComboY(combo));
                             puff->UseSprite(WPS_BLOCKPUFF);
                             RunFFCScript(platformscript,platformargs);
                             usedcane = false;
                         }
                         else{
                             CreateBlock();
                             usedcane = false;
                         }
                    }
                    else if(FirstComboTypeOf(CT_COSBLOCK,0) != -1){
                        DestroyBlock();
                        usedcane = false;
                    }
                }
            }
            if(BlockExist()){
                if(blockmoving && FirstComboTypeOf(CT_COSBLOCK,0) != -1) blockmoving = false;
                if(!blockmoving) BlockMoved();
            }
            if(onplatform && platformdir >= 0 && Link->Action == LA_SCROLLING) {
                if(!scrollinginit) {
                    if((platformdir & 2) == 0) {
                        platformx = Link->X;
                        scrollingframes = 40;
                        if(platformdir == DIR_UP) platformy = 0;
                        else platformy = 160;
                    }
                    else {
                        platformy = Link->Y;
                        scrollingframes = 60;
                        if(platformdir == DIR_LEFT) platformx = 0;
                        else platformx = 240;
                    }
                    int ffcindex;
                    ffc newplatform;
                    combo = ComboAt(CenterLinkX(), CenterLinkY());
                    ffcindex = RunFFCScript(platformscript, platformargs);
                    newplatform = Screen->LoadFFC(ffcindex);
                    newplatform->X = ComboX(combo);
                    newplatform->Y = ComboY(combo);
                    scrollinginit = true;
                }
                else if(scrollingframes > 0) {
                    if(platformdir == DIR_UP) platformy += 4;
                    else if(platformdir == DIR_DOWN) platformy -= 4;
                    else if(platformdir == DIR_LEFT) platformx += 4;
                    else platformx -= 4;
                    scrollingframes--;
                }
                Screen->FastCombo(2, platformx, platformy, platformargs[0], platformargs[1], 128);
            }
            else if(onplatform && platformdir == -1 && FindFFCRunning(platformscript) == 0) {
                onplatform = false;
                scrollinginit = false;
            }
            else if(Link->Action != LA_SCROLLING) scrollinginit = false;
                       
                        Waitframe();
                }
        }
}
 
//Function to check if a block or platform exists.
bool BlockExist(){
    bool exists;
    for(int i = Screen->NumLWeapons(); i > 0; i--){
        lweapon wpn = Screen->LoadLWeapon(i);
        if(wpn->ID == LW_BLOCKCHECKER){
            if(wpn->DeadState == -1) exists = true;
        }
    }
    return(exists);
}
 
//Function to create blocks.
void CreateBlock(){
    if(Screen->ComboS[combo] == 0000b && !ComboFI(combo, CF_NOCOSBLOCKS)) {
        lweapon puff = CreateLWeaponAt(LW_SPARKLE,ComboX(combo),ComboY(combo));
        puff->UseSprite(WPS_BLOCKPUFF);
        lweapon blockchecker = CreateLWeaponAt(LW_BLOCKCHECKER,0,0);
        blockchecker->DeadState = -1;
        blockchecker->UseSprite(WPS_BLANK);
        blockchecker->CollDetection = false;
        while(puff->isValid()) Waitframe();
        StoreUndercombo(combo);
        Screen->ComboD[combo] = blockarray[0];
        Screen->ComboC[combo] = blockarray[1];
        Screen->ComboT[combo] = CT_COSBLOCK;
        Screen->ComboF[combo] = CF_PUSH4WAYINS;
    }
}
 
//Function to destroy blocks.
void DestroyBlock(){
    combo = FirstComboTypeOf(CT_COSBLOCK,0);
    for(int i = 0; i < 4; i++){
        lweapon wpn = CreateLWeaponAt(LW_BLOCKPROJECTILE, ComboX(combo), ComboY(combo));
        wpn->UseSprite(WPS_BLOCKPROJECTILE);
        wpn->Dir = i;
        wpn->Step = blockarray[2];
        if(i == 2 || i == 3) wpn->OriginalTile += wpn->NumFrames;
        if(i == 1) wpn->Flip = 2;
        else if(i == 2) wpn->Flip = 1;
        wpn->Damage = blockarray[3];
    }
    lweapon puff = CreateLWeaponAt(LW_SPARKLE, ComboX(combo), ComboY(combo));
    puff->UseSprite(WPS_BLOCKPUFF);
    lweapon blockchecker = LoadLWeaponOf(LW_BLOCKCHECKER);
    blockchecker->DeadState = WDS_DEAD;
    RestoreUndercombo();
}
 
//Function to set the undercombo beneath blocks
void StoreUndercombo(int position){
    undercombo[0] = Screen->ComboD[position];
    undercombo[1] = Screen->ComboC[position];
    undercombo[2] = Screen->ComboF[position];
}
 
//Function to restore undercombo beneath blocks.
void RestoreUndercombo(){
    Screen->ComboD[combo] = undercombo[0];
    Screen->ComboC[combo] = undercombo[1];
    Screen->ComboF[combo] = undercombo[2];
}
 
//Function to check if the block was pushed this frame.
bool BlockMoved(){
    if(Screen->ComboT[combo] != CT_COSBLOCK){
        RestoreUndercombo();
        if(Link->Dir == DIR_UP) {
            StoreUndercombo(combo - 16);
            combo -= 16;
        }
        else if(Link->Dir == DIR_DOWN) {
            StoreUndercombo(combo + 16);
            combo += 16;
        }
        else if(Link->Dir == DIR_LEFT) {
            StoreUndercombo(combo - 1);
            combo--;
        }
        else if(Link->Dir == DIR_RIGHT) {
            StoreUndercombo(combo + 1);
            combo++;
        }
        blockmoving = true;
        return true;
    }
    else return false;
}
 
void DestroyPlatform() {
   onplatform = false;
   platformdir = -1;
   ffc temp;
   for(int i = 1; i <= 32; i++) {
      temp = Screen->LoadFFC(i);
      if(temp->Script == platformscript) {
         temp->X = 0;
         temp->Y = 0;
         temp->Vx = 0;
         temp->Vy = 0;
         temp->EffectHeight = 16;
         temp->Script = 0;
      }
   }
}
 
bool Falling;
ffc script HoleLava{
    void run(int lava, int warpto, int warptype, int damage){
        int graphic = WSP_FALLING; int sfx = SFX_FALLING;
        if(lava){ graphic = WSP_LAVA; sfx = SFX_LAVA; }
        if(this->X == 0 && this->Y == 0){
            Waitframes(5);
            this->X = Link->X; this->Y = Link->Y;
        }
        if(damage == 0) damage = 8;
   
        while(true){
            while(!OnPitCombo()) Waitframe();
            int pitclk = 0;
            while(OnPitCombo() && pitclk++ < 4) WaitCancelFeather();
            if(pitclk >= 5) Fall(this,sfx,graphic,damage,warpto,warptype);
        }
    }
    void Fall(ffc pos, int sfx, int graphic, int damage, int warpto, int warptype){
        Falling = true;
        Game->PlaySound(sfx);
       
        for(int i=1;i<=Screen->NumLWeapons();i++){
            lweapon l = Screen->LoadLWeapon(i);
            if(l->ID == LW_SWORD) l->DeadState = WDS_DEAD;
        }
       
        int wait = CreateGraphic(graphic);
        Link->CollDetection = false; Link->Invisible = true;
        for(int i=0;i<30;i++) WaitNoAction();
        Link->CollDetection = true; Link->Invisible = false;
 
        if(warpto) Warp(pos, warptype);
 
        Link->X = pos->X; Link->Y = pos->Y;
        Link->HP -= damage;
        Game->PlaySound(SFX_OUCH);
        Falling = false;
    }
    void Warp(ffc Warp, int warptype){
        int orig = Warp->Data;
        Warp->Data = CMB_AUTOWARP+warptype;
        Warp->Flags[FFCF_CARRYOVER] = true;
        Waitframe();
        Warp->Data = orig;
        Warp->Flags[FFCF_CARRYOVER] = false;
        Link->Z = Link->Y;
        Quit();
    }
    bool OnPitCombo(){
        return (Screen->ComboT[ComboAt(Link->X+8,Link->Y+8)] == CT_HOLELAVA && Link->Z <= 0 && Link->Action != LA_FROZEN && !onplatform);
    }
    int CreateGraphic(int sprite){
        lweapon l = Screen->CreateLWeapon(LW_SCRIPT1);
        l->HitXOffset = 500;
        l->UseSprite(sprite);
        l->DeadState = l->NumFrames*l->ASpeed;
        l->X = Link->X; l->Y = Link->Y;
        return l->DeadState;
    }
    void WaitCancelFeather(){
        if(GetEquipmentA() == I_ROCSFEATHER && Link->InputA) Link->InputA = false;
        if(GetEquipmentB() == I_ROCSFEATHER && Link->InputB) Link->InputB = false;
        Waitframe();
    }
}

 
//Item Script
item script CaneofSomaria{
    void run(int FAKE, int ffcData, int ffcCSet, int ffcSpeed, int ffcScript, int blockData, int blockCSet, int projectileSpeed){
        usedcane = true;
        DestroyPlatform();
	    int linkX = Link->X;
	    int linky = Link->Y;
	    int platX;
	    int platY;
	if ( Link->Dir == DIR_UP ) {
		platX = linkX - PLATFORM_X_OFFSET;
		platY = linkY;
	}
	if ( Link->Dir == DIR_DOWN ) {
		platX = linkX - PLATFORM_X_OFFSET;
		platY = linkY;
	}
	if ( Link->Dir == DIR_LEFT ) {
		platX = linkX;
		platY = linkY - PLATFORM_Y_OFFSET;
	}
	if ( Link->Dir == DIR_RIGHT ) {
		platX = linkX;
		platY = linkY + PLATFORM_Y_OFFSET;
	}
	platformargs[PLATFORM_X] = platX;
	platformargs[PLATFORM_X] = platY;
        if(!BlockExist()){
            if(Screen->ComboT[ComboAt(CenterLinkX() + InFrontX(Link->Dir, 0), CenterLinkY() + InFrontY(Link->Dir, 0))] != CT_DOCK &&
                Screen->ComboF[ComboAt(CenterLinkX() + InFrontX(Link->Dir, 0), CenterLinkY() + InFrontY(Link->Dir, 0))] == CF_RAFT){
                createplatform = true;
                combo = ComboAt(CenterLinkX() + InFrontX(Link->Dir, 0), CenterLinkY() + InFrontY(Link->Dir, 0));
                platformscript = ffcScript;
                platformargs[0] = ffcData;
                platformargs[1] = ffcCSet;
                platformargs[2] = ffcSpeed;
            }
            else{
                createplatform = false;
                combo = ComboAt(CenterLinkX()+ InFrontX(Link->Dir, 0), CenterLinkY() + InFrontY(Link->Dir, 0));
                blockarray[0] = blockData;
                blockarray[1] = blockCSet;
                blockarray[2] = projectileSpeed;
                blockarray[3] = this->Power;
            }
        }
    }
}
 
 
 
//Platform Script
ffc script COS_Platform{
    void run(int data, int cset, float speed, int locX, int locY){
        this->X = locX;
        this->Y = locY;
        this->Misc[0] = speed;
        if(!onplatform) Start(this);
        else {
           Move(this, platformdir);
           NoAction();
        }
        while(true) {
            if(OnPlatform(this) && Link->Z == 0){
                Link->X = this->X;
                Link->Y = this->Y;
            }
            int position = ComboAt(CenterX(this),CenterY(this));
            if(this->X % 16 == 0 && this->Y % 16 == 0){
                if(Screen->ComboT[position] != CT_DOCK && Screen->ComboF[position] == CF_RAFT){
                    Stop(this);
                }
                else if(Screen->ComboT[position] == CT_COSCHANGE1){
                    if(Link->Dir == DIR_UP && platformdir != DIR_DOWN && Screen->ComboF[position - 16] == CF_RAFTBRANCH){
                        Move(this, 0);
                    }
                    else if(Link->Dir == DIR_DOWN && platformdir != DIR_UP && Screen->ComboF[position + 16] == CF_RAFTBRANCH){
                        Move(this, 1);
                    }
                    else if(Link->Dir == DIR_LEFT && platformdir != DIR_RIGHT && Screen->ComboF[position - 1] == CF_RAFTBRANCH){
                        Move(this, 2);
                    }
                    else if(Link->Dir == DIR_RIGHT && platformdir != DIR_LEFT && Screen->ComboF[position + 1] == CF_RAFTBRANCH){
                        Move(this, 3);
                    }
                    else{
                        if(platformdir == 0){
                            if(Screen->ComboF[position - 16] == CF_RAFTBRANCH);
                            else if(Screen->ComboF[position - 1] == CF_RAFTBRANCH) Move(this,2);
                            else if(Screen->ComboF[position + 1] == CF_RAFTBRANCH) Move(this,3);
                            else Stop(this); // If this is done, it's an error on your part.
                        }
                        else if(platformdir == 1){
                            if(Screen->ComboF[position + 16] == CF_RAFTBRANCH);
                            else if(Screen->ComboF[position + 1] == CF_RAFTBRANCH) Move(this,3);
                            else if(Screen->ComboF[position - 1] == CF_RAFTBRANCH) Move(this,2);
                            else Stop(this); // If this is done, it's an error on your part.
                        }
                        else if(platformdir == 2){
                            if(Screen->ComboF[position - 1] == CF_RAFTBRANCH);
                            else if(Screen->ComboF[position - 16] == CF_RAFTBRANCH) Move(this,0);
                            else if(Screen->ComboF[position + 16] == CF_RAFTBRANCH) Move(this,1);
                            else Stop(this); // If this is done, it's an error on your part.
                        }
                        else if(platformdir == 3){
                            if(Screen->ComboF[position + 1] == CF_RAFTBRANCH);
                            else if(Screen->ComboF[position + 16] == CF_RAFTBRANCH) Move(this,1);
                            else if(Screen->ComboF[position - 16] == CF_RAFTBRANCH) Move(this,0);
                            else Stop(this); // If this is done, it's an error on your part.
                        }
                    }
                }
                else if(Screen->ComboT[position] == CT_COSCHANGE2){
                    if(Screen->ComboI[position] == CF_UPLEFT_DOWNRIGHT) Move(this, platformdir ^ 10b);
                    else if(Screen->ComboI[position] == CF_DOWNLEFT_UPRIGHT) Move(this, platformdir ^ 11b);
                }
                else if(Screen->ComboF[position] == 103) Move(this, platformdir ^ 1b);
            }
            if(this->X <= -16 || this->X >= 256 || this->Y <= -16 || this->Y >= 176) break;
            Screen->FastCombo(2, this->X, this->Y, data, cset, 128);
            Waitframe();
        }
        DestroyPlatform();
    }
    void Start(ffc platform){
        while(platform->Vx == 0 && platform->Vy == 0){
            if(OnPlatform(platform)) {
                if(Link->PressUp && Screen->ComboF[ComboAt(CenterX(platform), CenterY(platform)) - 16] == CF_RAFTBRANCH){
                    Move(platform, 0);
                }
                else if(Link->PressDown && Screen->ComboF[ComboAt(CenterX(platform), CenterY(platform)) + 16] == CF_RAFTBRANCH){
                    Move(platform, 1);
                }
                else if(Link->PressLeft && Screen->ComboF[ComboAt(CenterX(platform), CenterY(platform)) - 1] == CF_RAFTBRANCH){
                    Move(platform,2);
                }
                else if(Link->PressRight && Screen->ComboF[ComboAt(CenterX(platform), CenterY(platform)) + 1] == CF_RAFTBRANCH){
                    Move(platform, 3);
                }
            }
            Screen->FastCombo(2, platform->X, platform->Y, platformargs[0], platformargs[1], 128);
            Waitframe();
        }
    }
    void Stop(ffc platform){
        platform->Vx = 0;
        platform->Vy = 0;
        platform->EffectHeight = 16;
        platformdir = -1;
        Start(platform);
    }
    void Move(ffc platform, int direction){
        if(direction == 0){
            platform->Vx = 0;
            platform->Vy = platform->Misc[0] * -1;
        }
        else if(direction == 1){
            platform->Vx = 0;
            platform->Vy = platform->Misc[0];
        }
        else if(direction == 2){
            platform->Vx = platform->Misc[0] * -1;
            platform->Vy = 0;
        }
        else if(direction == 3){
            platform->Vx = platform->Misc[0];
            platform->Vy = 0;
        }
        platform->EffectHeight = 20;
        platformdir = direction;
        if(onplatform && Link->Z == 0) {
           Link->X = platform->X;
           Link->Y = platform->Y;
        }
    }
    bool OnPlatform(ffc platform){
        if(CenterLinkX() >= platform->X && CenterLinkX() <= (platform->X + (platform->TileWidth * 16)) &&
               CenterLinkY() >= platform->Y && CenterLinkY() <= (platform->Y + (platform->TileHeight * 16))) onplatform = true;
        else onplatform = false;
        return onplatform;
    }

    }
