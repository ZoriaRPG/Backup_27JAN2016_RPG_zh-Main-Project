// Coolgamer012345's Sideview engine. Version 1.0.
 
// NOTE: Set gravity and velocity in init data to 0.01, as the script already handles gravity.
// Unexpected things may happen if you change Gravity or Terminal Velocity to something aboe 0.01.
 
 
// Crappy constant names
const int THING_LINK = 0;
const int THING_ENEMY = 1;
const int THING_ITEM = 2;
const int THING_LWEAPON = 3;
const int THING_EWEAPON = 4;
const int THING_FFC = 5;
const int THING_POS = 6;
 
 
// For loops that cycle through things like the enemies on-screen.
const int S_FFCS = 1;
const int S_ITEMS = 1;
const int S_NPCS = 1;
const int S_LWEAPS = 1;
const int S_EWEAPS = 1;
 
 
// Universal "thing" constants. Couldn't think of a better name and was too lazy to try harder :P
const int A_FALLING = 0; // "Universal thing" Action; Action for falling.
const int A_ONGROUND = 1; // "Universal thing" Action; Action for being on the ground.
const int A_JUMPING = 2; // "Universal thing" Action; Action for jumping.
const int A_FLOATING = 3; // "Universal thing" Action; Action for floating.
const int A_ONLADDER = 4; // "Universal thing" Action; Action for being on ladders.
 
// The "Weapons/Misc" sprite that the hoverboots glow uses.
const int HOVERBOOT_GLOW_MISC = 84;
 
// An "Action" tracker for things related to sideview (eg, jumping, falling, etc)
int Link_Y_Action = A_FALLING;
// Link's Jump Velocity. Gets changed WHILE jumping so you should use Default_Jump_Vel for things you don't want to change when Link jumps.
float Link_Jumpspeed = 3;
 
 
// If the jump button is being pressed.
bool PressingJump;
 
 
// Used for preventing Link from jumping immedietly after hitting the ground. Don't mess with this unless you know what you're doing.
bool PressedJump = false;
 
 
// Counter for link pushing against stairs.
int Link_StairPressedCounter = 1;
// The amount of frames Link pressing against 'stairs' before he will move up them.
const int LINK_STAIRMAXFRAMES = 8;
 
 
// Previous Link Direction.
int Prev_Link_Dir;
 
 
// If the 'combo grid' is overlayed. Used for debugging stuff.
bool ComboGrid;
// Tile to use for the 'combo overlay grid'.
const int COMBO_GRID_TILE = 5;
 
 
// If the scripted hitbox showing is on/off. Used for debugging stuff.
bool DrawHitboxes;
 
 
// The flag to use for ladders.
const int LADDER_FLAG = 98;
 
 
// Counter for hoverboots hovering.
int HoveringCounter = 1;
// Amount of frames Link hovers for when he has a fale hoverboots item.
int Hovering_Frames_Max = 45;
// A variable used for Hoverboots. Don't mess with this unless you know what you're doing.
int CanFloat = 0;
 
// A counter used for making Hoverboot glow's animate. Don't mess with this unless you know what you're doing.
int HoverGlowDelayCounter = 1;
// A counter used for making Hoverboot glow's animate. Don't mess with this unless you know what you're doing.
int HoverGlowFrameCounter = 1;
// A counter used for detecting when the Hoverboots take away magic. Don't mess with this unless you know what you're doing.
int HoverbootMagicCostCounter = 1;
 
