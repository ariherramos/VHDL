# ============================================================================
# Name        : tb_divisor.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletr�nica, Florian�polis, IFSC
# Description : Exemplo de script de compila��o ModelSim para divisor de clock
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem � importante
vcom mux.vhd teste.vhd

#Simula (work � o diretorio, testbench � o nome da entity)
vsim -t ns work.teste

#Mosta forma de onda
view wave

#Adiciona ondas espec�ficas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /mux_in_a
add wave -radix binary  /mux_in_b
add wave -radix binary  /mux_sel
add wave -radix binary  /mux_out
#Como mostrar sinais internos do processo
#add wave -radix dec /dut/p0/count


#Simula at� um 500ns
run 80ns

wave zoomfull
write wave wave.ps