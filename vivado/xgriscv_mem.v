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

// module imem (
//     input  [6:0] a,
//     output [`INSTR_SIZE-1:0] spo
// );

//   reg [`INSTR_SIZE-1:0] RAM[`IMEM_SIZE-1:0];

//   initial begin
//     //$readmemh("C:/Users/Qiu/Desktop/codlab/work/modelsim/riscv32_sim1.dat", RAM);
//     $readmemh("C:/Users/Qiu/Desktop/codlab/work/vivado/coe/riscv-studentnosorting.dat", RAM);
//     //$readmemh("C:/Users/Qiu/Desktop/codlab/work/vivado/problem.dat", RAM);
//   end

//   assign spo = RAM[a[6:0]];  // instruction size aligned
// endmodule

// module dmem (
//     input              clk,
//     we,
//     input  [      3:0] amp,
//     input  [8:0] a,
//     input [`XLEN-1:0] wd,
//     output [`XLEN-1:0] rd
// );

//   reg [31:0] RAM[127:0];

//   assign rd = RAM[a[8:2]];  // word aligned

//   always @(posedge clk)
//     if (we) begin
//       case (amp)
//         4'b1111: RAM[a[8:2]] <= wd;  // sw
//         4'b0011: RAM[a[8:2]][15:0] <= wd[15:0];  // sh
//         4'b1100: RAM[a[8:2]][31:16] <= wd[15:0];  // sh
//         4'b0001: RAM[a[8:2]][7:0] <= wd[7:0];  // sb
//         4'b0010: RAM[a[8:2]][15:8] <= wd[7:0];  // sb
//         4'b0100: RAM[a[8:2]][23:16] <= wd[7:0];  // sb
//         4'b1000: RAM[a[8:2]][31:24] <= wd[7:0];  // sb
//         default: RAM[a[8:2]] <= wd;  // it shouldn't happen
//       endcase
//     end
// endmodule
module dmem (
    input              clk,
    we,
    input  [      3:0] amp,
    input  [6:0] ad,
    input [`XLEN-1:0] wd,
    output [`XLEN-1:0] rd
);
reg [7:0] wd_0, wd_1, wd_2, wd_3;
  memip dmem_0 (
      .clk(clk),
      .we (amp[0] & we),
      .a  (ad),
      .spo(rd[7:0]),
      .d  (wd_0)
  );
  memip dmem_1 (
      .clk(clk),
      .we (amp[0] & we),
      .a  (ad),
      .spo(rd[15:8]),
      .d  (wd_1)
  );
  memip dmem_2 (
      .clk(clk),
      .we (amp[0] & we),
      .a  (ad),
      .spo(rd[23:16]),
      .d  (wd_2)
  );
  memip dmem_3 (
      .clk(clk),
      .we (amp[0] & we),
      .a  (ad),
      .spo(rd[31:24]),
      .d  (wd_3)
  );
  always @(posedge clk)
    case (amp)
      4'b1111: begin
        wd_0 <= wd[7:0];
        wd_1 <= wd[15:8];
        wd_2 <= wd[23:16];
        wd_3 <= wd[31:24];
      end
      4'b0011: begin
        wd_0 <= wd[7:0];
        wd_1 <= wd[15:8];
        wd_2 <= wd[7:0];
        wd_3 <= wd[15:8];
      end
      4'b1100: begin
        wd_0 <= wd[7:0];
        wd_1 <= wd[15:8];
        wd_2 <= wd[7:0];
        wd_3 <= wd[15:8];
      end
      default: begin
        wd_0 <= wd[7:0];
        wd_1 <= wd[7:0];
        wd_2 <= wd[7:0];
        wd_3 <= wd[7:0];
      end
    endcase

endmodule
// dmem_0(0~7)
// dmem_1(8~15)
// dmem_2(16~23)
// dmem_4(24~31)



// module dmem (
//     input              clk,
//     we,
//     input  [      3:0] amp,
//     input  [`XLEN-1:0] a,
//     wd,
//     output [`XLEN-1:0] rd
// );

//   reg [31:0] RAM[1023:0];

//   assign rd = RAM[a[11:2]];  // word aligned

//   always @(posedge clk)
//     if (we) begin
//       case (amp)
//         4'b1111: RAM[a[11:2]] <= wd;  // sw
//         4'b0011: RAM[a[11:2]][15:0] <= wd[15:0];  // sh
//         4'b1100: RAM[a[11:2]][31:16] <= wd[15:0];  // sh
//         4'b0001: RAM[a[11:2]][7:0] <= wd[7:0];  // sb
//         4'b0010: RAM[a[11:2]][15:8] <= wd[7:0];  // sb
//         4'b0100: RAM[a[11:2]][23:16] <= wd[7:0];  // sb
//         4'b1000: RAM[a[11:2]][31:24] <= wd[7:0];  // sb
//         default: RAM[a[11:2]] <= wd;  // it shouldn't happen
//       endcase
//       $display("dataaddr = %h, writedata = %h", {a[31:2], 2'b00}, wd);
//       //$display("dataaddr = %h, memdata = %h", {a[31:2],2'b00}, RAM[a[11:2]]);
//     end
// endmodule