global script Sidescrolling_Engine_Global
{
        void run()
        {
                // Default Jumpspeed of things. Currently only useful for Link.
                float Default_Jumpspeeds[6] = {Link_Jumpspeed, 2, 2, 2, 2, 2, 2};
               
                // Fall resistance, in pixels; Use THING_ constants to index this array.
                float Fallspeed_Resist[6] = {0, 0, 0, 0, 0, 0, 0};
               
                // Fall speed, in pixels; Use THING_ constants to index this array.
                float Fallspeeds[6] = {2, 2, 2, 2, 2, 2, 2};
               
                // The amount that Fallspeed gets decreased by. Use THING_ constants to index this array.
                float Fallspeed_Decrease[6] = {0.25, 0.25, 0.4, 0.4, 0.4, 0.4, 0.4};
               
                // If Link can jump off a ladder while on it or not.
                bool CanJumpOffLadders = true;
               
                while(true)
                {
                        // Link direction from the previous frame..  I think. I might have to move this somewhere else.
                        Prev_Link_Dir = Link->Dir;
 
                        // Variable for if the jump button is pressed. You can change what that button is if you want to.
                        PressingJump = Link->InputL;
                       
                        // The sideview engine itself. Calls a bunch of other functions for Sideview stuff (Like making gravity.. work.. at all).
                        if(IsSideview())
                        {
                                SidescrollingEngineFunctions(   143, 92, Fallspeeds, Fallspeed_Resist, Default_Jumpspeeds,
                                                                                                Fallspeed_Decrease, CanJumpOffLadders, SFX_HOVER,HOVERBOOT_GLOW_MISC,
                                                                                                8, 1, 10);
                        }
                       
                        // Draws a bunch of Int's
                        DrawABunchOfInts();
                       
                        Waitframe();
                }
        }
}
 
// Returns true if there is a solid combo that is standable onable at a position.
// The arguments, in order;
// X/Y position to check (eg. Link->X, Link->Y)
// Width/Height of the thing (eg. Link->HitWidth, Link->HitHeight)
// Leeway. Used to make physics a bit 'smoother'. Use 0 for exact collision detection. I suggest to use 2 or 4.
bool OnSolidCombo(int x, int y, int w, int h, int l)
{
        if(Screen->isSolid(x + l, y + h) || Screen->isSolid(x + ((w / 2) - l), y + h) || Screen->isSolid(x + (w - 1), y + h))
        {
                return true;
        }
        else if(!Screen->isSolid(x + l, y + h) && !Screen->isSolid(x + ((w / 2) - l), y + h) && !Screen->isSolid(x + (w - 1), y + h))
        {
                return false;
        }
}
 
// Returns true if there is a flag/inherent flag on a combo below the positions specified
// The arguments, in order;
// X/Y position to check (eg. Link->X, Link->Y)
// Width/Height of the thing (eg. Link->HitWidth, Link->HitHeight)
// Leeway. Used to make physics a bit 'smoother'. Use 0 for exact collision detection. I suggest to use 2 or 4.
// The flag to check for.
bool OnTopOfComboFI(int x, int y, int w, int h, int l, int f)
{
        if(ComboFI(x + l, y + h, f) || ComboFI(x + ((w / 2) - l), y + h, f) || ComboFI(x + (w - 1), y + h, f))
        {
                return true;
        }
        else if(!ComboFI(x + l, y + h, f) && !ComboFI(x + ((w / 2) - l), y + h, f) && !ComboFI(x + (w - 1), y + h, f))
        {
                return false;
        }
}
 
void SidescrollingEngineFunctions(      int Fake_Hoverboots_ID, int Real_Hoverboots_ID, float Gravity_Fallspeed, float Gravity_Resistance,
                                                                        float Default_Jumpspeeds, float Link_Jumpspeed_Decrease, bool JumpOffLadders, int Hovering_SFX, int Hovering_Glow_Sprite,
                                                                        int Directional_Hover_Offset_Y, float HoverMagicCost, int HoverMagicCostFreq)
{
        UpdateGravityPositions(Gravity_Fallspeed, Gravity_Resistance, Default_Jumpspeeds);
        UpdateStairCombos();
        UpdateLadders(Default_Jumpspeeds, JumpOffLadders);
        PushLinkOutOfSolidCombos();
        DrawHitboxes();
        DrawGrid();
        MakeLinkJump(Link_Jumpspeed_Decrease);
       
        if(Link->MP >= HoverMagicCost)
        {
                HoverBootHandling(Fake_Hoverboots_ID, Real_Hoverboots_ID, Hovering_SFX, HoverMagicCost);
                HoverGlowHandling(Hovering_Glow_Sprite, Directional_Hover_Offset_Y);
        }
       
        HoverMagicCost(HoverMagicCost, HoverMagicCostFreq);
}
 
