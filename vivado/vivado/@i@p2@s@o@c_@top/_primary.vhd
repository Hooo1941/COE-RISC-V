library verilog;
use verilog.vl_types.all;
entity IP2SOC_Top is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        sw_i            : in     vl_logic_vector(15 downto 0);
        disp_seg_o      : out    vl_logic_vector(7 downto 0);
        disp_an_o       : out    vl_logic_vector(7 downto 0)
    );
end IP2SOC_Top;
