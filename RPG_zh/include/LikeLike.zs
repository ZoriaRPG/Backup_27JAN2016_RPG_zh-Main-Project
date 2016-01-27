ffc script LikeLike{
void run(int enemyID, int wait){
while(Screen->NumNPCs() == 0) Waitframe();
while(true){
npc n = CreateNPCAt(enemyID, this->X, this->Y);
int normal = n->OriginalTile;
int eat = n->OriginalTile + 1;
int initx = n->X;
int inity = n->Y;
while(n->isValid()){
int oldwidth = Link->HitWidth;
int oldheight = Link->HitHeight;
Link->HitWidth = 15;
Link->HitHeight = 15;
n->HitWidth = 15;
n->HitHeight = 15;
if(LinkCollision(n)) n->OriginalTile = eat;
else n->OriginalTile = normal;
Link->HitWidth = oldwidth;
Link->HitHeight = oldheight;
n->HitWidth = 16;
n->HitHeight = 16;
n->X = initx;
n->Y = inity;
Waitframe();
}
Waitframes(wait);
}
}}



ffc script LikeLike2{
void run(int enemyID, int wait){
while(Screen->NumNPCs() == 0) Waitframe();
while(true){
npc n = CreateNPCAt(enemyID, this->X, this->Y);
int normal = n->OriginalTile;
int eat = n->OriginalTile + 1;
int initx = n->X;
int inity = n->Y;
while(n->isValid()){
int oldwidth = Link->HitWidth;
int oldheight = Link->HitHeight;
Link->HitWidth = 15;
Link->HitHeight = 15;
n->HitWidth = 15;
n->HitHeight = 15;
if(LinkCollision(n)) n->OriginalTile = eat;
else n->OriginalTile = normal;
Link->HitWidth = oldwidth;
Link->HitHeight = oldheight;
n->HitWidth = 16;
n->HitHeight = 16;
n->X = initx;
n->Y = inity;
Waitframe();
}
Screen->TriggerSecrets();
Waitframes(wait);
}
}}
 