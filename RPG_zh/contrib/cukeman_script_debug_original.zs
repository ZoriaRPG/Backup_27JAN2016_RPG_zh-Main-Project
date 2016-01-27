import "std.zh"
import "ffcscript.zh"
 
 
const int FLICKER_SCRIPT = 1; //The script number.
const int FLICKER_TIME = 32; //Default 32.
const int WSP_FALLING        = 88; //Weapon/Misc. sprite for Link falling down a hole
const int WSP_LAVA            = 101; //Weapon/Misc. sprite for Link drowning in lava
const int SFX_FALLING        = 64; //SFX for falling down a hole
const int SFX_LAVA            = 55; //SFX for drowning in lava
const int CMB_AUTOWARP        = 200; //Combo ID of a transparent AutoWarp A combotype
const int CT_HOLELAVA        = 11; //Combotype to give hole functionality to (default is Left Statue)
const int I_NOJINX = 112; // Set the item number here
const int S_SOLDCOMBO        = 0; // Combo for the item not being available. (Transparent or a "sold out" sign.)
const int S_SOLDCSET         = 0; // CSet for the item not being available. (Only if you want a "sold out" sign.)
const int S_NORUPEES = 0; //Message saying 'Not enough rupees'
const int S_THANKS   = 0; //Message saying 'Thanks for buying'
const int shadowTile = 64240; //Tile of a shadow
const int shadowCSet = 7; //CSet of said shadow
const int countDownColorText = 1; //Color of timer text
const int countDownColorBG = 0; //Color of timer BG
 
 
const float Lspeedpercent=200;
 
 
int blastremitem = 112; //item to be removed
int lastX;
int lastY;
int curmap=-1;
int curscreen=-1;
int downtime=-1;
int countDown = -1; //Global countdown timer
int countDownWarpMap = 0; //Don't set here - set in FFC
int countDownWarpScreen = 0; //Don't set here - set in FFC
 
 
bool readmessage[256];
bool Falling;
bool pressdL=false;
 
 
global script Slot2
{
    void run()
    {
        Game->Counter[CR_SCRIPT10]=1;
        lastX = Link->X;
        lastY = Link->Y;
       
        while(true)
        {
         if(Link->Item[I_NOJINX])
        {
            Link->SwordJinx=0;
            Link->ItemJinx=0;
        }  
            bombFunction();
           
            flickerNPCs();
 
        countDown();
 
            OutOfBombs();
 
            OutOfBombs2();
           
            SetContinueScreenOnDeath();
 
            fastRun();
           
            Waitframe();
        }
    }
}
 
 
void countDown()
{
        while(true){
            if ( countDown > -1 ){
                Screen->DrawInteger(7, 4, 4, FONT_S, //Draw the timer
                    countDownColorText, countDownColorBG,
                    0, 0, countDown, 0, 128);
                countDown--;
                if ( !countDown ) //If time runs out
                    Link->Warp(countDownWarpMap, countDownWarpScreen); //Warp Link
            }
            Waitframe();
        }
    }
 
 
void bombFunction()
{
    int i;
   
    //for LW_ bombs
    for(i=1; i<=Screen->NumLWeapons(); i++)
    {
        lweapon bl = Screen->LoadLWeapon(i);
        if((bl->ID==LW_BOMBBLAST || bl->ID==LW_SBOMBBLAST) && LinkCollision(bl)) Link->Item[blastremitem]=false;
    }
    //for EW_ bombs
    for(i=1; i<=Screen->NumEWeapons(); i++)
    {
        eweapon be = Screen->LoadEWeapon(i);
        if((be->ID==EW_BOMBBLAST || be->ID==EW_SBOMBBLAST) && LinkCollision(be)) Link->Item[blastremitem]=false;
    }
}
 
void flickerNPCs()
{
    for(int i = Screen->NumNPCs(); i > 0; i--)
    {
        npc e = Screen->LoadNPC(i);
        if(e->Misc[0] == 0)
        {
            int args[8] = {e->ID};
            RunFFCScript(FLICKER_SCRIPT, args);
        }
    }
}
 
void OutOfBombs()
{
    if(Game->Counter[CR_BOMBS] == 0){
        Link->Item[144] = true;
        }
            else{
            Link->Item[144] = false;
}
}
 
 
void OutOfBombs2()
{
    if(Game->Counter[CR_SBOMBS] == 0){
        Link->Item[146] = true;
        }
            else{
            Link->Item[146] = false;
}
}
 
 
void SetContinueScreenOnDeath()
{
   if(Link->HP <= 0)
   {
      Link->HP = 1;
      Link->PitWarp(0, 4);
      NoAction();
      Waitframe();
      Link->HP = 0;
      NoAction();
      Waitframe();
   }
}
 
void fastRun()
{float    Lspeed=Lspeedpercent/100;
    if(Game->Counter[CR_SCRIPT10]==1)
    {  //make input false when item wasnt lifted yet
        Link->InputL=false;
    }
   
    if(curscreen!=Game->GetCurScreen()&&curmap==Game->GetCurMap()){
        Waitframes(10);
        curscreen=Game->GetCurScreen();
        lastX=Link->X;
        lastY=Link->Y;
    }
    if(curmap!=Game->GetCurMap()&&curscreen==Game->GetCurScreen()){
        Waitframes(10);
        curmap=Game->GetCurMap();
        lastX=Link->X;
        lastY=Link->Y;
    }
    if(curmap!=Game->GetCurMap()&&curscreen!=Game->GetCurScreen()){
        Waitframes(10);
        curscreen=Game->GetCurScreen();
        curmap=Game->GetCurMap();
        lastX=Link->X;
        lastY=Link->Y;
    }    
 
    if(Link->InputL&&downtime<0){ //checkj if L pressed if so toggle between running and not running state
        pressdL=!pressdL;
        downtime=10;  
    }
    if(downtime>-1){  // the downtime makes sure there are no glitches by the toggle button like toggle between running and not running too fast
        downtime-=1;
    }
 
    if(pressdL){ //Test if L was pressed
 
        Link->InputA=false;
 
        Link->InputB=false;
        Link->X+=round((Lspeed-1)*(Link->X-lastX));
        Link->Y+=round((Lspeed-1)*(Link->Y-lastY));
    }
   
    lastX=Link->X;
    lastY=Link->Y;
}
 
