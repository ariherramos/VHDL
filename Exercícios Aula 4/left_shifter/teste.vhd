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
	component shifter
		port(input       : IN  std_logic_vector(7 downto 0);
		     shift_cntrl : IN  std_logic_vector(1 downto 0);
		     shift_out   : OUT std_logic_vector(15 downto 0)
		    );
	end component shifter;

	-- declaração de sinais
	signal input       : std_logic_vector(7 downto 0);
	signal shift_cntrl : std_logic_vector(1 downto 0);
	signal shift_out   : std_logic_vector(15 downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	-- Instância de divisor_clock com nome dut, pode haver 
	-- quantas mais do que uma
	log : shifter
		port map(
			input       => input,
			shift_cntrl => shift_cntrl,
			shift_out   => shift_out
		);

	-- gera um clok
	process
	begin
		input       <= "11111111";
		shift_cntrl <= "00";
		wait for 10 ns;
		input       <= "11111111";
		shift_cntrl <= "01";
		wait for 10 ns;
		input       <= "11111111";
		shift_cntrl <= "10";
		wait for 10 ns;
		input       <= "11111111";
		shift_cntrl <= "11";
		wait for 10 ns;

	end process;

END ARCHITECTURE stimulus;
