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
USE IEEE.std_logic_unsigned.all;
------------------------------
ENTITY shifter IS
	port(
		input       : in  std_logic_vector(7 downto 0);
		shift_cntrl : in  std_logic_vector(1 downto 0);
		shift_out   : out std_logic_vector(15 downto 0)
	);
END ENTITY shifter;
------------------------------
ARCHITECTURE sele OF shifter IS

BEGIN                                   -- inicio do corpo da arquitetura

	deslocador : process(input, shift_cntrl)
	begin
		if shift_cntrl = "00" then
			shift_out <= "00000000" & input;
		elsif shift_cntrl = "01" then
			shift_out <= "0000" & input & "0000";
		elsif shift_cntrl = "10" then
			shift_out <= input & "00000000";
		else
			shift_out <= "00000000" & input;
		end if;
	end process;

END ARCHITECTURE sele;

