

void SlowWalk(){
        if ( IronBoots() ) {
                IronBoots[POWER_WALK_TIMER]++;
                if ( IronBoots[POWER_WALK_TIMER] && `IronBoots[POWER_WALK_TIMER] % WALK_SPEED_POWERUP == 0 ){
                        Link->InputRight = false;
                        Link->InputLeft = false;
                        Link->InputUp = false;
                        Link->InputDown = false;
                        IronBoots[POWER_WALK_TIMER] = 0;
                }
        }
}