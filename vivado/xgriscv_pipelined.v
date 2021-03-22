//=====================================================================
//
// Designer   : Yili Gong
//
// Description:
// As part of the project of Computer Organization Experiments, Wuhan University
// In spring 2021
// The overall of the pipelined xg-riscv implementation.
//
// ====================================================================

`include "xgriscv_defines.v"
// module xgriscv_pipeline (
//     clk,
//     reset
// );
//   input clk, reset;

//   wire [31:0] instr;
//   wire [31:0] pc;
//   wire memwrite;
//   wire [3:0] amp;
//   wire [31:0] addr, writedata, readdata;
//   wire [6:0] pci;
//   assign pc = {25'b0, pci};
//   imem U_imem (
//       pci,
//       instr
//   );

//   dmem U_dmem (
//       clk,
//       memwrite,
//       amp,
//       addr,
//       writedata,
//       readdata
//   );

//   xgriscv U_xgriscv (
//       clk,
//       reset,
//       pc,
//       instr,
//       memwrite,
//       amp,
//       addr,
//       writedata,
//       readdata,
//       ra3,
//       reg_data
//   );

// endmodule

// xgriscv: a pipelined riscv processor
module xgriscv (
    input                    clk,
    reset,
    output [           31:0] pc,
    input  [`INSTR_SIZE-1:0] instr,
    output                   memwrite,
    output [            3:0] amp,
    output [ `ADDR_SIZE-1:0] daddr,
    output [      `XLEN-1:0] writedata,
    input  [      `XLEN-1:0] readdata,
    input  [4:0] ra3,
    output [`XLEN-1:0] reg_data
);

  wire [6:0] opD;
  wire [2:0] funct3D;
  wire [6:0] funct7D;
  wire [4:0] rdD, rs1D;
  wire [11:0] immD;
  wire zeroD, ltD;
  wire [4:0] immctrlD;
  wire itypeD, jalD, jalrD, bunsignedD, pcsrcD;
  wire [3:0] branchD, aluctrlD;
  wire [1:0] alusrcaD, alusrcbD;
  wire memwriteD, lunsignedD;
  wire [1:0] swhbD, lwhbD;
  wire memtoregD, regwriteD;

  controller c (
      clk,
      reset,
      opD,
      funct3D,
      funct7D,
      rdD,
      rs1D,
      immD,
      zeroD,
      ltD,
      immctrlD,
      itypeD,
      jalD,
      jalrD,
      bunsignedD,
      branchD,
      pcsrcD,
      aluctrlD,
      alusrcaD,
      alusrcbD,
      memwriteD,
      lunsignedD,
      lwhbD,
      swhbD,
      memtoregD,
      regwriteD
  );

  datapath dp (
      clk,
      reset,
      instr,
      pc,
      readdata,
      daddr,
      writedata,
      memwrite,
      amp,
      immctrlD,
      itypeD,
      jalD,
      jalrD,
      bunsignedD,
      branchD,
      pcsrcD,
      aluctrlD,
      alusrcaD,
      alusrcbD,
      memwriteD,
      lunsignedD,
      lwhbD,
      swhbD,
      memtoregD,
      regwriteD,
      opD,
      funct3D,
      funct7D,
      rdD,
      rs1D,
      immD,
      zeroD,
      ltD,
      ra3,
      reg_data
  );

endmodule
