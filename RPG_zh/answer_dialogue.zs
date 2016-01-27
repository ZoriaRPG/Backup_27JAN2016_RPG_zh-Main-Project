[code=auto:0]const int ANSWER_YES = 1;
const int ANSWER_NO = 2;

//Let Link decide on stuff by saying yes or no.
ffc script Answer {
	void run(){
		int answer;
		while(true) {
			//Draw box, and string here.
			if ( answer > 2 ) {
				this->X = -32768;
				this->Y = -32768;
				this->Data = 0;
				Quit();
			}
			while (!answer) {
				if ( Link -> InputA ) answer = 1;
				if ( Link -> InputB ) answer = 2;
				Waitframe();
			}
			Waitframe();
		}
		if ( answer == ANSWER_YES ) { //Yes
		    //Do something.
			answer++;
		}
		if ( answer == ANSWER_NO ) {
		    //Do something else.
			answer++
		}
	}
}

[/code]