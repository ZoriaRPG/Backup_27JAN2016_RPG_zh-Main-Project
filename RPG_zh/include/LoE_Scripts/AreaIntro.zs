ffc script AreaIntro {
	void run(int string, int dat, int element){
		bool visited = false;
		bool playMsg = true;
		if ( Screen->D[SCREEN_INTRO] > 0 ) {
				visited = true;
		}
		while(true){
			if (visited){
				break;
			}
			if ( playMsg ) {

				Screen->Message(string);
				
				playMsg = false;
				if ( dat > 0 ) {
					Screen->D[SCREEN_INTRO]++;
				}
			}
			if (Link->PressB || Link->PressA) {
				
				this->Data = 0;
				break;
			}
			Waitframe();
		}
		return;
	}
}