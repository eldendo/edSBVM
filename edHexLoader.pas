program edHexLoader;

uses strutils;

var hex: string ='';

begin
    writeln('+-------------------------------------+');
    writeln('| Hexloader V0.0 DEV                  |');
    writeln('| (C)2017 by ir. Marc Dendooven       |');
    writeln('+-------------------------------------+');
    writeln;
    readln(hex);
    while hex<>'x' do 
    begin
	if odd(length(hex)) then writeln('odd digits. redo.') 
	else
		while hex<>'' do
		begin
		    writeln(Hex2Dec(leftStr(hex,2)));
		    hex := copy(hex,3,length(hex))
		end;
	readln(hex)
    end;
    
end.