// Updates things that can move's gravity (Link, Enemies, Items, FFC's and I might add in E/LWeapon support eventualy)
void UpdateGravityPositions(float Gravity_Fallspeed, float Gravity_Resistance, float Default_Jumpspeeds)
{
        // Sets Link's Y-Action to be onground when he's on the ground and sets his jump velocity to default
        if(OnSolidCombo(Link->X, Link->Y, Link->HitWidth, Link->HitHeight, 2) ||
        (       TouchingFlag(Link->X, Link->Y + 16, Link->X + Link->HitWidth - 1, Link->Y + Link->HitHeight - 1, 8, 0, LADDER_FLAG)
        &&  TouchingFlag(Link->X, Link->Y, Link->X + Link->HitWidth - 1, Link->Y + Link->HitHeight - 1, 8, 0, LADDER_FLAG) == false))
        {
                Link_Y_Action = A_ONGROUND;
                Link_Jumpspeed = Default_Jumpspeeds[THING_LINK];
        }
       
        // If the jump button isn't pressed, and Link isn't on thr ground/ladder and his action isn't floating
        if(     (PressingJump == false || Link_Y_Action != A_JUMPING)
                && OnSolidCombo(Link->X, Link->Y, Link->HitWidth, Link->HitHeight, 2) == false
                && TouchingFlag(Link->X, Link->Y, Link->X + Link->HitWidth - 1, Link->Y + Link->HitHeight - 1, 8, 0, LADDER_FLAG) == false
                && OnTopOfComboFI(Link->X, Link->Y, Link->HitWidth, Link->HitHeight, 2, LADDER_FLAG) == false
                && Link_Y_Action != A_FLOATING)
        {
                Link_Y_Action = A_FALLING;
        }
       
        // Moves link down when his Y-Action is for falling
        if(OnSolidCombo(Link->X, Link->Y, Link->HitWidth, Link->HitHeight, 2) == false && Link_Y_Action == A_FALLING && Link_Y_Action != A_FLOATING)
        {
                Link->Y += (Gravity_Fallspeed[THING_LINK] - Gravity_Resistance[THING_LINK]);
        }
       
        // Meant for making link fall after hitting against the bottom of a solid combo
        if(Screen->isSolid(Link->X, Link->Y - 1) || Screen->isSolid(Link->X + 8, Link->Y - 1) || Screen->isSolid(Link->X + 15, Link->Y - 1) && Link_Y_Action == A_JUMPING)
        {
                Link_Y_Action = A_FALLING;
        }
       
        // Makes link fall after hitting the bottom of the screen.
        if(Link->Y <= 2 && Link_Y_Action == A_JUMPING)
        {
                Link_Y_Action = A_FALLING;
        }
       
        //
        if((Link_Y_Action == A_ONGROUND || Link_Y_Action == A_ONLADDER) && PressingJump == false)
        {
                PressedJump = false;
        }
       
        // ********************** END OF LINK'S GRAVITY STUFF ********************** \\
       
        // Cycles through enemies
        for(int i = 1; i <= Screen->NumNPCs(); i += 1)
        {
                npc en = Screen->LoadNPC(i);
               
                // Moves enemies down when their 'action'(Misc[0]) is for falling and they're not on a solid combo
                if(OnSolidCombo(en->X, en->Y, en->HitWidth, en->HitHeight, 2) == false && en->Misc[0] == A_FALLING)
                {
                        // Fairy's don't know what gravity is
                        if(en->Type != NPC_FAIRY)
                        {
                                en->Y += (Gravity_Fallspeed[THING_ENEMY] - Gravity_Resistance[THING_ENEMY]);
                        }
                }
        }
       
        // Cycles through items
        for(int i = 1; i <= Screen->NumItems(); i += 1)
        {
                item it = Screen->LoadItem(i);
               
                // Moves items down when their 'action'(Misc[0]) is for falling and they're not on a solid combo
                // Checks the Misc encase they can float or something
                // if(!Screen->isSolid(it->X, it->Y + 16) && !Screen->isSolid(it->X + 15, it->Y + 16) && it->Misc[0] == A_FALLING)
                if(OnSolidCombo(it->X, it->Y, it->HitWidth, it->HitHeight, 2) == false && it->Misc[0] == A_FALLING)
                {
                        it->Y += (Gravity_Fallspeed[THING_ITEM] - Gravity_Resistance[THING_ITEM]);
                }
               
                // if(OnSolidCombo(it->X, it->Y, it->X + 15, it->Y + 15, 0) == false && it->Misc[0] == A_FALLING) // it->X + (it->HitWidth - 1), it->Y + (it->HitHeight - 1)
                // {
                        // it->Y += (Gravity_Fall[THING_ITEM] - Gravity_Resist[THING_ITEM]);
                // }
        }
       
        // Cycles through FFCs
        for(int i = S_FFCS; i <= 32; i += 1)
        {
                ffc f = Screen->LoadFFC(i);
               
                // Moves FFCs down when their 'action'(Misc[0]) is for falling and they're not on a solid combo
                // Checks the Misc encase they can float or something
                if(OnSolidCombo(f->X, f->Y, f->EffectWidth, f->EffectHeight, 2) == false && f->Data != 0 && f->Misc[0] == A_FALLING)
                {
                        f->Y += (Gravity_Fallspeed[THING_FFC] - Gravity_Resistance[THING_FFC]);
                }
        }
}
 