int round(float f){
   
    if(f<0.5&&f>-0.5){
        return 0;
    }else{
    int diff=f;
    int num=0;
    if(diff>0){
    while(diff>1){
    diff-=1;
    num+=1;
    }
    if(diff<0.5){
    return num;
    }else{
    return num+1;
    }
    }else{
        while(diff<-1){
    diff+=1;
    num-=1;
    }
    if(diff>-0.5){
    return num;
    }else{
    return num-1;
    }
}
}
}
 
 
ffc script FlickerWhenHit{
    void run(int enemyID){
        npc e = FindNPCOf(enemyID);
        e->Misc[0] = 1;
        int life = e->HP;
        int offset = e->DrawYOffset;
        int flicker;
        while(e->isValid()){
            if(e->HP < life){
                flicker = FLICKER_TIME;
                life = e->HP;
            }
            if(flicker > 0 && e->HP > 0){
                if(flicker%2 == 0) e->DrawYOffset = -200;
                else e->DrawYOffset = offset;
                flicker--;
            }
            else e->DrawYOffset = offset;
            Waitframe();
        }
    }
    npc FindNPCOf(int enemyID){
        npc e;
        for(int i = Screen->NumNPCs(); i > 0; i--){
            npc e2 = Screen->LoadNPC(i);
            if(e2->ID != enemyID) continue;
            else if(e2->Misc[0] != 0) continue;
            e = e2;
            break;
        }
        return(e);
    }
}
 
 
ffc script Title_Jinx
{
    void run()
    {
    Link->SwordJinx = 7200;
    Link->ItemJinx = 7200;
    }
}
 
 
ffc script Press_Start{
    void run(){
        while(true){
            if(Link-> InputStart){
                Link->Warp(00, 01);
            }
        Waitframe();
        }
    }
}
 
 
ffc script Laugh_Jinx
{
    void run()
    {
    Link->SwordJinx = 200;
    Link->ItemJinx = 200;
    }
}
 
 
item script Message{
    void run(int m){
        Screen->Message(m);
    }
}
 
 
ffc script thunder{
   void run(int tile, int layer, int trans, int startframe, int endframe, int totalframes, int delay, int sound){
       int cset = this->CSet;
       int x = this->X;
       int y = this->Y;
       int w = this->TileWidth;
       int h = this->TileHeight;
       int counter = 1;
       while(true){
           if(counter == startframe + delay) Game->PlaySound(sound);
           if(counter >= startframe && counter <= endframe) Screen->DrawTile(layer, x, y, tile, w, h, cset, -1, -1, 0, 0, 0, 0, true, trans);
           if(counter < totalframes) counter++;
           else counter = 1;
           Waitframe();
       }
   }
}
 
 
ffc script OneTimeMessage{
    void run(int string, int boolean){
        if(!readmessage[boolean]){
            Screen->Message(string);
            readmessage[boolean] = true;
        }
    }
}
 
 
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
        return (Screen->ComboT[ComboAt(Link->X+8,Link->Y+8)] == CT_HOLELAVA && Link->Z <= 0 && Link->Action != LA_FROZEN);
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
 
 
ffc script createItem
{
    void run(int itemID)
    {
        item i = Screen->CreateItem(itemID);
        i->X = this->X;
        i->Y = this->Y;
        i->Pickup=IP_HOLDUP;
    }
}
 
 
item script MessageMod{
    void run(int m, int stop){
        if(!Link->Item[stop])
        {Screen->Message(m);
        }
    }
}
 
 
ffc script Remove{
    void run(int i){
        if(Link->Item[i]){
               Link->Item[i]=false;
         }
     }
}
 
 
ffc script ChestMessage {
   void run(int m) {
      if(Screen->State[ST_CHEST] || Screen->State[ST_LOCKEDCHEST] || Screen->State[ST_BOSSCHEST]) Quit();
      while(!Screen->State[ST_CHEST] && !Screen->State[ST_LOCKEDCHEST] && !Screen->State[ST_BOSSCHEST]) Waitframe();
      Screen->Message(m);
   }
}
 
 
item script MessageShop{
    void run(int m1, int stop, int screen, int map, int m2){
        if(!Link->Item[stop])
        {
            if(Game->GetCurMap()!=map || Game->GetCurScreen()!=screen) Screen->Message(m1);
            else Screen->Message(m2);
        }
    }
}
 
 
ffc script StepMessage{
    void run(int m){
        while(CenterLinkX()<this->X || CenterLinkX()>this->X+this->TileWidth*16 || CenterLinkY()<this->Y || CenterLinkY()>this->Y+this->TileHeight*16) Waitframe();
        Screen->Message(m);
    }
}
 
 
ffc script real_npcV2 {
  void run(int m, int gmitem, int f, int d, int def_dir, int npcissolid, int gm_min, int gm_max) {
    int d_x;
    int d_y;
    int a_x;
    int a_y;
    int ir;
    int tho=(this->TileHeight*16-16);
    int orig_d = this->Data;
    int Apressed2;  
    int Appr2;
    int onscreenedge;
    if(d == 0) d = 48;
   
   
    while(true) {
        //This detects if link is on the edge of the screen
        if (Link->X<8 || Link->Y<8 || Link->X>232 || Link->Y>152){onscreenedge=1;} else {onscreenedge=0;}
 
        //This checks if you're above or below the NPC to create an overhead effect
        if (Link->Y<this->Y-8+tho && onscreenedge==0){this->Flags[FFCF_OVERLAY] = true;} else {this->Flags[FFCF_OVERLAY] = false;}
 
        //This detects if A was pressed, allowing you to exit messages with the A button
        if (Link->InputA)
        {
            if (Apressed2==1){Apressed2=0;}
        else
        {
            if (Appr2==0){Apressed2=1; Appr2=1;}}
        }
        else
        {
            Apressed2=0;
            Appr2=0;
        }
 
        d_x = this->X - Link->X;
        d_y = this->Y+(this->TileHeight*16-16) - Link->Y;
        a_x = Abs(d_x);
        a_y = Abs(d_y);
     
        if(f != 0) {
            if(a_x < d && a_y < d) {
                  if(a_x <= a_y) {
                    if(d_y >= 0) {
                          this->Data = orig_d + DIR_DOWN;
                    } else {
                        this->Data = orig_d + DIR_UP;
                    }
                } else {
                    if(d_x >= 0) {
                        this->Data = orig_d + DIR_LEFT;
                    } else {
                        this->Data = orig_d + DIR_RIGHT;
                    }
                  }
            } else {
                this->Data = orig_d + def_dir;
            }
        }
       
        //This checks if you have item D1, and makes the NPC disappear if you do.
        if (Link->Item[gmitem] == true){this->X=-256; this->Y=-256;}
        else
        {
 
            //This enables horizontal guard mode.
            if (gm_max>0)
            {
                if (Link->X>gm_min-32 && Link->X<gm_max+32 && Link->Y>this->Y+tho-32 && Link->Y<this->Y+tho+32) {ir=1;}
                else {ir=0;}
                if (Link->X<this->X-2 && this->X>gm_min && ir==1)
                {
                    if (Link->X>gm_min){this->Vx= (- this->X + Link->X)/4;}
                    else{this->Vx= (- this->X + gm_min)/4;}
                }
                if (Link->X>this->X+2 && this->X<gm_max && ir==1)
                {
                    if (Link->X<gm_max){this->Vx= (Link->X - this->X)/4;}
                    else{this->Vx= (gm_max - this->X)/4;}
                }
                if (Link->X<this->X+2 && Link->X>this->X-2){this->Vx=0;}
                if (ir==0){this->Vx=0;}
                if (this->X<gm_min+1){
                    if (this->Vx<0) this->Vx=0;
                        this->X=gm_min;
                }
                if (this->X>gm_max-1){
                    if (this->Vx>0) this->Vx=0;
                    this->X=gm_max;
            }
        }
 
        //This enables vertical guard mode.
        if (gm_max<0)
        {
            if (Link->Y>-gm_min-32 && Link->Y<-gm_max+32 && Link->X>this->X-32 && Link->X<this->X+32) {ir=1;}
            else {ir=0;}
            if (Link->Y<this->Y-2+tho && this->Y+tho>-gm_min && ir==1)
            {
                if (Link->Y>-gm_min){this->Vy= (- this->Y-tho + Link->Y)/4;}
                else {this->Vy= (- this->Y-tho + -gm_min)/4;}
            }
            if (Link->Y>this->Y+2+tho && this->Y+tho<-gm_max && ir==1)
            {
                if (Link->Y<-gm_max){this->Vy= (Link->Y - this->Y-tho)/4;}
                else {this->Vy= (-gm_max - this->Y-tho)/4;}
            }
                if (Link->Y<this->Y+2+tho && Link->Y>this->Y-2+tho){this->Vy=0;}
                if (ir==0){this->Vy=0;}
                if (this->Y+tho<-gm_min+1){
                    if (this->Vy<0)this->Vy=0;
                    this->Y=-gm_min-tho;
                }
                if (this->Y+tho>-gm_max-1){
                    if (this->Vy>0)this->Vy=0;
                    this->Y=-gm_max-tho;
                }
            }
 
        }
 
        if (this->Vy>0)this->Data = orig_d + DIR_UP;
        if (this->Vy<0)this->Data = orig_d + DIR_DOWN;
        if (this->Vx>0)this->Data = orig_d + DIR_RIGHT;
        if (this->Vx<0)this->Data = orig_d + DIR_LEFT;
     
        if(Apressed2==1 && a_x < 24 && a_y < 24) {
            //This is all checking if Link is facing the NPC while to the left, to the right, above, or below the NPC
            if (Link->X<this->X-8 && Link->Y>this->Y+tho-12 && Link->Y<this->Y+tho+8 && Link->Dir == DIR_RIGHT || Link->X>this->X+8 && Link->Y>this->Y+tho-12 && Link->Y<this->Y+tho+8 && Link->Dir == DIR_LEFT || Link->Y<this->Y+tho-8 && Link->X>this->X-8 && Link->X<this->X+8 && Link->Dir == DIR_DOWN || Link->Y>this->Y+tho+8 && Link->X>this->X-8 && Link->X<this->X+8 && Link->Dir == DIR_UP){
                Apressed2=0;
                Screen->Message(m);
                Link->InputA = false;
            }
        }
 
        //This enables the NPC to be solid without having to lay a solid combo under it.
        if (npcissolid>0){
            if ((Abs(Link->X - this->X) < 10) &&
                (Link->Y <= this->Y+tho + 12) && (Link->Y > this->Y+tho+8)){Link->Y = this->Y+tho+12;}
           
            if ((Abs(Link->Y - this->Y-tho) < 10) &&
                (Link->X >= this->X - 12) && (Link->X < this->X-8)){Link->X = this->X-12;}
       
            if ((Abs(Link->X - this->X) < 10) &&
                (Link->Y >= this->Y+tho - 12) && (Link->Y < this->Y+tho-8)){Link->Y = this->Y+tho-12;}
       
            if ((Abs(Link->Y - this->Y-tho) < 10) &&
                (Link->X <= this->X + 12) && (Link->X > this->X+8)){Link->X = this->X+12;}
        }
       
        Waitframe();
    }
  }
}
 
 
ffc script playSFX
{
  void run(int sfx)
  {
    Game->PlaySound(sfx);
  }
}
 
 
ffc script LikeLike{
void run(int enemyID, int wait){
while(Screen->NumNPCs() == 0) Waitframe();
while(true){
npc n = CreateNPCAt(enemyID, this->X, this->Y);
int normal = n->OriginalTile;
int eat = n->OriginalTile + 1;
int initx = n->X;
int inity = n->Y;
while(n->isValid()){
int oldwidth = Link->HitWidth;
int oldheight = Link->HitHeight;
Link->HitWidth = 15;
Link->HitHeight = 15;
n->HitWidth = 15;
n->HitHeight = 15;
if(LinkCollision(n)) n->OriginalTile = eat;
else n->OriginalTile = normal;
Link->HitWidth = oldwidth;
Link->HitHeight = oldheight;
n->HitWidth = 16;
n->HitHeight = 16;
n->X = initx;
n->Y = inity;
Waitframe();
}
Waitframes(wait);
}
}}
 
 
item script Wand{
    void run(int flag, int sound){
        Game->PlaySound(30);
        sound = 0;
        for(int i; i < 176; i++){
            if(!ComboFI(i, flag)) continue;
            sound = this->InitD[1];
            if(Screen->ComboF[i] == flag) Screen->ComboF[i] = 0;
            Screen->ComboD[i]++;
        }
        Game->PlaySound(sound);
    }
}
 
 
item script sfx{
    void run(int sound){
        Game->PlaySound(sound);
    }
}
 
 
// Script that will check the combo under it
// When the combo changes (be it script, slash->next, etc.)
// It will play the given sfx and give the requested item
    // d0 = Item number
    // d1 = Sound effect
