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
	component mux
		generic(tamanho : integer);
		port(mux_in_a, mux_in_b : IN  std_logic_vector(tamanho downto 0);
		     mux_sel            : in  std_logic;
		     mux_out            : OUT std_logic_vector(tamanho downto 0));
	end component mux;

	-- declaração de sinais
	signal mux_in_a : std_logic_vector(tamanho downto 0);
	signal mux_in_b : std_logic_vector(tamanho downto 0);
	signal mux_sel  : std_logic;
	signal mux_out  : std_logic_vector(tamanho downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Instância de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : mux
		generic map(
			tamanho => tamanho
		)
		port map(
			mux_in_a => mux_in_a,
			mux_in_b => mux_in_b,
			mux_sel  => mux_sel,
			mux_out  => mux_out
		);

	-- gera um clok
	process
	begin
		mux_in_a <= std_logic_vector(to_unsigned(0, tamanho + 1));
		mux_in_b <= std_logic_vector(to_unsigned(1, tamanho + 1));
		mux_sel <= '0';
		wait for 10 ns;
		mux_in_a <= std_logic_vector(to_unsigned(0, tamanho + 1));
		mux_in_b <= std_logic_vector(to_unsigned(1, tamanho + 1));
		mux_sel <= '1';
		wait for 10 ns;
		mux_in_a <= std_logic_vector(to_unsigned(2, tamanho + 1));
		mux_in_b <= std_logic_vector(to_unsigned(3, tamanho + 1));
		mux_sel <= '0';
		wait for 10 ns;
		mux_in_a <= std_logic_vector(to_unsigned(2, tamanho + 1));
		mux_in_b <= std_logic_vector(to_unsigned(3, tamanho + 1));
		mux_sel <= '1';
		wait for 10 ns;
		mux_in_a <= std_logic_vector(to_unsigned(4, tamanho + 1));
		mux_in_b <= std_logic_vector(to_unsigned(5, tamanho + 1));
		mux_sel <= '0';
		wait for 10 ns;
		mux_in_a <= std_logic_vector(to_unsigned(4, tamanho + 1));
		mux_in_b <= std_logic_vector(to_unsigned(5, tamanho + 1));
		mux_sel <= '1';
		wait for 10 ns;
		mux_in_a <= std_logic_vector(to_unsigned(6, tamanho + 1));
		mux_in_b <= std_logic_vector(to_unsigned(7, tamanho + 1));
		mux_sel <= '0';
		wait for 10 ns;
		mux_in_a <= std_logic_vector(to_unsigned(6, tamanho + 1));
		mux_in_b <= std_logic_vector(to_unsigned(7, tamanho + 1));
		mux_sel <= '1';
		wait for 10 ns;
	end process;

END ARCHITECTURE stimulus;