// Allows combos that are partially solid to act as Stairs. Might add in support for excluding certain combo types or something.
void UpdateStairCombos()
{
        if(Prev_Link_Dir != Link->Dir)
        {
                Link_StairPressedCounter = 1;
        }
       
        if(Link_Y_Action == A_ONGROUND || Link_Y_Action == A_ONLADDER)
        {
                if(Link->Dir == DIR_LEFT)
                {//Screen->isSolid(Link->X - 16, Link->Y + 8) ||
                        if(Screen->isSolid(Link->X - 8, Link->Y + 8) && !Screen->isSolid(Link->X - 8, Link->Y))
                        {
                                if(Link->InputLeft)
                                {
                                        Link_StairPressedCounter += 1;
                                }
                                else
                                {
                                        Link_StairPressedCounter = 1;
                                }
                               
                                if(Link_StairPressedCounter >= LINK_STAIRMAXFRAMES)
                                {
                                        Link->X -= 1;
                                        Link->Y -= 8;
                                        Link_StairPressedCounter = 1;
                                }
                        }
                }
               
                if(Link->Dir == DIR_RIGHT)
                {
                        if(Screen->isSolid(Link->X + 16, Link->Y + 8) && !Screen->isSolid(Link->X + 16, Link->Y))
                        {
                                if(Link->InputRight)
                                {
                                        Link_StairPressedCounter += 1;
                                }
                                else
                                {
                                        Link_StairPressedCounter = 1;
                                }
                               
                                if(Link_StairPressedCounter >= LINK_STAIRMAXFRAMES)
                                {
                                        Link->X += 1;
                                        Link->Y -= 8;
                                        Link_StairPressedCounter = 1;
                                }
                        }
                }
        }
}
 
// Pushes Link away from a combo if he gets stuck inside it. Couldn't think of a better name for this.
void PushLinkOutOfSolidCombos()
{
        if((Screen->isSolid(Link->X, Link->Y) || Screen->isSolid(Link->X, Link->Y + 15)) && !Screen->isSolid(Link->X + 16, Link->Y) && !Screen->isSolid(Link->X + 16, Link->Y + 15))
        {
                Link->X += 1;
        }
        else if((Screen->isSolid(Link->X + 15, Link->Y) || Screen->isSolid(Link->X + 15, Link->Y + 15)) && !Screen->isSolid(Link->X - 1, Link->Y) && !Screen->isSolid(Link->X - 1, Link->Y + 15))
        {
                Link->X -= 1;
        }
}
 
