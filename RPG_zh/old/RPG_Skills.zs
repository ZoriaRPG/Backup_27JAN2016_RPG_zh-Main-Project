/// Skills

// Constants

/////////////////////////////
/// SKill Check Constants ///
/////////////////////////////




int loreSuccess = 0; //Shouldnl't this be part of the array?
int loreRow = 0;
int loreColumn = 0;
//Create a single pointer, that may not be needed.




// Arrays

// Vars

int loreSkill;

//Functions

int loreValue(){
    int value = ( loreRow + loreColumn );
    return value;
}

///////////////////////
/// SKill Functions ///
///////////////////////

void LoreCheckGeneric() {
    int loreBase;
    loreBase = ( loreSkill * 10 );
    int loreTotal = ( loreBase + getMindStat() );
    int loreDifference = ( loreTotal - loreBase );
    int loreRoll = rollDie(100);
    bool success;
    int loreType;
    int itemToCheck;
    int location;
    int level;
    int skill;
    if ( loreRoll < loreTotal ) {
        //Success
        loreSuccess = 1; //Shouldn't this be part of the array, that stores successes?
        }
    else {
    //failure
    loreSuccess = 2; //Shouldn't this be part of the array, that stores successes?
    }
}

void makeLoreCheck(){
    if ( loreSuccess == 0 ){
    //do this
    }
 }
 
    

void LoreCheckSuccess(bool success, int loreType, int itemToCheck, int location, int level, int skill ){
    if ( loreSuccess == 0 ){
    //import results from makeLoreCheck. Create a makeLoreCheck command for each item 
    //that can use it, and each site that can use it.
    }
 }
    
void loreLevel(){
loreSuccess = 0; //When increasing Lore, or gaining a level, reset this value. 
}

//Possibly, use a function in the while loop with its own ints and bools.
//THis function would store the lore check results and the level of the check
//for every item. It wouod compare the result (0, 1, 2) to the character level, and the level at the time 
//that the player made the check. If the currentLevel > lastLevelForCheck, then it will allow a new check.
//if the result is 0, it will always allow a check, and if the result is 2, it gives the new item.
//This would keep the variables in the scope of the function, instead of as global constants and global vars.


//Scripts