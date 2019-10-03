-------------------------------------------------------------------
-- Name        : testbench.vhd
-- Author      : Renan Augusto Starke
-- Version     : 0.1
-- Copyright   : Renan, Departamento de Eletr�nica, Florian�polis, IFSC
-- Description : Exemplo de estimulus para testbenchs
-------------------------------------------------------------------

-- Bibliotecas e cl�sulas
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
-------------------------------------
ENTITY teste IS
END ENTITY teste;
------------------------------

ARCHITECTURE stimulus OF teste IS

	-- Decaclara��o do componente
	component paridade
		port(dataa : IN  std_logic_vector(7 downto 0);
		     sel   : IN  std_logic;
		     x     : OUT std_logic
		    );
	end component paridade;

	-- declara��o de sinais
	signal dataa : std_logic_vector(7 downto 0);
	signal sel   : std_logic;
	signal x     : std_logic;

BEGIN                                   -- inicio do corpo da arquitetura

	-- Inst�ncia de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : paridade
		port map(
			dataa => dataa,
			sel => sel,
			x   => x
		);

	-- gera um clok
	process
	begin
		sel <= '1';
		dataa<="00000000";
		wait for 10 ns;
		dataa<="10000000";
		sel <= '1';
		wait for 10 ns;
		dataa<="11010001";
		sel <= '1';
		wait for 10 ns;
		dataa<="01010001";
		sel <= '1';
		wait for 10 ns;
	end process;

END ARCHITECTURE stimulus;
