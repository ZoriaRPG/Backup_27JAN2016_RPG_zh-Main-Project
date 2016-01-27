
item script rubbish{ 
	void run(){
		int x = 1;
		active.rubbish(x); //THis will work, only if we know the pointer ID ahead of time. 
	}
}

global script active{
	void run(){
		int MyArray[20]; //Make an array.
		while ( true ) {
			rubbish(MyArray); //We pass the pointer of MyArray to the function.
			Waitframe();
		}
	}
	void rubbish(int MyArray){ //This accepts an integer as an input. 
		Trace(SizeOfArray(MyArray)); //This can trace the array, because we passed it spointer to the arg int MyArray.
		MyArray[1] = 100; //We can set this, because we passed the pointer.
	}
}

item script rubbish{ 
	void run(){
		int x = 1;
		active.rubbish(x);
	}
}

global script active{
	void run(){
		int MyArray[20]; //Make an array.
		while ( true ) {
			rubbish(MyArray); //We pass the pointer of MyArray to the function.
			Waitframe();
		}
	}
	void rubbish(int foo){ //Change the input name.
		Trace(SizeOfArray(foo)); //This can trace the array, because we passed the pointer of MyArray[20] declared in
					 //the script, to an input with the label of foo. 
		foo[1] = 100; //We can set this, because we passed the pointer to foo, and it will set MyArray[0] above to '100'.
	}
}