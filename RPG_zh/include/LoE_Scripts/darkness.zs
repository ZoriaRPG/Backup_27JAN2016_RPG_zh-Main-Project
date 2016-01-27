bool dark;

global script active{
	void run(){
		if (dark){
			DrawDarkness();
			Waitdraw();
			Waitframe();
		}
	}
}

ffc script darkness{ //Run on screen init.
	void run(){
		dark = true;
	}
}