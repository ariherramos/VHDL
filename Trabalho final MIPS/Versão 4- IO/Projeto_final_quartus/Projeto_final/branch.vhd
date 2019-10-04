library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branch is
	port(
		pc_data : in  std_logic_vector(31 downto 0);
		address : in  std_logic_vector(15 downto 0);
		b_add   : out std_logic_vector(31 downto 0)
	);
end entity branch;

architecture RTL of branch is
begin
	process(address, pc_data)
		variable aux : std_logic_vector(31 downto 0);
	begin
		if address(15)='0' then						--endereço para frente
			aux   := "0000000000000000" & address;
			b_add <= std_logic_vector(signed(aux) + signed(pc_data));
		else
			aux   := "1111111111111111" & address;	--endereço para trás
			b_add <= std_logic_vector(signed(aux) + signed(pc_data));
		end if;
	end process;
end architecture RTL;
