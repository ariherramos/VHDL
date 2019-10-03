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
ENTITY decodificador IS
	port(
		po0 : in  std_logic;
		po1 : in  std_logic;
		po2 : in  std_logic;
		po3 : in  std_logic;
		x1  : out std_logic;
		x0  : out std_logic;
		int : out std_logic
	);
END ENTITY decodificador;
------------------------------
ARCHITECTURE sele OF decodificador IS
	signal p    : std_logic_vector(3 downto 0);
	signal outt : std_logic_vector(2 downto 0);

BEGIN                                   -- inicio do corpo da arquitetura

	p <= po0 & po1 & po2 & po3;

	outt <= "001" when p(3) ='1' else
			"011" when p(2) ='1' else
			"101" when p(1) ='1' else
			"111" when p(0) ='1' else
			"110";

	x1  <= outt(2);
	x0  <= outt(1);
	int <= outt(0);

END ARCHITECTURE sele;
