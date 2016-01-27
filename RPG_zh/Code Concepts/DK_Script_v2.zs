import "std.zh"
import "string.zh"
 
////////////////////////////////////////////////////////////////
// Global Data Array.
int G[200000];
 
// Indices:
const int G_LinkX = 0;
const int G_LinkY = 1;
const int G_LinkDY = 2;
const int G_LinkMoveSpeed = 3;
const int G_LinkJumpSpeed = 4;
const int G_ScreenChanged = 100;
const int G_ScreenPrevious = 101;
 
const int G_DebugPixel = 200;
 
// Several spaces for collision boxes.
const int G_Box1 = 300;
const int G_Box2 = 304;
const int G_Box3 = 308;
 
////////////////////////////////////////////////////////////////
// Global Scripts
 
global script active {
    void run() {
 
        while (true) {
            Screen_Prepare();
 
            if (IsSideview()) {
                DK_Update();
            }
 
            Waitdraw();
 
            if (IsSideview() && !(G[G_ScreenChanged] || LA_SCROLLING == Link->Action)) {
                Link->X = Round(G[G_LinkX]);
                Link->Y = Round(G[G_LinkY]);
            }
 
            Waitframe();
        }
    }
}
 
global script Init {
    void run() {
        DK_InitComboData();
        G[G_ScreenPrevious] = -1;
 
        G[G_LinkMoveSpeed] = 1.5;
        G[G_LinkJumpSpeed] = 4;
    }
}
 
////////////////////////////////////////////////////////////////
// Combo Data
 
// Number of combo slots available.
const int DK_COMBO_DATA_COUNT = 100;
// Size of a single combo slot.
const int DK_COMBO_DATA_SIZE = 4;
// Array with all of the combo data.
int DK_ComboData[400];
// Combo id of index 0 and last index in the combo data.
const int DK_COMBO_START = 960;
const int DK_COMBO_END = 1060;
 
////////////////
// Indices for the combo data.
 
// Where the solid tile starts on this combo. This is the top pixel of
// solidity. The tiles are assumed to be 8 tall.
// <= - 8 :: No solidity. -32 is the canonical "no solid" value.
//    - 7 :: The solidity starts 7 pixels above the top border.
//      0 :: The top pixel of the combo is the top of the solid block.
//      8 :: The 9th pixel down of the combo is the top of the solid block.
// >=  16 :: No solidity.
const int DK_COMBO_SOLID_LEFT   = 0;
const int DK_COMBO_SOLID_RIGHT  = 1;
// The ladder data for the combo. This is the top pixel of the ladder. They
// are assumed to be 16 pixels tall.
// <= -16 :: No ladder. -32 is the canonical "no solid" value.
//    - 8 :: The ladder starts 8 pixels above the top border. So the top 8 pixels are ladder.
//      0 :: The top pixel of the combo is the top of the ladder.
//      8 :: The 9th pixel down of the combo is the top of the ladder.
// >=  16 :: No solidity.
const int DK_COMBO_LADDER_LEFT  = 2;
const int DK_COMBO_LADDER_RIGHT = 3;
 
// Clear value for the combo data.
const int DK_COMBO_NONE = -32;
 
