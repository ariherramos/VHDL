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
USE IEEE.std_logic_unsigned.all;
------------------------------
ENTITY paridade IS
	port(
		dataa : in  std_logic_vector(7 downto 0);
		sel   : in  std_logic;
		x     : out std_logic
	);
END ENTITY paridade;
------------------------------
ARCHITECTURE sele OF paridade IS

BEGIN                                   -- inicio do corpo da arquitetura
	paridade : process(dataa, sel)
		variable count : std_logic_vector(6 downto 0);
	begin
		if (sel = '1')  then

			count(3) := dataa(7) xor dataa(6);
			count(2) := dataa(5) xor dataa(4);
			count(1) := dataa(3) xor dataa(2);
			count(0) := dataa(1) xor dataa(0);

			count(4) := count(3) xor count(2);
			count(5) := count(1) xor count(0);

			count(6) := count(4) xor count(5);
			
		end if;
		x <= count(6);
	end process;
END ARCHITECTURE sele;

			--for i in imput' range loop
			--	temp:=temp xor imput(i)
			-- end loop
			-- else 
			-- 	temp:='0';
			--end if
			--output<=temp;