// Draws Hitboxes over Link, Enemies, Items, EWeapons and LWeapons to Layer 7. Might add in support for FFC's.
// Mainly for debugging purposes.
void DrawHitboxes()
{
        if(Link->PressEx2)
        {
                DrawHitboxes = !DrawHitboxes;
        }
       
        if(DrawHitboxes)
        {
                Screen->Rectangle(7, Link->X, Link->Y, Link->X + (Link->HitWidth - 1), Link->Y + (Link->HitHeight - 1), 0x61, 1, 0, 0, 0, true, OP_TRANS);
               
                for(int i = 1; i <= Screen->NumNPCs(); i += 1)
                {
                        npc en = Screen->LoadNPC(i);
                       
                        Screen->Rectangle(7, en->X, en->Y, en->X + (en->HitWidth - 1), en->Y + (en->HitHeight - 1), 0x81, 1, 0, 0, 0, true, OP_TRANS);
                }
               
                for(int i = 1; i <= Screen->NumItems(); i += 1)
                {
                        item it = Screen->LoadItem(i);
                       
                        Screen->Rectangle(7, it->X, it->Y, it->X + (it->HitWidth - 1), it->Y + (it->HitHeight - 1), 0x71, 1, 0, 0, 0, true, OP_TRANS);
                }
               
                for(int i = 1; i <= Screen->NumEWeapons(); i += 1)
                {
                        eweapon ew = Screen->LoadEWeapon(i);
                       
                        Screen->Rectangle(7, ew->X, ew->Y, ew->X + (ew->HitWidth - 1), ew->Y + (ew->HitHeight - 1), 0x82, 1, 0, 0, 0, true, OP_TRANS);
                }
               
                for(int i = 1; i <= Screen->NumLWeapons(); i += 1)
                {
                        lweapon lw = Screen->LoadLWeapon(i);
                       
                        Screen->Rectangle(7, lw->X, lw->Y, lw->X + (lw->HitWidth - 1), lw->Y + (lw->HitHeight - 1), 0x72, 1, 0, 0, 0, true, OP_TRANS);
                }
        }
}
 
// Draws a Grid over the screen on layer 7 using a 'grid' tile.
// Mostly for debugging purposes.
void DrawGrid()
{
        if(Link->PressEx1)
        {
                ComboGrid = !ComboGrid;
        }
 
        if(ComboGrid)
        {
                for(int i = 0; i < 16; i += 1)
                {
                        for(int i2 = 0; i2 < 11; i2 += 1)
                        {
                                Screen->FastTile(7, (i * 16), (i2 * 16), COMBO_GRID_TILE, 0, OP_TRANS);
                        }
                }
        }
}
 
// Draws a bunch of random ass integers that I needed to track and/or still need to track. This will likely be removed eventually.
void DrawABunchOfInts()
{
        Screen->DrawInteger(7,0, 0, FONT_Z1, 1, 2, -1, -1, Link_Jumpspeed, 0, OP_OPAQUE);
        Screen->DrawInteger(7,0, 16, FONT_Z1, 1, 2, -1, -1, Link->X, 0, OP_OPAQUE);
        Screen->DrawInteger(7,0, 32, FONT_Z1, 1, 2, -1, -1, Link->Y, 0, OP_OPAQUE);
        Screen->DrawInteger(7,0, 48, FONT_Z1, 1, 2, -1, -1, Link->Z, 0, OP_OPAQUE);
        Screen->DrawInteger(7,0, 64, FONT_Z1, 1, 2, -1, -1, Link_Y_Action, 0, OP_OPAQUE);
        Screen->DrawInteger(7,0, 80, FONT_Z1, 1, 2, -1, -1, HoveringCounter, 0, OP_OPAQUE);    
}
 
