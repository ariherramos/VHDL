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
		bin  : in  std_logic_vector(3 downto 0);
		sel  : in  std_logic_vector(1 downto 0);
		seg3 : buffer std_logic_vector(6 downto 0);
		seg2 : buffer std_logic_vector(6 downto 0);
		seg1 : buffer std_logic_vector(6 downto 0);
		seg0 : buffer std_logic_vector(6 downto 0);
		mst  : buffer std_logic_vector(3 downto 0)
	);
END ENTITY segmentos;
------------------------------
ARCHITECTURE sele OF segmentos IS
	signal seg : std_logic_vector(6 downto 0);
BEGIN                                   -- inicio do corpo da arquitetura
	selecionador : block
	begin
		mst <= "0111" when sel = "00" else 
			   "1011" when sel = "01" else 
			   "1101" when sel = "10" else 
			   "1110";
	end block selecionador;

	display : block
	begin
		with bin select --   abcdefg
		seg <="1111110" when "0000",
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
	end block display;
	
	print : block
	begin
		seg3 <= seg when mst(3)='0'else
				seg3;
		seg2 <= seg when mst(2)='0'else
				seg2;
		seg1 <= seg when mst(1)='0'else
				seg1;		
		seg0 <= seg when mst(0)='0'else
				seg0;
	end block print;

END ARCHITECTURE sele;
