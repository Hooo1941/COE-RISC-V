library verilog;
use verilog.vl_types.all;
entity ampattern is
    port(
        addr            : in     vl_logic_vector(1 downto 0);
        swhb            : in     vl_logic_vector(1 downto 0);
        amp             : out    vl_logic_vector(3 downto 0)
    );
end ampattern;
