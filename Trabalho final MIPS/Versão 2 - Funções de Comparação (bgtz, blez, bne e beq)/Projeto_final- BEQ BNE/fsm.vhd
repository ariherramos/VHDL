library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
	port(
		clk       : in  std_logic;
		rst       : in  std_logic;
		ir_opcode : in  std_logic_vector(5 downto 0);
		ir_funct  : in  std_logic_vector(5 downto 0);
		ula_equal : in  std_logic;
		ula_less  : in  std_logic;
		pc_load   : out std_logic;
		pc_inc    : out std_logic;
		rom_en    : out std_logic;
		ir_load   : out std_logic;
		br_p_w    : out std_logic;
		ulaop     : out std_logic_vector(5 downto 0);
		mux_d_sel : out std_logic;
		mux_e_sel : out std_logic;
		mux_r_sel : out std_logic;
		mux_c_sel : out std_logic;
		mux_a_sel : out std_logic;
		halt_sig  : out std_logic       --sinal que está tudo suspenso
	);
end entity fsm;

architecture RTL of fsm is
	type state_type is (FETCH, RI, DECODIFICADOR, LI, LI_MEN, FUNC_R, R_MEN, HALT, BRANCH_EQUAL, RETURN_EQUAL, BRANCH_ZERO, RETURN_ZERO, JUMP);
	signal state : state_type;
begin

	process(clk, rst)
	begin
		if rst = '0' then
			state <= FETCH;

		elsif rising_edge(clk) then
			case state is
				when FETCH =>
					state <= RI;

				when RI =>
					state <= DECODIFICADOR;

				when DECODIFICADOR =>
					if ir_opcode = "001001" then
						state <= LI;
						
					elsif ir_opcode = "000000" then
						if ir_funct = "001101" then
							state <= HALT;
						else
							state <= FUNC_R;
						end if;
						
					elsif ir_opcode = "000100" OR ir_opcode = "000101" then
						state<=BRANCH_EQUAL;
					
					
					elsif ir_opcode = "000111" OR ir_opcode = "000110" then
						state<=BRANCH_ZERO;
						
					elsif ir_opcode = "000010" then
						state <= JUMP;
						
					end if;

				when LI =>
					state <= LI_MEN;

				when LI_MEN =>
					state <= FETCH;

				when FUNC_R =>
					state <= R_MEN;

				when R_MEN =>
					state <= FETCH;

				when HALT =>
					state <= HALT;
					
				when BRANCH_EQUAL =>
					state <= RETURN_EQUAL;

				when RETURN_EQUAL =>
					state <= FETCH;
					
				when BRANCH_ZERO =>
					state <= RETURN_ZERO;

				when RETURN_ZERO =>
					state <= FETCH;
					
				when JUMP =>
					state <= FETCH;

			end case;
		end if;
	end process;

	process(state)
	begin
		case state is
			when FETCH =>
				rom_en    <= '1';
				halt_sig  <= '0';
				pc_load   <= '0';
				pc_inc    <= '0';
				ir_load   <= '0';
				br_p_w    <= '0';
				ulaop     <= "000000";
				mux_d_sel <= '0';
				mux_e_sel <= '0';
				mux_r_sel <= '0';
				mux_c_sel <= '0';
				mux_a_sel <= '0';

			when RI =>
				ir_load <= '1';

			when DECODIFICADOR =>

			when LI =>
				mux_e_sel <= '1';
				ulaop     <= ir_opcode;

			when LI_MEN =>
				mux_r_sel <= '1';
				br_p_w    <= '1';
				pc_inc    <= '1';

			when FUNC_R =>
				if ir_funct = "000000" or ir_funct = "000010" then
					mux_d_sel <= '1';
				end if;
				ulaop <= ir_funct;

			when R_MEN =>
				mux_r_sel <= '1';
				br_p_w    <= '1';
				pc_inc    <= '1';

			when HALT =>
				halt_sig <= '1';
				
			when BRANCH_EQUAL =>
				ulaop <= "000100";

			when RETURN_EQUAL =>
				if ir_opcode ="000100" then
					if ula_equal='1' then
						mux_a_sel<='1';
						pc_load<='1';
					else
						pc_inc<='1';
					end if;
				else
					if ula_equal='0' then
						mux_a_sel<='1';
						pc_load<='1';
					else
						pc_inc<='1';
					end if; 
				end if;
				
			when BRANCH_ZERO =>
				ulaop <= "000111";

			when RETURN_ZERO =>
				if ir_opcode ="000111" then
					if ula_less='1' then
						mux_a_sel<='1';
						pc_load<='1';
					else
						pc_inc<='1';
					end if;
				else
					if ula_less='0' then
						mux_a_sel<='1';
						pc_load<='1';
					else
						pc_inc<='1';
					end if; 
				end if;
				
			when JUMP=>
				pc_load<='1';
				
		end case;
	end process;

end architecture RTL;