ffc script potScript
{
    void run(int itm, int sfx)
    {
        // Grab the combo under the FFC initially
        int combo = Screen->ComboD[ComboAt(this->X+4, this->Y+4)];
 
        // While that combo is the same, wait
        while(Screen->ComboD[ComboAt(this->X+4, this->Y+4)] == combo)
            Waitframe();
 
        // Create the item
        item temp = Screen->CreateItem(itm);
        temp->X = this->X;
        temp->Y = this->Y;
        temp->Pickup |= (IP_TIMEOUT);
        temp->HitWidth = 16;
        temp->HitHeight = 16;
 
        // Play the given sound effect
        Game->PlaySound(sfx);
    }
}
 
 
// Script that will check the combo under it
// When the combo changes (be it script, slash->next, etc.)
// It will play the given sfx and give the requested item
    // d0 = Item number
    // d1 = Sound effect
ffc script BoulderScript
{
    void run(int itm, int sfx)
    {
        // Grab the combo under the FFC initially
        int combo = Screen->ComboD[ComboAt(this->X+4, this->Y+4)];
 
        // While that combo is the same, wait
        while(Screen->ComboD[ComboAt(this->X+4, this->Y+4)] == combo)
            Waitframe();
 
        // Grab the second combo under the FFC
        combo = Screen->ComboD[ComboAt(this->X+4, this->Y+4)];
 
        // While that combo is the same, wait
        while(Screen->ComboD[ComboAt(this->X+4, this->Y+4)] == combo)
            Waitframe();
 
        // Create the item
        item temp = Screen->CreateItem(itm);
        temp->X = this->X;
        temp->Y = this->Y;
        temp->Pickup |= (IP_TIMEOUT);
        temp->HitWidth = 16;
        temp->HitHeight = 16;
 
        // Play the given sound effect
        Game->PlaySound(sfx);
    }
}
 
 
item script HiLoMessage{
    void run(int mA, int mB){
        if(Link->Y > 96){
        Screen->Message(mA);
        }
        else{
        Screen->Message(mB);
        }
    }
}
 
 
ffc script DoubleJinx
{
    void run()
    {
        while(true)
        {
            Link->SwordJinx = 2;
            Link->ItemJinx = 2;
            Waitframe();
        }
    }
}
 
 
ffc script CantMove
{
    void run()
    {
        while(true)
        {
            Link->InputUp = false;
            Link->InputDown = false;
            Link->InputLeft = false;
            Link->InputRight = false;
            Waitframe();
        }
    }
}
 
 
item script activateL{
    void run(int m){
        Game->Counter[CR_SCRIPT10]=2;
    }
}
 
 
ffc script ComboAdvancer
{
    void run()
    {
        int numNPCs=Screen->NumNPCs();
        while(true)
        {
            while(numNPCs>Screen->NumNPCs())
            {
                Screen->ComboD[ComboAt(this->X, this->Y)]++;
                numNPCs--;
            }
            numNPCs=Screen->NumNPCs();
            Waitframe();
        }
    }
}
 
 
// Basic shop script FFC. These can be purchased multiple times
    // d0 = Item number you want to be available
    // d1 = The price for the item
    // d2 = The input button to press
            // 0 for A
            // 1 for B
            // 2 for L
            // 3 for R
    // d3 = Message String after obtaining the item (if not included, default S_THANKS string is used)
