const int TILE_INVIS = 0;

void InvertedCircle(int bitmapID, int layer, int x, int y, int radius, int scale, int fillcolor){
        Screen->PutPixel(layer, 0, 0, 0, 0, 0, 0, OP_OPAQUE);
	Screen->DrawTile(layer, 0, 0, TILE_INVIS, 1, 1, 0, -1, -1, 0, 0, 0, 0, true, 128);
	Screen->SetRenderTarget(bitmapID);     //Set the render target to the bitmap.
	Screen->Rectangle(layer, 0, 0, 256, 176, fillcolor, 1, 0, 0, 0, true, 128); //Cover the screen
	Screen->Circle(layer, x, y, radius, 0, scale, 0, 0, 0, true, 128); //Draw a transparent circle.
	Screen->SetRenderTarget(RT_SCREEN); //Set the render target back to the screen.
	Screen->DrawBitmap(layer, bitmapID, 0, 0, 256, 176, 0, 0, 256, 176, 0, true); //Draw the bitmap
}