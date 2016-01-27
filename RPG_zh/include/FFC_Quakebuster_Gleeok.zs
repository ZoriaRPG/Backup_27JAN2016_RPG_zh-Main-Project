
 
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
