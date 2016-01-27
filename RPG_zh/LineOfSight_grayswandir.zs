// This lets you step through every quarter tile that intersects the line from
// point A to point B. See Line_Draw at the end for an example usage.

// Line indices.
const int LINE_HORIZONTAL = 0;
const int LINE_VERTICAL = 1;
const int LINE_ORIENTATION = 0;
const int LINE_LONG = 1;
const int LINE_SHORT = 2;
const int LINE_TARGET = 3;
const int LINE_DELTA = 4;
const int LINE_SLOPE = 5;
const int LINE_SHORT_EXTRA = 6;

// Sets up a line. line is a new 7 elemnet array.
void Line_Start(int line, int x1, int y1, int x2, int y2) {
	x1 = Clamp(x1, 0, 255);
	y1 = Clamp(y1, 0, 175);
	x2 = Clamp(x2, 0, 255);
	y2 = Clamp(y2, 0, 175);

	int dx = x2 - x1;
	int dy = y2 - y1;
	int adx = Abs(dx);
	int ady = Abs(dy);
	// a is the longer axis, b is the shorter one.
	int a;
	int b;
	int da;
	int db;
	int ta;
	int a_is_x;
	if (adx > ady) {
		a_is_x = LINE_HORIZONTAL;
		a = x1;
		b = y1;
		ta = x2;
		da = Cond(dx >= 0, 1, -1);
		db = dy / dx;}
	else {
		a_is_x = LINE_VERTICAL;
		a = y1;
		b = x1;
		ta = y2;
		da = Cond(dy >= 0, 1, -1);
		db = dx / dy;}

	// Snap to the center of the nearest quarter tile.
	int diff = 3.5 - (a % 8);
	a += diff;
	b += diff * db;
	diff = 3.5 - (b % 8);
	b += diff;
	int extra_b = -diff;

	// Valid target as soon as we hit the edge of the quarter tile.
	diff = 4 - (ta % 8);
	ta += diff;
	if (da > 0) {ta -= 4;}
	else {ta += 3;}

	da *= 8;

	line[LINE_ORIENTATION] = a_is_x;
	line[LINE_LONG] = a;
	line[LINE_SHORT] = b;
	line[LINE_TARGET] = ta;
	line[LINE_DELTA] = da;
	line[LINE_SLOPE] = db;
	line[LINE_SHORT_EXTRA] = extra_b;}

// Gets the x value of a line.
int Line_X(int line) {
	if (LINE_HORIZONTAL == line[LINE_ORIENTATION]) {return line[LINE_LONG];}
	else {return line[LINE_SHORT];}}

// Gets the y value of a line.
int Line_Y(int line) {
	if (LINE_HORIZONTAL == line[LINE_ORIENTATION]) {return line[LINE_SHORT];}
	else {return line[LINE_LONG];}}

// Move to the next point along the line. Return false if we've already finished.
bool Line_Step(int line) {
	if (line[LINE_DELTA] > 0) {
		if (line[LINE_LONG] > line[LINE_TARGET]) {return false;}}
	else {
		if (line[LINE_LONG] < line[LINE_TARGET]) {return false;}}

	if (line[LINE_SHORT_EXTRA] < -4) {
		line[LINE_SHORT] -= 8;
		line[LINE_SHORT_EXTRA] += 8;}
	else if (line[LINE_SHORT_EXTRA] > 4) {
		line[LINE_SHORT] += 8;
		line[LINE_SHORT_EXTRA] -= 8;}
	else {
		line[LINE_LONG] += line[LINE_DELTA];
		line[LINE_SHORT_EXTRA] += line[LINE_DELTA] * line[LINE_SLOPE];}

	return true;}

void Line_Draw(int x1, int y1, int x2, int y2) {
	int line[7];
	Line_Start(line, x1, y1, x2, y2);
	while (Line_Step(line)) {
		int x = Line_X(line);
		int y = Line_Y(line);
		Screen->Rectangle(6, x - 4, y - 4, x + 4, y + 4, 1, 1, 0, 0, 0, true, OP_TRANS);}}