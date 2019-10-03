-- Bibliotecas e clásulas
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.all;
-------------------------------------
ENTITY teste IS
END ENTITY teste;
------------------------------

ARCHITECTURE stimulus OF teste IS

	component decodificador
		port(a          : IN  std_logic_vector(17 downto 0);
		     a2, a1, a0 : out std_logic_vector(14 downto 0);
		     cs2, cs1, cs0 : buffer std_logic
		    );
	end component decodificador;

	-- declaração de sinais
	signal a  : std_logic_vector(17 downto 0);
	signal a2 : std_logic_vector(14 downto 0);
	signal a1 : std_logic_vector(14 downto 0);
	signal a0 : std_logic_vector(14 downto 0);
	signal cs2 : std_logic;
	signal cs1 : std_logic;
	signal cs0 : std_logic;

BEGIN                                   -- inicio do corpo da arquitetura
	
	log : decodificador
		port map(
			a  => a,
			a2 => a2,
			a1 => a1,
			a0 => a0,
			cs2 => cs2,
			cs1 => cs1,
			cs0 => cs0
		);

	-- gera um clok
	process
	begin
		a<="011111111111111111";
		wait for 10 ns;
		a<="100111111111111111";
		wait for 10 ns;
		a<="101000000000000000";
		wait for 10 ns;
		a<="101000000000000001";
		wait for 10 ns;
		a<="100000000000000010";
		wait for 10 ns;

	end process;

END ARCHITECTURE stimulus;
