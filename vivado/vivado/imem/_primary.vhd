library verilog;
use verilog.vl_types.all;
entity imem is
    port(
        a               : in     vl_logic_vector(6 downto 0);
        spo             : out    vl_logic_vector(31 downto 0)
    );
end imem;
