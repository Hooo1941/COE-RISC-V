//=====================================================================
//
// Designer   : Yili Gong
//
// Description:
// As part of the project of Computer Organization Experiments, Wuhan University
// In spring 2021
// The instruction memory and data memory.
//
// ====================================================================

`include "xgriscv_defines.v"

module imem (
    input  [ `ADDR_SIZE-1:0] a,
    output [`INSTR_SIZE-1:0] rd
);

  reg [`INSTR_SIZE-1:0] RAM[`IMEM_SIZE-1:0];

  initial begin
    $readmemh("riscv32_sim6.dat", RAM);
  end

  assign rd = RAM[a[11:2]];  // instruction size aligned
endmodule


module dmem (
    input              clk,
    we,
    input  [      3:0] amp,
    input  [`XLEN-1:0] a,
    wd,
    output [`XLEN-1:0] rd
);

  reg [31:0] RAM[1023:0];

  assign rd = RAM[a[11:2]];  // word aligned

  always @(posedge clk)
    if (we) begin
      case (amp)
        4'b1111: RAM[a[11:2]] <= wd;  // sw
        4'b0011: RAM[a[11:2]][15:0] <= wd[15:0];  // sh
        4'b1100: RAM[a[11:2]][31:16] <= wd[15:0];  // sh
        4'b0001: RAM[a[11:2]][7:0] <= wd[7:0];  // sb
        4'b0010: RAM[a[11:2]][15:8] <= wd[7:0];  // sb
        4'b0100: RAM[a[11:2]][23:16] <= wd[7:0];  // sb
        4'b1000: RAM[a[11:2]][31:24] <= wd[7:0];  // sb
        default: RAM[a[11:2]] <= wd;  // it shouldn't happen
      endcase
      $display("dataaddr = %h, writedata = %h", {a[31:2], 2'b00}, wd);
      //$display("dataaddr = %h, memdata = %h", {a[31:2],2'b00}, RAM[a[11:2]]);
    end
endmodule
