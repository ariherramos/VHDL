library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arquivo_out is

end entity arquivo_out;

architecture RTL of arquivo_out is
	
begin
	escreve: process
	
	type arqv_int is file of integer;
	file arquivo_wr : arqv_int open WRITE_MODE is "dado_b.dat";

	begin
		for dado in 48 to 57 loop 
			write (arquivo_wr, dado);
		end loop;
		wait;

	end process escreve;
end architecture RTL;
