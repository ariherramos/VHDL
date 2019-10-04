library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips is
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
		m_halt_sig  : out std_logic;    --sinal que está tudo suspenso
		m_outa_reg  : out std_logic_vector(31 downto 0);
		m_out_ula   : out std_logic_vector(31 downto 0);
		m_p_w_add   : out std_logic_vector(4 downto 0);
		m_p_w_data  : out std_logic_vector(31 downto 0);
		SW_in       : in  std_logic_vector(8 downto 0);
		LED_out     : out std_logic_vector(9 downto 0)
	);
end entity mips;

architecture RTL of mips is
	component pc is
		port(
			clk     : in  std_logic;
			rst     : in  std_logic;
			load    : in  std_logic;
			inc     : in  std_logic;
			data_in : in  std_logic_vector(31 downto 0);
			data    : out std_logic_vector(31 downto 0)
		);
	end component pc;

	component rom is
		port(
			clk      : in  std_logic;
			en       : in  std_logic;
			rd_addr  : in  std_logic_vector(31 downto 0);
			data_out : out std_logic_vector(31 downto 0)
		);
	end component rom;

	component ir is
		port(
			clk            : in  std_logic;
			load           : in  std_logic;
			clear          : in  std_logic;
			data           : in  std_logic_vector(31 downto 0);
			opcode         : out std_logic_vector(5 downto 0);
			rs             : out std_logic_vector(4 downto 0);
			rt             : out std_logic_vector(4 downto 0);
			rd             : out std_logic_vector(4 downto 0);
			shamt          : out std_logic_vector(4 downto 0);
			funct          : out std_logic_vector(5 downto 0);
			address        : out std_logic_vector(15 downto 0);
			pseudo_address : out std_logic_vector(25 downto 0)
		);
	end component ir;

	component banco_reg_32_generate is
		port(
			clk      : in  std_logic;
			rst      : in  std_logic;
			pa_add   : in  std_logic_vector(4 downto 0);
			pb_add   : in  std_logic_vector(4 downto 0);
			p_w      : in  std_logic;
			p_w_add  : in  std_logic_vector(4 downto 0);
			p_w_data : in  std_logic_vector(31 downto 0);
			outa     : out std_logic_vector(31 downto 0);
			outb     : out std_logic_vector(31 downto 0)
		);
	end component banco_reg_32_generate;

	component ula is
		port(
			clk     : in  std_logic;
			rst     : in  std_logic;
			dataa   : in  std_logic_vector(31 downto 0);
			datab   : in  std_logic_vector(31 downto 0);
			ulaop   : in  std_logic_vector(5 downto 0);
			equal   : out std_logic;
			less    : out std_logic;
			out_lsb : out std_logic_vector(31 downto 0)
		);
	end component ula;

	component mux is
		port(
			mux_in_0 : in  std_logic_vector(31 downto 0);
			mux_in_1 : in  std_logic_vector(31 downto 0);
			mux_sel  : in  std_logic;
			mux_out  : out std_logic_vector(31 downto 0)
		);
	end component mux;

	component mux_r is
		port(
			mux_in_0 : in  std_logic_vector(4 downto 0);
			mux_in_1 : in  std_logic_vector(4 downto 0);
			mux_sel  : in  std_logic;
			mux_out  : out std_logic_vector(4 downto 0)
		);
	end component mux_r;

	component extensao_a is
		port(
			shamt    : in  std_logic_vector(4 downto 0);
			funct    : in  std_logic_vector(5 downto 0);
			ex_out_a : out std_logic_vector(31 downto 0)
		);
	end component extensao_a;

	component extensao_b is
		port(
			shamt    : in  std_logic_vector(4 downto 0);
			ex_out_b : out std_logic_vector(31 downto 0)
		);
	end component extensao_b;

	component concat is
		port(
			pc_data     : in  std_logic_vector(31 downto 0);
			pseudo_data : in  std_logic_vector(25 downto 0);
			c_out       : out std_logic_vector(31 downto 0)
		);
	end component concat;

	component branch is
		port(
			pc_data : in  std_logic_vector(31 downto 0);
			address : in  std_logic_vector(15 downto 0);
			b_add   : out std_logic_vector(31 downto 0)
		);
	end component branch;

	component fsm is
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
			ram_r_en  : out std_logic;
			ram_w_en  : out std_logic;
			halt_sig  : out std_logic   --sinal que está tudo suspenso
		);
	end component fsm;

	component add_ram is
		port(
			offset : in  std_logic_vector(31 downto 0);
			outa   : in  std_logic_vector(31 downto 0);
			addr   : out std_logic_vector(31 downto 0)
		);
	end component add_ram;

	component ram_mips is
		port(
			clk      : in  std_logic;
			rst      : in  std_logic;
			addr     : in  std_logic_vector(31 downto 0);
			ram_r_en : in  std_logic;
			ram_w_en : in  std_logic;
			data     : in  std_logic_vector(31 downto 0);
			out_ram  : out std_logic_vector(31 downto 0);
			data_sw  : in  std_logic_vector(8 downto 0);
			data_led : out std_logic_vector(9 downto 0)
		);
	end component ram_mips;

	--Sinais de controle

	signal pc_load   : std_logic;
	signal pc_inc    : std_logic;
	signal rom_en    : std_logic;
	signal ir_load   : std_logic;
	signal ir_opcode : std_logic_vector(5 downto 0);
	signal ir_funct  : std_logic_vector(5 downto 0);
	signal br_p_w    : std_logic;
	signal ulaop     : std_logic_vector(5 downto 0);
	signal ula_equal : std_logic;
	signal ula_less  : std_logic;
	signal mux_d_sel : std_logic;
	signal mux_e_sel : std_logic;
	signal mux_r_sel : std_logic;
	signal mux_c_sel : std_logic;
	signal mux_a_sel : std_logic;
	signal ram_r_en  : std_logic;
	signal ram_w_en  : std_logic;
	signal halt_sig  : std_logic;

	--Sinais de entrada e saida
	signal pc_data           : std_logic_vector(31 downto 0);
	signal rom_data_out      : std_logic_vector(31 downto 0);
	signal ir_rs             : std_logic_vector(4 downto 0);
	signal ir_rt             : std_logic_vector(4 downto 0);
	signal ir_rd             : std_logic_vector(4 downto 0);
	signal ir_shamt          : std_logic_vector(4 downto 0);
	--signal ir_funct  : std_logic_vector(5 downto 0);
	signal ir_address        : std_logic_vector(15 downto 0);
	signal ir_pseudo_address : std_logic_vector(25 downto 0);
	signal ex_out_a          : std_logic_vector(31 downto 0);
	signal ex_out_b          : std_logic_vector(31 downto 0);
	signal br_outa           : std_logic_vector(31 downto 0);
	signal br_outb           : std_logic_vector(31 downto 0);
	signal out_lsb           : std_logic_vector(31 downto 0);
	signal mux_d_out         : std_logic_vector(31 downto 0);
	signal mux_e_out         : std_logic_vector(31 downto 0);
	signal mux_r_out         : std_logic_vector(4 downto 0);
	signal mux_c_out         : std_logic_vector(31 downto 0);
	signal mux_a_out         : std_logic_vector(31 downto 0);
	signal c_out             : std_logic_vector(31 downto 0);
	signal b_add             : std_logic_vector(31 downto 0);
	signal out_io            : std_logic_vector(31 downto 0);
	signal ram_addr          : std_logic_vector(31 downto 0);

