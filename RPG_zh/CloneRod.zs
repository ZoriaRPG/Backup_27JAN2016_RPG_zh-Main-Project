//Clone Rod

//Clones one combo from a source position in front of Link, to a second location (on a second use) in front of link.

int LoadedCloneCombos[176]; //Store the loaded combos, and all their types. 

//Pretty muchm works like the SwithHook, except that the first time the item is used,
//it reads the combo in front of Link, and changes the item colour to an energrised state.

//if it is energised, using it will make that combo in front of Link, and clear its energised state
//and clear the array. 