ffc script Shop
{
    void run(int itm, int price, int input, int thanksString)
    {
        // Run continuously
        while(true)
        {
            // If Link is below the FFC facing up
            if(ShopCanBuy(this))
            {
                // If he hits the provided input button
                if(SelectPressInput(input))
                {
                    // Disable that input for the frame
                    SetInput(input,false);
                   
                    // If Link has enough rupees
                    if(Game->Counter[CR_RUPEES] >= price)
                    {
                        // Give Link the item
                        ShopItemThanks(itm, thanksString);
                       
                        // Remove the rupees
                        DeductRupees(price);
                    }
                    // Else Link does not have enough rupees
                    else Screen->Message(S_NORUPEES);
                }
                // Else Link is under the FFC but has not hit the correct button
                else
                {
                    // Do stuff here if you want something to happen when Link is under the item but hasn't hit the input button
                    // For example, add an input option for an informational string
                    // Or draw some graphic to indicate to the player what button to press
                }
            } //! End of if(ShopCanBuy(this))
           
            Waitframe();
        } //! End of while(true)
    } //! End of void run(int itm, int price, int input)
}//! End of ffc script Shop
 
 
// Alternate shop script FFC. These can be purchased only once.
// After it is sold, it shows the S_SOLDCOMBO combo for the FFC
    // d0 = Item number you want to be available
    // d1 = The price for the item
    // d2 = Screen->D index to use for checking the combo
    // d3 = The input button to press
            // 0 for A
            // 1 for B
            // 2 for L
            // 3 for R
    // d4 = Message String after obtaining the item (if not included, default S_THANKS string is used)
