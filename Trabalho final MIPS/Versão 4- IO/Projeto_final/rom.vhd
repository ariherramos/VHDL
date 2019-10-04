library ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rom is
	port(
		clk      : in  std_logic;
		en       : in  std_logic;
		rd_addr  : in  std_logic_vector(31 downto 0);
		data_out : out std_logic_vector(31 downto 0)
	);
end entity rom;

architecture RTL of rom is
	type memoria_rom is array (0 to 5) of std_logic_vector(31 downto 0);
	constant memoria : memoria_rom := ("00100100000000000000000000000001",--LI
	                                   "00100100000000000000100000000001",--LI
	                                   "00100100000000000001011111111110",--LI
	                                   "00000000000000100001000000100000",--ADD=3
	                                   --"000101 0000 00010 1111111111111111",--BNE
	                                   --"00011000010000001111111111111111",--BLEZ
	                                   "00001000000000000000000000000011",--JUMP
	                                   "00000000000000000000000000001101"
	                                  );
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if en = '1' then
				data_out <= memoria(conv_integer(rd_addr));
			end if;
		end if;
	end process;
end architecture RTL;
