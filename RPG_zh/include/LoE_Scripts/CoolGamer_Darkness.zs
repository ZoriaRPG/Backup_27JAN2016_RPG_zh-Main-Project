// CONSTANTS
//
// EDIT THESE TO EDIT THE EFFECTS OF THE CODE!
 
const int MAP_NUMBER = 1;
// ^ Number of the map with the screens that will be drawn over the screen
 
const int SCREEN_NUMBER = 2;
// ^ Number of the Screen with the screen with the Darkness
 
const int SOURCE_DARKLAYER = 0;
// ^ Layer that the Darkness layer is on
 
const int DARKLAYER = 6;
// ^ Layer you want the screens drawn to
 
const int SCREEN_NUMBER_2 = 1;
// ^ Screen number of the screen with the transparent circle (or other shape) in the center
 
// DON'T EDIT STUFF
// Don't edit this stuff.
 
int CURRENT_SCREEN;
//int CURRENT_SCREEN = Game->GetCurScreen();
// ^ Don't edit that.
 
int CURRENT_MAP;
//int CURRENT_MAP = Game->GetCurMap();
// ^ Don't edit that.
 
 
 
import "std.zh"
 
//Put constants here.
//Put Global Variables here
 
global script LttPLightRing
 
        {
                void run()
                        {
 
// Put Local Variables here.
int ScreenVar_X;               
int ScreenVar_Y;
int scrollDir;
int scrollCounter;             
 
// Global Var Stuff
 
                                while(true)
                                        {
 
ScreenVar_X = Link->X - 120;
ScreenVar_Y = Link->Y - 80;
CURRENT_SCREEN = Game->GetCurScreen();
// ^ Don't edit that.
 
CURRENT_MAP = Game->GetCurMap();
// ^ Don't edit that.
 
 
// if((Game->GetScreenFlags(CURRENT_MAP, CURRENT_SCREEN, SF_MISC) & 0000100b) != 0)
//                                              if((Game->GetScreenFlags& 0000100b)!= 0) {//stuff}
       
                                                if((Game->GetScreenFlags(CURRENT_MAP, CURRENT_SCREEN, SF_MISC) & 0000100b) != 0)
                                                        {
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER_2, SOURCE_DARKLAYER, ScreenVar_X - 256, ScreenVar_Y - 176, 0, OP_OPAQUE);       
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER_2, SOURCE_DARKLAYER, ScreenVar_X, ScreenVar_Y - 176, 0, OP_OPAQUE);
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER_2, SOURCE_DARKLAYER, ScreenVar_X + 256, ScreenVar_Y - 176, 0, OP_OPAQUE);
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER_2, SOURCE_DARKLAYER, ScreenVar_X - 256, ScreenVar_Y, 0, OP_OPAQUE);
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER_2, SOURCE_DARKLAYER, ScreenVar_X + 256, ScreenVar_Y, 0, OP_OPAQUE);
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER_2, SOURCE_DARKLAYER, ScreenVar_X - 256, ScreenVar_Y + 176, 0, OP_OPAQUE);
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER_2, SOURCE_DARKLAYER, ScreenVar_X, ScreenVar_Y + 176, 0, OP_OPAQUE);
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER_2, SOURCE_DARKLAYER, ScreenVar_X + 256, ScreenVar_Y + 176, 0, OP_OPAQUE);
                                       
                                        Screen->DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER, SOURCE_DARKLAYER, ScreenVar_X, ScreenVar_Y, 0, OP_OPAQUE);
 
// Saffiths code. Offsets the Darkness to Link's actual position.
if(Link->Action==LA_SCROLLING)
{
    if(scrollDir==-1)
    {
        if(Link->Y>160)
        {
            scrollDir=DIR_UP;
            scrollCounter=45;
        }
        else if(Link->Y<0)
        {
            scrollDir=DIR_DOWN;
            scrollCounter=45;
        }
        else if(Link->X>240)
        {
            scrollDir=DIR_LEFT;
            scrollCounter=65;
        }
        else
        {
            scrollDir=DIR_RIGHT;
            scrollCounter=65;
        }
    }
   
    if(scrollDir==DIR_UP && scrollCounter<45 && scrollCounter>4)
        ScreenVar_Y+=4;
    else if(scrollDir==DIR_DOWN && scrollCounter<45 && scrollCounter>4)
        ScreenVar_Y-=4;
    else if(scrollDir==DIR_LEFT && scrollCounter<65 && scrollCounter>4)
        ScreenVar_X+=4;
    else if(scrollDir==DIR_RIGHT && scrollCounter<65 && scrollCounter>4)
        ScreenVar_X-=4;
   
    scrollCounter--;
}
else
{
    ScreenVar_X=Link->X;
    ScreenVar_Y=Link->Y;
    if(scrollDir!=-1)
        scrollDir=-1;
}
// End of Saffiths code.
                                                        }              
        Waitframe();
                                        }
                        }
        }
//DrawLayer(int layer, int source_map, int source_screen, int source_layer, int x, int y, float rotation, int opacity);
//DrawLayer(DARKLAYER, MAP_NUMBER, SCREEN_NUMBER, SOURCE_DARKLAYER, Link->X - 120, Link->Y - 96, 0, OP_OPAQUE);
 
//int GetScreenFlags(int map, int screen, int flagset);
//int GetScreenFlags(CURRENT_MAP, CURRENT_SCREEN, SF_MISC);
//return (Game->DMapFlags[dmap]&flag)!=0;
 
//int GetCurScreen();
//int GetCurMap();