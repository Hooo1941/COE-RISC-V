library verilog;
use verilog.vl_types.all;
entity CLK_DIV is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        SW15            : in     vl_logic;
        Clk_CPU         : out    vl_logic
    );
end CLK_DIV;
