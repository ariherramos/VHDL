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
		a   : in  std_logic_vector(17 downto 0);
		a2  : out std_logic_vector(14 downto 0);
		a1  : out std_logic_vector(14 downto 0);
		a0  : out std_logic_vector(14 downto 0);
		cs2 : buffer std_logic;
		cs1 : buffer std_logic;
		cs0 : buffer std_logic
	);
END ENTITY decodificador;
------------------------------
ARCHITECTURE sele OF decodificador IS
	signal p : std_logic_vector(2 downto 0);

BEGIN                                   -- inicio do corpo da arquitetura
	selecionador: BLOCK
	begin
	p <= a(17 downto 15);
	
	cs2 <= '1' when p="000" or p="001" or p="010" or p="011" else
		   '0';
	cs1 <= '1' when p="100" else
		   '0';
	cs0 <= '1' when p="101" else
		   '0';
	END BLOCK selecionador;
	
	memoria: BLOCK
	begin
	
	a2 <= a(14 downto 0) when cs2 ='1';
	a1 <= a(14 downto 0) when cs1 ='1';
	a0 <= a(14 downto 0) when cs0 ='1';

	END BLOCK memoria;	
		  
END ARCHITECTURE sele;
