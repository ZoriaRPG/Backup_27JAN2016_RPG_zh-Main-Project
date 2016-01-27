0 1 2 3 4 5 6 7 8 9 a b c d e f
1
2
3
4
5
6
7
8
9
a
b


0->3 4->7 8->b c->f

0->3 4->7 8->b


for ( int q = 0; q < 176; q+=4 ) {
	//Create weapon
	//extend it to size 4
	//hitwidth and hitheight
	//starts at 00 and is 4x4
	
	if ( q % 13 == 0 ) q += 36; //mAKE THE OFFSET for reaching the end of a 4x4 row.
					//May need to be +32
}