int ChargeCounter[2]={240, 240};
const int CHARGEBEAM_TIMER = 0;
const int CHARGEBEAM_TIME_VALUE = 1;

void ChargeBeam(){
	if ( ( GetEquipmentA() == I_CHARGEBEAM && Link->InputA ) || 
		( GetEquipmentB() == I_CHARGEBEAM && Link->InputB ) && ChargeCounter[CHARGEBEAM_TIMER] > 0 ) ChargeCounter[CHARGEBEAM_TIMER]--;
	if ( ( GetEquipmentA() == I_CHARGEBEAM && Link->InputA ) || 
		( GetEquipmentB() == I_CHARGEBEAM && Link->InputB ) && ChargeCounter[CHARGEBEAM_TIMER] <= 0 ) {
		ChargeCounter[CHARGEBEAM_TIMER] = ChargeCounter[CHARGEBEAM_TIME_VALUE];
		ChargeBeamFire();
	}
}

void ChargeBeamFire(){
	//Link Actions
	//Make weapon (ffc)
}
		