ffc script ShopSingleSaleItem
{
    void run(int itm, int price, int perm, int input, int thanksString)
    {
        // While the item has not been purchased yet
        while(Screen->D[perm] == 0)
        {
            // If Link is under the FFC facing up
            if(ShopCanBuy(this))
            {
                // If he hits the selected input button
                if(SelectPressInput(input))
                {
                    // Disable the input for the selected input button
                    SetInput(input,false);
                   
                    // If Link has enough rupees
                    if(Game->Counter[CR_RUPEES] >= price)
                    {
                        // Give Link the item
                        ShopItemThanks(itm, thanksString);
                       
                        // Blank out the FFC's combo and cset
                        this->Data = S_SOLDCOMBO;
                        this->CSet = S_SOLDCSET;
                       
                        // Remove the rupees from Link
                        DeductRupees(price);
                       
                        // Set the Screen D value to reflect that the item was purchased
                        Screen->D[perm]++;
                    }
                    // Else Link doesn't have enough rupees
                    else Screen->Message(S_NORUPEES);
                }
                // Else Link is under the FFC but has not hit the selected input button
                else
                {
                    // Do stuff here if you want something to happen when Link is under the item but hasn't hit the input button
                    // For example, add an input option for an informational string
                    // Or draw some graphic to indicate to the player what button to press
                }
            } //! End of if(CanBuy(this))
           
            Waitframe();
        } //! End of  while(Screen->D[perm] == 0)
       
        // This item has been bought, so show the sold out combo
        this->Data = S_SOLDCOMBO;
    } //! End of void run(int itm, int price, int perm, int input)
} //! End of ffc script ShopSingleSaleItem
 
 
// Checks if Link is underneath the FFC facing up
bool ShopCanBuy(ffc buy)
{
    return (Abs(Link->X-buy->X) < 8 && Abs(Link->Y-(buy->Y+8)) < 8 && Link->Dir == DIR_UP);
}
 
// Gives Link the item, shows him holding it up
void ShopItemThanks(int itm, int thanksString)
{
    // Show the "thanks" string
    if(thanksString > 0)
        Screen->Message(thanksString);
    else
        Screen->Message(S_THANKS);
   
    // Put the item underneath Link
    ShopCreateItem(Link->X,Link->Y,itm);
   
    // Force Link to hold up the item
    Game->PlaySound(SFX_PICKUP);
    Link->Action = LA_HOLD2LAND;
    Link->HeldItem = itm;
   
    // While Link is holding up the item, disable input
    while(Link->HeldItem == itm && Link->Action == LA_HOLD2LAND)
    {
        // Disable all directional input of Link and Wait a frame
        Link->InputUp = false;
        Link->InputDown = false;
        Link->InputLeft = false;
        Link->InputRight = false;
        Waitframe();
    }
} //! End of void ShopItemThanks(int itm)
 
// Function to plant an item under Link
void ShopCreateItem(int x, int y, int itm)
{
    item Spawn = Screen->CreateItem(itm);
    Spawn->HitWidth = 16; Spawn->HitHeight = 16;
    Spawn->X = x; Spawn->Y = y;
}
 
// EVERYTHING UNDER HERE IS UN-EDITED FROM Joe123's VERSION
void DeductRupees(int amount)
{
    FreezeScreen();
   
    for(int i=0;i<amount;i++)
    {
        Game->PlaySound(SFX_MSG);
        Game->Counter[CR_RUPEES]--;
        WaitNoAction();
    }
   
    UnFreeze();
}
 
int FreezeID;
void FreezeScreen(){
    FreezeID = Screen->ComboT[0];
    Screen->ComboT[0] = CT_SCREENFREEZE;
}
void UnFreeze(){
    Screen->ComboT[0] = FreezeID;
}
 
