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
	type memoria_rom is array (0 to 11) of std_logic_vector(31 downto 0);
	constant memoria : memoria_rom := ("00100100000000000000000000000001",--LI
	                                   "00100100000000000000100000000010",--LI
	                                   "00100100001000000001000000000011",--LI
	                                   "00000000000000010001100000100000",--ADD=3
	                                   "00000000010000010010000000011000",--MULT=6
	                                   "00000000010000010010100000100100",--AND=2
	                                   "00000000010000010011000000100101",--OR=3
	                                   "00000000000000010011100000100110",--XOR=3
	                                   "00000000000000000100000000100111",--NOT
	                                   "00000000000000010100100010000000",--SLL=1000
	                                   "00000000000000010101000001000010",--SRL=1
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
