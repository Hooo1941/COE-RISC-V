//=====================================================================
//
// Designer   : Yili Gong
//
// Description:
// As part of the project of Computer Organization Experiments, Wuhan University
// In spring 2021
// The datapath of the pipeline.
// ====================================================================

`include "xgriscv_defines.v"

module datapath (
    input clk,
    reset,

    input  [`INSTR_SIZE-1:0] instrF,  // from instructon memory
    output [ `ADDR_SIZE-1:0] pcF,  // to instruction memory

    input  [`XLEN-1:0] readdataM,  // from data memory: read data
    output [`XLEN-1:0] aluoutM,  // to data memory: address
    output [`XLEN-1:0] writedataM,  // to data memory: write data
    output             memwriteM,  // to data memory: write enable
    output [      3:0] ampM,  // to data memory: access memory pattern

    // from controller
    input [4:0] immctrlD,  //which type
    input       itype,
    jalD,
    jalrD,
    bunsignedD,
    input [3:0] branchD,
    input       pcsrcD,
    input [3:0] aluctrlD,
    input [1:0] alusrcaD,
    input [1:0] alusrcbD,
    input       memwriteD,
    lunsignedD,
    input [1:0] lwhbD,
    swhbD,
    input       memtoregD,
    regwriteD,

    // to alu controller
    output [ 6:0] opD,
    output [ 2:0] funct3D,
    output [ 6:0] funct7D,
    output [ 4:0] rdD,
    rs1D,
    output [11:0] immD,
    output        zeroD,
    ltD,
    input  [4:0] ra3,
    output [`XLEN-1:0] reg_data
    //for pipeline
    //output       			flushE
    //'flushE' already declared in line 180 (= 0)
);

  // next PC logic (operates in fetch and decode)
  wire [`ADDR_SIZE-1:0] nextpcF1, pcplus4F, nextpcF, pcbranchD, pcadder2aD, pcadder2bD, pcbranch0D;
  wire branchT;
  wire stall;
  wire loadbranch;  //flush IF/ID, ID/EX pcD to pcF
  mux2 #(`ADDR_SIZE) pcsrcmux (
      pcplus4F,
      pcbranchD,
      branchT | jalD,
      nextpcF1
  );

  // Fetch stage logic
  pcenr pcreg (
      clk,
      reset,
      ~stall,
      nextpcF,
      pcF
  );
  addr_adder pcadder1 (
      pcF,
      `ADDR_SIZE'b100,
      pcplus4F
  );

  ///////////////////////////////////////////////////////////////////////////////////
  // IF/ID pipeline registers
  wire [`INSTR_SIZE-1:0] instrD;
  wire [`ADDR_SIZE-1:0] pcD;
  wire flushD = ((branchT | jalD) & ~stall) | loadbranch;
  flopenrc #(`INSTR_SIZE+`ADDR_SIZE) prD (
    clk,
    reset,
    ~stall,
    flushD,
    {instrF, pcF},
    {instrD, pcD}
  ); // 0.2ns
  mux2 #(`ADDR_SIZE) pcsrcmux2 (
      nextpcF1,
      pcD,
      loadbranch,
      nextpcF
  );
  // Decode stage logic
  wire [`RFIDX_WIDTH-1:0] rs2D;
  assign opD = instrD[6:0];
  assign rdD = instrD[11:7];
  assign funct3D = instrD[14:12];
  assign rs1D = instrD[19:15];
  assign rs2D = instrD[24:20];
  assign funct7D = instrD[31:25];
  assign immD = instrD[31:20];

  // immediate generate
  wire [11:0] iimmD = instrD[31:20];
  wire [11:0] simmD = {instrD[31:25], instrD[11:7]};
  wire [11:0] bimmD = {instrD[31], instrD[7], instrD[30:25], instrD[11:8]};
  wire [19:0] uimmD = instrD[31:12];
  wire [19:0] jimmD = {instrD[31], instrD[19:12], instrD[20], instrD[30:21]};
  wire [`XLEN-1:0] immoutD, shftimmD;
  wire [`XLEN-1:0] rdata1R, rdata2R, rdata1D, rdata2D, wdataW;
  wire [`RFIDX_WIDTH-1:0] waddrW;

  imm im (
      iimmD,
      simmD,
      bimmD,
      uimmD,
      jimmD,
      immctrlD,
      immoutD
  );


  // register file (operates in decode and writeback)
  regfile rf (
      clk,
      rs1D,
      rs2D,
      rdata1R,
      rdata2R,
      regwriteW,
      waddrW,
      wdataW,
      ra3,
      reg_data
  );

  wire [1:0] forwardD1, forwardD2;

  mux3 #(`XLEN) rdata1mux (
      rdata1R,
      aluoutM,
      wdataW,
      forwardD1,
      rdata1D
  );
  mux3 #(`XLEN) rdata2mux (
      rdata2R,
      aluoutM,
      wdataW,
      forwardD2,
      rdata2D
  );

  // shift amount
  wire [4:0] shamt0D = instrD[24:20];
  wire [4:0] shamtD;
  mux2 #(5) shamtmux (
      rdata2D[4:0],  //R[rs2]
      shamt0D,  //imm
      itype,  //1 is imm
      shamtD
  );

  // comparator for branch
  cmp cmp (
      rdata1D,
      rdata2D,
      bunsignedD,
      zeroD,
      ltD
  );

  assign branchT = ((branchD == `BRANCH_BLT) & ltD) 
                 | ((branchD == `BRANCH_BGE) & ~ltD) 
                 | ((branchD == `BRANCH_BEQ) & zeroD) 
                 | ((branchD == `BRANCH_BNE) & ~zeroD);
  assign pcbranchD = (jalrD ? rdata1D : pcD) + immoutD;

  ///////////////////////////////////////////////////////////////////////////////////
  // ID/EX pipeline registers

  // for control signals
  wire memtoregE, regwriteE, memwriteE, lunsignedE, jalE;
  wire [1:0] swhbE, lwhbE, alusrcaE, alusrcbE;
  wire [3:0] aluctrlE;
  wire flushE = loadbranch | stall;
  wire itypeE;
  floprc #(18) regE (
      clk,
      reset,
      flushE,
      {
        memtoregD,
        regwriteD,
        memwriteD,
        swhbD,
        lwhbD,
        lunsignedD,
        alusrcaD,
        alusrcbD,
        aluctrlD,
        jalD,
        itype
      },
      {
        memtoregE,
        regwriteE,
        memwriteE,
        swhbE,
        lwhbE,
        lunsignedE,
        alusrcaE,
        alusrcbE,
        aluctrlE,
        jalE,
        itypeE
      }
  );

  // for data
  wire [`XLEN-1:0] srca1E, srcb1E, immoutE, srca2E, srca3E, srcb2E, srcb3E, aluoutE;
  wire [`RFIDX_WIDTH-1:0] rs1E, rs2E, rdE;
  wire [4:0] shamtE;
  wire [`ADDR_SIZE-1:0] pcE;
//   floprc #(`XLEN + `XLEN + `XLEN + `RFIDX_WIDTH + `RFIDX_WIDTH + `RFIDX_WIDTH + 5 + `ADDR_SIZE) prE (
//       clk,
//       reset,
//       flushE,
//       {rdata1D, rdata2D, immoutD, rs1D, rs2D, rdD, shamtD, pcD},
//       {srca1E, srcb1E, immoutE, rs1E, rs2E, rdE, shamtE, pcE}
//   );
  floprc #(`XLEN) pr1E (
      clk,
      reset,
      flushE,
      rdata1D,
      srca1E
  );  //???????1
  floprc #(`XLEN) pr2E (
      clk,
      reset,
      flushE,
      rdata2D,
      srcb1E
  );  //???????2
  floprc #(`XLEN) pr3E (
      clk,
      reset,
      flushE,
      immoutD,
      immoutE
  );  //???????
  floprc #(`RFIDX_WIDTH) pr4E (
      clk,
      reset,
      flushE,
      rs1D,
      rs1E
  );  //??????1
  floprc #(`RFIDX_WIDTH) pr5E (
      clk,
      reset,
      flushE,
      rs2D,
      rs2E
  );  //??????2
  floprc #(`RFIDX_WIDTH) pr6E (
      clk,
      reset,
      flushE,
      rdD,
      rdE
  );  //???????
  floprc #(5) pr7E (
      clk,
      reset,
      flushE,
      shamtD,
      shamtE
  );  //32????shift??????
  floprc #(`ADDR_SIZE) pr8E (
      clk,
      reset,
      flushE,
      pcD,
      pcE
  );  //pc

  // execute stage logic
  wire [1:0] forwardaE, forwardbE;
  mux3 #(`XLEN) srca1mux (
      srca1E,
      wdataW,
      aluoutM,
      forwardaE,
      srca2E
  );  // srca1mux
  mux3 #(`XLEN) srca2mux (
      srca2E,
      0,
      pcE,
      alusrcaE,
      srca3E
  );  // srca2mux
  mux3 #(`XLEN) srcb1mux (
      srcb1E,
      wdataW,
      aluoutM,
      forwardbE,
      srcb2E
  );  // srcb1mux
  mux3 #(`XLEN) srcb2mux (
      srcb2E,
      immoutE,
      4,
      alusrcbE,
      srcb3E
  );  // srcb2mux
  wire forwardcE, forwarddE;
  wire [4:0] shamtE1;
  mux3 #(5) shamtEmux (
      shamtE,
      aluoutM[4:0],  //from MEM(arith)
      wdataW[4:0],  //from WB(load)
      ~itypeE ? (forwardcE ? 2'b01 : (forwarddE ? 2'b10 : 2'b00)) : 2'b00,
      shamtE1
  );

  alu alu (
      srca3E,
      srcb3E,
      shamtE1,
      aluctrlE,
      aluoutE,
      overflowE,
      zeroE,
      ltE,
      geE
  );
