transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/flag_register.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/full_adder.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/INT_REG.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/IR.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/MAR.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/MDR.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/Register_Bank.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/shif_unit.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/spram.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/upc.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/uProgramMemory.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/nbit_adder.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/add_sub.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/control_unit.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/processing_unit.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/ALU.vhd}
vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/PDUA.vhd}

vcom -93 -work work {C:/Users/juan/Desktop/PDUA_Final/PDUA_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  PDUA_tb

add wave *
view structure
view signals
run -all
