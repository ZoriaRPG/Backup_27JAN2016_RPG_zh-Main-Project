

int dmapName[20];
int dmapTitle[20];
int dmapIntro[72];

void StoreDmapName(int dmap){
	for ( int q = 0; q <= SizeOfArray(dmapame); q++ ){
		dmapName[q] = 0; //Ensures we wipe the old string, before setting new string. 
	}
	Game->GetDmapName(dmap,dmapName);
}	

void StoreDmapIntro(int dmap){
	for ( int q = 0; q <= SizeOfArray(dmapIntro); q++ ){
		dmapIntro[q] = 0; //Ensures we wipe the old string, before setting new string. 
	}
	Game->GetDMapIntro(dmap, dmapIntro);
}

void StoreDmapTitle(int dmap){
	for ( int q = 0; q <= SizeOfArray(dmapTitle); q++ ){
		dmapTitle[q] = 0; //Ensures we wipe the old string, before setting new string. 
	}
	Game->GetDMapTitle(dmap, dmapTitle);
}
