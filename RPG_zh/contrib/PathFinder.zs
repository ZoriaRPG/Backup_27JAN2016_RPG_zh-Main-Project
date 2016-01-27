// Credits to Lejes for making the A* algorithm actually work in ZC! I probably wouldn't have ended up making my version (which is older than this) work without the assistance!

ffc script Astar5FFC
{
	void run()
	{
		while (true)
		{
			if (Link->PressEx1)
			{
				Astar5(this, ComboAt(Link->X + 8, Link->Y + 8));
			}
			
			Waitframe();
		}
	}
}

void Astar5(ffc Pathfinder, int Dest)
{
	int PathfinderLoc = ComboAt(CenterX(Pathfinder), CenterY(Pathfinder));
	int current = PathfinderLoc;
   
	int ClosedSet[176]; // The set of nodes already evaluated.
	int OpenSet[176]; // The set of tentative nodes to be evaluated, initially containing the start node
	int Came_From[176]; // The map of navigated nodes.
	int total_path[176];

	int g_score[176]; // Cost from start along best known path.

	// Estimated total cost from start to goal through y.
	int f_score[176];
	
	//Astar5ArrayInit(OpenSet, ClosedSet, Came_From, g_score, f_score);
	for (int i = 0; i < 176; i++)
	{
		OpenSet[i] = -1;
	}
	for (int i = 0; i < 176; i++)
	{
		ClosedSet[i] = -1;
	}
	for (int i = 0; i < 176; i++)
	{
		Came_From[i] = -1;
	}
	for (int i = 0; i < 176; i++)
	{
		total_path[i] = -1;
	}
	for (int i = 0; i < 176; i++)
	{
		g_score[i] = 9999;
	}
	for (int i = 0; i < 176; i++)
	{
		f_score[i] = 9999;
	}
	
	OpenSet[0] = PathfinderLoc;
	g_score[current] = 0;
	f_score[current] = ManhattanDist(PathfinderLoc, Dest);
   
	while(!ListIsEmpty(OpenSet))//while OpenSet is not empty
	{
		current = FindNode(OpenSet);
		for (int i = 0; i < SizeOfArray(OpenSet); i++)
		{
			if (OpenSet[i] > -1 && current > -1)
			{
				if (f_score[OpenSet[i]] < f_score[current] || (f_score[OpenSet[i]] == f_score[current] && ManhattanDist(OpenSet[i], Dest) < ManhattanDist(current, Dest)))
				{
					current = OpenSet[i];
				}
			}
		}

		if(current == Dest)
		{
			reconstruct_path(total_path, Came_From, current, PathfinderLoc);
			for (int i = 175; i >= 0; i--)
			{
				Trace(total_path[i]);
				if (total_path[i] > -1)
				{
					//Pathfinder->X = ComboX(total_path[i]);
					//Pathfinder->Y = ComboY(total_path[i]);
					
					// Correct vvv
					Screen->ComboD[total_path[i]] = 897;
					Screen->ComboC[total_path[i]] = 7;
					Waitframes(15);
					
					// int walkVar = i + 1;
					// while(walkVar <= -1)
					// {
						// walkVar += 1;
					// }
					
					// if(total_path[walkVar] == PathfinderLoc - 16)
					// {
						// for(int i2 = 0; i2 < 16; i2 += 1)
						// {
							// Pathfinder->Y -= 1;
							
							// Waitframe();
						// }
					// }
					// else if(total_path[walkVar] == PathfinderLoc + 16)
					// {
						// for(int i2 = 0; i2 < 16; i2 += 1)
						// {
							// Pathfinder->Y += 1;
							
							// Waitframe();
						// }
					// }
					// else if(total_path[walkVar] == PathfinderLoc - 1)
					// {
						// for(int i2 = 0; i2 < 16; i2 += 1)
						// {
							// Pathfinder->X -= 1;
							
							// Waitframe();
						// }
					// }
					// else if(total_path[walkVar] == PathfinderLoc + 1)
					// {
						// for(int i2 = 0; i2 < 16; i2 += 1)
						// {
							// Pathfinder->X += 1;
							
							// Waitframe();
						// }
					// }
					
					// break;
				}
			}
		   
			break;
		}

		RemoveNode(OpenSet, current);//OpenSet.Remove(current)
		AddNode(ClosedSet, current);//ClosedSet.Add(current)
	   
		for(int i = 1; i <= 4; i += 1)
		{
			int neighbor;// = current + i;
			if(i == 1)              {neighbor = current - 16;}
			else if(i == 2) {neighbor = current + 16;}
			else if(i == 3) {neighbor = current - 1;}
			else if(i == 4) {neighbor = current + 1;}
			
			if (!ValInRange(0, 175, neighbor))
			{
				continue;
			}
			if(NumInArray(ClosedSet, neighbor) || Screen->ComboS[neighbor] != 0) // neighbor in ClosedSet
			{
					continue; // Ignore the neighbor which is already evaluated.
			}

			int tentative_g_score = g_score[current] + ManhattanDist(current, neighbor);
			if (tentative_g_score < g_score[neighbor] || !NumInArray(OpenSet, neighbor))      // Discover a new node
			{
				Came_From[neighbor] = current;
				g_score[neighbor] = tentative_g_score;
				f_score[neighbor] = g_score[neighbor] + ManhattanDist(neighbor, Dest);
				if (!NumInArray(OpenSet, neighbor))
				{
					AddNode(OpenSet, neighbor);
				}
			}
		   
			// Game->PlaySound(2);
		}
	   
		for(int i = 0; i < 176; i += 1)
		{
			if(OpenSet[i] > -1)
			{
				Screen->ComboD[OpenSet[i]] = 896;
				Screen->ComboC[OpenSet[i]] = 5;
			}
		   
			if(ClosedSet[i] > -1)
			{
				Screen->ComboD[ClosedSet[i]] = 898;
				Screen->ComboC[ClosedSet[i]] = 8;
			}
			
			if (g_score[i] < 9999)
			{
				Screen->DrawInteger(6, ComboX(i), ComboY(i) + 10, FONT_SP, 0x06, 0x07, 0, 0, g_score[i], 0, OP_OPAQUE);
			}
			if (f_score[i] < 9999)
			{
				Screen->DrawInteger(6, ComboX(i), ComboY(i), FONT_SP, 0x01, 0x07, 0, 0, f_score[i], 0, OP_OPAQUE);
			}
			Screen->DrawInteger(6, 0, 0, FONT_Z1, 0x01, 0x07, 0, 0, current, 0, OP_OPAQUE);
			Screen->DrawInteger(6, 0, 16, FONT_Z1, 0x01, 0x07, 0, 0, OpenSet[0], 0, OP_OPAQUE);
		}
	   
		Waitframe();
	}

	//return failure
}

