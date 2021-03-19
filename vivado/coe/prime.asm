# x2, i
main:
li x5, 0xffff000c
# li x5, 0
addi x2, x0, 0x03
addi x4, x0, 0x2
addi x11, x0, 0x64 # end of i
sw x4, 0(x5)
loop1:
  addi x3, x0, 0x02 # j
  add x4, x0, x2 # end of j
loop2:
  addi x7, x2, 0
loop3:
  sub x7, x7, x3
  beq x7, x0, incrLoop1
  blt x7, x0, incrLoop2
  jal x0, loop3
incrLoop2:
  addi x3, x3, 1
  bge x3, x2, output
  jal x0, loop2
incrLoop1:
  addi x2, x2, 1
  blt x2, x11, loop1
jal x0, main
output:
sw x2, 0(x5)
jal x0, incrLoop1