Legacy of Emperors Game Theory

One of the main concepts with Legacy of Emperors (LoE) is that the player should be encouraged to seek out 
challenges, from either friendly, or non-friendly NPCs, instead of grinding for money, or experience. 

To this end, grinding for money is partially limited, and made slightly annoying, by the ‘free wallet and pocket
space’ global functions in RPG.zh.

This provides a limited about of physical volume, as in the amount of space, that is available. Value items, 
such as money, gems, and what have you, have both a fixed denominational size, and a volume. The denominational 
value, and the volume, are not identical.

The larger an object is, in volume, the more space it requires. If the player goes about grinding, and picking 
up small value objects, they will fill up his available space, and he will need to frequent the bank, for 
downsizing. This puts money on a CryDisc, that stores any value, but only uses ‘3’ space. 

General List of Sizes
Object					Type		Colour		Value		Volume	Script
Dsari (Small, Silver)			Money		Light Grey	1		1	moneyObject
Dsari (Large, Silver)			Money		Light Grey	5		3	moneyObject
Dsari (Small, Electrum)			Money		Grey/Yellow	10		1	moneyObject
Dsari (Large, Electrum)			Money		Grey/Yellow	20		3	moneyObject
Dsari (Small, Gold)			Money		Yellow		50		1	moneyObject
Dsari (Large, Gold)			Money		Yellow		100		3	moneyObject
Dsari (Small, Adamantium		Money		Slate Grey	250		1	moneyObject
Dsari (Large, Adamantium)		Money		Slate Grey	750		3	moneyObject
Dsari (Small, Virilinium)		Money		Green		1000		1	moneyObject
Dsari (Large, Virilinium)		Money		Green		5000		3	moneyObject
Dsari (Small, CryDisc, Blue)		Money		Blue		250		1	moneyObject
Dsari (Small, CryDisc, Red)		Money		Red		500		1	moneyObject
Dsari (Large, Crydisc, Blue)		Money		Blue		750		3	moneyObject
Dsari (Large, CryDisc, Red)		Money		Red		1500		3	moneyObject
Dsari (CryDisc, Bank, Flashing)		Money		Red/Blue	Variable	3	moneyObject
Gem (Tiny, Ruby)			Money		Red		25		0.5	fractionalMoneyPickup
Gem (Tiny [...] )			Money		Unspecified	Unassigned	0.5	fractionalMoneyPickup
Gem (Small [...] )			Money		Unspecified	Unassigned	1.5	fractionalMoneyPickup
Gem (Medium [...] )			Money		Unspecified	Unassigned	4.5	fractionalMoneyPickup
Gem (Large [...] )			Money		Unspecified	Unassigned	7.5	fractionalMoneyPickup
Gem (Huge [...] )			Money		Unspecified	Unassigned	10	fractionalMoneyPickup
Maerk ( Other Coin Type ) * Currency for home world.

Larger value objects, with small sizes, are found only in dungeons, missions, challenge areas, treasure chests,
special enemy drops, and such. Likewise, the XP table is linked to a CR (Challenge Rating) table, and a MAX LEVEL
table. These work together, to determine what award killing any (unGhosted) monster should give. The game checks
the player level, and the monster CR, and looks into both the awards table, and the max level for awards table:

If the player level, is equal to, or less than the ‘Max Level for Award’, the functions that grant the award run. Otherwise, there is no XP award. This means that the player can’t grind easy monsters all game, to rack up XP. After a while, the lesser foes are not a threat, and grant nothing. 
All of this, ties into ‘Challenge Areas’, as defined below.

Challenge Area Concept
Essentially, I'll have FFCs that look like blue-tone, grey-tone, red-tone, or green-tone enemies, and the player
can't kill them. The 'enemy ffc' looks, and moves like a normal enemy, appropriate to that screen, except that it
is monochromatic (using shades of blue, grey, green, or red), and may, or may not launch projectile attacks.

(I have mixed feelings about something like this, that can damage a player, but that the player can't damage, 
although completing the challenge clears the enemy, so this may also work, to trigger some screen-secrets.) 
In any event, merely touching the ffc enemy won't damage the player (as touching it, is required. Any 'attacks'
that it has, must be projectiles.

If the player touches one, it does the following:

( 1 ) All of these will do this: Store the current DMAP, screen, x, y, and z coordinates of the player, when he
touched the ffc; which is what the returnWarp ffc does (in theory); in a global array.

( 2 ) When the player touches an FFC (other than red, or green), it compares h9is level tot he value of Screen->D
[2]. If his level is greater than that value,. he will get a choice to accept a challenge of one sort or another,
using a JRPG menu. Accepting sends him to the appropriate challenge, and declining temporarily sets a boolean 
(local to the ffc [bool declined] ) to true, so the player would need to leave the screen and return, to change
his mind.

( 3 ) Add a menu entry to the 'Misc' menu 'Forfeit', that returns the player to his previous location. I would 
prefer to require that the player gain a level before accepting a challenge on that screen again, so forfeit 
will warp the player back, and set Screen->D[2] to the current level of the player.

( 4 ) An award is at the end of each, and may be XP, money, or other valuables, or commodities.It should be a 
reward of value equal to the difficulty of the challenge, and challenge rooms will have a CR (challenge rating)
that determines the item awarded.

( 5 ) Awards are dummy items (in big chests) have a pick-up script, that grants the award, and then runs a global
function.

( 6 ) Awards should never be key items, that are mandatory to complete the game!

( 7 ) If the player completes all challenges of each type, they get a special award for each.

( 8 ) Completing a challenge sets a global boolean (currentChallengeWon) to true, then returns the player to the 
screen on which they accepted it, at their previous coordinates. (This is partly why I accepted your request for
a mirror-like item, if you didn't know that.)

( 9 ) The global function that returns the player, after warping him, reads Screen->D[3], and if the value 
is < 1, because the boolean is true, removes the FFC, and sets Screen->D[3] to 1, then clears the boolean 
condition. Else, this may work through the ffc, which won't run ifScreen->D[3] is > 0.


Challenge Types & Rules

Grey Enemies: Tactics Challenges: A menu opens, prompting the player to accept a challenge. if the player accepts
, it warps him to a randomly selected 'Challenge Room'. The Rand will read the inventory of the player, and see 
for which challenges he is eligible. (If he has no eligible challenges,. it returns 'You don't have what you need
to participate at this time. Try again later).

A challenge room, is a mini-dungeon, three to eight rooms in size, that requires two specific items to complete. The initial check (before the rand) determines which challenge rooms may be used, by assembling a list of inventory, and comparing it to a pre-set list of requirements; re-Randing the value, until one is possible; unless none are possible.

Challenge rooms are about tactics, and are mental challenges. They may include puzzles, and enemies, but should 
not be enemy spams... The idea, is to make the player use two items to solve the challenge, even two different 
swords; as swords have unique properties in LoE.

Thus, each room shall either limit the player to specific items (reduced inventory) of which two items are 
mandatory to complete the challenge (the player will need to determine what they are, or the player may be 
given a description in the dialogue to accept the challenge); or just built around using two items (with a full 
inventory).

Tactics Challenge rooms should not limit HP, or MP, but if they do, it should be for a very good reason! They may
make use of skills (learned in game, via the skills system), but should not require them.

Each challenge room may only be used once, or possibly twice, and the types completed are stored in an array.

If the player is of a level =< Screen->D[2], then the prompt to accept a challenge (if given), states: 
'You need to gain more experience before you may try again.'

Blue Enemies: Temporal Challenges: The rules are the same as tactics challenges, however, instead of two items, 
the area has two(past/present, or present/future; low to mid CR); or three (past/present/future; mid to high CR) 
temporal states. The player will be given something in the area to shift temporal states, or may already have an
item to do this.

These are more puzzle-oriented, and involve thinking in a 4-D manner, to solve. Enemies should either be few, or
should change/vanish based on temporal state (think Lanayru mines).

Green Enemies: Mystic & Mental Challenges:

These have the same base rules, but are based on a combination of mystic prowess, and mental challenges. 
They may limit HP greatly, but should only minimally limit MP, if at all. These may require specific spells, 
magical items, or skills at a certain rank, for each area. Unlike other challenge areas, if the player is unable
to accept, because of the lack of one of these, then the game should report what the player is lacking, in all 
three instances.

If the player is missing an item, or spell, or skill (only one), the game will report:

'You do not have an item essential to this challenge.'
--or--
'You do not have a skill at a high enough rank to accept this challenge.'
--or--
'You do not know a spell essential to this challenge.'

If the player is missing two or more, the game will report both.

e.g.:
'You do not have an item essential to this challenge.'
--and--
'You do not know a spell essential to this challenge.'

The game will not, however, report exactly what is needed. Some mental/mystic challenges may never be possible, 
if the player does not assign skill points, etc.

This challenge category may have puzzles, and enemies, but the solutions should be based on magic. Attacking 
things with non-magical attacks should cause the player grief. (It is a great place for infinite split on hit 
enemies; that is, enemies that split into two or more of the same enemy when hit, but die instantly when hit 
with a specific magical attack.)

Skills (meaning, in-game skills used by the JRPG menus) should play heavily into this.

Red Enemies: Physical & Combat Challenges: Finally, red ffc enemies are physical (combat, arena) challenges. 
These are sort of glorified gauntlets, but should never be over-long. (They may limit both HP, and MP!) This is 
for players that want more combat, as the game focuses a great deal on mind-based puzzles, and story, so it can 
give them a break, with a non-essential reward.

Wandering NPCs can also offer these challenges though, by changing some game parameters. If the player isn’t 
knocked back by an NPC that doesn’t damage him, he can use the L and R buttons to communicate with it 
immediately.

Creatures that are treated as friendly, can offer dialogue, be it advice, or challenges. Enemies controlled by a
power with whom the player has formed a pact, or alliance, are to be stored in their own tables, and treated 
differently via global functions. Otherwise non-monster NPCs (e.g. humans) may be treated as non-hostiles, 
unless the player takes a truly evil path. 

This further permits stranger actions, like ‘Steal’, to try to take something from a wandering enemy when you 
touch them. A ‘Thief’ class, would benefit from this. 

Temporal Battles: (Type 1; Timeflow) Touching this FFC, that looks like a deep-blue (monochrome) enemy sends 
the player to a challenge room/arena, with more than one time-state (fast/normal/slow), and the player must 
switch between timeframes, to complete the challenge.  In this type, the area remains constant, but the enemies 
change/vanish/become invincible based n the speed of the flow of time. One of the gimmicks here is that from a 
normal time flow reference point, some enemies move at normal speed, some are slowed, and some are increased 
in speed. Enemies in a slower reference will be faster to the player, possibly invisible, or impossible to 
damage until the player moves into their reference. Enemies in a faster timeflow, will be slower to the player, 
and may not register damage, or be frozen from your perspective.

Remember, in a slower timeframe, from your perspective in normal time, events will occur to be happening very
faster, and conversely, in a faster timeflow, events from a normal perspective will seem to be very slow. 
(Relativity.)

Temporal battles (Type II, Time Depth) Touching this FFC, that looks like a Blue-Grey, or Blue/Violet 
(monochrome) enemy, sends the player to a challenge room/arena, that has more than one time state 
(past/present/future). In ths version, enemies change, but don;t become faster/invincible. Instead, the 
area changes (similar to Lanayru Mines in 'Skyward Sword'), and the player must move between past, present, 
future, to solve the challenge. The enemy types on0screen, change to reflect the time period, but the main
gimmick is changing terrain, puzzles, and objects.

Tempirally Disjointed Encounters:  Another type of temporal event, where timeflows are disjoined, and several 
different timeflows are happening on-screen at once. The player may only interact fully with one of these at a 
time, and must use spells, items, or triggers to shift between them. This is a general puzzle mechanic. 
In this scenario, the player can ‘see’ all the disjoined timestreams, but they aren’t past/present/future, they 
are all happening in ‘moments of now’, at different relative speeds. 


Words of Power

!Help: Initially, this does nothing... As the player meets, and befriends, or aids NPCs, or pacts with creatures, there
is a % chance that doingthis may summon one of them to aid you. The % chance increases by +1 per day of non-use.

!Eppy -> Unlock !Leap to get upgraded jump.

ROOMTEMP, : this damages the player by x, for each degree above 100 in any given room. Fire, or fire enemies heats rooms
	as does desert terrain. Spekks, items, and armour can protect against heat, by raising the 100 threshold while in use.
		Wen equippingL MAXTEMP += val. When expiring, MAXTEMP -= val.
	Make a flickering red/orange overlay. The hotter a room, the more opacity for te overlay.
	
	Troll enemies, regen hp. If killed without fire or light, split intp two trolls on death.
	Light as bright as daylight is instnt death for them.
		
	
Although I should write a spin attack trigger. That would be interesting.
[2:52:40 AM] Samer Charif: yes
[2:52:46 AM] Samer Charif: it'll cause th player to think
[2:52:48 AM] _|  ZoriaRPG |_: A spinning object, that you need to use a spin attack on, to rotate in the other direction.
[2:52:51 AM] _|  ZoriaRPG |_: I like this idea.