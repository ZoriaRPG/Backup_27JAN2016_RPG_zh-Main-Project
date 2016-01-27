import "std.zh"

float XP = 12345.6789;

void FloatXPtoIntXP(){
	int ones = GetPartialArg(XP, -2, 3);
	int thousands = GetPartialArg(XP, 1, 3);
	int millions = GetPartialArg(XP, 4, 3);
	int Ones[]="Ones Places: ";
	int Thousands[]="Thousands Places: ";
	int Millions[]="Millions Places: ";
	int Function[]="Testing FloatXPtoIntXP()";
	TraceNL();
	TraceS(Function);
	TraceNL();
	TraceS(Ones);
	Trace(ones);
	TraceNL();
	TraceS(Thousands);
	Trace(thousands);
	TraceNL();
	TraceS(Millions);
	Trace(millions);
	
}


int GetPartialArg(int arg, int place, int num){
	place = Clamp(place, -4, 4);
	int r;
	int adj = 1;
	for(int i = num-1; i > -1; i--){
		if(place - i < -4) continue;
		r += GetDigit(arg, place - i) * adj;
		adj *= 10;
	}
	return r;
}

int GetRemainderAsInt(int v)
{
    int r = (v - (v << 0)) * 10000;
    return r;
}

// This function breaks up the value of an argument into individual digits. It is combined with the function GetDigit below.


int GetDigit(int n, int place)
{
	place = Clamp(place, -4, 4);
	if(place < 0)
	{
		n = GetRemainderAsInt(n);
		place += 4;
	}

	int r = ((n / Pow(10, place)) % 10) << 0;
	return r;
}

int GetPartialArg2(int arg, int place, int num){
	place = Clamp(place, -4, 4);
	int r;
	int adj = 1;
	for(int i = num-1; i > -1; i--){
		if(place - i < -4) continue;
		
		
		place = ( Clamp(place, -4, 4) - i);
		if(place < 0) {
			arg = GetRemainderAsInt(arg);
			place += 4;
		}
		r += ( ((arg / Pow(10, place)) % 10) << 0 ) * adj;
		adj *= 10;
	}
	return r;
}

int GetPartialArg3(int arg, int place, int num){
	place = Clamp(place, -4, 4);
	int r;
	int adj = 1;
	for(int i = num-1; i > -1; i--){
		if(place - i < -4) continue;
		
		
		place = ( Clamp(place, -4, 4) - i );
		if(place < 0)
		{
		arg = GetRemainderAsInt(arg);
		place += 4;
		}

		int z = ((arg / Pow(10, place)) % 10) << 0;
		
		r += z;
		adj *= 10;
		

	}
	return r;
}

global script active{
	void run(){
		while(true){
			FloatXPtoIntXP();
			Waitframe();
		}
	}
}