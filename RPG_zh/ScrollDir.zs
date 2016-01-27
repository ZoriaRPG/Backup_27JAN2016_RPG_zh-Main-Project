int ScrolledDir()
{
        if(Link->Action == LA_SCROLLING && !JustScrolled) {
                JustScrolled = true;
		return Link->Dir + 1;
        }
        else if(Link->Action != LA_SCROLLING && JustScrolled ) {
		JustScrolled = false;
		return 0;
	}
}