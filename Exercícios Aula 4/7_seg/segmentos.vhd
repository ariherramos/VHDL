-------------------------------------------------------------------
-- Name        : 
-- Author      : arihe
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : 
-------------------------------------------------------------------

-- Bibliotecas e clásulas
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
------------------------------
ENTITY segmentos IS
	port(
		bin : in  std_logic_vector(3 downto 0);
		seg : out std_logic_vector(6 downto 0)
	);
END ENTITY segmentos;
------------------------------
ARCHITECTURE sele OF segmentos IS

BEGIN                                   -- inicio do corpo da arquitetura

	segmento : process(bin)
	begin
	case bin is
		--   abcdefg
		when "0000" =>
			seg <= "1111110";
		when "0001" =>
			seg <= "1100000";
		when "0010" =>
			seg <= "1011010";
		when "0011" =>
			seg <= "1110011";
		when "0100" =>
			seg <= "1100101";
		when "0101" =>
			seg <= "0110111";
		when "0110" =>
			seg <= "0111111";
		when "0111" =>
			seg <= "1100010";
		when "1000" =>
			seg <= "1111111";
		when "1001" =>
			seg <= "1110111";
		when others =>
			seg <= "0000000";
		end case;
	end process;

END ARCHITECTURE sele;