begin

	m_ir_opcode <= ir_opcode;
	m_ir_funct  <= ir_funct;
	m_ula_equal <= ula_equal;
	m_ula_less  <= ula_less;
	m_pc_load   <= pc_load;
	m_pc_inc    <= pc_inc;
	m_rom_en    <= rom_en;
	m_ir_load   <= ir_load;
	m_br_p_w    <= br_p_w;
	m_ulaop     <= ulaop;
	m_mux_d_sel <= mux_d_sel;
	m_mux_e_sel <= mux_e_sel;
	m_mux_r_sel <= mux_r_sel;
	m_mux_c_sel <= mux_c_sel;
	m_mux_a_sel <= mux_a_sel;
	m_halt_sig  <= halt_sig;            --sinal que está tudo suspenso
	m_outa_reg  <= br_outa;
	m_out_ula   <= out_lsb;
	m_p_w_add   <= mux_r_out;
	m_p_w_data  <= mux_c_out;

	pc_0 : pc
		port map(
			clk     => clk,
			rst     => rst,
			load    => pc_load,
			inc     => pc_inc,
			data_in => mux_a_out,
			data    => pc_data
		);

	rom_0 : rom
		port map(
			clk      => clk,
			en       => rom_en,
			rd_addr  => pc_data,
			data_out => rom_data_out
		);

	ir_0 : ir
		port map(
			clk            => clk,
			load           => ir_load,
			clear          => rst,
			data           => rom_data_out,
			opcode         => ir_opcode,
			rs             => ir_rs,
			rt             => ir_rt,
			rd             => ir_rd,
			shamt          => ir_shamt,
			funct          => ir_funct,
			address        => ir_address,
			pseudo_address => ir_pseudo_address
		);

	br_0 : banco_reg_32_generate
		port map(
			clk      => clk,
			rst      => rst,
			pa_add   => ir_rs,
			pb_add   => ir_rt,
			p_w      => br_p_w,
			p_w_add  => mux_r_out,
			p_w_data => mux_c_out,
			outa     => br_outa,
			outb     => br_outb
		);

	ula_0 : ula
		port map(
			clk     => clk,
			rst     => rst,
			dataa   => mux_d_out,
			datab   => mux_e_out,
			ulaop   => ulaop,
			equal   => ula_equal,
			less    => ula_less,
			out_lsb => out_lsb
		);

	mux_d : mux
		port map(
			mux_in_0 => br_outa,
			mux_in_1 => ex_out_b,
			mux_sel  => mux_d_sel,
			mux_out  => mux_d_out
		);

	mux_e : mux
		port map(
			mux_in_0 => br_outb,
			mux_in_1 => ex_out_a,
			mux_sel  => mux_e_sel,
			mux_out  => mux_e_out
		);

	mux_c : mux
		port map(
			mux_in_0 => out_lsb,
			mux_in_1 => out_io,
			mux_sel  => mux_c_sel,
			mux_out  => mux_c_out
		);

	mux_a : mux
		port map(
			mux_in_0 => c_out,
			mux_in_1 => b_add,
			mux_sel  => mux_a_sel,
			mux_out  => mux_a_out
		);

	r_mux : mux_r
		port map(
			mux_in_0 => ir_rt,
			mux_in_1 => ir_rd,
			mux_sel  => mux_r_sel,
			mux_out  => mux_r_out
		);

	ex_a : extensao_a
		port map(
			shamt    => ir_shamt,
			funct    => ir_funct,
			ex_out_a => ex_out_a
		);

	ex_b : extensao_b
		port map(
			shamt    => ir_shamt,
			ex_out_b => ex_out_b
		);

	con : concat
		port map(
			pc_data     => pc_data,
			pseudo_data => ir_pseudo_address,
			c_out       => c_out
		);

	bc : branch
		port map(
			pc_data => pc_data,
			address => ir_address,
			b_add   => b_add
		);
	machine : fsm
		port map(
			clk       => clk,
			rst       => rst,
			ir_opcode => ir_opcode,
			ir_funct  => ir_funct,
			ula_equal => ula_equal,
			ula_less  => ula_less,
			pc_load   => pc_load,
			pc_inc    => pc_inc,
			rom_en    => rom_en,
			ir_load   => ir_load,
			br_p_w    => br_p_w,
			ulaop     => ulaop,
			mux_d_sel => mux_d_sel,
			mux_e_sel => mux_e_sel,
			mux_r_sel => mux_r_sel,
			mux_c_sel => mux_c_sel,
			mux_a_sel => mux_a_sel,
			ram_r_en  => ram_r_en,
			ram_w_en  => ram_w_en,
			halt_sig  => halt_sig       --sinal que está tudo suspenso
		);

	add_0 : add_ram
		port map(
			offset => ex_out_a,
			outa   => br_outa,
			addr   => ram_addr
		);

	ram_0 : ram_mips
		port map(
			clk      => clk,
			rst      => rst,
			addr     => ram_addr,
			ram_r_en => ram_r_en,
			ram_w_en => ram_w_en,
			data     => br_outb,
			out_ram  => out_io,
			data_sw  => SW_in,
			data_led => lED_out
		);
end architecture RTL;