//These functions should only be included in your script file once
bool SelectPressInput(int input)
{
    if(input == 0) return Link->PressA;
    else if(input == 1) return Link->PressB;
    else if(input == 2) return Link->PressL;
    else if(input == 3) return Link->PressR;
}
void SetInput(int input, bool state){
    if(input == 0) Link->InputA = state;
    else if(input == 1) Link->InputB = state;
    else if(input == 2) Link->InputL = state;
    else if(input == 3) Link->InputR = state;
}
 
 
ffc script StepNextSFX{
    void run(int comboid, int sfx){
        while(true){
            for(int i=0; i<=175; i++){
                if(Screen->ComboD[i]==comboid){
                    Game->PlaySound(sfx);
                    Screen->ComboD[i]++;
                }
            }
            Waitframe();
        }
    }
}
 
 
ffc script changewarp{
    void run(int FI, int FS, int FD, int SI, int SS, int SD, int NEXT, int MAX){
        if(Link->Item[FI] && FI != -1){
            Screen->SetSideWarp(0, FS, FD, -1);
        }
        else if(Link->Item[SI] && SI != -1){
            Screen->SetSideWarp(0, SS, SD, -1);
        }
        else{
            if(NEXT >= 0 && NEXT <= MAX){
                Screen->D[0] = NEXT;
            }
            else{
                Screen->SetSideWarp(0, -1, -1, -1);
            }
        }
    Waitframe();
    }
}
 
 
ffc script changewarpcontinued{
    void run(int FI, int FS, int FD, int SI, int SS, int SD, int CFFC, int MAX){
        if(Screen->D[0] == CFFC){
            int NEXT;
            if(Link->Item[FI] && FI != -1){
                NEXT = Screen->D[0];
                NEXT = 1;
                Screen->D[0] = NEXT;
                Screen->SetSideWarp(0, FS, FD, -1);
            }
            else if(Link->Item[SI] && SI != -1){
                NEXT = Screen->D[0];
                NEXT = 0;
                Screen->D[0] = NEXT;
                Screen->SetSideWarp(0, SS, SD, -1);
            }
            else{
                NEXT = Screen->D[0];
                if(NEXT <= MAX){
                    NEXT = NEXT++;
                    Screen->D[0] = NEXT;
                }
                else{
                    Screen->SetSideWarp(0, -1, -1, -1);
                }
            }
        }
    Waitframe();
    }
}
 
 
ffc script ReceiveItem{
    void run(int i){
               Link->Item[i]=true;
         }
     }
 
 
