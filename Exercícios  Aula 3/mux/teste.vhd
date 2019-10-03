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
		tamanho : integer := 1
	);
END ENTITY teste;
------------------------------

ARCHITECTURE stimulus OF teste IS

	-- Decaclaração do componente
	component mux
		generic(tamanho : integer);
		port(ina, inb, inc, ind, sel : IN  std_logic_vector(tamanho downto 0);
		     x                       : OUT std_logic_vector(tamanho downto 0));
	end component mux;

	-- declaração de sinais
	signal ina : std_logic_vector(tamanho downto 0) := "00";
	signal inb : std_logic_vector(tamanho downto 0) := "01";
	signal inc : std_logic_vector(tamanho downto 0) := "10";
	signal ind : std_logic_vector(tamanho downto 0) := "11";
	signal sel : std_logic_vector(tamanho downto 0);
	signal x   : std_logic_vector(tamanho downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Instância de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : mux
		generic map(
			tamanho => tamanho
		)
		port map(
			ina => ina,
			inb => inb,
			inc => inc,
			ind => ind,
			sel => sel,
			x   => x
		);

	-- gera um clok
	process
	begin
		sel <= std_logic_vector(to_unsigned(0, tamanho + 1));
		wait for 10 ns;
		sel <= std_logic_vector(to_unsigned(1, tamanho + 1));
		wait for 10 ns;
		sel <= std_logic_vector(to_unsigned(2, tamanho + 1));
		wait for 10 ns;
		sel <= std_logic_vector(to_unsigned(3, tamanho + 1));
		wait for 10 ns;
		sel <= std_logic_vector(to_unsigned(1, tamanho + 1));
		wait for 10 ns;
		sel <= std_logic_vector(to_unsigned(1, tamanho + 1));
		wait for 10 ns;
		sel <= std_logic_vector(to_unsigned(1, tamanho + 1));
		wait for 10 ns;
		sel <= std_logic_vector(to_unsigned(1, tamanho + 1));
	end process;

END ARCHITECTURE stimulus;
