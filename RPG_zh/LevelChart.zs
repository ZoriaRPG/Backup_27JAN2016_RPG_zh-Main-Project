	
//This stores the NP needed for each level as a float. 
float LevelChart[46]={ //This needs to be a float, and we need to use decimal values for XP, or just smaller values.
	0,
	0.0100,0.0150,0.0200,0.0275,0.0375,0.0512,0.0700,0.0956,0.1306,0.1784,
	0.2437,0.3329,0.4548,0.6213,0.8487,1.1594,1.5888,2.1685,2.9629,4.0472,
	5.5286,7.5522,10.3165,14.0926,19.2509,26.2972,35.9227,49.0763,67.0377,91.5745,
	125.0939,170.8812,233.3181,318.7587,435.4178,594.7172,910.4261,1207.7847,1662.9978,2266.8902,
	0,0,0,0}; //Each next at + 1/2 previous level base.
	