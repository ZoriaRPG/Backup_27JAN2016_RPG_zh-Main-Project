import "std.zh"

const int SPINNER_START = 541;
const int SFX_SPINNER = 61;

ffc script Spinner
{
	void run()
	{
		int timerHoldDirection = 0;
		int timerBeginSpin = 0;
		int timerCooldown = 0;
		bool spinning = false;
		
		for (int i = 0; true; i = (i + 1) % 60)
		{
			if (Screen->ComboD[ComboAt(Link->X + 8, Link->Y + 8)] == SPINNER_START && !spinning && timerHoldDirection >= 10 && timerCooldown <= 0)
			{
				timerHoldDirection = 0;
				timerBeginSpin = 60;
				spinning = true;
				Link->X = GridX(Link->X);
				Link->Y = GridY(Link->Y);
				this->X = Link->X;
				this->Y = Link->Y;
				this->Vy = -3;
			}
			if (spinning)
			{
				if (this->Vy < 0 && this->Vx == 0 && !ComboFI(this->X + 8, this->Y - 1, CF_SCRIPT1))
				{
					this->X = GridX(this->X + 8);
					this->Y = GridY(this->Y + 8);
					if (ComboFI(this->X + 17, this->Y + 8, CF_SCRIPT1))
					{
						this->Vx = 3;
						this->Vy = 0;
					}
					else if (ComboFI(this->X - 1, this->Y + 8, CF_SCRIPT1))
					{
						this->Vx = -3;
						this->Vy = 0;
					}
				}
				if (this->Vy > 0 && this->Vx == 0 && !ComboFI(this->X + 8, this->Y + 17, CF_SCRIPT1))
				{
					this->X = GridX(this->X + 8);
					this->Y = GridY(this->Y + 8);
					if (ComboFI(this->X + 18, this->Y + 8, CF_SCRIPT1))
					{
						this->Vx = 3;
						this->Vy = 0;
					}
					else if (ComboFI(this->X - 1, this->Y + 8, CF_SCRIPT1))
					{
						this->Vx = -3;
						this->Vy = 0;
					}
				}
				if (this->Vy == 0 && this->Vx < 0 && !ComboFI(this->X - 1, this->Y + 8, CF_SCRIPT1))
				{
					this->X = GridX(this->X + 8);
					this->Y = GridY(this->Y + 8);
					if (ComboFI(this->X + 8, this->Y - 1, CF_SCRIPT1))
					{
						this->Vx = 0;
						this->Vy = -3;
					}
					else if (ComboFI(this->X + 8, this->Y + 17, CF_SCRIPT1))
					{
						this->Vx = 0;
						this->Vy = 3;
					}
				}
				if (this->Vy == 0 && this->Vx > 0 && !ComboFI(this->X + 17, this->Y + 8, CF_SCRIPT1))
				{
					this->X = GridX(this->X + 8);
					this->Y = GridY(this->Y + 8);
					if (ComboFI(this->X + 8, this->Y - 1, CF_SCRIPT1))
					{
						this->Vx = 0;
						this->Vy = -3;
					}
					else if (ComboFI(this->X + 8, this->Y + 17, CF_SCRIPT1))
					{
						this->Vx = 0;
						this->Vy = 3;
					}
				}
				timerHoldDirection = 0;
				timerBeginSpin--;
				
				Link->X = this->X;
				Link->Y = this->Y;
				
				Link->InputUp = false;
				Link->InputDown = false;
				Link->InputLeft = false;
				Link->InputRight = false;
				Trace(this->Vy);
			}
			
			if (Screen->ComboD[ComboAt(Link->X + 8, Link->Y + 8)] == SPINNER_START && spinning && timerBeginSpin <= 0)
			{
				spinning = false;
				this->Vx = 0;
				this->Vy = 0;
				timerCooldown = 60;
			}
			
			if (Screen->ComboD[ComboAt(Link->X + 8, Link->Y + 8)] == SPINNER_START)
			{
				if (Link->InputUp || Link->InputDown || Link->InputLeft || Link->InputDown)
				{
					timerHoldDirection++;
				}
				else
				{
					timerHoldDirection = 0;
				}
			}
			else
			{
				timerHoldDirection = 0;
			}
			
			if (i % 15 == 0 && spinning)
			{
				Game->PlaySound(SFX_SPINNER);
			}
			
			if (timerCooldown >= 0)
			{
				timerCooldown--;
			}
			
			Waitframe();
		}
	}
}