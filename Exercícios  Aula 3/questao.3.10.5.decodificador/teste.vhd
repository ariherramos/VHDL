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
USE IEEE.std_logic_unsigned.all;
-------------------------------------
ENTITY teste IS
END ENTITY teste;
------------------------------

ARCHITECTURE stimulus OF teste IS
	-- Decaclaração do componente

	component decodificador
		port(po0, po1, po2, po3 : IN  std_logic;
		     x1, x0, int        : OUT std_logic
		    );
	end component decodificador;

	-- declaração de sinais
	signal po0 : std_logic;
	signal po1 : std_logic;
	signal po2 : std_logic;
	signal po3 : std_logic;
	signal po4 : std_logic;
	signal x1  : std_logic;
	signal x0  : std_logic;
	signal int : std_logic;

BEGIN                                   -- inicio do corpo da arquitetura

	-- Instância de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : decodificador
		port map(
			po0 => po0,
			po1 => po1,
			po2 => po2,
			po3 => po3,
			x1  => x1,
			x0  => x0,
			int => int
		);

	-- gera um clok
	process
	begin
		po0<='1';
		po1<='1';
		po2<='1';
		po3<='1';
		wait for 10 ns;
		po0<='0';
		po1<='1';
		po2<='1';
		po3<='1';
		wait for 10 ns;
		po0<='0';
		po1<='0';
		po2<='1';
		po3<='1';
		wait for 10 ns;
		po0<='0';
		po1<='0';
		po2<='0';
		po3<='1';
		wait for 10 ns;
		po0<='0';
		po1<='0';
		po2<='0';
		po3<='0';
		wait for 10 ns;

	end process;

END ARCHITECTURE stimulus;