ffc script createfairy
{
    void run(int itemID)
    {
        item i = Screen->CreateItem(itemID);
        i->X = this->X;
        i->Y = this->Y;
    }
}
 
 
ffc script enemyspawner{
    void run(int spawner ,int spawnenemy,int enemyspawnrate,int HP, int enemyhp, int effect,int item_out, int noreturnscreenvariable){
    npc boss;
    if(Screen->D[noreturnscreenvariable]!=3.1415||noreturnscreenvariable==-1){
    boss=CreateNPCAt(spawner,this->X,this->Y);
    }
    boss->HP=HP; //if you set the hp it will give it the hp you set
    int i=0;
    npc spawnenemies;
        spawnenemies=CreateNPCAt(0,0,0);
    int aliveenemies=0;//potential start value
   
    while(true){
    if(Screen->D[noreturnscreenvariable]!=3.1415||noreturnscreenvariable==-1){
    aliveenemies=NumNPCsOf(spawnenemy);
    int randangle=Rand(360);
    this->X=boss->X+20*Sin(randangle);
    this->Y=boss->Y-20*Cos(randangle);
    if(i==0&&boss->ID==spawner){  //Spawn enemies only at spawntimes and if the spawner is still alive
        spawnenemies=CreateNPCAt(spawnenemy,this->X,this->Y);
        spawnenemies->HP=enemyhp;
    }
    if(boss->HP<=0) boss=CreateNPCAt(0,boss->X,boss->Y); //handle the spawner's death
    //if spawner is dead and all his friends are dead do something special
    if(aliveenemies==0&&boss->ID!=spawner){
        if(effect==1) Screen->TriggerSecrets(); //trigger secret
        if(effect==2){ //create an item
        item it = Screen->CreateItem(item_out);
        it->X=Link->X;
        it->Y=Link->Y;
        it->Z=40;
        }
        if(effect==3){ // trigger permanent secret
        Screen->TriggerSecrets();
        Screen->State[13]=true;
        }
        // ################################################################################
##########################
        //Here you can add other effects you might want like healing link after killing all enemies or similar things
        //just make another if(effect==n) with number n any number different than the numbers already used for effects
        // in that if you can the write anything you want to happen once the spawner and all his friends died
        // ################################################################################
##########################
        if(noreturnscreenvariable!=-1) Screen->D[noreturnscreenvariable]=3.1415;
    }
    i=(i+1)%enemyspawnrate;
            }
             Waitframe();
    }
    }
}
 
 
ffc script LikeLike2{
void run(int enemyID, int wait){
while(Screen->NumNPCs() == 0) Waitframe();
while(true){
npc n = CreateNPCAt(enemyID, this->X, this->Y);
int normal = n->OriginalTile;
int eat = n->OriginalTile + 1;
int initx = n->X;
int inity = n->Y;
while(n->isValid()){
int oldwidth = Link->HitWidth;
int oldheight = Link->HitHeight;
Link->HitWidth = 15;
Link->HitHeight = 15;
n->HitWidth = 15;
n->HitHeight = 15;
if(LinkCollision(n)) n->OriginalTile = eat;
else n->OriginalTile = normal;
Link->HitWidth = oldwidth;
Link->HitHeight = oldheight;
n->HitWidth = 16;
n->HitHeight = 16;
n->X = initx;
n->Y = inity;
Waitframe();
}
Screen->TriggerSecrets();
Waitframes(wait);
}
}}
 
 
// This will check for the specified combo.
// If found, it will play a message.
// If the combo disappears, the check for the combo will reset.
// d0 = String
// d1 = Number of the combo to check for
ffc script comboString
{
    void run(int string, int combo)
    {
        bool hasAppeared = false;
        // Enter the main loop
        while(true)
        {
            // If the combo has not appeared, loop through this while loop...
            while(!hasAppeared)
            {
                // Check if there is an instance of the combo on the screen...
                if(FirstComboOf(combo, 0) != -1)
                {
                    hasAppeared = true;
                    Screen->Message(string); // Play the message.
                }
                Waitframe();
            }
            // If the combo has appeared, loop through this while loop...
            while(hasAppeared)
            {
                // Check if the combo is not still on the screen...
                if(FirstComboOf(combo, 0) == -1)
                {
                    hasAppeared = false;
                }
                Waitframe();
            }
            Waitframe();
        }//!End while(true)
    }//!End void run()
}//!End ffc script comboString
 
 
ffc script triforceSFX{
    void run ( int glowSFX, int frequency ){
        while ( !Screen->State[ST_ITEM] ){
            Game->PlaySound(glowSFX);
            Waitframes(frequency);
        }
    }
}
 
 
ffc script Lower_Stun_Time{
    void run(int enemyNum, int stuntime){
        Waitframes(4);
        npc n = Screen->LoadNPC(enemyNum);
        while(n->isValid()){
            if(n->Stun > stuntime) n->Stun = stuntime;
            Waitframe();
        }
    }
}
 
 
ffc script BombFlower
{
    void run(int i, int oldc, int newc)
    {
         bool bCombosChanged = false;
         while(true)
         {
            if (Link->Item[i] && bCombosChanged == false)
            {     //If Link has the item
                  for(int j = 0; j < (16*11); j++)
                  {   //For each combo on screen
                       if(Screen->ComboD[j]==oldc) Screen->ComboD[j] = newc; //If it matches oldc, change to newc
                  }
                  //Set our bool to true so we don't run through this loop again.
                  bCombosChanged = true;
             }
             Waitframe();
         }
    }
}
 
 
ffc script BombFlowerPlus
{
    void run(int triggerItem, int oldc, int newc)
    {
         bool bCombosChanged = false;
         while(!bCombosChanged)
         {
            if (Link->Item[triggerItem] && bCombosChanged == false)
            {     //If Link has the item
                  //Change each combo on each layer
                  //This includes layer 0, the screen itself
                  for(int l=0; l<=6; l++)
                      for(int i=0; i<(16*11); i++)
                          if (GetLayerComboD(l,i) == oldc )
                              SetLayerComboD( l, i, newc );
                  //Set our bool to true to let the script end
                  bCombosChanged = true;
             }
             Waitframe();
         }
    }
}
 
 
ffc script DamageSlashNextAll{
    void run(int comboID){
        while(FirstComboOf(comboID, 0) != -1){
            lweapon sword = LoadLWeaponOf(LW_SWORD);
            for(int i; i < 176; i++){
                if(Screen->ComboD[i] != comboID) continue;
                this->X = ComboX(i);
                this->Y = ComboY(i);
                if(sword->isValid() && sword->Z == 0 && Collision(this, sword)){
                    Screen->ComboD[i]++;
                    break;
                }
            }
            Waitframe();
        }
        this->Data = 0;    
    }
}
 
 
//D0: The direction Link faces on entry (0-3; up/down/left/right)
ffc script setDirOnEntry{
    void run ( int dir ){
        Link->Dir = dir;
    }
}
 
 
//D0: First of four tiles (U/D/L/R)
ffc script autoWalk{
    void run ( int upCombo ){
        bool pressedCombo = false; //Link just stepped on a direction-changing combo
        int underLink = ComboAt ( Link->X+8, Link->Y+8 );
        while ( true ){
            underLink = ComboAt ( Link->X+8, Link->Y+8 );
           
            if ( Link->InputUp ) //Set Link's direction to the input direction
                Link->Dir = DIR_UP;
            else if ( Link->InputDown )
                Link->Dir = DIR_DOWN;
            else if ( Link->InputLeft )
                Link->Dir = DIR_LEFT;
            else if ( Link->InputRight )
                Link->Dir = DIR_RIGHT;
            noDirInput(); //Cancel all input directions
           
            if ( Link->Dir == DIR_UP ) //Enable the directional input matching Link's dir
                Link->InputUp = true;
            else if ( Link->Dir == DIR_DOWN )
                Link->InputDown = true;
            else if ( Link->Dir == DIR_LEFT )
                Link->InputLeft = true;
            else if ( Link->Dir == DIR_RIGHT )
                Link->InputRight = true;
               
            if ( Screen->ComboD[underLink] == upCombo && !pressedCombo ){ //Check for combo under Link and adjust direction
                Link->Dir = DIR_UP;
                Screen->ComboD[underLink]++;
                pressedCombo = true;
            }
            else if ( Screen->ComboD[underLink] == upCombo+1 && !pressedCombo ){
                Link->Dir = DIR_DOWN;
                Screen->ComboD[underLink]++;
                pressedCombo = true;
            }
            else if ( Screen->ComboD[underLink] == upCombo+2 && !pressedCombo ){
                Link->Dir = DIR_LEFT;
                Screen->ComboD[underLink]++;
                pressedCombo = true;
            }
            else if ( Screen->ComboD[underLink] == upCombo+3 && !pressedCombo ){
                Link->Dir = DIR_RIGHT;
                Screen->ComboD[underLink] = upCombo;
                pressedCombo = true;
            }
            else
                pressedCombo = false;
           
            Waitframe();
        }
    }
}
 
