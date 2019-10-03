# ============================================================================
# Name        : sim_testbench.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim
# ============================================================================

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom arquivo_out.vhd arquivo_in.vhd testbench_arquivo.vhd

#Simula
vsim -t ns work.testbench_arquivo

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary -label clk /clk
add wave -radix dec -label dado /dado

#Simula até um 100ns
run 100ns

wave zoomfull
write wave wave.ps