void BackupCheat(){
	int cheatlevel = Game->Cheat;
	GameDynamics[CHEATLEVEL] = cheatlevel;
}

void RestoreCheat(){
	int cheatlevel = GameDynamics[CHEATLEVEL];
	Game->Cheat = cheatlevel;
}