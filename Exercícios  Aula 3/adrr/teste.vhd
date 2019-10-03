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
USE IEEE.std_logic_unsigned. all;
-------------------------------------
ENTITY teste IS
		generic(
			tamanho : integer := 3
		);
END ENTITY teste;
------------------------------

ARCHITECTURE stimulus OF teste IS

	-- Decaclara��o do componente
	component adder is
		generic(
			tamanho : integer 
		);
		port(dataa, datab : IN  std_logic_vector(tamanho downto 0);
		     sum          : OUT std_logic_vector(tamanho downto 0));
	end component adder;

	-- declara��o de sinais
	signal dataa : std_logic_vector(tamanho downto 0);
	signal datab : std_logic_vector(tamanho downto 0);
	signal sum   : std_logic_vector(tamanho downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Inst�ncia de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : adder
		generic map(
			tamanho => tamanho
		)
		port map(
			dataa => dataa,
			datab => datab,
			sum   => sum
		);

	-- gera um clok
	process
	begin
		dataa <="0000";
		datab <="0001";
		wait for 10 ns;
		dataa <="0001";
		datab <="0001";
		wait for 10 ns;
		dataa <="0010";
		datab <="0001";
		wait for 10 ns;
		dataa <="0100";
		datab <="0001";
		wait for 10 ns;
		dataa <="0000";
		datab <="0001";
		wait for 10 ns;
		dataa <="0000";
		datab <="0001";
		wait for 10 ns;
		dataa <="0000";
		datab <="0001";
		wait for 10 ns;
		dataa <="0000";
		datab <="0001";
	end process;

END ARCHITECTURE stimulus;
