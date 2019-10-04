library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_ram is
	port(
		offset : in  std_logic_vector(31 downto 0);
		outa   : in  std_logic_vector(31 downto 0);
		addr   : out std_logic_vector(31 downto 0)
	);
end entity add_ram;

architecture RTL of add_ram is

begin
	
	addr <= std_logic_vector(signed(offset) + signed(outa));
	
end architecture RTL;