// Returns true if a thing is touching a specific Flag type
// The arguments, in order;
// X/Y position of the object
// Width/Height of the object
// Leeway X/Y. A Leeway of 0 would detect if the thing was touching the flag at all.
// Something like 4 would mean the object would have to be 4 pixles into the flag to be 'touching' the flag.
// I suggest using 4 or 8 for this. Unexected things may happen after 8.
// The number of the flag you're checking collision against. Check std_constants for a list of CF_ constants for flags.
bool TouchingFlag(int x, int y, int w, int h, int lx, int ly, int f)
{
        if(
        ComboFI(Link->X + lx, Link->Y + ly, f) ||
        ComboFI(Link->X + (Link->HitWidth - lx), Link->Y + ly, f)||
        ComboFI(Link->X + lx, Link->Y + (Link->HitWidth - ly), f) ||
        ComboFI(Link->X + (Link->HitWidth - lx), Link->Y + (Link->HitWidth - ly), f)
        )
        {
                return true;
        }
        else
        {
                return false;
        }
}
 
void UpdateLadders(float Default_Jumpspeeds, bool AllowJumping)
{
        if(TouchingFlag(Link->X, Link->Y, Link->X + Link->HitWidth - 1, Link->Y + Link->HitHeight - 1, 8, 0, LADDER_FLAG) && PressingJump == false)
        {
                Link_Y_Action = A_ONLADDER;
 
                // if(Link->InputUp || Link->InputDown)
                // {GridX(Link->X);}
        }
 
        if(!AllowJumping && Link_Y_Action == A_ONLADDER)
        {
                PressingJump = false;
        }
 
        if(PressingJump == false)
        {
                if(Link_Y_Action == A_ONLADDER)
                {
                        Link_Jumpspeed = Default_Jumpspeeds[THING_LINK];
                       
                        if(Link->InputUp && !Screen->isSolid(Link->X, Link->Y - 2) && !Screen->isSolid(Link->X + 15, Link->Y - 2))
                        {
                                Link->Y -= 1;
                        }
 
                        if(Link->InputDown && !Screen->isSolid(Link->X, Link->Y + 16) && !Screen->isSolid(Link->X + 15, Link->Y + 16))
                        {
                                Link->Y += 1;
                        }
                }
        }
       
        if(Link_Y_Action == A_JUMPING)
        {
                if(TouchingFlag(Link->X, Link->Y, Link->X + Link->HitWidth - 1, Link->Y + Link->HitHeight - 1, 8, 0, LADDER_FLAG) && Link->PressL)
                {
                        GridX(Link->X);
                        Link_Y_Action = A_ONLADDER;
                }
        }
}
 
void MakeLinkJump(float Link_Jumpspeed_Decrease)
{
        if(Link_Y_Action != A_FALLING)
        {
                if(PressedJump == false)
                {
                        if(PressingJump && (Link_Y_Action == A_ONGROUND || Link_Y_Action == A_ONLADDER))
                        {
                                if(PressedJump == false)
                                {
                                        Game->PlaySound(SFX_JUMP);
                                }
                               
                                PressedJump = true;
                                Link_Y_Action = A_JUMPING;
                        }
                }
        }
       
        if(PressingJump && Link_Y_Action == A_JUMPING && !Screen->isSolid(Link->X, Link->Y - 2) && !Screen->isSolid(Link->X + 15, Link->Y - 2))
        {
                Link->Y -= Link_Jumpspeed;
               
                PressedJump = true;
               
                if(Link_Jumpspeed > 0)
                {
                        Link_Jumpspeed -= Link_Jumpspeed_Decrease[THING_LINK]; // Should make link 'arch' in his jump by lowering the amount he moves in his jump.
                }
        }
        else if(Link_Y_Action == A_JUMPING && (Screen->isSolid(Link->X, Link->Y - 2) || Screen->isSolid(Link->X + 15, Link->Y - 2)))
        {
                Link_Y_Action = A_FALLING;
        }
       
        if(Link_Jumpspeed <= 0 && Link_Y_Action != A_FLOATING)
        {
                Link_Y_Action = A_FALLING;
                Link_Jumpspeed = 0;
        }
       
        // if(!Link->InputL && Link_Y_Action != A_ONGROUND && Link_Y_Action != A_ONLADDER)
        // {
                // PressingJump = false;
                // Link_Y_Action = A_FALLING;
        // }
}
 
