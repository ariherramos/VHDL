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
		port(bin  : in     std_logic_vector(3 downto 0);
		     sel  : in     std_logic_vector(1 downto 0);
		     seg3 : buffer std_logic_vector(6 downto 0);
		     seg2 : buffer std_logic_vector(6 downto 0);
		     seg1 : buffer std_logic_vector(6 downto 0);
		     seg0 : buffer    std_logic_vector(6 downto 0);
		     mst  : buffer    std_logic_vector(3 downto 0)
		    );
	end component segmentos;

	-- declaração de sinais
	signal bin  : std_logic_vector(3 downto 0);
	signal sel  : std_logic_vector(1 downto 0);
	signal seg3 : std_logic_vector(6 downto 0);
	signal seg2 : std_logic_vector(6 downto 0);
	signal seg1 : std_logic_vector(6 downto 0);
	signal seg0 : std_logic_vector(6 downto 0);
	signal mst  : std_logic_vector(3 downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Instância de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : segmentos
		port map(
			bin  => bin,
			sel  => sel,
			seg3 => seg3,
			seg2 => seg2,
			seg1 => seg1,
			seg0 => seg0,
			mst  => mst
		);

	-- gera um clok
	process
	begin
		sel<="01";
		bin <= "1111";
		sel<="10";
		bin <= "1111";
		sel<="11";
		bin <= "1111";
		
		sel<="00";
		bin <= "0000";

		wait for 10 ns;
		sel<="01";
		bin <= "0001";

		wait for 10 ns;
		sel<="10";
		bin <= "1001";

		wait for 10 ns;
		sel<="11";
		bin <= "1000";

		wait for 10 ns;
		sel<="00";
		bin <= "1001";

		wait for 10 ns;
		sel<="01";
		bin <= "0111";

		wait for 10 ns;

	end process;

END ARCHITECTURE stimulus;
