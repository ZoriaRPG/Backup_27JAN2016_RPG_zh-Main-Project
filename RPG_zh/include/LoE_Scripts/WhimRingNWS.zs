int SwordPower = 122; //The item id number of the whimsical ring. Chance should be set to
//1 in 1 and power to 0
int SwordDamage; 


//Set the actual power of the "Sword" item (Wooden sword, white sword, etc.) to 0.
//D0 is the minimum damage the sword can do, D1 is the maximum damage the sword can do.
item script SwordRandomDamage 
    {
        void run(int SwMinDam, int SwMaxDam) 
        {
        SwordDamage = Rand(SwMinDam, SwMaxDam);
        ModItemPower(SwordPower,SwordDamage);
        //Trace(SwordDamage); 
        //Uncomment above for testing purposes
        }
    }