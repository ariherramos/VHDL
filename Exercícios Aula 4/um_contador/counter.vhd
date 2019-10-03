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
USE IEEE.std_logic_unsigned. all;
--USE IEEE.std_logic_arith. all;
------------------------------
ENTITY counter IS
	port(
		dataa : in  std_logic_vector(3 downto 0);
		sum   : out std_logic_vector(3 downto 0)
	);
END ENTITY counter;
------------------------------
ARCHITECTURE somador OF counter IS

BEGIN                                   -- inicio do corpo da arquitetura
	contador : process(dataa)
		variable count : std_logic_vector(3 downto 0);
	begin
		count := (others => '0');
		for i in dataa' range loop
			if (dataa(i) /= '0') then
				count := count + '1';
			end if;
		end loop;
		sum<=count;
	end process;
END ARCHITECTURE somador;
