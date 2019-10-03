-------------------------------------------------------------------
-- Name        : testbench.vhd
-- Author      : Renan Augusto Starke
-- Version     : 0.1
-- Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Exemplo de estimulus para testbenchs
-------------------------------------------------------------------

-- Bibliotecas e clásulas
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
-------------------------------------
ENTITY teste IS
END ENTITY teste;
------------------------------

ARCHITECTURE stimulus OF teste IS

	-- Decaclaração do componente
	component segmentos
		port(bin : IN  std_logic_vector(3 downto 0);
		     seg : OUT std_logic_vector(6 downto 0));
	end component segmentos;

	-- declaração de sinais
	signal bin : std_logic_vector(3 downto 0);
	signal seg : std_logic_vector(6 downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Instância de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : segmentos
		port map(
			bin => bin,
			seg => seg
		);

	-- gera um clok
	process
	begin
		bin<="0000";

		wait for 10 ns;
		bin<="0001";

		wait for 10 ns;
		bin<="1111";

		wait for 10 ns;
		bin<="1000";

		wait for 10 ns;
		bin<="1001";

		wait for 10 ns;
		bin<="0111";

		wait for 10 ns;

	end process;

END ARCHITECTURE stimulus;
