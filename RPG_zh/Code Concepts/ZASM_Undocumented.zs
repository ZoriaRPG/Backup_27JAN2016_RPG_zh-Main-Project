Opcode parameters defined in bytecode.h
Labels in ffscript.cpp ->Global gd regs line 515
defs in ffscrfipt.h

All in-game limits defined in zdefs.h
as are game constants, such as MAGICPERBLOCK

SCRIPT FLAGS
TRUEFLAG
MOREFLAG

SETTRUE
SETFALSE
SETMORE
SETLESS

GOTOTRUE Goes to a line if a true condition is set. This is used to interrupt instruction blocks
	and bypass other GOTO instructions. Used to set a value if a condition evaluates.
		
	case GOTOTRUE:
            if(ri->scriptflag & TRUEFLAG)
            {
                pc = sarg1;
                increment = false;
            }
            
            break;
	    
SETTRUE Sets a true condition for the Assembler, if a COMPARERV and COMPARER validate.
	SETMORE ? 

SETFALSE ?

GOTOFALSE: In theory, this would be the opposite of GOTOTRUE, and should GOTO an instruction if a condition
	does not validate.
Defined in ffscript.cpp

case GOTOFALSE:
            if(!(ri->scriptflag & TRUEFLAG))
            {
                pc = sarg1;
                increment = false;
            }
            
            break;

LOADI Loads an integer from a register, from another register (or address?).
STOREI Stores an integer in a register, from another register (or address?).

GOTOTRUE = while true loop / infinite loop
Negative. Seems to perform a special goto, only if an internal Assembler value is true. 
Works on a per-instruction-block basis.

GOTO
//pop the stack frame pointer

GOTOIMMEDIATE
//pop the stack frame
 //nop to end while

OGotoTrueImmediate(
//run the loop body

OSetFalse

OGotoFalseImmediate
bytecode.h line 744



OTraceRegister