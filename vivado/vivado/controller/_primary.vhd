library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        opcode          : in     vl_logic_vector(6 downto 0);
        funct3          : in     vl_logic_vector(2 downto 0);
        funct7          : in     vl_logic_vector(6 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        rs1             : in     vl_logic_vector(4 downto 0);
        imm             : in     vl_logic_vector(11 downto 0);
        zero            : in     vl_logic;
        lt              : in     vl_logic;
        immctrl         : out    vl_logic_vector(4 downto 0);
        itype           : out    vl_logic;
        jal             : out    vl_logic;
        jalr            : out    vl_logic;
        bunsigned       : out    vl_logic;
        branch          : out    vl_logic_vector(3 downto 0);
        pcsrc           : out    vl_logic;
        aluctrl         : out    vl_logic_vector(3 downto 0);
        alusrca         : out    vl_logic_vector(1 downto 0);
        alusrcb         : out    vl_logic_vector(1 downto 0);
        memwrite        : out    vl_logic;
        lunsigned       : out    vl_logic;
        lwhb            : out    vl_logic_vector(1 downto 0);
        swhb            : out    vl_logic_vector(1 downto 0);
        memtoreg        : out    vl_logic;
        regwrite        : out    vl_logic
    );
end controller;
