void MirrorCounter(int main, int mirror){
	Game->Counter[mirror] = Game->Counter[main];
}

void MirrorMCounter(int main, int mirror){
	Game->MCounter[mirror] = Game->MCounter[main];
}

void MirrorDCounter(int main, int mirror){
	Game->DCounter[mirror] = Game->DCounter[main];
}