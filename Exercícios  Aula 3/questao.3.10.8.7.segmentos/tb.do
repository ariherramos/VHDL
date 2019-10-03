# ============================================================================
# Name        : tb_divisor.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim para divisor de clock
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom segmentos.vhd teste.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.teste

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /bin
add wave -radix binary  /seg
#Como mostrar sinais internos do processo
#add wave -radix dec /dut/p0/count


#Simula até um 500ns
run 80ns

wave zoomfull
write wave wave.ps