//Returns from VitalStatistics[]
float Stat(int var){
	return VitalStatistics[var];
}

// e.g You can use this as a shortcut, anywhere you need to use a value int he array as a variable by doing:
//Stat(ST_STRENGTH) , and so forth.

//Sets a value in VitalStatistics[]
void Stat(int var, float value){
	VitalStatistics[var] = value;
}

//Easily set, change, or modify a value like this:
// Stat(ST_LUCK,20); //Changes Luck state to 20.

//Bumps a value in VitalStatistics by +1; boolean can be set to either true, or false, and is used as a signature ID.
void Stat(int var, bool increase){
	VitalStatistics[var]++;
}

//Bumps a value in VitalStatistics by arg amount; boolean can be set to either true, or false, and is used as a signature ID.
void Stat(int var, bool increase, int amount){
	VitalStatistics[var] += amount;
}