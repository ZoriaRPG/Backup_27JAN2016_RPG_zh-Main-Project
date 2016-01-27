
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
 
 

