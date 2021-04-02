library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        aluctrl         : in     vl_logic_vector(3 downto 0);
        aluout          : out    vl_logic_vector(31 downto 0);
        overflow        : out    vl_logic;
        zero            : out    vl_logic;
        lt              : out    vl_logic;
        ge              : out    vl_logic
    );
end alu;
