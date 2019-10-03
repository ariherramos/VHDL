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
		a2  : buffer std_logic_vector(14 downto 0);
		a1  : buffer std_logic_vector(14 downto 0);
		a0  : buffer std_logic_vector(14 downto 0);
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
	
	with p select
	cs2 <= '1' when "000"|"001"|"010"|"011",
		   '0' when others;
	with p select
	cs1 <= '1' when "100",
		   '0' when others;
	with p select
	cs0 <= '1' when "101",
		   '0' when others;
	END BLOCK selecionador;
	
	memoria: BLOCK
	begin
	with cs2 select
	a2 <= a(14 downto 0) when '1',
		  a2 when others;
	
	with cs1 select
	a1 <= a(14 downto 0) when '1',
		  a1 when others;
	
	with cs0 select
	a0 <= a(14 downto 0) when '1',
		  a0 when others;

	END BLOCK memoria;	
		  
END ARCHITECTURE sele;
