-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : 
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Projeto base DE10-Lite
-------------------------------------------------------------------
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

entity de0_lite is 
	port (
		---------- CLOCK ----------
		ADC_CLK_10:	in std_logic;
		MAX10_CLK1_50: in std_logic;
		MAX10_CLK2_50: in std_logic;
		
		----------- SDRAM ------------
		DRAM_ADDR: out std_logic_vector (12 downto 0);
		DRAM_BA: out std_logic_vector (1 downto 0);
		DRAM_CAS_N: out std_logic;
		DRAM_CKE: out std_logic;
		DRAM_CLK: out std_logic;
		DRAM_CS_N: out std_logic;		
		DRAM_DQ: inout std_logic_vector(15 downto 0);
		DRAM_LDQM: out std_logic;
		DRAM_RAS_N: out std_logic;
		DRAM_UDQM: out std_logic;
		DRAM_WE_N: out std_logic;
		
		----------- SEG7 ------------
		HEX0: out std_logic_vector(7 downto 0);
		HEX1: out std_logic_vector(7 downto 0);
		HEX2: out std_logic_vector(7 downto 0);
		HEX3: out std_logic_vector(7 downto 0);
		HEX4: out std_logic_vector(7 downto 0);
		HEX5: out std_logic_vector(7 downto 0);

		----------- KEY ------------
		KEY: in std_logic_vector(1 downto 0);

		----------- LED ------------
		LEDR: out std_logic_vector(9 downto 0);

		----------- SW ------------
		SW: in std_logic_vector(9 downto 0);

		----------- VGA ------------
		VGA_B: out std_logic_vector(3 downto 0);
		VGA_G: out std_logic_vector(3 downto 0);
		VGA_HS: out std_logic;
		VGA_R: out std_logic_vector(3 downto 0);
		VGA_VS: out std_logic;
	
		----------- Accelerometer ------------
		GSENSOR_CS_N: out std_logic;
		GSENSOR_INT: in std_logic_vector(2 downto 1);
		GSENSOR_SCLK: out std_logic;
		GSENSOR_SDI: inout std_logic;
		GSENSOR_SDO: inout std_logic;
	
		----------- Arduino ------------
		ARDUINO_IO: inout std_logic_vector(15 downto 0);
		ARDUINO_RESET_N: inout std_logic
	);
end entity;


architecture rtl of de0_lite is

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
			m_p_w_data  : out std_logic_vector(31 downto 0);
			SW_in       : in  std_logic_vector(8 downto 0);
			LED_out     : out std_logic_vector(9 downto 0);
			display_out : out std_logic_vector(1 downto 0)
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
	signal sel_display : std_logic_vector(1 downto 0);
	--signal SW_in       : std_logic_vector(8 downto 0);
	signal LED_sig     : std_logic_vector(9 downto 0);
	
	
begin

		log : mips
		port map(
			clk         => MAX10_CLK1_50,
			rst         => SW(9),
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
			m_p_w_data  => m_p_w_data,
			SW_in       => SW(8 downto 0),
			LED_out     => LEDR(9 downto 0),
			display_out => sel_display
		);
		
		
	--LEDR(9 downto 0)<="0000000" & sel_display;	
	
	process(MAX10_CLK1_50, SW(9), sel_display)
	begin

		if SW(9) = '0' then
			HEX5<="11111111";
			HEX4<="11111111";
			HEX3<="11111111";
			HEX2<="11111111";
			HEX1<="11111111";
			HEX0<="11111111";	
			
		elsif rising_edge(MAX10_CLK1_50) then

			if sel_display = "00" then
				--boas
				--     pgfedcba		 	
				HEX5<="10000000";
				HEX4<="11000000";
				HEX3<="10001000";
				HEX2<="10010010";
				HEX1<="11111111";
				HEX0<="11111111";
				
			elsif sel_display = "01" then
				--ferias
				--     pgfedcba		 	
				HEX5<="10001110";
				HEX4<="10000110";
				HEX3<="10001000";
				HEX2<="11001111";
				HEX1<="10001000";
				HEX0<="10010010";
				
			elsif sel_display = "10" then
				--pld
				--     pgfedcba		 	
				HEX5<="10001100";
				HEX4<="11000111";
				HEX3<="11000000";
				HEX2<="11111111";	
				HEX1<="11111111";	
				HEX0<="11111111";
				
			elsif sel_display = "11" then
				--2018|2
				--     pgfedcba		 	
				HEX5<="10100100";
				HEX4<="11000000";
				HEX3<="11111001";
				HEX2<="10000000";
				HEX1<="11001111";
				HEX0<="10100100";
			else
				HEX5<="11101111";
				HEX4<="11111111";
				HEX3<="11111111";
				HEX2<="11111111";
				HEX1<="11111111";
				HEX0<="11111111";	

			end if;
		end if;
	end process;
	

end;

