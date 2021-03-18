library verilog;
use verilog.vl_types.all;
entity MIO_BUS is
    port(
        mem_w           : in     vl_logic;
        sw_i            : in     vl_logic_vector(15 downto 0);
        cpu_data_out    : in     vl_logic_vector(31 downto 0);
        cpu_data_addr   : in     vl_logic_vector(31 downto 0);
        cpu_data_amp    : in     vl_logic_vector(3 downto 0);
        ram_data_out    : in     vl_logic_vector(31 downto 0);
        cpu_data_in     : out    vl_logic_vector(31 downto 0);
        ram_data_in     : out    vl_logic_vector(31 downto 0);
        ram_addr        : out    vl_logic_vector(6 downto 0);
        cpuseg7_data    : out    vl_logic_vector(31 downto 0);
        ram_we          : out    vl_logic;
        ram_amp         : out    vl_logic_vector(3 downto 0);
        seg7_we         : out    vl_logic
    );
end MIO_BUS;
