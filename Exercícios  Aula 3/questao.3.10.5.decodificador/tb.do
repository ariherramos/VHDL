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
vcom decodificador.vhd teste.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.teste

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /po0
add wave -radix binary  /po1
add wave -radix binary  /po2
add wave -radix binary  /po3
add wave -radix binary  /x1
add wave -radix binary  /x0
add wave -radix binary  /int
#Como mostrar sinais internos do processo
#add wave -radix dec /dut/p0/count


#Simula até um 500ns
run 80ns

wave zoomfull
write wave wave.ps