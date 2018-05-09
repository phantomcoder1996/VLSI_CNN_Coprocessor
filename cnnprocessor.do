vsim -gui work.ramcacheinterface

add wave -r /*
force -freeze sim:/ramcacheinterface/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ramcacheinterface/rst 1 0
force -freeze sim:/ramcacheinterface/Start 1 0
force -freeze sim:/ramcacheinterface/conv 1 0
force -freeze sim:/ramcacheinterface/size 1 0
force -freeze sim:/ramcacheinterface/stride 0 0
mem load -i C:/ThirdYearSecondTerm/VLSI/Project/output.mem /ramcacheinterface/myRam/ram