void reconstruct_path(int total_path, int Came_From, int current, int PathfinderLoc)
{
	total_path[0] = current;
	
    for (int i = 1; i < 176; i++)
	{
		total_path[i] = Came_From[current];
		current = Came_From[current];
		if (current == PathfinderLoc)
		{
			break;
		}
	}
}
 
int ManhattanDist(int loc1, int loc2)
{
        return (Abs(ComboX(loc2) - ComboX(loc1)) + Abs(ComboY(loc2) - ComboY(loc1)));
}
 
// Returns if an array is "empty". Returns true if all elements of an array equal -1. Overloaded to check a specific indice.
bool ListIsEmpty(float list_arr)
{
        for(int i = 0; i < SizeOfArray(list_arr); i += 1)
        {
                if(list_arr[i] > -1)
                {
                        return false;
                }
        }
       
        return true;
}
 
// Returns if an indice on a list array is "empty".
bool ListIsEmpty(float list_arr, int indice)
{
        if(list_arr[indice] <= -1)
        {
                return true;
        }
        else
        {
                return false;
        }
}
 
// returns the size of an array "list"
int ListSize(float list_arr)
{
        int size = 0;
       
        for(int i = 0; i < SizeOfArray(list_arr); i += 1)
        {
                if(!ListIsEmpty(list_arr, i))
                {
                        size += 1;
                }
        }
       
        return size;
}
 
