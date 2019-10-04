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
	type memoria_rom is array (0 to 19) of std_logic_vector(31 downto 0);
	constant memoria : memoria_rom := (
													"00100100000000000000000010000000",--LI LED
													"00100100000000000000100010000001",--LI DISPLAY
													"00100100000000000001000010000001",--LI SW
													"00100100000000000001100000000000",--LI
													"00100100000000000010000000000001",--LI
													"00100100000000000010100000000010",--LI
													"00100100000000000011000000000011",--LI
													"10001100010000000011100000000000",--LW CHAVE
													"00010000011001110000000000000111",--BEQ
													"00010000100001110000000000000110",--BEQ
													"00010000101001110000000000000101",--BEQ
													"00010000110001110000000000000100",--BEQ
													"00000000101001100100100000100000",--ADD=5
													"10101100000010010000000000000000",--Sw LEDS	
													"00001000000000000000000000000111",--JUMP SW CHAVE
													"10101100001001110000000000000000",--Sw DISPLAY
													"00000000000001110100000100000000",--sll NO VALOR DA CHAVE
													"10101100000010000000000000000000",--Sw LEDS
													"00001000000000000000000000000111",--JUMP	SW CHAVE										
													"00000000000000000000000000001101" --HALT
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
