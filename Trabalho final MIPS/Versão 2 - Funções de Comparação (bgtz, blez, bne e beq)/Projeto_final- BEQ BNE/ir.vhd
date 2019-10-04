library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ir is
	port(
		clk            : in  std_logic;
		load           : in  std_logic;
		clear          : in  std_logic;
		data           : in  std_logic_vector(31 downto 0);
		opcode         : out std_logic_vector(5 downto 0);
		rs             : out std_logic_vector(4 downto 0);
		rt             : out std_logic_vector(4 downto 0);
		--Intru��o R
		rd             : out std_logic_vector(4 downto 0);
		shamt          : out std_logic_vector(4 downto 0);
		funct          : out std_logic_vector(5 downto 0);
		--Instru��o I
		address        : out std_logic_vector(15 downto 0);
		--Instru��o J
		pseudo_address : out std_logic_vector(25 downto 0)
	);
end entity ir;

architecture RTL of ir is

begin

	process(clk, clear, load)
	begin
		if clear = '0' then
			opcode         <= (others => '0');
			rs             <= (others => '0');
			rt             <= (others => '0');
			rd             <= (others => '0');
			shamt          <= (others => '0');
			funct          <= (others => '0');
			address        <= (others => '0');
			pseudo_address <= (others => '0');

		elsif load = '1' then
			opcode         <= data(31 downto 26);
			rs             <= data(25 downto 21);
			rt             <= data(20 downto 16);
			rd             <= data(15 downto 11);
			shamt          <= data(10 downto 6);
			funct          <= data(5 downto 0);
			address        <= data(15 downto 0);
			pseudo_address <= data(25 downto 0);
		end if;
	end process;

end architecture RTL;
