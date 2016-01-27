//Accepts args for validation DMap; then source screen, map, and layer.

void MovingBackground(int dmap, int layer, int src_map, int src_screen, int src_layer){
    int xspeed = 1;
    int yspeed = 1;
    int s_running[]="BG *if* block is running.";
    
 
    if (Game->GetCurDMap() == dmap){
        TraceNL(); TraceS(s_running); TraceNL(); //Will print: 'BG *if* block is running.' to allegro.log if it runs.
        x_position = (x_position + xspeed) % 255;
        y_position = (y_position + yspeed) % 175;
 
        Screen->DrawLayer(layer, src_dmap, src_screen, src_layer, Floor(x_position), Floor(y_position), 0, OP_OPAQUE);
        Screen->DrawLayer(layer, src_dmap, src_screen, src_layer, Floor(x_position), Floor(y_position) - 128, 0, OP_OPAQUE);
        Screen->DrawLayer(layer, src_dmap, src_screen, src_layer, Floor(x_position) - 176, Floor(y_position), 0, OP_OPAQUE);
        Screen->DrawLayer(layer, src_dmap, src_screen, src_layer, Floor(x_position) - 176, Floor(y_position) - 128, 0, OP_OPAQUE);
    }
}