//   assign stall = (memtoregE & ~memwriteD & ((rs1D == rdE) | (rs2D == rdE))) |  //load-use
//   (branchD != 4'b0000 & regwriteE & ((rs1D == rdE) | (rs2D == rdE)));  //arith-beq

  assign stall = ((memtoregE & ~memwriteD) |  //load-use
  (branchD != 4'b0000 & regwriteE)) //arith-beq
  & ((rs1D == rdE) | (rs2D == rdE));

//   assign stall = ((branchD == 4'b0000) & memtoregE & ((rs1D == rdE) | (rs2D == rdE)) & ~memwriteD) |  //load-use
//   ((branchD != 4'b0000) & ~memtoregE & regwriteE & ((rs1D == rdE) | (rs2D == rdE)));  //arith-beq //0.13ns

  assign loadbranch = (branchD != 4'b0000) & memtoregE & ((rs1D == rdE) | (rs2D == rdE));
  // EX/MEM pipeline registers
  // for control signals
  wire memtoregM, regwriteM, jalM, lunsignedM;
  wire [1:0] swhbM, lwhbM;
  flopr #(9) regM (
      clk,
      reset,
      {memtoregE, regwriteE, memwriteE, lunsignedE, swhbE, lwhbE, jalE},
      {memtoregM, regwriteM, memwriteM, lunsignedM, swhbM, lwhbM, jalM}
  );

  // for data
  wire [`RFIDX_WIDTH-1:0] rs2M, rdM;
  wire [`XLEN-1:0] writedataM1;
  flopr #(`XLEN) pr1M (
      clk,
      reset,
      aluoutE,
      aluoutM
  );
  flopr #(`XLEN) pr2M (
      clk,
      reset,
      srcb1E,
      writedataM1
  );
  flopr #(`RFIDX_WIDTH) pr3M (
      clk,
      reset,
      rdE,
      rdM
  );
  flopr #(`RFIDX_WIDTH) pr5M (
      clk,
      reset,
      rs2E,
      rs2M
  );

