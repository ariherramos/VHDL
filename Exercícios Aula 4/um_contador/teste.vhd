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
	component counter is
		port(dataa : IN  std_logic_vector(3 downto 0);
		     sum   : OUT std_logic_vector(3 downto 0));
	end component counter;

	-- declara��o de sinais
	signal dataa : std_logic_vector(3 downto 0);
	signal sum   : std_logic_vector(3 downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Inst�ncia de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : counter
		port map(
			dataa => dataa,
			sum   => sum
		);

	-- gera um clok
	process
	begin
		dataa <= std_logic_vector(to_unsigned(1, 4));
		wait for 10 ns;
		dataa <= std_logic_vector(to_unsigned(2, 4));
		wait for 10 ns;
		dataa <= std_logic_vector(to_unsigned(3, 4));
		wait for 10 ns;
		dataa <= std_logic_vector(to_unsigned(4, 4));
		wait for 10 ns;
		dataa <= std_logic_vector(to_unsigned(5, 4));
		wait for 10 ns;
		dataa <= std_logic_vector(to_unsigned(6, 4));
		wait for 10 ns;
		dataa <= std_logic_vector(to_unsigned(7, 4));
		wait for 10 ns;

	end process;

END ARCHITECTURE stimulus;
