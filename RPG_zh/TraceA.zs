void TraceArray(int arr){
	int str[]="Tracing array with Pointer: ";
	int bufferPtr[7]=" ";
	itoa(arr,bufferPointer);
	int mainBuffer[40]=" ";
	strcat(str,mainBuffer);
	strcat(bufferPointer,mainBuffer);
	TraceNL();
	TraceS(mainBuffer);
	TraceNL();

	for ( int q = 0; q < SizeOfArray(arr); q++ ) {
		int str2[]="Index: ";
		int str3[]="is : ";
		int buffer[22]=" ";
		int bufferAmt[7]=" ";
		int bufferIndex[7]=" ";
		itoa(arr[q],bufferAmt);
		itoa(q,bufferIndex);
		strcat(str2,buffer);
		strcat(bufferIndex,buffer);
		strcat(str3,buffer);
		strcat(bufferAmt,buffer);
		TraceS(buffer);
		TraceNL();
	}
}

void TraceA(int arr){
	TraceArray(arr);
}