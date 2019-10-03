library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arquivo_in is
	port(
		dado : out integer range 0 to 100
	);
end entity arquivo_in;

architecture RTL of arquivo_in is
begin
	le: process
		
	type arqv_int is file of integer;
	file arquivo_rd: arqv_int open READ_MODE is "dado_a.dat";
	variable dado_v: integer;

	begin
		while not ENDFILE(arquivo_rd) loop
			read(arquivo_rd, dado_v);
			dado <= dado_v;
			wait for 10 ns;
		end loop;
		wait;
	end process le;
end architecture RTL;
