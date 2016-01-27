// Katakana Font for Tango

const int START_TILE_KATAKANA = 1200;

int FONT_KATAKANA[] = {
    TANGO_FONT_CUSTOM,
    TANGO_FONT_MONOSPACE,
    0,    // Unused
    START_TILE_KATAKANA, // Starting tile
    8,   // Character height
    2,    // Space between lines
    8    // Character width
};

// Some constants to make the string slightly less ugly

//Pure vowel kana.
const int AA = 33;
const int II = 34;
const int UU = 35;
const int EE = 36;
const int OO = 37;

//Hard C/K consonant.
const int KA = 38;
const int CA = 38;
const int KI = 39;
const int CI = 39;
const int KU = 40;
const int CU = 40;
const int KE = 41;
const int CE = 41;
const int KO = 42;
const int CO = 42;

const int SA = 43;
const int SI = 44;
const int SU = 45;
const int SE = 46;
const int SO = 47;

const int TA = 48;
const int TI = 49;
const int TU = 50;
const int TSU = 50;
const int TE = 51;
const int TO = 52;

const int NA = 53;
const int NI = 54;
const int NU = 55;
const int NE = 56;
const int NO = 57;

const int HA = 58;
const int HI = 59;
const int HU = 60;
const int HE = 61;
const int HO = 62;

const int MA = 63;
const int MI = 64;
const int MU = 65;
const int ME = 66;
const int MO = 67;

//R and L consonants are shared. Also, 'Ryu' trilled consonant is usually not enunciated well outside of Japan, and would be produced by [RY,YU] here..
const int RA = 68;
const int LA = 68;
const int RI = 69;
const int LI = 69;
const int RU = 70;
const int LU = 70;
const int RE = 71;
const int LE = 71;
const int RO = 72;
const int LO = 72;

const int GA = 73;
const int GI = 74;
const int GU = 75;
const int GE = 76;
const int GO = 77;

const int ZA = 78;
const int ZI = 79;
const int ZU = 80;
const int ZE = 81;
const int ZO = 82;

const int DA = 83;
const int DI = 84;
const int DU = 85;
const int DE = 86;
const int DO = 87;

const int BA = 88;
const int BI = 89;
const int BU = 90;
const int BE = 91;
const int BO = 92;

//P and F consonants are shared.
const int PA = 93;
const int FA = 93;
const int PI = 94;
const int FI = 94;
const int PU = 95;
const int FU = 95;
const int PE = 96;
const int FE = 96;
const int PO = 97;
const int FO = 97;

const int WA = 98;
const int WU = 99;

const int NN = 100;

//Consonant +ya, +yu, +yo trills. Add these to a consonant kana as separate kana. 
const int YA = 101;
const int YU = 102;
const int YO = 103;

const int LONGV = 104;
const int DBL = 105;

const int YEN = 106;
//Hour is absent.
const int JDAY = 107; //Japanese Kanji for Day
const int NICHI = 107;
const int HIKA = 107;
const int JMONTH = 108; //Japanese Kanji for Month
const int GETSU = 108;
const int TSUKI = 108;
const int JYEAR = 109; //Japanese Kanji for Year
const int NEN = 109;
const int TOSHI = 109;
const int JLQUOTE = 110;
const int JRQUOTE = 111;
const int JNO = 112; //The 'no' Kanji, meaninf 'of, relating to'
const int SPC = 113; //A blank space.

//Numerals
const int J0 = 114; // Kana for '0'.
const int REI = 114;
const int J1 = 115; // Kana for '1'.
const int ICHI = 115;
const int J2 = 116; // Kana for '2'.
const int NI = 116;
const int J3 = 117; // Kana for '3'.
const int SAN = 117;
const int J4 = 118; // Kana for '4'.
const int SHI = 118;
const int YON = 118; //Alternative to Shi.
const int J5 = 119; // Kana for '5'.
const int GGO = 119; //The numeral is pronounced 'Go' as is the kana 'Go', so we need to differentiate them.
const int J6 = 120; // Kana for '6'.
const int ROKU = 120;
const int J7 = 121; // Kana for '7'.
const int SHICHI = 121;
const int NANA = 121; //Alternative to Shichi.
const int J8 = 122; // Kana for '8'.
const int HACHI = 8;
const int J9 = 123; // Kana for '9'.
const int KYUU = 123; 
const in J10 = 124; //Kana for '10'
const int JUU - 124;
const int J100 = 125; //Kana for '100'
const int HYAKU = 125;
const int J1000 = 126; //Kana for '1000'
const int SEN = 126;
const int J10000 = 127; //Kana for '10000'.
const int MAN = 127;



int Katakana[]={ AA, II, UU, EE, OO, KA, CA, KI, CI, KU, CU, KE, CE, KO, CO, SA, SI, SU, SE, SO, TA, TI, TU, TE,
		TO, NA, NI, NU, NE, NO, HA, HI, HU, HE, HO, MA, MI, MU, ME, MO, RA, LA, RI, LI, RU, LU, RE, LE, 
		RO, LO, GA, GI, GU, GE, GO, ZA, ZI, ZU, ZE, ZO, DA, DI, DU, DE, DO, BA, BI, BU, BE, BO, PA, FA, 
		PI, FI, PU, FU, PE, FE, PO, FO, WA, WU, NN, YA, YU, YO, LONGV, DBL, YEN, JDAY, JHOUR, JYEAR, 
		JLQUOTE, JRQUOTE, JNO, SPC, J0, J1, J2, J3, J4, J5, J6, J7, J8, J9, J10, J100, J1000, J10000};

int stringJ[]={GGO,SEN,NICHI,JNO,HA,KU,NULL}; //'The toil of 50,000 days. This string tests numerals with ordinary kana.
		int format[]="%s@sync(1)";
		int string[256];
		sprintf(string, format, stringJ);

int stringZelda[]={ZE,RU,DA,JNO,DE,NE,SE,TSU};