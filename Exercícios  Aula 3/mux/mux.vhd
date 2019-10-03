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
USE IEEE.std_logic_unsigned. all;
------------------------------
ENTITY mux IS
	generic(
		tamanho: integer
	);
	port(
	ina:   in  std_logic_vector (tamanho downto 0);
	inb:   in  std_logic_vector (tamanho downto 0);
	inc:   in  std_logic_vector (tamanho downto 0);
	ind:   in  std_logic_vector (tamanho downto 0);
	sel:   in  std_logic_vector (1 downto 0);
	x  :   out std_logic_vector (tamanho downto 0)
	);	
END ENTITY mux;
------------------------------
ARCHITECTURE sele OF mux IS
	
BEGIN  -- inicio do corpo da arquitetura
	
	with sel select
	x <= ina when "00",
		 inb when "01",
		 inc when "10",
		 ind when others;
		 
END ARCHITECTURE sele;



