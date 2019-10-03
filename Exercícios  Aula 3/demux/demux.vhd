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
ENTITY demux IS
	generic(
		tamanho : integer
	);
	port(
		outa : out std_logic_vector(tamanho downto 0);
		outb : out std_logic_vector(tamanho downto 0);
		outc : out std_logic_vector(tamanho downto 0);
		outd : out std_logic_vector(tamanho downto 0);
		sel  : in  std_logic_vector(1 downto 0);
		x    : in  std_logic_vector(tamanho downto 0)
	);
END ENTITY demux;
------------------------------
ARCHITECTURE sele OF demux IS

BEGIN                                   -- inicio do corpo da arquitetura

	with sel select 
		outa <=x when "00",
		std_logic_vector(to_unsigned(0, tamanho+1)) when others;
	with sel select 
		outb <=x when "01",
		std_logic_vector(to_unsigned(0, tamanho+1)) when others;
	with sel select 
		outc <=x when "10",
		std_logic_vector(to_unsigned(0, tamanho+1)) when others;
	with sel select 
		outd <=x when "11",
		std_logic_vector(to_unsigned(0, tamanho+1)) when others;

END ARCHITECTURE sele;
