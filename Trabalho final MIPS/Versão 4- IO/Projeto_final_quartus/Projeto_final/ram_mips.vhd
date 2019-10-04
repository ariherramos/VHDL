library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_mips is
	port(
		clk      : in  std_logic;       --mips
		rst      : in  std_logic;       --mips
		addr     : in  std_logic_vector(31 downto 0);
		ram_r_en : in  std_logic;
		ram_w_en : in  std_logic;
		data     : in  std_logic_vector(31 downto 0);
		out_ram  : out std_logic_vector(31 downto 0);
		
		data_sw  : in  std_logic_vector(8 downto 0);
		data_led : out std_logic_vector(9 downto 0);
		data_display : out std_logic_vector(2 downto 0)
	);
end entity ram_mips;

architecture RTL of ram_mips is

	type memoria_ram is array (0 to 127) of std_logic_vector(31 downto 0);
	signal memoria : memoria_ram;

begin

	--separar os processos para entender que é uma ram

	process(clk, rst, addr, ram_w_en, ram_r_en, data, data_sw)
	begin

		if rst='0' then
			data_led <="0000000000";
			data_display<="111";
			
		elsif rising_edge(clk) then
			if addr(7) = '1' then
				if addr(0) = '0' and ram_w_en = '1' then
					data_led <= data(9 downto 0);
				elsif addr(0) = '1' and ram_r_en = '1' then
					out_ram <= "00000000000000000000000" & data_sw;	
				elsif addr(0) = '0' and addr(1) = '1'and ram_w_en = '1' then
					data_display <= data(2 downto 0);
				end if;
			else
				if ram_r_en = '1' then
					out_ram <= memoria(to_integer(unsigned(addr)));
				elsif ram_w_en = '1' then
					memoria(to_integer(unsigned(addr))) <= data;
				end if;
			end if;
		end if;

	end process;

end architecture RTL;
