#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom pc.vhd rom.vhd ir.vhd reg32.vhd banco_reg_32_generate.vhd mux_r.vhd mux.vhd extensao_a.vhd extensao_b.vhd  ula.vhd branch.vhd concat.vhd add_ram.vhd ram_mips.vhd fsm.vhd mips.vhd tb_fast.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.tb_fast

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /clk 
add wave -radix binary  /rst
add wave -label estados /log/machine/state
add wave -radix binary  /m_ir_opcode
add wave -radix binary  /m_ir_funct
add wave -radix binary  /m_ula_equal
add wave -radix binary  /m_ula_less
add wave -radix binary  /m_pc_load
add wave -radix binary  /m_pc_inc
add wave -radix binary  /m_rom_en 

add wave -radix binary  /m_ir_load
add wave -radix binary  /m_br_p_w 
add wave -radix binary  /m_ulaop
#add wave -radix binary  /m_mux_d_sel
add wave -radix binary  /m_mux_e_sel
add wave -radix binary  /m_mux_r_sel
add wave -radix binary  /m_mux_c_sel
#add wave -radix binary  /m_mux_a_sel
add wave -radix binary  /m_halt_sig 

add wave -radix binary  /m_out_ula
add wave -radix binary  /m_p_w_add 
add wave -radix binary  /m_p_w_data
add wave -radix binary  /m_outa_reg

add wave -label registradores -radix dec /log/br_0/reg_out


#Simula até um 500ns
run 3000ns

wave zoomfull
# write wave wave.ps