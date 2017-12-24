program edHexLoader;

uses strutils;

var hex: string ='';
    f: file of byte;

begin
    writeln('+-------------------------------------+');
    writeln('| Hexloader V0.0 DEV                  |');
    writeln('| (C)2017 by ir. Marc Dendooven       |');
    writeln('+-------------------------------------+');
    writeln;
    assign(f,'a.out');
    rewrite(f);
    readln(hex);
    while hex<>'x' do 
    begin
	if odd(length(hex)) then writeln('odd digits. redo.') 
	else
		while hex<>'' do
		begin
		    write(f,Hex2Dec(leftStr(hex,2)));
		    hex := copy(hex,3,length(hex))
		end;
	readln(hex)
    end;
    close(f)
end.
