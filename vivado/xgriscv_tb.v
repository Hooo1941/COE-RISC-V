module xgriscv_tb ();

  reg clk, rstn;
  reg[15:0] sw_i;
  wire [7:0] disp_seg_o, disp_an_o;

  // instantiation of xgriscv 
  IP2SOC_Top xgriscvp (
      clk,
      rstn,
	  sw_i,
	  disp_seg_o, disp_an_o
  );

  integer counter = 0;

  initial begin
    clk = 1;
    rstn = 0;
    #5;
    rstn = 1;
  end

  always begin
    #(50) clk = ~clk;

    if (clk == 1'b1) begin
      counter = counter + 1;
      $display("clock: %d", counter);
      $display("pc:\t\t%h", xgriscvp.PC);
      $display("instr:\t%h", xgriscvp.instr);
    end
  end  //end always

endmodule
