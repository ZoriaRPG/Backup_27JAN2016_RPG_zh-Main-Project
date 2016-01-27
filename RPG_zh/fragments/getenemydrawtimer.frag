const int ENEM_DRAW_TIMER_DAMAGE = 0;
const int ENEM_DRAW_TIMER_HEAL = 1;
const int ENEM_DRAW_TIMER_OTHER = 2;

//Returns the value of an enemy drawing timer. 
int GetEnemyDrawTimer(npc n, int timer){
	return GetDigit(n->Misc[ENEM_DRAWTIMERS],timer);
}

//Set the value of an enemy drawing timer. 
int SetEnemyDrawTimer(npc n, int timer, int value){
	
	float indexvalue = n->Misc[ENEM_DRAWTIMERS];
	
	int tenthousands = GetDigit(n->Misc[ENEM_DRAWTIMERS], 4);
	int thousands = GetDigit(n->Misc[ENEM_DRAWTIMERS], 3);
	int hundreds = GetDigit(n->Misc[ENEM_DRAWTIMERS], 2);
	int tens = GetDigit(n->Misc[ENEM_DRAWTIMERS], 1);
	int ones = GetDigit(n->Misc[ENEM_DRAWTIMERS], 0);
	int tenths = GetDigit(n->Misc[ENEM_DRAWTIMERS], -1);
	int hundreths = GetDigit(n->Misc[ENEM_DRAWTIMERS], -2)
	int thoudandths = GetDigit(n->Misc[ENEM_DRAWTIMERS], -3);
	int tenthousandths = GetDigit(n->Misc[ENEM_DRAWTIMERS], -4);
	
	if ( timer == 4 ) tenthousandths = value;
	if ( timer == 3 ) thousands = value;
	if ( timer == 2 ) hundreds = value;
	if ( timer == 1 ) tens = value;
	if ( timer == 0 ) ones = value;
	if ( timer == -1 ) tenths = value;
	if ( timer == -2 ) hundredths = value;
	if ( timer == -3 ) thousandths = value;
	if ( timer == -4 ) tenthousandths = value;
	
	indexvalue = tenthousandths + thousandths + hundredths + tenths + ones + tens + hundreds + thousands + tenthousandths;
}

//Reduce an enemy drawing timer by 1. 
void ReduceEnemyDrawTimer(npc n, int timer){
	float indexvalue = n->Misc[ENEM_DRAWTIMERS];
	
	int tenthousands = GetDigit(n->Misc[ENEM_DRAWTIMERS], 4);
	int thousands = GetDigit(n->Misc[ENEM_DRAWTIMERS], 3);
	int hundreds = GetDigit(n->Misc[ENEM_DRAWTIMERS], 2);
	int tens = GetDigit(n->Misc[ENEM_DRAWTIMERS], 1);
	int ones = GetDigit(n->Misc[ENEM_DRAWTIMERS], 0);
	int tenths = GetDigit(n->Misc[ENEM_DRAWTIMERS], -1);
	int hundreths = GetDigit(n->Misc[ENEM_DRAWTIMERS], -2)
	int thoudandths = GetDigit(n->Misc[ENEM_DRAWTIMERS], -3);
	int tenthousandths = GetDigit(n->Misc[ENEM_DRAWTIMERS], -4);
	
	if ( timer == 4 ) tenthousandths--;
	if ( timer == 3 ) thousands--;
	if ( timer == 2 ) hundreds--;
	if ( timer == 1 ) tens--;
	if ( timer == 0 ) ones--;
	if ( timer == -1 ) tenths--;
	if ( timer == -2 ) hundredths--;
	if ( timer == -3 ) thousandths--;
	if ( timer == -4 ) tenthousandths--;
	
	indexvalue = tenthousandths + thousandths + hundredths + tenths + ones + tens + hundreds + thousands + tenthousandths;
}
	
	
	
	
	