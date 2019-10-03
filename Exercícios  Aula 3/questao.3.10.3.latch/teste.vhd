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
	generic(
		tamanho : integer := 3
	);
END ENTITY teste;
------------------------------

ARCHITECTURE stimulus OF teste IS

	-- Decaclara��o do componente
	component latch
		generic(tamanho : integer);
		port(ina : IN  std_logic_vector(tamanho downto 0);
		     sel : IN  std_logic;
		     x   : OUT std_logic_vector(tamanho downto 0));
	end component latch;

	-- declara��o de sinais
	signal ina : std_logic_vector(tamanho downto 0) := "0000";
	signal sel : std_logic;
	signal x   : std_logic_vector(tamanho downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Inst�ncia de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : latch
		generic map(
			tamanho => tamanho
		)
		port map(
			ina => ina,
			sel => sel,
			x   => x
		);

	-- gera um clok
	process
	begin
		
		ina <= std_logic_vector(to_unsigned(1, tamanho + 1));
		sel <= '0';

		wait for 10 ns;
		ina <= std_logic_vector(to_unsigned(1, tamanho + 1));
		sel <= '1';

		wait for 10 ns;
		ina <= std_logic_vector(to_unsigned(3, tamanho + 1));
		sel <= '0';

		wait for 10 ns;
		ina <= std_logic_vector(to_unsigned(5, tamanho + 1));
		sel <= '1';

		wait for 10 ns;
		ina <= std_logic_vector(to_unsigned(7, tamanho + 1));
		sel <= '0';

		wait for 10 ns;
		ina <= std_logic_vector(to_unsigned(1, tamanho + 1));
		sel <= '1';

		wait for 10 ns;

	end process;

END ARCHITECTURE stimulus;
