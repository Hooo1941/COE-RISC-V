# jalr negative test
main: addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
jal x1,proc1
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
proc1:
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
jalr     x0, x1, -4
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0