//   wire [`RFIDX_WIDTH-1:0] rs2M, rdM;
//   wire [`XLEN-1:0] writedataM1;
//   flopr #(9 + `XLEN + `XLEN + `RFIDX_WIDTH + `RFIDX_WIDTH) prM (
//       clk,
//       reset,
//       {memtoregE, regwriteE, memwriteE, lunsignedE, swhbE, lwhbE, jalE, aluoutE, srcb1E, rdE, rs2E},
//       {memtoregM, regwriteM, memwriteM, lunsignedM, swhbM, lwhbM, jalM, aluoutM, writedataM1, rdM, rs2M}
//   );
  // memory stage logic
  ampattern amp (
      aluoutM[1:0],
      swhbM,
      ampM
  );  // for sw, sh and sb, ampM to data memory

  wire [`XLEN-1:0] membyteM, memhalfM, readdatabyteM, readdatahalfM, memdataM;
  mux2 #(16) lhmux (
      readdataM[15:0],
      readdataM[31:16],
      aluoutM[1],
      memhalfM[15:0]
  );  // for lh and lhu
  wire [`XLEN-1:0] signedhalfM = {{16{memhalfM[15]}}, memhalfM[15:0]};  // for lh
  wire [`XLEN-1:0] unsignedhalfM = {16'b0, memhalfM[15:0]};  // for lhu
  mux2 #(32) lhumux (
      signedhalfM,
      unsignedhalfM,
      lunsignedM,
      readdatahalfM
  );

  mux4 #(8) lbmux (
      readdataM[7:0],
      readdataM[15:8],
      readdataM[23:16],
      readdataM[31:24],
      aluoutM[1:0],
      membyteM[7:0]
  );
  wire [`XLEN-1:0] signedbyteM = {{24{membyteM[7]}}, membyteM[7:0]};  // for lb
  wire [`XLEN-1:0] unsignedbyteM = {24'b0, membyteM[7:0]};  // for lbu

  mux2 #(`XLEN) lbumux (
      signedbyteM,
      unsignedbyteM,
      lunsignedM,
      readdatabyteM
  );

  mux3 #(`XLEN) lwhbmux (
      readdataM,
      readdatahalfM,
      readdatabyteM,
      lwhbM,
      memdataM
  );

  assign forwardcE = (rs2E == rdM) & regwriteM & ~memtoregM;
