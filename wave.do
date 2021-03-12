onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[19]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[18]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[17]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[16]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[15]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[14]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[13]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[12]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[11]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[10]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[9]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[8]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[7]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[6]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[5]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[4]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[3]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[2]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_xgriscv/dp/rf/rf[1]}
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/pc
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_dmem/RAM[1]}
add wave -noupdate -radix hexadecimal {/xgriscv_tb/xgriscvp/U_dmem/RAM[0]}
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/rs1D
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/rs2D
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/branchD
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/stall
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/en
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/instrD
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/flushD
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/instrF
add wave -noupdate -radix hexadecimal /xgriscv_tb/xgriscvp/U_xgriscv/dp/pcF
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1264 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 396
configure wave -valuecolwidth 71
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {3512 ns}