// Adds a 'node' to an array 'list'
int AddNode(int list_arr, int locToAdd)
{
        for(int i = 0; i < SizeOfArray(list_arr); i += 1)
        {
                // if(ListIsEmpty(list_arr, i))
                if(list_arr[i] <= -1)
                {
                        list_arr[i] = locToAdd;
                        return i;
                        break;
                }
        }
}
 
// Adds a 'node' to an array 'list'
int AddNode(int locToAdd, int val_gCost, int val_hCost, int val_Parent, int list_arr, int list_gCost, int list_hCost, int list_Parent)
{
        for(int i = 0; i < SizeOfArray(list_arr); i += 1)
        {
                if(list_arr[i] <= -1)
                {
                        list_arr[i] = locToAdd;
                        list_gCost[i] = val_gCost;
                        list_hCost[i] = val_hCost;
                        list_Parent[i] = val_Parent;
                       
                        return i;
                       
                        break;
                }
        }
}
 
// Removes a 'node' from an array 'list'
void RemoveNode(int list_arr, int node)
{
	// if(!ListIsEmpty(list_arr, indice))
	for (int i = 0; i < SizeOfArray(list_arr); i++)
	{
		if (list_arr[i] == node)
		{
			list_arr[i] = -1;
		}
	}
}
 
// Returns if a variable is in an array.
bool NumInArray(float arr, float num)
{
        for(int i = 0; i < SizeOfArray(arr); i += 1)
        {
                if(arr[i] == num)
                {
                        return true;
                }
        }
       
        return false;
}
 
// Returns the lowest number in array 'arr'.
// Set checkForValid to true if you want to make sure the returned value is "valid" (ie. above -1).
float LowestVal(float arr, bool checkForValid)
{
        float smallest = arr[0] ;
        for(int i = 1; i < SizeOfArray(arr); i += 1)
        {
                if(checkForValid)
                {
                        if(arr[i] > -1 && arr[i] < smallest)
                        {
                                smallest = arr[i];
                        }
                }
                else if(arr[i] < smallest)
                {
                        smallest = arr[i];
                }
        }
        return smallest;
}
 
float LowestIndice(float arr, bool checkForValid)
{
        int smallestVal = arr[0];
        int smallestIndice = 0;
        for(int i = 1; i < SizeOfArray(arr); i += 1)
        {
                if(checkForValid)
                {
                        if(arr[i] < smallestVal && arr[i] > -1)
                        {
                                smallestVal = arr[i];
                                smallestIndice = i;
                        }
                }
                else if(arr[i] < smallestVal)
                {
                        smallestVal = arr[i];
                        smallestIndice = i;
                }
        }
        return smallestIndice;
}
 
// Returns if a number is in range of range_min (inclusive) and range_max (inclusive).
bool ValInRange(float min, float max, float num)
{
        if(min <= max)
        {
                if(num >= min && num <= max)
                {
                        return true;
                }
        }
        else
        {
                if(num >= max && num <= min)
                {
                        return true;
                }
        }
       
}

void Astar5ArrayInit(int OpenSet, int ClosedSet, int Came_From, int g_score, int f_score)
{
	for (int i = 0; i < 176; i++)
	{
		OpenSet[i] = -1;
	}
	for (int i = 0; i < 176; i++)
	{
		ClosedSet[i] = -1;
	}
	for (int i = 0; i < 176; i++)
	{
		Came_From[i] = -1;
	}
	for (int i = 0; i < 176; i++)
	{
		g_score[i] = 9999;
	}
	for (int i = 0; i < 176; i++)
	{
		f_score[i] = 9999;
	}
}

int FindNode(int list_arr)
{
	for (int i = 0; i < SizeOfArray(list_arr); i++)
	{
		if (list_arr[i] > 0)
		{
			return list_arr[i];
		}
	}
	return -1;
}