void DK_InitComboData() {
    // First, clear all combo data.
    for (int i = 0; i < SizeOfArray(DK_ComboData); ++i) {
        DK_ComboData[i] = DK_COMBO_NONE;
    }
 
    DK_ComboData[ 0 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 0;
    DK_ComboData[ 0 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 0;
    DK_ComboData[ 1 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 1;
    DK_ComboData[ 1 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 1;
    DK_ComboData[ 2 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 1;
    DK_ComboData[ 2 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 2;
    DK_ComboData[ 3 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 2;
    DK_ComboData[ 3 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 2;
 
    DK_ComboData[ 8 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 3;
    DK_ComboData[ 8 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 3;
    DK_ComboData[ 9 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 4;
    DK_ComboData[ 9 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 4;
    DK_ComboData[10 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 5;
    DK_ComboData[10 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 5;
    DK_ComboData[11 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 5;
    DK_ComboData[11 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 6;
 
    DK_ComboData[16 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 6;
    DK_ComboData[16 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 6;
    DK_ComboData[17 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 7;
    DK_ComboData[17 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 7;
    DK_ComboData[18 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 7;
    DK_ComboData[18 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 8;
    DK_ComboData[19 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 8;
    DK_ComboData[19 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 8;
 
    DK_ComboData[24 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 9;
    DK_ComboData[24 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 9;
    DK_ComboData[28 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -7;
    DK_ComboData[28 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -7;
    DK_ComboData[25 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 9;
    DK_ComboData[25 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 10;
    DK_ComboData[29 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -7;
    DK_ComboData[29 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -6;
    DK_ComboData[26 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 10;
    DK_ComboData[26 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 10;
    DK_ComboData[30 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -6;
    DK_ComboData[30 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -6;
    DK_ComboData[27 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 11;
    DK_ComboData[27 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 11;
    DK_ComboData[31 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -5;
    DK_ComboData[31 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -5;
 
    DK_ComboData[32 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 11;
    DK_ComboData[32 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 12;
    DK_ComboData[36 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -5;
    DK_ComboData[36 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -4;
    DK_ComboData[33 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 12;
    DK_ComboData[33 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 12;
    DK_ComboData[37 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -4;
    DK_ComboData[37 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -4;
    DK_ComboData[34 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 12;
    DK_ComboData[34 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 12;
    DK_ComboData[38 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -4;
    DK_ComboData[38 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -4;
    DK_ComboData[35 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 12;
    DK_ComboData[35 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 12;
    DK_ComboData[39 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -4;
    DK_ComboData[39 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -4;
 
    DK_ComboData[40 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 13;
    DK_ComboData[40 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 13;
    DK_ComboData[44 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -3;
    DK_ComboData[44 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -3;
    DK_ComboData[41 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 13;
    DK_ComboData[41 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 14;
    DK_ComboData[45 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -3;
    DK_ComboData[45 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -2;
    DK_ComboData[42 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 14;
    DK_ComboData[42 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 14;
    DK_ComboData[46 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -2;
    DK_ComboData[46 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -2;
    DK_ComboData[43 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 15;
    DK_ComboData[43 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 15;
    DK_ComboData[47 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -1;
    DK_ComboData[47 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -1;
 
    DK_ComboData[48 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 15;
    DK_ComboData[48 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = DK_COMBO_NONE;
    DK_ComboData[52 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -1;
    DK_ComboData[52 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 0;
    DK_ComboData[49 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = DK_COMBO_NONE;
    DK_ComboData[49 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = DK_COMBO_NONE;
    DK_ComboData[53 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 0;
    DK_ComboData[53 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 0;
    DK_ComboData[50 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 15;
    DK_ComboData[50 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 15;
    DK_ComboData[54 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -1;
    DK_ComboData[54 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -1;
    DK_ComboData[51 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 15;
    DK_ComboData[51 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 15;
    DK_ComboData[55 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -1;
    DK_ComboData[55 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -1;
 
    DK_ComboData[56 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 14;
    DK_ComboData[56 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 14;
    DK_ComboData[60 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -2;
    DK_ComboData[60 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -2;
    DK_ComboData[57 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 14;
    DK_ComboData[57 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 14;
    DK_ComboData[61 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -2;
    DK_ComboData[61 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -2;
    DK_ComboData[58 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 13;
    DK_ComboData[58 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 13;
    DK_ComboData[62 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -3;
    DK_ComboData[62 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -3;
    DK_ComboData[59 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 12;
    DK_ComboData[59 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 12;
    DK_ComboData[63 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -4;
    DK_ComboData[63 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -4;
 
    DK_ComboData[64 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 11;
    DK_ComboData[64 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 11;
    DK_ComboData[68 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -5;
    DK_ComboData[68 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -5;
    DK_ComboData[65 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 11;
    DK_ComboData[65 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 11;
    DK_ComboData[69 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -5;
    DK_ComboData[69 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -5;
    DK_ComboData[66 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 10;
    DK_ComboData[66 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 10;
    DK_ComboData[70 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -6;
    DK_ComboData[70 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -6;
    DK_ComboData[67 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 10;
    DK_ComboData[67 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 10;
    DK_ComboData[71 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -6;
    DK_ComboData[71 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -6;
 
    DK_ComboData[72 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 9;
    DK_ComboData[72 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 9;
    DK_ComboData[76 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -7;
    DK_ComboData[76 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -7;
    DK_ComboData[73 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 9;
    DK_ComboData[73 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 9;
    DK_ComboData[77 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = -7;
    DK_ComboData[77 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = -7;
    DK_ComboData[74 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = 8;
    DK_ComboData[74 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = 8;
    DK_ComboData[78 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = DK_COMBO_NONE;
    DK_ComboData[78 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = DK_COMBO_NONE;
    DK_ComboData[75 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = DK_COMBO_NONE;
    DK_ComboData[75 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = DK_COMBO_NONE;
    DK_ComboData[79 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT]   = DK_COMBO_NONE;
    DK_ComboData[79 * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT]  = DK_COMBO_NONE;
 
    DK_ComboData[80 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = DK_COMBO_NONE;
    DK_ComboData[80 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = 1;
    DK_ComboData[81 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = DK_COMBO_NONE;
    DK_ComboData[81 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = 8;
    DK_ComboData[81 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = DK_COMBO_NONE;
    DK_ComboData[81 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = 0;
    DK_ComboData[81 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = DK_COMBO_NONE;
    DK_ComboData[81 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = 12;
 
    DK_ComboData[84 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = 1;
    DK_ComboData[84 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = DK_COMBO_NONE;
    DK_ComboData[85 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = DK_COMBO_NONE;
    DK_ComboData[85 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = 8;
    DK_ComboData[86 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = 0;
    DK_ComboData[86 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = DK_COMBO_NONE;
    DK_ComboData[87 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = -12;
    DK_ComboData[87 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = DK_COMBO_NONE;
 
    DK_ComboData[88 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT]  = 1;
    DK_ComboData[88 * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT] = DK_COMBO_NONE;
}
 
////////////////////////////////////////////////////////////////
// Pixel Types
 
const int DK_PIXEL_SOLID_TOP    = 00001b;
const int DK_PIXEL_SOLID_UNDER  = 00010b;
const int DK_PIXEL_LADDER_TOP   = 00100b;
const int DK_PIXEL_LADDER_UNDER = 01000b;
const int DK_PIXEL_OFFSCREEN    = 10000b;
 
// Get the type of a given pixel.
int DK_PixelType(int x, int y) {
 
    if (x < 0 || x >= 256 || y < 0 || y >= 176) {return DK_PIXEL_OFFSCREEN;}
 
    int type = 0;
    int location = ComboAt(x, y);
    bool left = x % 16 < 8;
    y = Floor(y % 16);
 
    // Grab data from layers 0 through 2.
    for (int layer = 0; layer <= 2; ++layer) {
        int combo_id = GetLayerComboD(layer, location);
        if (combo_id < DK_COMBO_START || combo_id > DK_COMBO_END) {continue;}
        int combo_index = combo_id - DK_COMBO_START;
 
        int solid;
        int ladder;
        if (left) {
            solid = DK_ComboData[combo_index * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_LEFT];
            ladder = DK_ComboData[combo_index * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_LEFT];
        } else {
            solid = DK_ComboData[combo_index * DK_COMBO_DATA_SIZE + DK_COMBO_SOLID_RIGHT];
            ladder = DK_ComboData[combo_index * DK_COMBO_DATA_SIZE + DK_COMBO_LADDER_RIGHT];
        }
 
      // Check solidity.
        if (solid == y) {type |= DK_PIXEL_SOLID_TOP;}
        else if (y > solid && y < solid + 8) {type |= DK_PIXEL_SOLID_UNDER;}
        // Check for ladder.
        if (ladder == y) {type |= DK_PIXEL_LADDER_TOP;}
        else if (y > ladder && y < ladder + 16) {type |= DK_PIXEL_LADDER_UNDER;}
    }
 
    return type;
}
 
////////////////////////////////////////////////////////////////
// Screen
 
// Get screen id.
int Screen_Get() {
    return (Game->GetCurDMap() << 8) + Game->GetCurDMapScreen();
}
 
// Updates variables.
void Screen_Prepare() {
    int screen = Screen_Get();
    G[G_ScreenChanged] = Cond(screen == G[G_ScreenPrevious], 0, 1);
    G[G_ScreenPrevious] = screen;
}
 
////////////////////////////////////////////////////////////////
// Collision
 
void DK_BoxCopy(int target_array, int target_offset, int source_array, int source_offset) {
    target_array[target_offset + DIR_UP] = source_array[source_offset + DIR_UP];
    target_array[target_offset + DIR_DOWN] = source_array[source_offset + DIR_DOWN];
    target_array[target_offset + DIR_LEFT] = source_array[source_offset + DIR_LEFT];
    target_array[target_offset + DIR_RIGHT] = source_array[source_offset + DIR_RIGHT];
}
 
// Read Link's position into a collision box.
void DK_LinkReadBox(int box_array, int box_offset) {
    box_array[box_offset + DIR_UP] = G[G_LinkY];
    box_array[box_offset + DIR_DOWN] = G[G_LinkY] + 16;
    box_array[box_offset + DIR_LEFT] = G[G_LinkX] + 2;
    box_array[box_offset + DIR_RIGHT] = G[G_LinkX] + 14;
}
 
// Update Link's position based on a collision box.
void DK_LinkWriteBox(int box_array, int box_offset) {
    G[G_LinkX] = box_array[box_offset + DIR_LEFT] - 2;
    G[G_LinkY] = box_array[box_offset + DIR_UP];
}
 
void DK_TraceBox(int box_array, int box_offset) {
    int format[] = "Box: %d - %d | %d - %d\n";
    printf(format,
                 box_array[box_offset + DIR_LEFT],
                 box_array[box_offset + DIR_RIGHT],
                 box_array[box_offset + DIR_UP],
                 box_array[box_offset + DIR_DOWN]);
}
 
// The shortest distance which results in a change in solidity
const int DK_SOLID_GRANULARITY = 7;
 
// Move a box as far as it can in a given direction.
// The movement distance should not exceed 8 pixels.
//
// box_array - the array holding the collision box
// box_offset - the first index of the collision box in box_array
// dir - The direction of movement. Must be one of the 4 cardinal directions.
// distance - How far to move. May be 0 to make this a simple collision test.
// collision_mask - What pixel types will impede movement.
// returns - If we hit a wall or not.
bool DK_BoxMove(int box_array, int box_offset, int dir, int distance, int collision_mask) {
    int dx = 0;
    int dy = 0;
    int code = 0;
    int x;
    int y;
    int border_distance;
 
    int i = 0;
 
    if (DIR_UP == dir) {dy = -1;}
    if (DIR_DOWN == dir) {dy = 1;}
    if (DIR_LEFT == dir) {dx = -1;}
    if (DIR_RIGHT == dir) {dx = 1;}
 
    // Check to see if the final position is valid. If it is, move there
    // immediately and quit.
    if (DIR_UP == dir || DIR_DOWN == dir) {
        code = 0;
        y = box_array[box_offset + dir] + distance * dy;
        if (DIR_DOWN == dir) {y -= 0.0001;}
        for (x = box_array[box_offset + DIR_LEFT];
                 x < box_array[box_offset + DIR_RIGHT] - 0.0001;
                 x += DK_SOLID_GRANULARITY) {
            code |= DK_PixelType(x, y);
        }
        x = box_array[box_offset + DIR_RIGHT] - 0.0001;
        code |= DK_PixelType(x, y);
        if (!(code & collision_mask)) {
            box_array[box_offset + DIR_UP] += distance * dy;
            box_array[box_offset + DIR_DOWN] += distance * dy;
            return false;
        }
    }
    if (DIR_LEFT == dir || DIR_RIGHT == dir) {
        code = 0;
        x = box_array[box_offset + dir] + distance * dx;
        if (DIR_RIGHT == dir) {x -= 0.0001;}
        for (y = box_array[box_offset + DIR_UP];
                 y < box_array[box_offset + DIR_DOWN] - 0.0001;
                 y += DK_SOLID_GRANULARITY) {
            code |= DK_PixelType(x, y);
        }
        y = box_array[box_offset + DIR_DOWN] - 0.0001;
        code |= DK_PixelType(x, y);
        if (!(code & collision_mask)) {
            box_array[box_offset + DIR_LEFT] += distance * dx;
            box_array[box_offset + DIR_RIGHT] += distance * dx;
            return false;
        }
    }
 
    // If we don't have any movement left, quit.
    if (distance <= 0) {return true;}
 
    // How far are we from the next pixel?
    border_distance = box_array[box_offset + dir] % 1;
    if (DIR_DOWN == dir || DIR_RIGHT == dir) {border_distance = (1 - border_distance) % 1;}
 
    // If we have enough movement, move up to the next pixel border.
    if (border_distance > 0 && distance >= border_distance) {
        box_array[box_offset + DIR_UP] += border_distance * dy;
        box_array[box_offset + DIR_DOWN] += border_distance * dy;
        box_array[box_offset + DIR_LEFT] += border_distance * dx;
        box_array[box_offset + DIR_RIGHT] += border_distance * dx;
        distance -= border_distance;
    }
 
    // Advance by whole pixels until we hit a wall.
    while (distance > 0) {
 
        ++i;
 
        // First, check to see if we hit something solid.
        if (DIR_UP == dir || DIR_DOWN == dir) {
            code = 0;
            y = box_array[box_offset + dir] + dy;
            if (DIR_DOWN == dir) {y -= 0.0001;}
            for (x = box_array[box_offset + DIR_LEFT];
                     x < box_array[box_offset + DIR_RIGHT] - 0.0001;
                     x += DK_SOLID_GRANULARITY) {
                code |= DK_PixelType(x, y);
            }
            x = box_array[box_offset + DIR_RIGHT] - 0.0001;
            code |= DK_PixelType(x, y);
            // If we hit, exit.
            if (code & collision_mask) {return true;}
        }
        if (DIR_LEFT == dir || DIR_RIGHT == dir) {
            code = 0;
            x = box_array[box_offset + dir] + dx;
            if (DIR_RIGHT == dir) {x -= 0.0001;}
            for (y = box_array[box_offset + DIR_UP];
                     y < box_array[box_offset + DIR_DOWN] - 0.0001;
                     y += DK_SOLID_GRANULARITY) {
                code |= DK_PixelType(x, y);
            }
            y = box_array[box_offset + DIR_DOWN] - 0.0001;
            code |= DK_PixelType(x, y);
            // If we hit, exit.
            if (code & collision_mask) {return true;}
        }
 
        // We're clear, so advance the box.
        box_array[box_offset + DIR_UP] += dy;
        box_array[box_offset + DIR_DOWN] += dy;
        box_array[box_offset + DIR_LEFT] += dx;
        box_array[box_offset + DIR_RIGHT] += dx;
        distance -= 1;
    }
 
    return true;
}
 
////////////////////////////////////////////////////////////////
// Main Script
 
// Minimum and maximum speeds.
const int DK_MIN_DX = -8;
const int DK_MAX_DX = 8;
const int DK_MIN_DY = -8;
const int DK_MAX_DY = 8;
 
// Sideview States
const int DK_STATE_FALLING = 0;
const int DK_STATE_ = 0;
 
void DK_Update() {
 
    if (G[G_ScreenChanged] || LA_SCROLLING == Link->Action) {
        G[G_LinkX] = Link->X;
        G[G_LinkY] = Link->Y;
        G[G_LinkDY] = 0;
    }
 
    if (LA_SCROLLING == Link->Action) {return;}
 
    bool grounded = false;
 
    bool block;
    int y;
    int dir;
 
    Link->Jump = 0;
    Link->Z = 0;
 
    if (Link->PressEx4) {
        G[G_DebugPixel] = 1 - G[G_DebugPixel];
    }
    if (G[G_DebugPixel]) {
        DK_DrawPixelTypes();
    }
 
    G[G_LinkDY] = Clamp(G[G_LinkDY] + GRAVITY, DK_MIN_DY, DK_MAX_DY);
 
    // If Link is falling:
    if (G[G_LinkDY] > 0) {
 
        // Check for being grounded.
        DK_LinkReadBox(G, G_Box1);
        grounded = DK_BoxMove(G, G_Box1, DIR_DOWN, 0.0001, DK_PIXEL_SOLID_TOP);
 
        // Make link fall if he's not grounded.
        if (!grounded) {
            DK_LinkReadBox(G, G_Box1);
            grounded = DK_BoxMove(G, G_Box1, DIR_DOWN, G[G_LinkDY], DK_PIXEL_SOLID_TOP | DK_PIXEL_SOLID_UNDER);
            DK_LinkWriteBox(G, G_Box1);
        }
 
        // Kill vertical momentum if grounded.
        if (grounded) {G[G_LinkDY] = 0;}
    }
 
    // If Link is rising:
    if (G[G_LinkDY] < 0) {
        // Move link up.
        DK_LinkReadBox(G, G_Box1);
        block = DK_BoxMove(G, G_Box1, DIR_UP, -G[G_LinkDY], DK_PIXEL_SOLID_UNDER);
        DK_LinkWriteBox(G, G_Box1);
 
        // If we hit something, kill vertical momentum
        if (block) {G[G_LinkDY] = 0;}
    }
 
    // Move Link.
    if (Link->InputLeft || Link->InputRight) {
        // Read link's position.
        DK_LinkReadBox(G, G_Box1);
 
        // Move box accordingly.
        if (Link->InputLeft) {dir = DIR_LEFT;}
        else if (Link->InputRight) {dir = DIR_RIGHT;}
        if (Link->InputEx3) {Trace(dir); DK_TraceBox(G, G_Box1);}
        DK_BoxMove(G, G_Box1, dir, G[G_LinkMoveSpeed], DK_PIXEL_SOLID_UNDER);
 
        // Copy box so we can use it in a test later.
        DK_BoxCopy(G, G_Box2, G, G_Box1);
 
        // If we're covering a "solid top" pixel, move up by 1.
        if (DK_BoxMove(G, G_Box1, DIR_DOWN, 0, DK_PIXEL_SOLID_TOP)) {
            --G[G_Box1 + DIR_UP];
            --G[G_Box1 + DIR_DOWN];
        }
 
        // If there's a "solid top" pixel 2 spaces down, we've stepped down, so
        // move link down to match it.
        else if (DK_BoxMove(G, G_Box2, DIR_DOWN, 2, DK_PIXEL_SOLID_TOP)) {
            DK_BoxCopy(G, G_Box1, G, G_Box2);
        }
 
        // Write box back to link's position.
        DK_LinkWriteBox(G, G_Box1);
    }
    if (Link->PressR) {
        Link->InputR = false;
        Link->PressR = false;
 
        if (grounded) {
            G[G_LinkDY] -= G[G_LinkJumpSpeed];
        }
    }
 
    G[G_LinkX] = Clamp(G[G_LinkX], 0, 240);
    G[G_LinkY] = Clamp(G[G_LinkY], 0, 160);
}
 
int dk_frame = 0;
void DK_DrawPixelTypes() {
    Screen->SetRenderTarget(RT_BITMAP0);
    for (int i = 0; i < 50; ++i) {
        ++dk_frame;
        dk_frame %= 256 * 176;
        int x = dk_frame % 256;
        int y = dk_frame / 256;
        int code = DK_PixelType(x, y);
        int color = 0;
        if (code & DK_PIXEL_LADDER_TOP) {color = 18;}
        else if (code & DK_PIXEL_LADDER_UNDER) {color = 17;}
        else if (code & DK_PIXEL_SOLID_TOP) {color = 2;}
        else if (code & DK_PIXEL_SOLID_UNDER) {color = 1;}
        Screen->PutPixel(7, x, y, color, 0, 0, 0, OP_OPAQUE);
    }
    Screen->SetRenderTarget(RT_SCREEN);
 
    Screen->DrawBitmap(7, RT_BITMAP0, 0, 0, 256, 176, 0, 0, 256, 176, 0, true);

    }
