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
ENTITY latch IS
	generic(
		tamanho : integer
	);
	port(
		ina : in  std_logic_vector(tamanho downto 0);
		sel : in  std_logic;
		x   : out std_logic_vector(tamanho downto 0)
	);
END ENTITY latch;
------------------------------
ARCHITECTURE sele OF latch IS
	signal xx : std_logic_vector(tamanho downto 0):=std_logic_vector(to_unsigned(0,tamanho+1));

BEGIN                                   -- inicio do corpo da arquitetura

	xx <= ina when sel = '1' else 
		  xx;
	x<=xx;

END ARCHITECTURE sele;