//   MEM/WB pipeline registers
//   for control signals
  flopr #(3) regW (
      clk,
      reset,
      {memtoregM, regwriteM, jalM},
      {memtoregW, regwriteW, jalW}
  );

  // for data
  wire [`XLEN-1:0] aluoutW, memdataW, wdata0W;
  wire forwardM = (waddrW == rs2M) & regwriteW;

  mux2 #(32) forwardmemmux (
      writedataM1,
      wdataW,
      forwardM,
      writedataM
  );

  flopr #(`XLEN) pr1W (
      clk,
      reset,
      aluoutM,
      aluoutW
  );
  flopr #(`XLEN) pr2W (
      clk,
      reset,
      memdataM,
      memdataW
  );
  flopr #(`RFIDX_WIDTH) pr3W (
      clk,
      reset,
      rdM,
      waddrW
  );

//   wire [`XLEN-1:0] aluoutW, memdataW, wdata0W;
//   wire forwardM;

//   flopr #(3 + `XLEN + `XLEN + `RFIDX_WIDTH) regW (
//       clk,
//       reset,
//       {memtoregM, regwriteM, jalM, aluoutM, memdataM, rdM},
//       {memtoregW, regwriteW, jalW, aluoutW, memdataW, waddrW}
//   );

//   mux2 #(32) forwardmemmux (
//       writedataM1,
//       wdataW,
//       forwardM,
//       writedataM
//   );

//   // write-back stage logic
//   assign forwardM = (waddrW == rs2M) & regwriteW;
  assign wdataW = memtoregW ? memdataW : aluoutW;

  assign forwardD1 = (rs1D == rdM & regwriteM & ~memtoregM) ? 2'b01 : (rs1D == waddrW & regwriteW ? 2'b10 : 2'b00);
  assign forwardD2 = (rs2D == rdM & regwriteM & ~memtoregM) ? 2'b01 : (rs2D == waddrW & regwriteW ? 2'b10 : 2'b00);

  assign forwardaE = (rs1E == rdM & regwriteM) ? 2'b10 :
  ((rs1E == waddrW & regwriteW) ? 2'b01 : 2'b00);
  assign forwardbE = (rs2E == rdM & regwriteM) ? 2'b10 :
  ((rs2E == waddrW & regwriteW) ? 2'b01 : 2'b00);
  assign forwarddE = rs2E == waddrW & regwriteW;
endmodule
