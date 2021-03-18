library verilog;
use verilog.vl_types.all;
entity MULTI_CH32 is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        EN              : in     vl_logic;
        ctrl            : in     vl_logic_vector(5 downto 0);
        Data0           : in     vl_logic_vector(31 downto 0);
        data1           : in     vl_logic_vector(31 downto 0);
        data2           : in     vl_logic_vector(31 downto 0);
        data3           : in     vl_logic_vector(31 downto 0);
        data4           : in     vl_logic_vector(31 downto 0);
        data5           : in     vl_logic_vector(31 downto 0);
        data6           : in     vl_logic_vector(31 downto 0);
        data7           : in     vl_logic_vector(31 downto 0);
        reg_data        : in     vl_logic_vector(31 downto 0);
        seg7_data       : out    vl_logic_vector(31 downto 0)
    );
end MULTI_CH32;
