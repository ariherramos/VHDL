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
ENTITY adder IS
	generic(
		tamanho: integer
	);
	port(
	dataa:   in  std_logic_vector (tamanho downto 0);
	datab:   in  std_logic_vector (tamanho downto 0);
	sum:	 out std_logic_vector (tamanho downto 0)
	);	
END ENTITY adder;
------------------------------
ARCHITECTURE somador OF adder IS

BEGIN  -- inicio do corpo da arquitetura
	sum <= std_logic_vector(unsigned(dataa) + unsigned(datab));
END ARCHITECTURE somador;



