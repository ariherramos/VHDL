-- Bibliotecas e clásulas
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;		
-------------------------------------
ENTITY testbench_arquivo IS
END ENTITY testbench_arquivo;
------------------------------
ARCHITECTURE stimulus OF testbench_arquivo IS

-- Decaclaração do componente
	component arquivo_out
	
	end component arquivo_out;
	
	component arquivo_in
		port(dado : out integer range 0 to 100);
	end component arquivo_in;
	
	signal clk : std_logic;
	signal dado : integer range 0 to 100;
	
BEGIN -- início do corpo da arquitetura

	dut: arquivo_in
	port map(
		dado => dado
	);

	-- gera um clock
	process
		begin
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
	end process;
			
END ARCHITECTURE stimulus;