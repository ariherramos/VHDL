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
	component demux
		generic(tamanho : integer);
		port(outa, outb, outc, outd : out std_logic_vector(tamanho downto 0);
		     x, sel                 : in  std_logic_vector(tamanho downto 0));
	end component demux;

	-- declaração de sinais
	signal outa : std_logic_vector(tamanho downto 0);
	signal outb : std_logic_vector(tamanho downto 0);
	signal outc : std_logic_vector(tamanho downto 0);
	signal outd : std_logic_vector(tamanho downto 0);
	signal sel  : std_logic_vector(tamanho downto 0);
	signal x    : std_logic_vector(tamanho downto 0):="11";

BEGIN                                   -- inicio do corpo da arquitetura

	-- Instância de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : demux
		generic map(
			tamanho => tamanho
		)
		port map(
			outa => outa,
			outb => outb,
			outc => outc,
			outd => outd,
			sel  => sel,
			x    => x
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
