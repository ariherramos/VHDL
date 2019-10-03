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
ENTITY mux IS
	generic(
		tamanho : integer
	);
	port(
		mux_in_a : in  std_logic_vector(tamanho downto 0);
		mux_in_b : in  std_logic_vector(tamanho downto 0);
		mux_sel  : in  std_logic;
		mux_out  : out std_logic_vector(tamanho downto 0)
	);
END ENTITY mux;
------------------------------
ARCHITECTURE sele OF mux IS

BEGIN                                   -- inicio do corpo da arquitetura

	mux: process(mux_sel, mux_in_a, mux_in_b)
	begin
		if mux_sel='0' then
			mux_out <= mux_in_a;
		else
			mux_out <= mux_in_b;
		end if;
	end process;

END ARCHITECTURE sele;

