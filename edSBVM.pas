(*****************************************
*            edSBVM V0.0 DEV             *
* El Dendo's Stack Based Virtual Machine *
* (C)2017 by ir. Marc Dendooven          *
* This program is stil under development *
* Everything can be changed              *
*****************************************)
program edSBVM;

const 	maxStack = 1023;
	maxProg = 1023;

var s: array [0..maxStack] of integer;  //Stack
    p: array [0..maxProg] of byte;	//Program Memory
    PC: 0..maxProg; // Program Counter
    SP,LV: 0..maxStack; // Stack pointer, Local Variable frame pointer
    IR: byte; //Instruction Register
    running: boolean = true;
    f: file of byte;
//    i: integer;
begin
    writeln('+----------------------------------------+');
    writeln('|           edSBVM V0.0 DEV              |');
    writeln('| El Dendo''s Stack Based Virtual Machine |');
    writeln('| (C)2017 by ir. Marc Dendooven          |');
    writeln('| This program is stil under development |');
    writeln('| Everything can be changed              |'); 
    writeln('+----------------------------------------+'); 

    assign(f,'a.out');
    reset(f);
    PC := 0;
    while not eof(f) do 
    begin
	read(f,p[PC]);
	inc(PC)
    end;
    close(f);
        
    PC := 0; SP := 0; LV := 0; 
    
    while running do
    begin
	IR := p[PC]; inc(PC);
//	writeln(' ',IR,' ',PC,' ',SP);
//	for i := 0 to SP-1 do write(s[i],' ');
//	readln;
	case IR of
{NOP}	    0: ; 
{HALT}	    1: running := false; 
{LIT}	    2: begin s[SP] := p[PC]*256+p[PC+1]; inc(PC,2); inc(SP) end;
{ADD}	    3: begin dec(SP); s[SP-1] := s[SP-1] + s[SP] end;
{SUB}       4: begin dec(SP); s[SP-1] := s[SP-1] - s[SP] end;
{MUL}	    5: begin dec(SP); s[SP-1] := s[SP-1] * s[SP] end;
{DIV}       6: begin dec(SP); s[SP-1] := s[SP-1] div s[SP] end;
{JMP}       7: PC := p[PC]*256+p[PC+1];
{JPZ}       8: begin dec(SP); if s[SP]=0 then PC := p[PC]*256+p[PC+1] else inc(PC,2) end;
{JPL}	    9: begin dec(SP); if s[SP]<0 then PC := p[PC]*256+p[PC+1] else inc(PC,2) end;
{DUP}	    10: begin s[SP] := s[SP-1]; inc(SP) end;
{WRITE}     20: begin dec(SP); writeln(s[SP]) end;
	else
	    writeln('unknown instruction ', hexStr(IR,2),' on address ',hexStr(PC-1,4));halt
	end
    end;
    writeln;
    writeln('program has been terminated by the HALT instruction');
    writeln('bye')
end.
