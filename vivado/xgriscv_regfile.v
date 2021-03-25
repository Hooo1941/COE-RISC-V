//=====================================================================
//
// Designer   : Yili Gong
//
// Description:
// As part of the project of Computer Organization Experiments, Wuhan University
// In spring 2021
// The regfile module implements the core's general purpose registers file.
//
// ====================================================================

`include "xgriscv_defines.v"

module regfile (
    input                     clk,
    input  [`RFIDX_WIDTH-1:0] ra1,
    ra2,
    output [       `XLEN-1:0] rd1,
    rd2,

    input                    we3,
    input [`RFIDX_WIDTH-1:0] wa3,
    input [       `XLEN-1:0] wd3,
    input [`RFIDX_WIDTH-1:0] ra3,
    output [`XLEN-1:0] reg_data
);

  reg [`XLEN-1:0] rf[`RFREG_NUM-1:0];

  // three ported register file
  // read two ports combinationally
  // write third port on falling edge of clock
  // register 0 hardwired to 0

  always @(posedge clk)
    if (we3) begin
      rf[wa3] <= wd3;
`ifdef DEBUG
      $display("x%d = %h", wa3, wd3);
`endif
    end
  assign reg_data = rf[ra3];
  assign rd1 = rf[ra1];
  assign rd2 = rf[ra2];
endmodule
