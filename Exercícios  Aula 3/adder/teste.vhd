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
		generic(
			tamanho : integer := 3
		);
END ENTITY teste;
------------------------------

ARCHITECTURE stimulus OF teste IS

	-- Decaclaração do componente
	component adder is
		generic(
			tamanho : integer 
		);
		port(dataa, datab : IN  std_logic_vector(tamanho downto 0);
		     sum          : OUT std_logic_vector(tamanho downto 0));
	end component adder;

	-- declaração de sinais
	signal dataa : std_logic_vector(tamanho downto 0);
	signal datab : std_logic_vector(tamanho downto 0);
	signal sum   : std_logic_vector(tamanho downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Instância de divisor_clock com nome dut, pode haver 
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
		dataa <=std_logic_vector(to_unsigned(1,tamanho+1));
		datab <=std_logic_vector(to_unsigned(1,tamanho+1));
		wait for 10 ns;
		dataa <=std_logic_vector(to_unsigned(2,tamanho+1));
		datab <=std_logic_vector(to_unsigned(1,tamanho+1));
		wait for 10 ns;
		dataa <=std_logic_vector(to_unsigned(3,tamanho+1));
		datab <=std_logic_vector(to_unsigned(1,tamanho+1));
		wait for 10 ns;
		dataa <=std_logic_vector(to_unsigned(4,tamanho+1));
		datab <=std_logic_vector(to_unsigned(1,tamanho+1));
		wait for 10 ns;
		dataa <=std_logic_vector(to_unsigned(5,tamanho+1));
		datab <=std_logic_vector(to_unsigned(1,tamanho+1));
		wait for 10 ns;
		dataa <=std_logic_vector(to_unsigned(1,tamanho+1));
		datab <=std_logic_vector(to_unsigned(1,tamanho+1));
		wait for 10 ns;
		dataa <=std_logic_vector(to_unsigned(1,tamanho+1));
		datab <=std_logic_vector(to_unsigned(1,tamanho+1));
		wait for 10 ns;
		dataa <=std_logic_vector(to_unsigned(1,tamanho+1));
		datab <=std_logic_vector(to_unsigned(1,tamanho+1));
	end process;

END ARCHITECTURE stimulus;