void noDirInput(){
    Link->InputUp = false;
    Link->InputDown = false;
    Link->InputLeft = false;
    Link->InputRight = false;
}
 
 
ffc script fallingTile{
    void run ( int tileID, int delay, int speed ){
        int originY = this->Y; //Save original Y pos
        int originCSet = this->CSet;
        this->Y = 0; //Move to the top of the screen
       
        Waitframes(delay); //Wait...
       
        Game->PlaySound(SFX_FALL); //Play falling SFX
        this->Data = tileID; //Change to the tile
        this->CSet = originCSet;
        while ( this->Y < originY ){ //Fall towards the origin Y
            this->Y += speed;
            if ( this->Y > originY )
                this->Y = originY;
            Waitframe();
            if ( this->Y < originY )
                Screen->FastTile( 2, this->X, originY, shadowTile, shadowCSet, 64 ); //Draw the shadow (transparent)
        }
       
        this->Data = 0; //Remove FFC
        Screen->ComboD[ComboAt(this->X,originY)] = tileID; //Change combo underneath FFC
    }
}
 
 
ffc script CircularMotion{
    void run(int radius, int speed, int angle, int radius2){
        if(radius2 == 0) radius2 = radius;
        int x = this->X; int y = this->Y;
        for(;true;angle++){
            this->X = x + radius*Cos(angle*speed);
            this->Y = y + radius2*Sin(angle*speed);
            angle %= 360;
            Waitframe();
        }
    }
}
 
 
ffc script setCountDown{
    void run ( int timer, int DMap, int screen ){
        countDown = timer; //Set the countdown data
        countDownWarpMap = DMap;
        countDownWarpScreen = screen;
    }
}
 
 
ffc script autoMove3{
    void run(int startCombo, int stopCombo){
    bool moving;
        while(true){
            if ( Screen->ComboD[ComboAt(Link->X+8, Link->Y+8)] == startCombo ) { //if Link is on startCombo
                this->X = Link->X; //move this ffc to Link's position
                this->Y = Link->Y;
                if ( Link->Dir == DIR_UP ) //and give this ffc the speed of 4 in the direction Link is facing
                    this->Vy = -4;
                if ( Link->Dir == DIR_RIGHT )
                    this->Vx = 4;
                if ( Link->Dir == DIR_DOWN )
                    this->Vy = 4;
                if ( Link->Dir == DIR_LEFT )
                    this->Vx = -4;
                moving = true;
            }
            if ( moving == true ) {
                Link->X = this->X; //stick Link to this ffc
                Link->Y = this->Y;
                Link->InputUp = false; //disable directional buttons
                Link->InputRight = false;
                Link->InputDown = false;
                Link->InputLeft = false;
            }
            if ( Screen->ComboD[ComboAt(Link->X+8, Link->Y+8)] == stopCombo ) { //if Link is on stopCombo
                this->X = 0; this->Y = 0; //reset this ffc
                this->Vx = 0; this->Vy = 0;
                moving = false; //Link has control over his actions again
            }
            Waitframe();
        }
    }
}
 
 
//D0 = Sound to play
//Place FFC on top of combo to play the sound (the "active" combo)
ffc script NewsoundCombo{
    void run(int sfx){
        int combo = ComboAt(this->X, this->Y);
        int soundCombo = Screen->ComboD[combo];
       
        //Wait for soundCombo to vanish (don't play first time)
        while(Screen->ComboD[combo] == soundCombo)
                Waitframe();
       
        while(true){
            //Wait for it to come back
            while(Screen->ComboD[combo] != soundCombo){
                Waitframe();
            }
           
            //Play sound
            Game->PlaySound(sfx);
           
            //Wait for it to vanish again
            while(Screen->ComboD[combo] == soundCombo)
                Waitframe();
        }
    }
}
 
 
//D0: Combo to look for
//D1: Layer to look in
//D2: SFX to play
ffc script OldsoundCombo{
    void run ( int combo, int layer, int sfx ){
        while(true){
            int pos = FirstComboOf(combo, layer);
            if ( pos > -1 ){
                Screen->ComboD[pos]++;
                Game->PlaySound(sfx);
            }
            Waitframe();
        }
    }
}
 
 
ffc script endCountDown{
    void run (){
        while ( !Screen->State[ST_SECRET] ){ //Quit when secrets are triggered
            if ( countDown == 1 ){ //If there is a countdown
                countDown = -1; //End it
                Screen->TriggerSecrets(); //Trigger secrets
                Screen->State[ST_SECRET] = false; //And DON'T save them
                Game->PlaySound(SFX_SECRET);
            }
            Waitframe();
        }
    }
}
 
 
// ***FFC SCRIPT QUAKEBUSTER***  -by Gleeok. :)
// Creates an earthquake on a single screen, or multiple screens/Dmaps
// if ffc-carryover is set. to stop ffc carryover on a screen simply check the
// corresponding box under [F9]Screen Flags.
//
// ~ARGUMENTS~
// * D[0] - frames the quake will last. (seconds = frames*60)
// for a perpetual quake set this to a negative number.
//
// * D[1] - magnitude of a perpetual quake. this does nothing if D[0] is not set
// to a negative number. if D[0] is negative, D[1] then controls the quake function.
// * For a constant "tremor" effect set both D[0] and D[1] to a negative number, wherein
// these arguments then reverse. ie: D[1] becomes the "magnitude" of the tremor, and
// D[0] becomes *roughly* the time in frames the quake subsides.
//
// * D[2] - sound effect to play at D[3] intervals, where intervals is in frames.
// * D[3] - frame delay before playing the sfx.
// D[4] - item to have to cancel the quake.
 
 
ffc script QuakeBuster
{
    void run(int frames, int magnitude, int sfx, int sfx_delay, int itemID)
    {
        if(Link->Item[itemID])
            Quit();
 
        int f = Abs(frames);
        int m = Abs(magnitude);
        int i; int delay;
        if(frames < 0)
        {
            frames = Abs(frames);
            do
            {
                f++; delay = m;
                Waitframe();
                Screen->Quake = m;
                if(f % sfx_delay == 0 && sfx > 0)Game->PlaySound(sfx);
                if(magnitude < 0)
                {
                    for(i = frames+(Rand(frames)*3);i > 0;i--){
                        Waitframe();
                        if(i % sfx_delay == 0 && sfx > 0 && delay > 0){
                            Game->PlaySound(sfx);
                            delay--;
                        }
                    }
                }
            } while(true)
        }
        Screen->Quake = f;
        while(f-- > 0)
        {
            Waitframe();
            if(f % sfx_delay == 0 && sfx > 0)Game->PlaySound(sfx);
        }
    }
}