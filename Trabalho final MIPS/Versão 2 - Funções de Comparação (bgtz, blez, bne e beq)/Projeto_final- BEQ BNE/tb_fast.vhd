library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_fast is
end entity tb_fast;

architecture RTL of tb_fast is

	component mips is
		port(
			clk         : in  std_logic;
			rst         : in  std_logic;
			m_ir_opcode : out std_logic_vector(5 downto 0);
			m_ir_funct  : out std_logic_vector(5 downto 0);
			m_ula_equal : out std_logic;
			m_ula_less  : out std_logic;
			m_pc_load   : out std_logic;
			m_pc_inc    : out std_logic;
			m_rom_en    : out std_logic;
			m_ir_load   : out std_logic;
			m_br_p_w    : out std_logic;
			m_ulaop     : out std_logic_vector(5 downto 0);
			m_mux_d_sel : out std_logic;
			m_mux_e_sel : out std_logic;
			m_mux_r_sel : out std_logic;
			m_mux_c_sel : out std_logic;
			m_mux_a_sel : out std_logic;
			m_halt_sig  : out std_logic; --sinal que está tudo suspenso
			m_outa_reg  : out std_logic_vector(31 downto 0);
			m_out_ula   : out std_logic_vector(31 downto 0);
			m_p_w_add   : out std_logic_vector(4 downto 0);
			m_p_w_data  : out std_logic_vector(31 downto 0)
		);
	end component mips;

	signal clk         : std_logic;
	signal rst         : std_logic;
	signal m_pc_load   : std_logic;
	signal m_pc_inc    : std_logic;
	signal m_rom_en    : std_logic;
	signal m_ir_load   : std_logic;
	signal m_ir_opcode : std_logic_vector(5 downto 0);
	signal m_ir_funct  : std_logic_vector(5 downto 0);
	signal m_br_p_w    : std_logic;
	signal m_ulaop     : std_logic_vector(5 downto 0);
	signal m_ula_equal : std_logic;
	signal m_ula_less  : std_logic;
	signal m_mux_d_sel : std_logic;
	signal m_mux_e_sel : std_logic;
	signal m_mux_r_sel : std_logic;
	signal m_mux_c_sel : std_logic;
	signal m_mux_a_sel : std_logic;
	signal m_halt_sig  : std_logic;
	signal m_outa_reg  : std_logic_vector(31 downto 0);
	signal m_out_ula   : std_logic_vector(31 downto 0);
	signal m_p_w_add   : std_logic_vector(4 downto 0);
	signal m_p_w_data  : std_logic_vector(31 downto 0);

begin

	log : mips
		port map(
			clk         => clk,
			rst         => rst,
			m_ir_opcode => m_ir_opcode,
			m_ir_funct  => m_ir_funct,
			m_ula_equal => m_ula_equal,
			m_ula_less  => m_ula_less,
			m_pc_load   => m_pc_load,
			m_pc_inc    => m_pc_inc,
			m_rom_en    => m_rom_en,
			m_ir_load   => m_ir_load,
			m_br_p_w    => m_br_p_w,
			m_ulaop     => m_ulaop,
			m_mux_d_sel => m_mux_d_sel,
			m_mux_e_sel => m_mux_e_sel,
			m_mux_r_sel => m_mux_r_sel,
			m_mux_c_sel => m_mux_c_sel,
			m_mux_a_sel => m_mux_a_sel,
			m_halt_sig  => m_halt_sig,  --sinal que está tudo suspenso
			m_outa_reg  => m_outa_reg,
			m_out_ula   => m_out_ula,
			m_p_w_add   => m_p_w_add,
			m_p_w_data  => m_p_w_data
		);

	rst <= '0', '1' after 5 ns;

	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

end architecture RTL;
