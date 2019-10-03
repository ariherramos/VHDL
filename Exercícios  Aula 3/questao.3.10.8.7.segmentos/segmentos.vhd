-------------------------------------------------------------------
-- Name        : adder
-- Author      : arihe
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Exemplo de somador 
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

	with bin select
	   --   abcdefg
	seg <= "1111110" when "0000",
	   	   "1100000" when "0001",
	   	   "1011010" when "0010",
	   	   "1110011" when "0011",
	   	   "1100101" when "0100",
	   	   "0110111" when "0101",
	   	   "0111111" when "0110",
	   	   "1100010" when "0111",
	   	   "1111111" when "1000",
	   	   "1110111" when "1001",
	   	   "0000000" when others;

END ARCHITECTURE sele;
