01 	: Self-critical hit,
02-05 	: Major injury to self,
06-10 	: Moderate injury to self,
11-20 	: Minor injury to self,
21-30 	: Drunk movement for duration (unbalanced...been working on a better function for that),
31-40 	: Nothing Happens 10% (padding for balance),
41-50 	: -1d4 Str/Stamina for X-minutes (exhausted),
51-65 	: Nothing happens 15% (total 25% in two number ranges).
66-80 	: Lose item (remove from inventory, and place on screen within 5 tiles of player (you will also 
	  need to store a value in Screen->D when this happens, so that leaving the screen, and returning puts 
	  the item somewhere on the screen),
81-90 	: Break item (will require a way to fix it for unique items, or any items, or replace non-unique items,
91-97 	: Hits enemy for reduced (halved) damage,
98-99 	: Hits enemy for normal damage *on enemy* (recursive recovery),
100 	: Hits enemy for accidental crit *on enemy* (recursive luck). 