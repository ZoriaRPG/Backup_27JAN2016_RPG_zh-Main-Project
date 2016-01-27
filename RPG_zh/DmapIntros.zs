void StoreDmapName(int dmap, bool wipe){
	if ( wipe ) {
		for ( int q = 0; q <= SizeOfArray(dmapName); q++ ){
			dmapName[q] = 0; //Ensures we wipe the old string, before setting new string. 
		}
	}
	Game->GetDMapName(dmap,dmapName);
}

void StoreDmapIntro(int dmap, bool wipe){
	if ( wipe ) {
		for ( int q = 0; q <= SizeOfArray(dmapIntro); q++ ){
			dmapIntro[q] = 0; //Ensures we wipe the old string, before setting new string. 
		}
	}
	Game->GetDMapIntro(dmap, dmapIntro);
}

void StoreDmapTitle(int dmap, bool wipe){
	if ( wipe ) {
		for ( int q = 0; q <= SizeOfArray(dmapTitle); q++ ){
			dmapTitle[q] = 0; //Ensures we wipe the old string, before setting new string. 
		}
	}
	Game->GetDMapTitle(dmap, dmapTitle);
}