void HoverBootHandling(int FakeHoverboots, int RealHoverboots, int HoverSound, int MagicCost)
{
        if(Link->Item[FakeHoverboots] == true)
        {
                if(Link_Y_Action == A_FALLING && CanFloat == 0)
                {
                        CanFloat = 1;
                }
               
                if(Link_Y_Action == A_FALLING && CanFloat == 1)
                {
                        Link_Y_Action = A_FLOATING;
                        Game->PlaySound(HoverSound);
                }
               
                if(HoveringCounter <= Hovering_Frames_Max)
                {
                        if(Link_Y_Action == A_FLOATING)// || (Link_Y_Action == A_FALLING && HoveringCounter > 0)
                        {
                                HoveringCounter += 1;
 
                                if(Link->InputDown)
                                {
                                        Link->Y += 1;
                                }
                        }
                }
               
                if(HoveringCounter > Hovering_Frames_Max)
                {
                        HoveringCounter = 1;
                        CanFloat = 2;
                        Link_Y_Action = A_FALLING;
                       
                        if(Link->Item[RealHoverboots] == true)
                        {
                                Link->Item[RealHoverboots] = false;
                        }
                }
               
                if(Link_Y_Action == A_ONGROUND || Link_Y_Action == A_ONLADDER || Link_Y_Action == A_JUMPING)
                {
                        CanFloat = 0;
                        HoveringCounter = 1;
                        HoverGlowFrameCounter = 0;
                        HoverGlowDelayCounter = 0;
                        Link->Item[RealHoverboots] = false;
                }
        }
}
 
void HoverGlowHandling(int HoverSprite, int DirYHoverOffset)
{
        if(Link_Y_Action == A_FLOATING)
        {
                eweapon HoverGlow = CreateEWeaponAt(EW_SCRIPT1, Link->X, Link->Y + DirYHoverOffset);
 
                HoverGlow->UseSprite(HoverSprite);
                HoverGlow->CollDetection = false;
                HoverGlow->DeadState = 2;//HoverGlow->NumFrames;
                HoverGlow->Misc[0] = A_FLOATING;
                HoverGlow->DrawStyle = DS_NORMAL;
               
                if(HoverGlowDelayCounter >= HoverGlow->ASpeed)
                {
                        HoverGlowFrameCounter += 1;
                        HoverGlowDelayCounter = 0;
                }
               
                if(HoverGlowFrameCounter >= HoverGlow->NumFrames)
                {
                        HoverGlowFrameCounter = 0;
                }
               
                HoverGlow->Frame = HoverGlowFrameCounter;
               
                HoverGlowDelayCounter += 1;
        }
}
 
void HoverMagicCost(float MagicCost, int MagicCostFreq)
{
        if(Link->Action != LA_SCROLLING)
        {
                if(Link_Y_Action == A_FLOATING && HoverbootMagicCostCounter >= MagicCostFreq)
                {
                        if(Link->MP >= MagicCost)
                        {
                                Link->MP -= MagicCost;
                                HoverbootMagicCostCounter = 1;
                        }
                        else
                        {
                                Link_Y_Action = A_FALLING;
                                HoverbootMagicCostCounter = 1;
                        }
                }
               
                HoverbootMagicCostCounter += 1;
        }
}
 
//if(TouchingFlag(Link->X, Link->Y, Link->X + Link->HitWidth - 1, Link->Y + Link->HitHeight - 1, 8, 0, LADDER_FLAG))