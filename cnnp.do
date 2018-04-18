vsim -gui work.ramcacheinterface
# vsim -gui work.ramcacheinterface 
# Start time: 22:25:05 on Apr 18,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.ramcacheinterface(ramcacheinterfacearch)
# Loading work.dma(dma_arch)
# Loading work.counter(counterarch)
# Loading work.stridecounter(counterarch)
# Loading work.nbitregisterf(nbitregister_architecture)
# Loading work.ram(syncrama)
# Loading work.cache2(cachearch)
add wave -r /*
mem load -skip 0 -filltype rand -filldata 00000000 -fillradix unsigned -startaddress 0 -endaddress 262143 /ramcacheinterface/Ram/ram
force -freeze sim:/ramcacheinterface/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ramcacheinterface/rst 1 0
force -freeze sim:/ramcacheinterface/Start 1 0
force -freeze sim:/ramcacheinterface/conv 1 0
force -freeze sim:/ramcacheinterface/size 1 0
force -freeze sim:/ramcacheinterface/stride 0 0
force -freeze sim:/ramcacheinterface/AcceleratorOutput 11110001 0
force -freeze sim:/ramcacheinterface/opFinished 0 0
run

force -freeze sim:/ramcacheinterface/rst 0 0
run
force -freeze sim:/ramcacheinterface/Start 0 0
run
run
run
run
run
run
run
run
run
run
run